// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_is_empty, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/data/https.dart';
import 'package:bytuswallet/presentation/bottom_navbar/bottom_navbar.dart';
import 'package:bytuswallet/presentation/widget_screens/profile.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:bytuswallet/services/user_services.dart';
import 'package:bytuswallet/util/app_button.dart';
import 'package:bytuswallet/util/size_config.dart';
import 'package:bytuswallet/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IdVerificationScreen extends StatefulWidget {
  const IdVerificationScreen({super.key});

  @override
  State<IdVerificationScreen> createState() => _IdVerificationScreenState();
}

class _IdVerificationScreenState extends State<IdVerificationScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _frontPhoto;
  File? _backPhoto;
  bool _isLoading = false;

  Future<void> _pickImages() async {
    // Function to pick image from specified source
    Future<void> _pickImage(ImageSource source, bool isFront) async {
      final pickedImage = await _picker.pickImage(source: source);
      if (pickedImage == null) {
        showCustomToast(
            isFront ? "No front photo selected" : "No back photo selected",
            success: false);
        return;
      }

      setState(() {
        if (isFront) {
          _frontPhoto = File(pickedImage.path);
        } else {
          _backPhoto = File(pickedImage.path);
        }
      });
    }

    // Prompt the user to choose between camera and gallery
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  // Pick front photo from gallery
                  await _pickImage(ImageSource.gallery, true);
                  // Pick back photo from gallery
                  await _pickImage(ImageSource.gallery, false);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  // Pick front photo from camera
                  await _pickImage(ImageSource.camera, true);
                  // Pick back photo from camera
                  await _pickImage(ImageSource.camera, false);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _processUploadDoc() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_frontPhoto == null || _backPhoto == null) {
        showCustomToast("Please select both front and back photos",
            success: false);
        setState(() {
          _isLoading = false;
        });
        return;
      }

      bool response = await userServices.uploadDoc(
        frontPhoto: _frontPhoto!,
        backPhoto: _backPhoto!,
      );
      await UserPreferences.setPinCreated(true);

      await UserPreferences.setRegistered(true);

      if (response) {
        showCustomToast("User Verified", success: true);
        navigationService.pushAndReplace(const BottomNavBarScreen(
          
        ));
      } else {
        showCustomToast("Upload Failed", success: false);
      }

      // Handle post verification actions here, such as navigating to the home screen
    } catch (e, l) {
      print(e);
      print(l);
      showCustomToast("Upload Failed", success: false);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height * .25,
                color: Colors.black,
                child: Image.asset(
                  "assets/images/bytus3.jpg",
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: width,
                clipBehavior: Clip.none,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Identity Verification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Upload the front and back view of your ID photo. This helps you prove your identity and it should match the information you have provided in the previous steps.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    _frontPhoto == null
                        ? const Text('No front photo selected.')
                        : Image.file(_frontPhoto!),
                    const SizedBox(
                      height: 30,
                    ),
                    _backPhoto == null
                        ? const Text('No back photo selected.')
                        : Image.file(_backPhoto!),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppButton.outline(
                        color: Colors.white,
                        txtColor: Colors.blue,
                        text: 'Upload ID',
                        onPressed: () {
                          _pickImages();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Note: Picture must not exceed 5Mb. Allowed formats are jpg and png.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    if (_isLoading)
                      Center(
                          child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CircularProgressIndicator(
                          backgroundColor: primary,
                          strokeWidth: 1.w,
                          strokeCap: StrokeCap.round,
                        ),
                      )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppButton(
                        color: Colors.black,
                        text: 'Submit',
                        onPressed: () {
                          _processUploadDoc();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
