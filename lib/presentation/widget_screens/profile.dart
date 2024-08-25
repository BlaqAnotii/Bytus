// ignore_for_file: avoid_print

import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/data/https.dart';
import 'package:bytuswallet/presentation/auth/login.dart';
import 'package:bytuswallet/presentation/main_screens/customer_support.dart';
import 'package:bytuswallet/presentation/main_screens/personal_info.dart';
import 'package:bytuswallet/presentation/main_screens/settings.dart';
import 'package:bytuswallet/presentation/main_screens/terms_of_use.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  
  const ProfileScreen(
      {super.key,
      });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  void initState() {
    _nameUpdate();
   
    super.initState();
  }

  final _secureStorage = const FlutterSecureStorage();

  String newname = '';
  String newnames = '';
  bool userVerified = false;

  Future<void> _nameUpdate() async {
    String? savedLastName = await _secureStorage.read(key: 'last_name');
    String? savedFirstName = await _secureStorage.read(key: 'first_name');
    String? userVerifiedStr = await _secureStorage.read(key: 'userVerified');

    print(savedLastName);
    print(savedFirstName);

    setState(() {
      if (savedLastName != null) {
        newname = savedLastName;
      }
      if (savedFirstName != null) {
        newnames = savedFirstName;
      }
      if (userVerifiedStr != null) {
        userVerified = userVerifiedStr == 'true';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        toolbarHeight: 70,
        leading: Padding(
          padding: EdgeInsets.only(
            left: screenSize.width / 30,
          ),
          child: const CircleAvatar(
            backgroundColor: black,
            child: Icon(
              Iconsax.user,
              color: white,
            ),
          ),
        ),
        title: Column(
          children: [
            Text(
              "$newnames $newname",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17,
                color: black,
              ),
            ),
            userVerified
                ? const Text(
                    "Verified",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: offcolor,
                    ),
                  )
                : const Text(
                    "Not verified",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: offcolor,
                    ),
                  )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            const SizedBox(
              height: 15,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                  "Get Help",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: black,
                  ),
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
                      onTap: () {
                        navigationService.push(const CustomerSupportScreen());
                      },
                      leading: const Icon(
                        Iconsax.call,
                        color: Colors.black,
                        size: 18,
                      ),
                      title: const Text(
                        "Call Customer Support",
                        style: TextStyle(
                          fontSize: 15,
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
            const SizedBox(
              height: 18,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                  "Our Legal terms",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: black,
                  ),
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
                      onTap: () {
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const PersonalInfoPage(),
                        //   ),
                        // );
                        navigationService.push(const TermsandConditionScreen());
                      },
                      leading: const Icon(
                        Iconsax.receipt,
                        color: Colors.black,
                        size: 18,
                      ),
                      title: const Text(
                        "Terms & Conditions",
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
            const SizedBox(
              height: 18,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                ),
                child: Text(
                  "My Account",
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600, color: black),
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
                      onTap: () {
                        navigationService.push(PersonalInformation(
                        
                        ));
                      },
                      leading: const Icon(
                        Iconsax.profile_circle,
                        color: Colors.black,
                        size: 18,
                      ),
                      title: const Text(
                        "Personal Information",
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
                        navigationService.push(const SettingsScreen());
                      },
                      leading: const Icon(
                        Iconsax.verify,
                        color: Colors.black,
                        size: 18,
                      ),
                      title: const Text(
                        "Verify Your Account",
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
                        promptUser(context, "Sign Out",
                            "Are you sure you want to logout?", () async {
                          await userServices.logout();
                          navigationService
                              .pushToAndRemoveUntil(const LoginScreen(
                         
                          ));
                        });
                      },
                      leading: const Icon(
                        Iconsax.logout,
                        color: Colors.black,
                        size: 18,
                      ),
                      title: const Text(
                        "Log out",
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
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  promptUser(BuildContext context, String title, String comment,
      void Function() callback) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(comment),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    callback();
                    Navigator.pop(context);
                  },
                  child: const Text("Yes")),
            ],
          );
        });
  }
}
