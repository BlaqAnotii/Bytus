// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/repository/auth_repository.dart';
import 'package:bytuswallet/util/app_button.dart';
import 'package:bytuswallet/util/data.dart';
import 'package:bytuswallet/util/dropdown.dart';
import 'package:bytuswallet/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:oktoast/oktoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendBtc extends StatefulWidget {
  const SendBtc({super.key});

  @override
  State<SendBtc> createState() => _SendBtcState();
}

class _SendBtcState extends State<SendBtc> {
  // bool _isDropdownError = false;

  // String? selectedCode;
  // String? selectedcode;

  // List<String> options = countryCODE.values.toList();

  // void _validateDropdown() {
  //   setState(() {
  //     _isDropdownError = selectedCode == null;
  //   });
  // }

  @override
  void initState() {
    super.initState();
  }

  final TextEditingController amount = TextEditingController();
  final TextEditingController receiver = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String transactionResult = '';
  String? usdEquivalent;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  AuthRepository authRepo = AuthRepository();

  bool _isLoading = false;

  void startLoader() {
    setState(() {
      _isLoading = true;
    });
  }

  void stopLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> sendBTC() async {
    String? userWalletiD = await _secureStorage.read(key: 'wallet_id');
    String? savedmethod = await _secureStorage.read(key: 'method_Id');

    print('Method Token: $savedmethod');

    final url =
        Uri.parse('https://api-wallet.venly.io/api/transactions/execute');

    print(url);
    startLoader();
    final accessToken = await authRepo.getValidAccessToken();
    if (accessToken != null) {
      // Get the current BTC to USD conversion rate
      final usdEquivalent = await getBTCRateInUSD(amount.text);
      if (usdEquivalent == null) {
        stopLoader();
        print('Failed to fetch BTC to USD conversion rate.');
        return;
      }
      print('USD Equivalent: $usdEquivalent');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
          'Signing-Method': '$savedmethod:070331'
        },
        body: json.encode({
          "transactionRequest": {
            "walletId": userWalletiD,
            'to': receiver.text,
            "secretType": "BITCOIN",
            "type": "TRANSFER",
            "value": amount.text,
          }
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final totalTransactionAmount =
            responseBody['result']['transactionDetails']['value'];

        if (totalTransactionAmount == '0.00000000') {
          stopLoader();
          _showSupportTeamDialog();
          print('insufficient funds::');
        } else {
          stopLoader();
          showCustomToast('Bitcoin sent successfully', success: true);
        }
      } else {
        stopLoader();
        print(
            'Failed to send transaction request: ${response.statusCode} ${response.body}');
        setState(() {
          transactionResult =
              'Failed to send transaction request: ${response.statusCode} ${response.body}';
        });
        _showSupportTeamDialog();
      }
    } else {
      print('No Access Token');
    }
  }

  Future<void> updateUSDEquivalent(String amount) async {
    if (amount.isEmpty) {
      setState(() {
        usdEquivalent = null;
      });
      return;
    }

    final usdValue = await getBTCRateInUSD(amount);
    setState(() {
      usdEquivalent = usdValue != null ? usdValue.toStringAsFixed(2) : 'N/A';
    });
  }

  Future<double?> getBTCRateInUSD(String amount) async {
    const String apiKey = 'c192c0f5-2208-44fb-a44a-ec7fa13bcc26';
    final url = Uri.parse(
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=BTC&convert=USD');

    final response = await http.get(url, headers: {
      'X-CMC_PRO_API_KEY': apiKey,
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final btcToUsdRate = responseBody['data']['BTC']['quote']['USD']['price'];

      final double amountInBtc = double.parse(amount);
      final usdEquivalent = amountInBtc * btcToUsdRate;
      return usdEquivalent;
    } else {
      print(
          'Failed to fetch BTC to USD conversion rate: ${response.statusCode}');
      return null;
    }
  }

  void _showSupportTeamDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contact Support'),
          content: const Text(
              'Contact our support team to\ngenerate a secret to complete.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            const Divider(),
            SizedBox(
              height: 2.h,
            ),
            Text(
              'Send Bitcoin',
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
              'You can safely send Bitcoin to others',
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
                padding: const EdgeInsets.only(left: 20, right: 20, top: 7),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: amount,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.payment),
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
                    hintText: "Enter Bitcoin amount (e.g., 0.003)",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    updateUSDEquivalent(value);
                  },
                ),
              ),
            ),
            if (usdEquivalent != null) ...[
              SizedBox(
                height: 1.h,
              ),
              Text(
                '\$${usdEquivalent!}',
                style: TextStyle(
                  color: grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
            SizedBox(
              height: 2.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 7),
                child: TextFormField(
                  controller: receiver,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.payment),
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
                    hintText: "Enter Recipient Address",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            _isLoading
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: black,
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      left: 5.w,
                      right: 5.w,
                    ),
                    child: AppButton(
                      color: black,
                      text: 'Send',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          sendBTC();
                        }
                      },
                    ),
                  ),
            SizedBox(
              height: 5.h,
            ),
          ],
        ),
      ),
    );
  }
}
