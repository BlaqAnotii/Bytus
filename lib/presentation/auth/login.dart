import 'package:bytuswallet/base/base_ui.dart';
import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/presentation/auth/reset_password.dart';
import 'package:bytuswallet/presentation/auth/sign_up.dart';
import 'package:bytuswallet/presentation/bottom_navbar/bottom_navbar.dart';
import 'package:bytuswallet/presentation/main_screens/users_details.dart';
import 'package:bytuswallet/services/auth_view_services.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:bytuswallet/util/app_button.dart';
import 'package:bytuswallet/util/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<LoginScreen> {
  bool _isHidden = true;
  bool isChecked = false;
  //final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  // AuthViewModel authservice = AuthViewModel();

  // void _loadEmail() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     authservice.email.text = prefs.getString('email') ?? '';
  //     authservice.rememberMe = prefs.getBool('remember_me') ?? false;
  //   });
  // }

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
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
                            ' Welcome Back!',
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
                            ' Please Log In to Continue',
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
                              obscureText: _isHidden,
                              controller: model.password,
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
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 8.w,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  navigationService
                                      .push(const ResetPasswordScreen());
                                },
                                child: const Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                    color: offcolor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              right: 5.w,
                            ),
                            child: AppButton(
                              color: black,
                              text: 'Login',
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (model.formKey.currentState!.validate()) {
                                  model.attemptLogin();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Don't have an Account?",
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
                                    navigationService
                                        .push(const SignUpScreen());
                                  },
                                  child: Text(
                                    "SignUp",
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
                          SizedBox(
                            height: Adaptive.h(8),
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
