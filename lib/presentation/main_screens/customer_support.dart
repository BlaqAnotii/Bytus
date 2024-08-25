import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/presentation/widget_screens/webview.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class CustomerSupportScreen extends StatefulWidget {
  const CustomerSupportScreen({super.key});

  @override
  State<CustomerSupportScreen> createState() => _CustomerSupportScreenState();
}

class _CustomerSupportScreenState extends State<CustomerSupportScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

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
          'Customer Support',
          style: TextStyle(
            color: black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenSize.width / 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/help.png",
                scale: 2,
              ),
            ),
            SizedBox(
              height: screenSize.width / 10,
            ),
            const Text(
              "Hello !",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: screenSize.width / 30,
            ),
            const Text(
              "How can we be of help to you?",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: screenSize.width / 15,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenSize.width / 20,
                right: screenSize.width / 20,
              ),
              child: const Text(
                "We are determined to give you the best support experience, If you have any question or challenges, We are available to help.",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: screenSize.width / 15,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  navigationService.push(
                    const WebviewTidio(),
                  );
                },
                leading: const Icon(
                  Icons.headphones,
                  color: primary,
                  size: 25,
                ),
                title: const Text(
                  "Live Chat",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                subtitle: const Text(
                  "Need urgent help? Chat live with customer support",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
            ),
           
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.mail,
                  color: primary,
                  size: 25,
                ),
                title: const Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                subtitle: const Text(
                  "Send us a mail at\nsupport@bytus.online",
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.width / 10,
            ),
          ],
        ),
      ),
    );
  }
}
