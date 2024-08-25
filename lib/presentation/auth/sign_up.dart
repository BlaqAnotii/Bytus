import 'package:bytuswallet/base/base_ui.dart';
import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/presentation/auth/login.dart';
import 'package:bytuswallet/presentation/main_screens/terms_of_use.dart';
import 'package:bytuswallet/services/auth_view_services.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:bytuswallet/util/app_button.dart';
import 'package:bytuswallet/util/size_config.dart';
import 'package:bytuswallet/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //bool _isHidden = true;
  bool isChecked = false;
  //final _formKey = GlobalKey<FormState>();

  final TextEditingController fname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

  final TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    return BaseView<AuthViewModel>(
        onModelReady: (model) {},
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: black,
            body: SingleChildScrollView(
              child: Form(
                key: model.formKey,
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
                            height: 2.h,
                          ),
                          Text(
                            ' Welcome to Bytus Wallet',
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
                            ' Please enter the following details below to get started.',
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 7),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                controller: model.firstName,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Mulish",
                                  ),

                                  contentPadding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    left: 5,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 0.3,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  hintText: "First Name",

                                  //enabledBorder: InputBorder.none),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 7),
                              child: TextFormField(
                                keyboardType: TextInputType.name,
                                controller: model.lastName,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Mulish",
                                  ),

                                  contentPadding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    left: 5,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 0.3,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  hintText: "Last Name",

                                  //enabledBorder: InputBorder.none),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Name is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 7),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: model.email,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.mail),
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Mulish",
                                  ),

                                  contentPadding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    left: 5,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 0.3,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  hintText: "example@mail.com",

                                  //enabledBorder: InputBorder.none),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is Required';
                                  } else if (!value.contains(
                                    RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"),
                                  )) {
                                    return 'Enter a correct email address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 8),
                            child: TextFormField(
                              obscureText: model.isHidden,
                              controller: model.password,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Mulish",
                                ),

                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      model.isHidden = !model.isHidden;
                                    });
                                  },
                                  icon: Icon(model.isHidden
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
                            height: 1.h,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 8),
                            child: TextFormField(
                              obscureText: model.isHidden,
                              controller: model.confirmPassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                hintText: 'Confirm Password',
                                hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Mulish",
                                ),

                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      model.isHidden = !model.isHidden;
                                    });
                                  },
                                  icon: Icon(model.isHidden
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
                          const SizedBox(height: 10),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 22,
                              ),
                              child: Text(
                                "By Signing up, You have agreed to the terms and conditions of Bytus Wallet",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
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
                              text: 'Get Started',
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (model.formKey.currentState!.validate()) {
                                  if (model.confirmPassword.text !=
                                      model.password.text) {
                                    showCustomToast("Passwords do not match!");
                                    return;
                                  }
                                  model.processSignUp();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Already have an Account?",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Adaptive.w(3),
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    navigationService.push(const LoginScreen(
                                     
                                    ));
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      color: offcolor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                navigationService
                                    .push(const TermsandConditionScreen());
                              },
                              child: Text(
                                "Terms and Condition >>>",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: offcolor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Adaptive.h(5),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
