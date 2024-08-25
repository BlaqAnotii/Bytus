// ignore_for_file: avoid_print, non_constant_identifier_names, duplicate_ignore, unnecessary_string_interpolations, unused_local_variable, prefer_interpolation_to_compose_strings

// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'dart:io';

import 'package:bytuswallet/data/error_handler.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';

import 'package:bytuswallet/data/https.dart';
import 'package:bytuswallet/data/url_path.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository {
  final _secureStorage = const FlutterSecureStorage();
  final Dio _dio = Dio();
  Future register(Map<String, dynamic> data) async {
    String urlRegister = 'https://bytus.online/api/register';

    try {
      final response = await _dio.post(
        urlRegister,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: data,
      );
      final responseData = response.data;
      if (responseData['status'] == true) {
        final email = responseData['data']['email'];
        await _secureStorage.write(key: 'email', value: email);
      } else {
        print("Error: ${responseData['message']}");
      }

      print(responseData);
      return responseData;
    } on DioException catch (err) {
      print("error happening @ " + urlRegister);
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

  Future login(
    Map<String, dynamic> data,
  ) async {
    String urlRegister = 'https://bytus.online/api/login';

    try {
      final response = await _dio.post(
        urlRegister,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: data,
      );
      final responseData = response.data;

      if (response.statusCode == 200) {
        final iD = responseData['user']['id'].toString();

        final lastName = responseData['user']['last_name'];
        final firstName = responseData['user']['first_name'];
        final email = responseData['user']['email'];

        final totalBalance = double.tryParse(
                responseData['user']['total_balance']?.toString() ?? "0.00") ??
            0.00;
        final btcBalance = double.tryParse(
                responseData['user']['btc_balance']?.toString() ?? "0.00") ??
            0.00;
        final ethBalance = double.tryParse(
                responseData['user']['eth_balance']?.toString() ?? "0.00") ??
            0.00;
        final btcUnit = double.tryParse(
                responseData['user']['btc_unit']?.toString() ?? "0.00") ??
            0.00;
        final ethUnit = double.tryParse(
                responseData['user']['eth_unit']?.toString() ?? "0.00") ??
            0.00;
        // Save data using Flutter Secure Storage
        await _secureStorage.write(key: 'id', value: iD);

        await _secureStorage.write(key: 'last_name', value: lastName);
        await _secureStorage.write(key: 'first_name', value: firstName);
        await _secureStorage.write(key: 'email', value: email);
        await _secureStorage.write(
            key: 'total_balance', value: totalBalance.toString());
        await _secureStorage.write(
            key: 'btc_balance', value: btcBalance.toString());
        await _secureStorage.write(
            key: 'eth_balance', value: ethBalance.toString());
        await _secureStorage.write(key: 'btc_unit', value: btcUnit.toString());
        await _secureStorage.write(key: 'eth_unit', value: ethUnit.toString());

        // Read saved data
        String? id = await _secureStorage.read(key: 'id');
        String? savedLastName = await _secureStorage.read(key: 'last_name');
        String? savedFirstName = await _secureStorage.read(key: 'first_name');
        String? savedEmail = await _secureStorage.read(key: 'email');
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

        // Print saved data
        print("ID:::::: $id");

        print("Last Name:::::: $savedLastName");
        print("First Name:::::: $savedFirstName");
        print("Email:::::: $savedEmail");
        print("Total Balance:::::: $savedTotalBalance");
        print("BTC Balance:::::: $savedBtcBalance");
        print("ETH Balance:::::: $savedEthBalance");
        print("BTC Unit:::::: $savedBtcUnit");
        print("ETH Unit:::::: $savedEthUnit");
        print("RESPONSE:::::: $responseData");

        return responseData;
      }
    } on DioException catch (err) {
      // ignore: prefer_interpolation_to_compose_strings
      print("error happening @ " + urlRegister);
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
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await httpPost(UrlPath.createpin, data);
    final responseData = response.data;
    // ignore: unused_local_variable

    print(responseData);

    return responseData;
  }

  Future updatePersonalInfo(
    Map<String, dynamic> data,
  ) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await httpPost(UrlPath.updateInfo, data);
    final responseData = response.data;
    // ignore: unused_local_variable

    print(responseData);

    return responseData;
  }

  Future<bool> uploadDoc({
    required File frontPhoto,
    required File backPhoto,
  }) async {
    const url = 'https://bytus.online/api/upload-documents';
    try {
      String frontPhotoFilename = path.basename(frontPhoto.path);
      String backPhotoFilename = path.basename(backPhoto.path);
      var formData = FormData.fromMap({
        'front_photo': await MultipartFile.fromFile(frontPhoto.path,
            filename: frontPhotoFilename),
        'back_photo': await MultipartFile.fromFile(backPhoto.path,
            filename: backPhotoFilename),
      });
      final response = await Dio().post(
        url,
        data: formData,
      );

      final responseData = response.data;

      print(responseData);

      return responseData;
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

  Future forgetPwd(
    Map<String, dynamic> data,
  ) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    var response = await httpPost(UrlPath.forgotPassword, data);
    final responseData = response.data;
    // ignore: unused_local_variable

    print(responseData);

    return responseData;
  }

  final String apiKey = 'c67053df39527722a4e950f6752301118fcfe530';

  Future<Map<String, dynamic>> createWalletAddress() async {
    String? userToken = await _secureStorage.read(key: 'user_id');
    String? userWalletiD = await _secureStorage.read(key: 'walletId');
    String? email = await _secureStorage.read(key: 'Email');

    String apiUrl =
        'https://rest.cryptoapis.io/wallet-as-a-service/wallets/$userWalletiD/bitcoin/testnet/addresses/';

    Map<String, dynamic> requestBody = {
      "context": "yourExampleString",
      "data": {
        "item": {"label": email}
      }
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'X-API-Key': apiKey,
        "Authorization": "Bearer $userToken"
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      String address = responseBody['data']['item']['address'];
      // Save the address using SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await _secureStorage.write(key: 'address', value: address);

      String? savedBTCaddress = await _secureStorage.read(key: 'address');

      print("btcwallletaddress:::::$savedBTCaddress");

      return responseBody;
    } else {
      throw Exception('Failed to create wallet address: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> createEthWalletAddress() async {
    String? userToken = await _secureStorage.read(key: 'user_id');
    String? userWalletiD = await _secureStorage.read(key: 'walletId');
    String? email = await _secureStorage.read(key: 'Email');

    String apiUrl2 =
        'https://rest.cryptoapis.io/wallet-as-a-service/wallets/$userWalletiD/ethereum/sepolia/addresses/';

    Map<String, dynamic> requestBody = {
      "context": "yourExampleString",
      "data": {
        "item": {"label": email}
      }
    };

    final response = await http.post(
      Uri.parse(apiUrl2),
      headers: {
        'Content-Type': 'application/json',
        'X-API-Key': apiKey,
        "Authorization": "Bearer $userToken"
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      String address = responseBody['data']['item']['address'];

      // Save the address using SharedPreferences
      await _secureStorage.write(key: 'address', value: address);

      String? savedEthaddress = await _secureStorage.read(key: 'eth_address');

      print('ETH:::::$savedEthaddress');

      return responseBody;
    } else {
      throw Exception('Failed to create ETH wallet address: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> createWalletID() async {
    const String apiUrl =
        'https://rest.cryptoapis.io/wallet-as-a-service/wallets/generate';
    String? userToken = await _secureStorage.read(key: 'user_id');
    String? name = await _secureStorage.read(key: 'first_name');

    Map<String, dynamic> requestBody = {
      "context": "yourExampleString",
      "data": {
        "item": {"walletName": name, "walletType": "test"}
      }
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'X-API-Key': apiKey,
        "Authorization": "Bearer $userToken"
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      String walletID = responseBody['data']['item']['walletId'];
      // Save the address using SharedPreferences
      await _secureStorage.write(key: 'walletId', value: walletID);
      String? wName = await _secureStorage.read(key: 'walletId');

      print("WalletID:::::$wName");

      return responseBody;
    } else {
      throw Exception('Failed to create wallet address: ${response.body}');
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> storeTokens(String accessToken, String refreshToken, int expiresIn) async {
  await _secureStorage.write(key: 'access_token', value: accessToken);
  await _secureStorage.write(key: 'refresh_token', value: refreshToken);
  final expirationTime = DateTime.now().add(Duration(seconds: expiresIn));
  await _secureStorage.write(key: 'expiration_time', value: expirationTime.toIso8601String());
}

final String _tokenUrl = 'https://login.venly.io/auth/realms/Arkane/protocol/openid-connect/token';

  Future<void> authenticate() async {
    final url = Uri.parse(_tokenUrl);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
        'client_id': '194c6a44-9b26-4a69-8f0c-e7c00d8fdfa9',
        'client_secret': '2CIDqS6eqPAOTSlzmEndWhTWOPr0x0j5',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final accessToken = data['access_token'];
      final expiresIn = data['expires_in'];

      await _secureStorage.write(key: 'access_token', value: accessToken);
      await _secureStorage.write(key: 'expires_in', value: expiresIn.toString());

      final expirationTime = DateTime.now().add(Duration(seconds: expiresIn));
      await _secureStorage.write(key: 'expiration_time', value: expirationTime.toIso8601String());

      print('Authenticated successfully. Access token: $accessToken');
      print('Expires in: $expiresIn');

      _scheduleTokenRefresh(expiresIn);

    } else {
      print('Failed to authenticate: ${response.body}');
    }
  }

  void _scheduleTokenRefresh(int expiresIn) {
    // Schedule the token refresh a few minutes before it actually expires
    final refreshTime = (expiresIn - 120) * 1000; // Refresh 2 minutes before expiration
    Future.delayed(Duration(milliseconds: refreshTime), authenticate);
  }

  Future<void> checkTokenExpiry() async {
    final expirationTimeString = await _secureStorage.read(key: 'expiration_time');
    if (expirationTimeString != null) {
      final expirationTime = DateTime.parse(expirationTimeString);
      if (DateTime.now().isAfter(expirationTime.subtract(const Duration(minutes: 2)))) {
        await authenticate();
      }
    }
  }

  Future<String?> getValidAccessToken() async {
    await checkTokenExpiry();
    return await _secureStorage.read(key: 'access_token');
  }


  String signingMethodId = '';
  String userId = '';
  Future<String?> createUser() async {
    // Retrieve email and access token from secure storage
    String? savedEmail = await _secureStorage.read(key: 'email');
   

    // Define the URL
    final url = Uri.parse('https://api-wallet.venly.io/api/users');

    try {
      // Make the POST request
       final accessToken = await getValidAccessToken();
  if (accessToken != null) {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: json.encode(
          {
            'reference': savedEmail,
            'signingMethod': {
              'type': 'PIN',
              'value': '070331',
            },
          },
        ),
      );

      // Print the response for debugging
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Check the status code
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        userId = data['result']['id'];
        signingMethodId = data['result']['signingMethods'][0]['id'];

        // Save the user ID and signing method ID in secure storage
        await _secureStorage.write(key: 'user_Id', value: userId);
        await _secureStorage.write(key: 'method_Id', value: signingMethodId);

        return userId;
      } else {
        print('Failed to create user: ${response.body}');
        return null;
      }
       } else {
    print('No valid access token available.');
  }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
    return null;
  }


  Future<String?> createBtcWallet() async {
    String? savedId = await _secureStorage.read(key: 'user_Id');
    String? savedmethod = await _secureStorage.read(key: 'method_Id');

    // Ensure savedId is not null
    if (savedId == null) {
      print('No ID saved in secure storage.');
      return null;
    }

    print('Method Token: $savedmethod');

    final url = Uri.parse('https://api-wallet.venly.io/api/wallets');

    print(url);
 final accessToken = await getValidAccessToken();
  if (accessToken != null) {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Signing-Method': '$savedmethod:070331'
      },
      body: json.encode({
        "secretType": "BITCOIN",
        "userId": savedId,
      }),
    );

    // Print the response for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
     await _secureStorage.write(key: 'wallet_id', value: data['result']['id']);
      await _secureStorage.write(key: 'wallet_address', value: data['result']['address']);
      await _secureStorage.write(key: 'wallet_type', value: data['result']['walletType']);
      await _secureStorage.write(key: 'secret_type', value: data['result']['secretType']);
      await _secureStorage.write(key: 'description', value: data['result']['description']);
      await _secureStorage.write(key: 'user_id', value: data['result']['userId']);

      // Save balance details
      await _secureStorage.write(key: 'balance_secret_type', value: data['result']['balance']['secretType']);
      await _secureStorage.write(key: 'balance', value: data['result']['balance']['balance'].toString());
      await _secureStorage.write(key: 'gas_balance', value: data['result']['balance']['gasBalance'].toString());
      await _secureStorage.write(key: 'balance_symbol', value: data['result']['balance']['symbol']);
      await _secureStorage.write(key: 'gas_symbol', value: data['result']['balance']['gasSymbol']);
      await _secureStorage.write(key: 'raw_balance', value: data['result']['balance']['rawBalance']);
      await _secureStorage.write(key: 'raw_gas_balance', value: data['result']['balance']['rawGasBalance']);
      await _secureStorage.write(key: 'decimals', value: data['result']['balance']['decimals'].toString());
    } else if (response.statusCode == 400) {
      final errorData = json.decode(response.body);
      if (errorData['errors'] != null) {
        for (var error in errorData['errors']) {
          if (error['code'] == 'pin.exists') {
            print('PIN signing method already exists.');
            return null; // Or handle this case as needed
          }
        }
      }
      print('Failed to create Wallet: ${response.body}');
      return null;
    } else {
      print('Failed to create Wallet method: ${response.body}');
      return null;
    } } else {
    print('No valid access token available.');
  }
  return null;
  }

   Future<String?> createEthWallet() async {
    String? savedId = await _secureStorage.read(key: 'user_Id');
    String? savedmethod = await _secureStorage.read(key: 'method_Id');

    // Ensure savedId is not null
    if (savedId == null) {
      print('No ID saved in secure storage.');
      return null;
    }

    print('Method Token: $savedmethod');

    final url = Uri.parse('https://api-wallet.venly.io/api/wallets');

    print(url);
 final accessToken = await getValidAccessToken();
  if (accessToken != null) {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
        'Signing-Method': '$savedmethod:070331'
      },
      body: json.encode({
        "secretType": "ETHEREUM",
        "userId": savedId,
      }),
    );

    // Print the response for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
   await _secureStorage.write(key: 'eth_wallet_id', value: data['result']['id']);
      await _secureStorage.write(key: 'eth_wallet_address', value: data['result']['address']);
      await _secureStorage.write(key: 'wallet_type', value: data['result']['walletType']);
      await _secureStorage.write(key: 'secret_type', value: data['result']['secretType']);
      await _secureStorage.write(key: 'description', value: data['result']['description']);
      await _secureStorage.write(key: 'user_id', value: data['result']['userId']);

      // Save balance details
      await _secureStorage.write(key: 'balance_available', value: data['result']['balance']['available'].toString());
      await _secureStorage.write(key: 'balance_secret_type', value: data['result']['balance']['secretType']);
      await _secureStorage.write(key: 'balance', value: data['result']['balance']['balance'].toString());
      await _secureStorage.write(key: 'gas_balance', value: data['result']['balance']['gasBalance'].toString());
      await _secureStorage.write(key: 'balance_symbol', value: data['result']['balance']['symbol']);
      await _secureStorage.write(key: 'gas_symbol', value: data['result']['balance']['gasSymbol']);
      await _secureStorage.write(key: 'raw_balance', value: data['result']['balance']['rawBalance']);
      await _secureStorage.write(key: 'raw_gas_balance', value: data['result']['balance']['rawGasBalance']);
      await _secureStorage.write(key: 'decimals', value: data['result']['balance']['decimals'].toString());
    } else if (response.statusCode == 400) {
      final errorData = json.decode(response.body);
      if (errorData['errors'] != null) {
        for (var error in errorData['errors']) {
          if (error['code'] == 'pin.exists') {
            print('PIN signing method already exists.');
            return null; // Or handle this case as needed
          }
        }
      }
      print('Failed to create Wallet: ${response.body}');
      return null;
    } else {
      print('Failed to create Wallet method: ${response.body}');
      return null;
    } } else {
    print('No valid access token available.');
  }
  return null;
  }


  
}
