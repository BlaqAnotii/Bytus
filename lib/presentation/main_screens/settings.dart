import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/presentation/auth/id_verification.dart';
import 'package:bytuswallet/presentation/auth/personal_info.dart';
import 'package:bytuswallet/presentation/auth/security_pin.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
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
          'Verify Account',
          style: TextStyle(
            color: black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
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
                    onTap: () {
                      navigationService.push(const PersonalInfoScreen());
                    },
                    leading: const Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 18,
                    ),
                    title: const Text(
                      "Update Information",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Color.fromARGB(255, 209, 209, 209),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      navigationService.push(const IdVerificationScreen());
                    },
                    leading: const Icon(
                      Icons.receipt,
                      color: Colors.black,
                      size: 18,
                    ),
                    title: const Text(
                      "Upload Document",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Color.fromARGB(255, 209, 209, 209),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          GestureDetector(
            onTap: () {},
            child: const Center(
              child: Text(
                "Delete Account",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: offcolor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
