import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class TermsandConditionScreen extends StatefulWidget {
  const TermsandConditionScreen({super.key});

  @override
  State<TermsandConditionScreen> createState() =>
      _TermsandConditionScreenState();
}

class _TermsandConditionScreenState extends State<TermsandConditionScreen> {
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
          'Terms & Conditions',
          style: TextStyle(
            color: black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: screenSize.width / 50,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Agreement to Terms',
                  style: TextStyle(
                    color: black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.width / 50,
              ),
              const Text(
                'By accessing or using any or all of the Services, you expressly acknowledge that (i) you have read and understood these Terms; (ii) you agree to be bound by these Terms; and (iii) you are legally competent to enter into these Terms. If you do not agree to be bound by these Terms or any updates or modifications to these Terms, you may not access or use our Services. WE DO NOT PROVIDE INVESTMENT OR FINANCIAL ADVICE OR CONSULTING SERVICES. WE ARE SOLELY THE PROVIDER OF BYTUS WALLET AND WE DO NOT ADVISE OR MAKE RECOMMENDATIONS ABOUT ENGAGING IN DIGITAL ASSET TRANSACTIONS OR OPERATIONS. DECISIONS TO ENGAGE IN TRANSACTIONS OR PERFORM OPERATIONS INVOLVING DIGITAL ASSETS SHOULD BE TAKEN ON YOUR OWN ACCORD.',
                style: TextStyle(
                  color: black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: screenSize.width / 20,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.width / 50,
              ),
              const Text(
                'You acknowledge and agree that your use of the Services is subject to, and that we can collect, use and/or disclose your information (including any personal data you provide to us) in accordance with our Privacy Policy.',
                style: TextStyle(
                  color: black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
