// ignore_for_file: avoid_print, unnecessary_import, unnecessary_null_comparison, non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'dart:ffi';

import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/custom_widgets/crypto_card.dart';
import 'package:bytuswallet/custom_widgets/service_box.dart';
import 'package:bytuswallet/presentation/main_screens/customer_support.dart';
import 'package:bytuswallet/presentation/main_screens/receive_crypto.dart';
import 'package:bytuswallet/presentation/main_screens/send_crypto.dart';
import 'package:bytuswallet/repository/auth_repository.dart';
import 'package:bytuswallet/services/crypto_model.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:bytuswallet/services/user_model.dart';
import 'package:bytuswallet/services/wallet_model.dart';
import 'package:bytuswallet/util/app_button.dart';
import 'package:bytuswallet/util/progress_indicator.dart';
import 'package:bytuswallet/util/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String lastname;
  late String firstname;

  bool isBalanceVisible = false;

  void toggleBalanceVisibility() {
    setState(() {
      isBalanceVisible = !isBalanceVisible;
    });
  }

  final List<CryptoTracker> tracker = [];
  bool _isLoading = false;

  Future<List<dynamic>?> trackerData() async {
    setState(() {
      _isLoading = true;
    });

    String apiEndpoint =
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=USD&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en";
    var url = Uri.parse(apiEndpoint);

    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      // ignore: no_leading_underscores_for_local_identifiers
      List<CryptoTracker> _tracker = [];
      for (var item in jsonData) {
        _tracker.add(CryptoTracker.fromJson(item));
      }
      setState(() {
        tracker.addAll(_tracker);
        _isLoading = false;
        //_currentPage++; // Increment current page for next fetch
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load order history');
    }
    return null;
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
  // final Dio _dio = Dio();
  // String baseUrl = 'https://bytus.online/api/admin/users';
  // Map<String, dynamic>? userDetails;

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

  Future<void> _Update() async {
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

    String? id = await _secureStorage.read(key: 'id');
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
    });
  }

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  Future<void> _initializeState() async {
    await _Update();
    // fetchUserDetails(iD);
    trackerData();
    _triggerWalletID();
    _getNativeBalance();
    _getEthNativeBalance();
    _getBalance();
    _updateTotalBalance();
  }

  AuthRepository authRepo = AuthRepository();

  void _triggerWalletID() async {
    // Check if the function has already been executed
    String? hasTriggered =
        await _secureStorage.read(key: 'has_triggered_wallet_id');

    if (hasTriggered == null) {
      // If not, execute the function
      await Future.delayed(const Duration(seconds: 1)); // Delay for 3 seconds

      await authRepo.createBtcWallet();
      await authRepo.createEthWallet();

      // Set the flag to indicate that the function has been executed
      await _secureStorage.write(key: 'has_triggered_wallet_id', value: 'true');
    } else {
      // Skip the function execution
      print('The wallet creation functions have already been executed.');
    }
  }

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
          realBal = balance;

          print('REALLLLL:::: $realBal');
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

  Future<void> _updateTotalBalance() async {
          await Future.delayed(const Duration(seconds: 30)); // Delay for 6 seconds

    setState(() {
      print('REALLLLLooooooo:::: $realBal');
      print("Balance in ethoooo: $ETHBALANCE");
      print("Balance in BTCooooooo: $BALANCE");

      if (BALANCE != null && ETHBALANCE != null && realBal != null) {
        _totalBalance = BALANCE! + ETHBALANCE! + realBal!;
      } else {
        _totalBalance = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
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
          "PORTFOLIO",
          style: TextStyle(
            color: white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        // actions: <Widget>[
        //   Padding(
        //     padding: EdgeInsets.only(right: 4.w),
        //     child: SizedBox(
        //       height: 4.5.h,
        //       width: 12.w,
        //       child: Container(
        //         decoration: BoxDecoration(
        //           border: Border.all(width: 1),
        //           color: white,
        //           shape: BoxShape.circle,
        //         ),
        //         child: const Icon(
        //           Iconsax.notification,
        //           color: primary,
        //         ),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: screenSize.width / 2,
                  decoration: const BoxDecoration(
                    color: black,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenSize.width / 70,
                      ),
                      const Text(
                        "Main Balance",
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
                                    ? const Text(
                                        '*****',
                                        style: TextStyle(
                                          color: white,
                                        ),
                                      )
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
                Padding(
                  padding: EdgeInsets.only(
                    top: 16.h,
                    left: 10.w,
                    right: 10.w,
                  ),
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
                          offset:
                              const Offset(1, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              userVerified
                                  ? navigationService
                                      .push(const SendCryptoScreen())
                                  : showCustomToast(
                                      "Please Verify Your account",
                                      success: false);
                            },
                            child: const ServiceBox(
                              color: black,
                              title: "Send",
                              icon: Iconsax.send_1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              userVerified
                                  ? _showAlertDialog()
                                  : showCustomToast(
                                      "Please Verify Your account",
                                      success: false);
                            },
                            child: const ServiceBox(
                              color: black,
                              title: "Receive",
                              icon: Iconsax.received,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              navigationService
                                  .push(const CustomerSupportScreen());
                            },
                            child: const ServiceBox(
                              color: black,
                              title: "Help",
                              icon: Iconsax.message_question,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                    "My Watchlist",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Text(
                  //   "...See all",
                  //   style: TextStyle(
                  //     color: grey,
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w700,
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            _isLoading
                ? const Center(
                    child: ProgressIndcatorbar(),
                  )
                : RefreshIndicator(
                    onRefresh: trackerData,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: tracker.length,
                      itemBuilder: (context, index) {
                        var snap = tracker[index];
                        return CryptoCard(
                            symbol: snap.symbol,
                            name: snap.name,
                            img: snap.img,
                            currentPrice: snap.currentPrice.toDouble(),
                            percentChange: snap.percentChange.toDouble());
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }

  _showAlertDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Stack(
        children: [
          // ignore: avoid_unnecessary_containers
          Center(
            child: Container(
              height: 30.h,
              width: 70.w,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // Center(
                  //   child: Padding(
                  //     padding: EdgeInsets.only(
                  //       left: 5.w,
                  //       right: 5.w,
                  //     ),
                  //     child: AppButton(
                  //       color: black,
                  //       text: 'Generate Address',
                  //       onPressed: () {
                  //         showCustomToast("Address Generated", success: true);
                  //       },
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 5.w,
                        right: 5.w,
                      ),
                      child: AppButton(
                        color: black,
                        text: 'View Addresses',
                        onPressed: () {
                          navigationService.push(const ReceiveCryptoScreen());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40, // Adjust as needed
            right: 20, // Adjust as needed
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
