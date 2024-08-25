// ignore_for_file: avoid_print, duplicate_ignore

//import 'dart:io';

import 'dart:convert';
import 'dart:io';

import 'package:bytuswallet/base/base_vm.dart';
import 'package:bytuswallet/presentation/auth/id_verification.dart';
import 'package:bytuswallet/presentation/auth/login.dart';
import 'package:bytuswallet/presentation/auth/personal_info.dart';
import 'package:bytuswallet/presentation/auth/verification_confirmation_screen.dart';
import 'package:bytuswallet/presentation/bottom_navbar/bottom_navbar.dart';
import 'package:bytuswallet/util/toast.dart';
import 'package:flutter/material.dart';
//import 'package:device_info_plus/device_info_plus.dart';
//import 'package:flutter/material.dart';

//import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends BaseViewModel {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController otp = TextEditingController();

  final TextEditingController phone = TextEditingController();
  final TextEditingController dob = TextEditingController();



  String? state;
  String? country;
  String pin = "";

  File? image;
  String path = '';

  bool isHidden = true;
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  // final otpformKey = GlobalKey<FormState>();

  // String? selectedCode;

  String fName = '';
  String lName = '';
  String eMail = '';

  Future processSignUp() async {
    try {
      startLoader();

      var data = {
        "first_name": firstName.text.trim(),
        "last_name": lastName.text.trim(),
        "email": email.text.trim(),
        "password": password.text.trim(),
      };
      var response = await authRepo.register(data);
     await authRepo.authenticate();
      await authRepo.createUser();
      print(response);

      //await userServices.initializer();

      showCustomToast("Registration Successful", success: true);
      stopLoader();
      navigationService.pushAndReplace(
        VerificationConfirmation(
          lname: lName,
          fname: fName,
          email: eMail,
        ),
      );
    } catch (e, l) {
      stopLoader();
      print(e);
      print(l);
    }
    return null;
  }

  // // Future<void> navigateToOtpScreen() async {
  // //   var response = await processSignUp();
  // //   if (response != null) {
  // //     String verificationCode = response['data']['verificationCode'] as String;
  // //     String username = response['data']['username']
  // //         as String; // Assuming username is returned in the response
  // //     navigationService.push(const OtpScreen(
  // //         // verificationCode: verificationCode,
  // //         // username: username,
  // //         ));
  // //   } else {
  // //     // Handle registration failure
  // //     print('cant read this');
  // //   }
  // // }

  // Future verifyEmail(String username) async {
  //   try {
  //     startLoader();

  //     var response = await authRepo.verifyEmail(
  //       code: otp.text.trim(),
  //       username: username,
  //     );

  //     print(response);

  //     showCustomToast("Email Verified Successfully", success: true);
  //     stopLoader();
  //     navigationService.push(const LoginScreen());

  //     // Handle post verification actions here, such as navigating to the home screen
  //   } catch (e, l) {
  //     stopLoader();
  //     print(e);
  //     print(l);
  //   }
  // }

  // Future reVerifyEmail(String email) async {
  //   try {
  //     startLoader();

  //     var response = await authRepo.reVerifyEmail(
  //       email: email,
  //     );

  //     print(response);

  //     showCustomToast("Otp resent to your email", success: true);
  //     stopLoader();

  //     // Handle post verification actions here, such as navigating to the home screen
  //   } catch (e, l) {
  //     stopLoader();
  //     print(e);
  //     print(l);
  //   }
  // }

  Future processForgotPwd() async {
    try {
      startLoader();

      var data = {"email": email.text.trim()};

      var response = await authRepo.forgetPwd(data);

      print(response);
      //await userServices.initializer();

      showCustomToast("A password reset link has been sent to your email",
          success: true);
      navigationService.push(const LoginScreen());

      stopLoader();

      // Handle post verification actions here, such as navigating to the home screen
    } catch (e, l) {
      stopLoader();
      print(e);
      print(l);
    }
  }

  Future processCreatePin() async {
    try {
      startLoader();

      

      //await userServices.initializer();

      showCustomToast("Pin Created", success: true);
      stopLoader();
      navigationService.push(const PersonalInfoScreen());

      // Handle post verification actions here, such as navigating to the home screen
    } catch (e, l) {
      stopLoader();
      print(e);
      print(l);
    }
  }

  Future processUploadDoc(File frontPhoto, File backPhoto) async {
    try {
      startLoader();

      var response = await authRepo.uploadDoc(
        frontPhoto: frontPhoto,
        backPhoto: backPhoto,
      );

      print(response);
      await userServices.initializer();

      showCustomToast("Upload Successful", success: true);
      stopLoader();

      // Handle post verification actions here, such as navigating to the home screen
    } catch (e, l) {
      stopLoader();
      print(e);
      print(l);
    }
  }

  Future processUpdateInfo() async {
    try {
      startLoader();

      var data = {
        "phone_number": phone.text.trim(),
        "date_of_birth": dob.text.trim(),
        "country": country,
        "state": state,
      };

      var response = await userServices.updatePersonalInfo(data);

      //  SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? userToken = prefs.getString('token');

      print(response);
      await userServices.initializer();

      showCustomToast("Updated succcessfully", success: true);
      stopLoader();
      navigationService.pushAndReplace(const IdVerificationScreen());

      // Handle post verification actions here, such as navigating to the home screen
    } catch (e, l) {
      stopLoader();
      print(e);
      print(l);
    }
  }

  String btcWALLET = '';
  String ethWALLET = '';
  bool rememberMe = false;

  Future attemptLogin() async {
    try {
      startLoader();

      var data = {
        "email": email.text.trim(),
        "password": password.text.trim(),
      };

      var response = await authRepo.login(data);
     // await authRepo.createSigningMethod();

      var newToken = response['user']['id'];

        if (response['user']['email_verified_at'] == null) {
        stopLoader();
        showCustomToast('Please Verify your mail to enable you login',
            success: false);
      } else {
        stopLoader();
          await userServices.updateToken(newToken);
      await userServices.initializer();
      showCustomToast("Login Successful", success: true);
      navigationService.pushAndReplace(const BottomNavBarScreen());
      }
    
    } catch (e, l) {
      stopLoader();
      print(e);
      print(l);
    }
  }
  // String deviceModel = '';
  // String deviceOS = '';
  // String osVersion = '';
  // String deviceBrand = '';
  // String deviceId = '';

  // Future getDeviceInfo() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     deviceModel = androidInfo.model;
  //     deviceOS = 'Android';
  //     osVersion = androidInfo.version.release;
  //     deviceBrand = androidInfo.brand;
  //     deviceId = androidInfo.id;
  //   } else if (Platform.isIOS) {
  //     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     deviceModel = iosInfo.utsname.machine;
  //     deviceOS = 'iOS';
  //     osVersion = iosInfo.systemVersion;
  //     deviceBrand = 'Apple'; // Apple devices have a fixed brand
  //     deviceId = iosInfo.identifierForVendor ?? 'Unknown';
  //   }

  //   print('DEVICE MODEL:::::: $deviceModel');
  //   print('DEVICE OS:::::: $deviceOS');
  //   print('DEVICE OS VERSION:::::: $osVersion');
  //   print('DEVICE BRAND:::::: $deviceBrand');
  //   print('DEVICE ID:::::: $deviceId');
  // }
}
