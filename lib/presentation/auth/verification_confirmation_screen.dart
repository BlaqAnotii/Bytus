import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/presentation/auth/login.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:bytuswallet/util/app_button.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class VerificationConfirmation extends StatefulWidget {
  final String lname;
  final String fname;
  final String email;
  const VerificationConfirmation(
      {super.key,
      required this.lname,
      required this.fname,
      required this.email});

  @override
  State<VerificationConfirmation> createState() =>
      _VerificationConfirmationState();
}

class _VerificationConfirmationState extends State<VerificationConfirmation> {
  late String lastname;
  late String firstname;
  late String email;

  @override
  void initState() {
    super.initState();
    lastname = widget.lname;
    firstname = widget.fname;
    email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Email Verification Link Sent",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: black,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            const Text(
              "A Verification Link has been sent to your email, verify email to proceed to Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: grey,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 5.w,
                right: 5.w,
              ),
              child: AppButton(
                  color: black,
                  text: 'Proceed',
                  onPressed: () {
                    navigationService.push(
                       const LoginScreen(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
