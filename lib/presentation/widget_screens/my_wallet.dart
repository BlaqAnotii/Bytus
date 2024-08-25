// ignore_for_file: avoid_print, unused_local_variable, unnecessary_null_comparison, non_constant_identifier_names

import 'dart:convert';

import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/repository/auth_repository.dart';
import 'package:bytuswallet/services/user_model.dart';
import 'package:bytuswallet/services/user_services.dart';
import 'package:bytuswallet/services/wallet_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool isBalanceVisible = false;

  void toggleBalanceVisibility() {
    setState(() {
      isBalanceVisible = !isBalanceVisible;
    });
  }

  AuthRepository authRepo = AuthRepository();

  ///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
  final Dio _dio = Dio();
  String baseUrl = 'https://bytus.online/api/admin/users';
  Map<String, dynamic>? userDetails;

  double portBalanceInUsds = 0.0;
  double portBtcBalanceInUsds = 0.0;
  double portEthBalanceInUsds = 0.0;
  double portBtcUnits = 0.0;
  double portEthUnits = 0.0;

  final _secureStorage = const FlutterSecureStorage();

  String newname = '';
  String newnames = '';
  bool userVerified = false;
  String iD = '';
  String walletiD = '';

  Future<void> _nameUpdate() async {
    String? savedLastName = await _secureStorage.read(key: 'last_name');
    String? savedFirstName = await _secureStorage.read(key: 'first_name');
    String? userVerifiedStr = await _secureStorage.read(key: 'userVerified');
    double savedTotalBalance =
        double.parse(await _secureStorage.read(key: 'total_balance') ?? '0.00');
    double savedBtcBalance =
        double.parse(await _secureStorage.read(key: 'btc_balance') ?? '0.00');
    double savedEthBalance =
        double.parse(await _secureStorage.read(key: 'eth_balance') ?? '0.00');
    double savedBtcUnit =
        double.parse(await _secureStorage.read(key: 'btc_unit') ?? '0.00');
    double savedEthUnit =
        double.parse(await _secureStorage.read(key: 'eth_unit') ?? '0.00');
    String? id = await _secureStorage.read(key: 'user_id');
    String? wName = await _secureStorage.read(key: 'walletId');

    print(savedLastName);
    print(savedFirstName);

    // Print saved data
    print("ID:::::: $id");
    print("WalletID:::::: $wName");

    print("Last Name:::::: $savedLastName");
    print("First Name:::::: $savedFirstName");

    setState(() {
      if (id != null) {
        iD = id;
      }
      if (wName != null) {
        walletiD = wName;
      }
      if (savedLastName != null) {
        newname = savedLastName;
      }
      if (savedFirstName != null) {
        newnames = savedFirstName;
      }
      if (userVerifiedStr != null) {
        userVerified = userVerifiedStr == 'true';
      }
      if (savedTotalBalance != null) {
        portBalanceInUsds = savedTotalBalance;
      }
      if (savedBtcBalance != null) {
        portBtcBalanceInUsds = savedBtcBalance;
      }
      if (savedEthBalance != null) {
        portEthBalanceInUsds = savedEthBalance;
      }
      if (savedEthUnit != null) {
        portEthUnits = savedEthUnit;
      }
      if (savedBtcUnit != null) {
        portBtcUnits = savedBtcUnit;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    await _nameUpdate();
    //fetchUserDetails(iD);
    _getNativeBalance();
    _getEthNativeBalance();
    _getBalance();
    _updateTotalBalance();
  }

  // final String _baseUrl = 'https://api-wallet.venly.io/api/wallets';
  // double? _balance;
  // double? _balanceunit;

  // Future<void> _getNativeBalance() async {
  //   try {
  //     String? walletId = await _secureStorage.read(key: 'wallet_id');
  //     print("Wallet ID: $walletId");
  //     String? walletAd = await _secureStorage.read(key: 'wallet_address');
  //     print("Wallet Address: $walletAd");

  //     final String url = '$_baseUrl/$walletId/balance';
  //     print(url);

  //     final accessToken = await authRepo.getValidAccessToken();
  //     if (accessToken != null) {
  //       print("Access token: $accessToken");

  //       final response = await http.get(
  //         Uri.parse(url),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $accessToken',
  //         },
  //       );

  //       print("Response status: ${response.statusCode}");
  //       print("Response data: ${response.body}");

  //       if (response.statusCode == 200) {
  //         final data =
  //             WalletBalanceResponse.fromJson(json.decode(response.body));
  //         print(
  //             "Parsed data: ${data.success}, ${data.result.rawBalance} balance");

  //         setState(() {
  //           final balance = double.parse(data.result.rawBalance);

  //           _balance = balance;
  //           _updateTotalBalance();

  //           print("Balance: $_balance");
  //         });
  //       } else {
  //         print("Failed to fetch balance: ${response.statusCode}");
  //         throw Exception('Failed to fetch balance');
  //       }
  //     } else {
  //       print("Failed to refresh token");
  //       throw Exception('Failed to refresh token');
  //     }
  //   } catch (e) {
  //     print('Error fetching balance: $e');
  //     setState(() {
  //       _balance = null;
  //     });
  //   }
  // }

  // double? ethBalance;

  // final String basUrl = 'https://api-wallet.venly.io/api/wallets';
  // Future<void> _getEthNativeBalance() async {
  //   try {
  //     String? walletId = await _secureStorage.read(key: 'eth_wallet_id');
  //     print("Wallet ID: $walletId");
  //     String? walletAd = await _secureStorage.read(key: 'wallet_address');
  //     print("Wallet Address: $walletAd");

  //     final String url = '$basUrl/$walletId/balance';
  //     print(url);

  //     final accessToken = await authRepo.getValidAccessToken();
  //     if (accessToken != null) {
  //       print("Access token: $accessToken");

  //       final response = await http.get(
  //         Uri.parse(url),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $accessToken',
  //         },
  //       );

  //       print("Response status: ${response.statusCode}");
  //       print("Response data: ${response.body}");

  //       if (response.statusCode == 200) {
  //         final data =
  //             WalletBalanceResponse.fromJson(json.decode(response.body));
  //         print(
  //             "Parsed data: ${data.success}, ${data.result.rawBalance} balance");

  //         setState(() {
  //           final balance = double.parse(data.result.rawBalance);
  //           ethBalance = balance;
  //           _updateTotalBalance();

  //           print("Balance: $ethBalance");
  //         });
  //       } else {
  //         print("Failed to fetch balance: ${response.statusCode}");
  //         throw Exception('Failed to fetch balance');
  //       }
  //     } else {
  //       print("Failed to refresh token");
  //       throw Exception('Failed to refresh token');
  //     }
  //   } catch (e) {
  //     print('Error fetching balance: $e');
  //     setState(() {
  //       _balance = null;
  //     });
  //   }
  // }

  // double? realBal;
  // double? realbtcBal;
  // double? realethBal;

  // final String baUrl = 'https://bytus.online/api/admin/users';
  // Future<void> _getBalance() async {
  //   try {
  //     String? Id = await _secureStorage.read(key: 'id');
  //     print("Wallet ID: $Id");

  //     final String url = '$baUrl/$Id';
  //     print(url);

  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //     );

  //     print("Response status: ${response.statusCode}");
  //     print("Response data: ${response.body}");

  //     if (response.statusCode == 200) {
  //       final data = User.fromJson(json.decode(response.body));
  //       print("Parsed data: ${data.totalBalance} ");

  //       setState(() {
  //         final balance = double.parse(data.totalBalance);

  //         final btcbal = double.parse(data.btcBalance);
  //         final ethbal = double.parse(data.ethBalance);
  //         realBal = balance;
  //         realbtcBal = btcbal;
  //         realethBal = ethbal;

  //         print('REALLLLL:::: $realBal');
  //         _updateTotalBalance();

  //         print("Balance: $ethBalance");
  //       });
  //     } else {
  //       print("Failed to fetch balance: ${response.statusCode}");
  //       throw Exception('Failed to fetch balance');
  //     }
  //   } catch (e) {
  //     print('Error fetching balance: $e');
  //     setState(() {
  //       _balance = null;
  //     });
  //   }
  // }

  // double? _totalBalance;
  // double? _totalBtcBalance;
  // double? _totalethBalance;

  // void _updateTotalBalance() {
  //   setState(() {
  //     if (_balance != null && ethBalance != null && realBal != null) {
  //       _totalBalance = _balance! + ethBalance! + realBal!;

  //       _totalBtcBalance = _balance! + realbtcBal!;
  //       _totalethBalance = ethBalance! + realethBal!;
  //     } else {
  //       _totalBalance = null;
  //     }
  //   });
  // }

  Future<double?> _getConversionRate(String cryptoSymbol) async {
    const String apiKey = 'c192c0f5-2208-44fb-a44a-ec7fa13bcc26';
    final String url =
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=$cryptoSymbol&convert=USD';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'X-CMC_PRO_API_KEY': apiKey,
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final usdRate = data['data'][cryptoSymbol]['quote']['USD']['price'];
        return usdRate;
      } else {
        print('Failed to fetch conversion rate: ${response.statusCode}');
        throw Exception('Failed to fetch conversion rate');
      }
    } catch (e) {
      print('Error fetching conversion rate: $e');
      return null;
    }
  }

  final String _baseUrl = 'https://api-wallet.venly.io/api/wallets';
  double? _balance;
  double? BALANCE;
  Future<void> _getNativeBalance() async {
    try {
      await Future.delayed(const Duration(seconds: 6)); // Delay for 6 seconds

      String? walletId = await _secureStorage.read(key: 'wallet_id');
      print("Wallet ID: $walletId");

      final String url = '$_baseUrl/$walletId/balance';
      print(url);

      final accessToken = await authRepo.getValidAccessToken();
      if (accessToken != null) {
        print("Access token: $accessToken");

        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        );

        print("Response status: ${response.statusCode}");
        print("Response data: ${response.body}");

        if (response.statusCode == 200) {
          final data =
              WalletBalanceResponse.fromJson(json.decode(response.body));
          print(
              "Parsed data: ${data.success}, ${data.result.rawBalance} balance");

          final btcBalance = double.parse(data.result.rawBalance);
          final btcRate = await _getConversionRate('BTC');

          setState(() {
            final btcInUsd = btcRate != null ? btcBalance * btcRate : null;
            BALANCE = btcInUsd;
            print("Balance in BTC: $btcBalance, Balance in USD: $btcInUsd");
            print("Balance in BTC: $BALANCE");
          });
        } else {
          print("Failed to fetch balance: ${response.statusCode}");
          throw Exception('Failed to fetch balance');
        }
      } else {
        print("Failed to refresh token");
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      print('Error fetching balance: $e');
      setState(() {
        _balance = null;
      });
    }
  }

  double? _ethBalance;
  double? ETHBALANCE;

  final String basUrl = 'https://api-wallet.venly.io/api/wallets';
  Future<void> _getEthNativeBalance() async {
    try {
      await Future.delayed(const Duration(seconds: 6)); // Delay for 6 seconds

      String? walletId = await _secureStorage.read(key: 'eth_wallet_id');
      print("Wallet ID: $walletId");

      final String url = '$basUrl/$walletId/balance';
      print(url);

      final accessToken = await authRepo.getValidAccessToken();
      if (accessToken != null) {
        print("Access token: $accessToken");

        final response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
        );

        print("Response status: ${response.statusCode}");
        print("Response data: ${response.body}");

        if (response.statusCode == 200) {
          final data =
              WalletBalanceResponse.fromJson(json.decode(response.body));
          print(
              "Parsed data: ${data.success}, ${data.result.rawBalance} balance");

          final ethBalance = double.parse(data.result.rawBalance);
          final ethRate = await _getConversionRate('ETH');

          setState(() {
            final ethInUsd = ethRate != null ? ethBalance * ethRate : null;
            ETHBALANCE = ethInUsd;
            print("Balance in ETH: $ethBalance, Balance in USD: $ethInUsd");
            print("Balance in BTC: $ETHBALANCE");
          });
        } else {
          print("Failed to fetch balance: ${response.statusCode}");
          throw Exception('Failed to fetch balance');
        }
      } else {
        print("Failed to refresh token");
        throw Exception('Failed to refresh token');
      }
    } catch (e) {
      print('Error fetching balance: $e');
      setState(() {
        _ethBalance = null;
      });
    }
  }

  double? realBal;
  double? realbtcBal;
  double? realethBal;

  final String baUrl = 'https://bytus.online/api/admin/users';
  Future<void> _getBalance() async {
    try {
      String? Id = await _secureStorage.read(key: 'id');
      print("Wallet ID: $Id");

      final String url = '$baUrl/$Id';
      print(url);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.body}");

      if (response.statusCode == 200) {
        final data = User.fromJson(json.decode(response.body));
        print("Parsed data: ${data.totalBalance} ");

        setState(() {
          final balance = double.parse(data.totalBalance);
          final btcbal = double.parse(data.btcBalance);
          final ethbal = double.parse(data.ethBalance);

          realBal = balance;
          realbtcBal = btcbal;
          realethBal = ethbal;

          print('REALLLLL:::: $realBal');
                    print('REALLLLLBTC:::: $realbtcBal');
                    print('REALLLLLETH:::: $realethBal');

        });
      } else {
        print("Failed to fetch balance: ${response.statusCode}");
        throw Exception('Failed to fetch balance');
      }
    } catch (e) {
      print('Error fetching balance: $e');
      setState(() {
        BALANCE = null;
      });
    }
  }

  double? _totalBalance;
  double? _totalBtcBalance;
  double? _totalethBalance;

  Future<void> _updateTotalBalance() async {
    await Future.delayed(const Duration(seconds: 30)); // Delay for 6 seconds

    setState(() {
      print('REALLLLLooooooo:::: $realBal');
      print("Balance in ethoooo: $ETHBALANCE");
      print("Balance in BTCooooooo: $BALANCE");

      if (BALANCE != null && ETHBALANCE != null && realBal != null) {
        _totalBalance = BALANCE! + ETHBALANCE! + realBal!;

               _totalBtcBalance = BALANCE! + realbtcBal!;
         _totalethBalance = ETHBALANCE! + realethBal!;
      } else {
        _totalBalance = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: secondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), //appbar size
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: black,
          leading: SizedBox(
            height: 10.w,
            width: 15.w,
          ),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          leadingWidth: 15.w,
          title: const Text(
            "MY WALLET",
            style: TextStyle(
              color: white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: screenSize.width / 2.5,
                decoration: const BoxDecoration(
                  color: black,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.width / 100,
                    ),
                    const Text(
                      "Total Balance",
                      style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: screenSize.width / 300,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: screenSize.width / 4.0,
                          ),
                          child: Visibility(
                              visible: isBalanceVisible,
                              child: _totalBalance == null
                                  ? const Text('*****')
                                  : Text(
                                      "\$ $_totalBalance USD",
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: white,
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                        ),
                        IconButton(
                          onPressed: toggleBalanceVisibility,
                          icon: Icon(
                            isBalanceVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 20,
                            color: white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Assets",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(15),
                height: 43.sp,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      secondary,
                      secondary,
                      secondary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 3,
                        ),
                        Image.asset(
                          "assets/images/btc1.png",
                          scale: 7,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        _totalBtcBalance == null
                            ? const Text('*****')
                            : Text(
                                "\$ $_totalBtcBalance",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "BTC",
                          style: TextStyle(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(15),
                height: 43.sp,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      secondary,
                      secondary,
                      secondary,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(1, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 3,
                        ),
                        Image.asset(
                          "assets/images/eth.png",
                          scale: 7,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        _totalethBalance == null
                            ? const Text('*****')
                            : Text(
                                "\$ $_totalethBalance",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Eth",
                          style: TextStyle(
                            color: black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
        ],
      )),
    );
  }
}
