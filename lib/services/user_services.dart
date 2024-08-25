// ignore_for_file: avoid_print, unused_local_variable

//import 'package:dio/dio.dart';
import 'dart:io';

import 'package:bytuswallet/data/error_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserServices extends ChangeNotifier {
  bool isUserLoggedIn = false;
  String authToken = "";
  bool firstLogin = false;

  Future<String> initializer() async {
    isUserLoggedIn = false;
    firstLogin = true;
    authToken = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = await _secureStorage.read(key: 'id');
     String? savedLastName = await _secureStorage.read(key: 'last_name');
    String? savedFirstName = await _secureStorage.read(key: 'first_name');
    String? userVerifiedStr = await _secureStorage.read(key: 'userVerified');
      double savedTotalBalance = double.parse(
            await _secureStorage.read(key: 'total_balance') ?? '0.00');
        double savedBtcBalance = double.parse(
            await _secureStorage.read(key: 'btc_balance') ?? '0.00');
        double savedEthBalance = double.parse(
            await _secureStorage.read(key: 'eth_balance') ?? '0.00');
        double savedBtcUnit =
            double.parse(await _secureStorage.read(key: 'btc_unit') ?? '0.00');
        double savedEthUnit =
            double.parse(await _secureStorage.read(key: 'eth_unit') ?? '0.00');

   
    notifyListeners();

    print(savedLastName);
    print(savedFirstName);

    if (userToken != null) {
      authToken = userToken;
      isUserLoggedIn = true;
    } else {
      authToken = "";
      isUserLoggedIn = false;
    }

    print("Is User Logged In:::: $isUserLoggedIn");
    firstLogin = false;
    print("USER TOKEN::: $authToken");
    print("FirstName::: $savedLastName");
    print("LastName::: $savedFirstName");
    print("USER Verified::: $userVerifiedStr");
    print("TOTAL BAL::: $savedTotalBalance");
    print("BTC BAL::: $savedBtcBalance");
    print("ETH BAL::: $savedEthBalance");
    print("BTC UNIT::: $savedBtcUnit");
    print("ETH UNIT::: $savedEthUnit");

    return authToken;
  }

  Future<void> updateToken(int newToken) async {
    await _secureStorage.write(key: 'id', value: newToken.toString());

    authToken = newToken.toString();
    isUserLoggedIn = true;
  }

  bool isAnyLoggedIn() {
    return isUserLoggedIn;
  }

  String getAuthToken() {
    return authToken;
  }

  //final Dio _dio = Dio();

  Future forgotPassword(
    Map<String, dynamic> data,
  ) async {
        String? userToken = await _secureStorage.read(key: 'user_id');

    String url = 'https://bytus.online/api/forgot-password';


    var dio = Dio(BaseOptions(baseUrl: url,  headers: {
      "Accept": "application/json",
    }));
    try {
      var response = await dio.post(url, data: data);

      final responseData = (response.data);

      // ignore: duplicate_ignore
      // ignore: avoid_print
      print(responseData);
      return responseData;
    } on DioException catch (err) {
      // ignore: prefer_interpolation_to_compose_strings
      handleError(err);
      rethrow;
    } on Exception catch (err) {
      print(err);
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future createPin(
    Map<String, dynamic> data,
  ) async {
        String? userToken = await _secureStorage.read(key: 'user_id');

    String url = 'https://bytus.online/api/create-pin/$userToken';


    var dio = Dio(BaseOptions(baseUrl: url, followRedirects: true, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $userToken"
    }));
    try {
      var response = await dio.post(url, data: data);

      final responseData = (response.data);

      // ignore: duplicate_ignore
      // ignore: avoid_print
      print(responseData);
      return responseData;
    } on DioException catch (err) {
      // ignore: prefer_interpolation_to_compose_strings
      handleError(err);
      rethrow;
    } on Exception catch (err) {
      print(err);
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future updatePersonalInfo(
    Map<String, dynamic> data,
  ) async {
        String? userToken = await _secureStorage.read(key: 'id');

    String url = 'https://bytus.online/api/update-personal-info/$userToken';


    var dio = Dio(BaseOptions(baseUrl: url, followRedirects: true, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $userToken"
    }));
    try {
      var response = await dio.post(url, data: data);

      final responseData = (response.data);
      final phone = responseData['data']['phone_number'];
      final dob = responseData['data']['date_of_birth'];
      final country = responseData['data']['country'];
      final state = responseData['data']['state'];

      await _secureStorage.write(key: 'phone_number', value: phone);
      await _secureStorage.write(key: 'date_of_birth', value: dob);
      await _secureStorage.write(key: 'country', value: country);
      await _secureStorage.write(key: 'state', value: state);
      String? savedPhone = await _secureStorage.read(key: 'phone_number');
      String? savedDob = await _secureStorage.read(key: 'date_of_birth');
      String? savedCountry = await _secureStorage.read(key: 'country');
      String? savedState = await _secureStorage.read(key: 'state');

      print("FirstName:::::: $savedPhone");
      print("FirstName:::::: $savedDob");
      print("FirstName:::::: $savedCountry");
      print("FirstName:::::: $savedState");

      // ignore: duplicate_ignore
      // ignore: avoid_print
      print(responseData);
      return responseData;
    } on DioException catch (err) {
      // ignore: prefer_interpolation_to_compose_strings
      handleError(err);
      rethrow;
    } on Exception catch (err) {
      print(err);
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<bool> uploadDoc({
    required File frontPhoto,
    required File backPhoto,
  }) async {
        String? userToken = await _secureStorage.read(key: 'id');

    String url = 'https://bytus.online/api/upload-documents/$userToken';

    var dio = Dio(BaseOptions(baseUrl: url, followRedirects: true, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $userToken"
    }));
    try {
      String frontPhotoFilename = path.basename(frontPhoto.path);
      String backPhotoFilename = path.basename(backPhoto.path);
      var formData = FormData.fromMap({
        'id_back_photo': await MultipartFile.fromFile(frontPhoto.path,
            filename: frontPhotoFilename),
        'id_front_photo': await MultipartFile.fromFile(backPhoto.path,
            filename: backPhotoFilename),
      });
      final response = await dio.post(
        '',
        data: formData,
      );

      final responseData = response.data;

      final pinCreated = responseData['data']['pinCreated'];
      final updateInfo = responseData['data']['updateInfo'];
      final uploadDoc = responseData['data']['uploadDoc'];
      final userVerified = responseData['data']['userVerified'];
      await _secureStorage.write(
          key: 'pinCreated', value: pinCreated.toString());
      await _secureStorage.write(
          key: 'updateInfo', value: updateInfo.toString());
      await _secureStorage.write(key: 'uploadDoc', value: uploadDoc.toString());
      await _secureStorage.write(
          key: 'userVerified', value: userVerified.toString());

      print(responseData);

      return responseData['status'];
    } on DioException catch (err) {
      handleError(err);
      print(err);
      rethrow;
    } on Exception catch (err) {
      print(err);
      rethrow;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  final _secureStorage = const FlutterSecureStorage();

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove the token
    await _secureStorage.delete(key: 'user_id');

    // Set first_run to false if required

    // Reinitialize the authentication state
    await initializer();

    return true;
  }
}

class UserPreferences {
  static Future<void> setRegistered(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRegistered', value);
  }

  static Future<bool> isRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isRegistered') ?? false;
  }

  static Future<void> setPinCreated(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPinCreated', value);
  }

  static Future<bool> isPinCreated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isPinCreated') ?? false;
  }

  static Future<void> clearRegistrationData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isRegistered');
    await prefs.remove('isPinCreated');
  }
}
