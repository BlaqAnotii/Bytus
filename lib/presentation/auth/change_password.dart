import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/util/app_button.dart';
import 'package:bytuswallet/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _isHidden = true;
  bool isChecked = false;
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    return Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height * .25,
                color: black,
                child: Image.asset(
                  "assets/images/bytus3.jpg",
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                width: width,
                clipBehavior: Clip.none,
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      ' New Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'Enter your New Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: grey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 8),
                      child: TextFormField(
                        obscureText: _isHidden,
                        controller: password,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Mulish",
                          ),

                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isHidden = !_isHidden;
                              });
                            },
                            icon: Icon(_isHidden
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          contentPadding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 5),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0.3),
                            borderRadius: BorderRadius.circular(5),
                          ),

                          //enabledBorder: InputBorder.none),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password can't be empty ";
                          } else if (value.length < 6) {
                            return 'Length of password should be greater than 6';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
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
                          // navigationService.push(const SecurityPinScreen());
                        },
                      ),
                    ),
                    SizedBox(
                      height: Adaptive.h(10),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
