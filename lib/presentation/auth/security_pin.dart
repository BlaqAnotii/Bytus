import 'package:bytuswallet/base/base_ui.dart';
import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/custom_widgets/pin_code_field.dart';
import 'package:bytuswallet/services/auth_view_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class SecurityPinScreen extends StatefulWidget {
  const SecurityPinScreen({super.key});

  @override
  State<SecurityPinScreen> createState() => _SecurityPinScreenState();
}

class _SecurityPinScreenState extends State<SecurityPinScreen> {
  String pin = "";
  // PinTheme pinTheme = PinTheme(
  //   keysColor: Colors.white,
  // );

  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);

    // double width = SizeConfig.screenW!;
    // double height = SizeConfig.screenH!;
    return BaseView<AuthViewModel>(
                    onModelReady: (model) {},

      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: black,
          body: Form(
            key: model.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Text(
                    'Create Pin',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  ' Please enter a 6 digit number to create your security pin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                 PinCodeTextField(
                                      cursorColor: black,
                                      length: 6,
                                      textStyle: const TextStyle(
                                          color: black),
                                      appContext: context,
                                      obscureText: false,
                                      keyboardType: TextInputType.number,
                                      animationType: AnimationType.fade,
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      enableActiveFill: true,
                                      backgroundColor: Colors.transparent,
                                      controller: model.otp,
                                      onCompleted: (code) async {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        if (model.formKey.currentState!
                                            .validate()) {
                                          // ignore: avoid_print
            
                                          model.processCreatePin();
                                        }
                                      },
                                      onChanged: (val) {},
                                    ),
              ],
            ),
          ),
        );
      }
    );
  }
}
