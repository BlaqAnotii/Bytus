// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInformation extends StatefulWidget {
 
  const PersonalInformation(
      {super.key,
     });

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late String lastname;
  late String firstname;
  late String emails;
  @override
  void initState() {
    _info();
   
    super.initState();
  }

  String newname = '';
  String newnames = '';
  String email = '';
  String phone = '';
  String dob = '';
  String state = '';
  String country = '';

  Future<void> _info() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLastName = await _secureStorage.read(key: 'last_name');
    String? savedFirstName = await _secureStorage.read(key: 'first_name');
    String? emailss = await _secureStorage.read(key: 'email');
    String? savedPhone = await _secureStorage.read(key: 'phone_number');
    String? savedDob = await _secureStorage.read(key: 'date_of_birth');
    String? savedCountry = await _secureStorage.read(key: 'country');
    String? savedState = await _secureStorage.read(key: 'state');

    print(savedLastName);
    print(savedFirstName);
    print(emailss);
    print(savedPhone);
    print(savedDob);
    print(savedCountry);
    print(savedState);

    setState(() {
      if (savedLastName != null) {
        newname = savedLastName;
      }
      if (savedFirstName != null) {
        newnames = savedFirstName;
      }
      if (savedPhone != null) {
        phone = savedPhone;
      }
      if (emailss != null) {
        email = emailss;
      }
      if (savedDob != null) {
        dob = savedDob;
      }
      if (savedState != null) {
        state = savedState;
      }
      if (savedCountry != null) {
        country = savedCountry;
      }
    });
  }

  final _secureStorage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              navigationService.goBack();
            },
            child: const Icon(
              Iconsax.arrow_left,
              color: black,
              size: 25,
            )),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 50,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.dark, // For iOS (dark icons)
        ),
        centerTitle: true,
        title: const Text(
          'Personal Information',
          style: TextStyle(
            color: black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          const Divider(),
          SizedBox(
            height: 1.h,
          ),
          const Center(
            child: Text(
              "Personal Information are automatically gotten from your registration process. If you want to make any changes, Contact our Support",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: grey,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(1, 1), // changes position of shadow
                  ),
                ],
              ),
              child: ListView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: const Icon(
                      Iconsax.profile_circle,
                      color: Colors.black,
                      size: 18,
                      weight: 2,
                    ),
                    title: Text(
                      "$newnames $newname",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.mail_outline,
                      color: Colors.black,
                      size: 18,
                      weight: 2,
                    ),
                    title: Text(
                      email,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Iconsax.call,
                      color: Colors.black,
                      size: 18,
                      weight: 2,
                    ),
                    title: Text(
                      phone,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.date_range,
                      color: Colors.black,
                      size: 18,
                      weight: 2,
                    ),
                    title: Text(
                      dob,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Iconsax.location,
                      color: Colors.black,
                      size: 18,
                      weight: 2,
                    ),
                    title: Text(
                      state,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Iconsax.global,
                      color: Colors.black,
                      size: 18,
                      weight: 2,
                    ),
                    title: Text(
                      country,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
