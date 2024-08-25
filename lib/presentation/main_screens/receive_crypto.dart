// ignore_for_file: avoid_print, avoid_unnecessary_containers

import 'dart:convert';

import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/repository/auth_repository.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:bytuswallet/util/app_button.dart';
import 'package:bytuswallet/util/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReceiveCryptoScreen extends StatefulWidget {
  const ReceiveCryptoScreen({super.key});

  @override
  State<ReceiveCryptoScreen> createState() => _ReceiveCryptoScreenState();
}

class _ReceiveCryptoScreenState extends State<ReceiveCryptoScreen> {
  AuthRepository authRepo = AuthRepository();
  @override
  void initState() {
    super.initState();
    fetchWalletAddresses();
    fetchBtcWalletAddresses();
  }

  String bitcoin = '';
  String ethereum = '';
  final _secureStorage = const FlutterSecureStorage();

   String bitcoinID = '';
  String ethereumID = '';

  Future<void> fetchBtcWalletAddresses() async {
    String apiKey = 'c67053df39527722a4e950f6752301118fcfe530';
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = await _secureStorage.read(key: 'user_id');
        String? userWalletiD = await _secureStorage.read(key: 'walletId');
                String? btc = await _secureStorage.read(key: 'wallet_address');
                String? eth = await _secureStorage.read(key: 'eth_wallet_address');

                setState(() {

                  if(btc !=null){
                    bitcoinID = btc;
                  }

                  if(eth !=null){
                    ethereumID = eth;
                  }
                });


    String url =
        'https://rest.cryptoapis.io/wallet-as-a-service/wallets/$userWalletiD/bitcoin/testnet/addresses?context=yourExampleString&limit=1&offset=0';

    // Replace 'your_api_key' with your actual API key
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-API-Key': apiKey,
      "Authorization": "Bearer $userToken"
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          // Extract the first item from the response
          if (data['data']['items'].isNotEmpty) {
            final item = data['data']['items'][0];
            bitcoin = item['address'];
          }
        });
        // Handle the response data as needed
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> fetchWalletAddresses() async {
    String apiKey = 'c67053df39527722a4e950f6752301118fcfe530';
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = await _secureStorage.read(key: 'user_id');
    String? userWalletiD = await _secureStorage.read(key: 'walletId');
    String url =
        'https://rest.cryptoapis.io/wallet-as-a-service/wallets/$userWalletiD/ethereum/sepolia/addresses?context=yourExampleString&limit=1&offset=0';

    // Replace 'your_api_key' with your actual API key
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-API-Key': apiKey,
      "Authorization": "Bearer $userToken"
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          // Extract the first item from the response
          if (data['data']['items'].isNotEmpty) {
            final item = data['data']['items'][0];
            ethereum = item['address'];
          }
        });
        // Handle the response data as needed
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
          'Receive Crypto',
          style: TextStyle(
            color: black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              'Select Crypto Address to receive crypto below\nfrom the options provided to fund your crypto wallet',
              maxLines: 2,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Color(0xFF8D8D8E),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/images/btc1.png',
                      scale: 7,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 220,
                          top: 10,
                        ),
                        child: Text(
                          'Beneficiary',
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 230,
                        ),
                        child: Text(
                          'Bitcoin',
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 204,
                        ),
                        child: Text(
                          'Wallet Address',
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            bitcoinID,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: white,
                              fontSize: 7,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              _copyToClipboardbtc();
                            },
                            child: const Icon(
                              Icons.copy,
                              size: 15,
                              color: white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      'assets/images/eth.png',
                      scale: 7,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 220,
                          top: 10,
                        ),
                        child: Text(
                          'Beneficiary',
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 230,
                        ),
                        child: Text(
                          'Ethereum',
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          right: 204,
                        ),
                        child: Text(
                          'Wallet Address',
                          maxLines: 2,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            ethereumID,
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: white,
                              fontSize: 7,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              _copyToClipboard();
                            },
                            child: const Icon(
                              Icons.copy,
                              size: 15,
                              color: white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _copyToClipboardbtc() async {
    await Clipboard.setData(
      ClipboardData(text: bitcoinID),
    );
    // ignore: use_build_context_synchronously

    showCustomToast("Copied to Clipboard", success: true);
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(
      ClipboardData(text: ethereumID),
    );
    // ignore: use_build_context_synchronously

    showCustomToast("Copied to Clipboard", success: true);
  }
}
