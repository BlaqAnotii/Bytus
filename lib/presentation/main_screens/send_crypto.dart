// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/custom_widgets/send_card.dart';
import 'package:bytuswallet/custom_widgets/transaction_category.dart';
import 'package:bytuswallet/presentation/widget_screens/sendBTC.dart';
import 'package:bytuswallet/presentation/widget_screens/send_usdt.dart';
import 'package:bytuswallet/presentation/widget_screens/sendeth.dart';
import 'package:bytuswallet/services/navigation_services.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class SendCryptoScreen extends StatefulWidget {
  const SendCryptoScreen({super.key});

  @override
  State<SendCryptoScreen> createState() => _SendCryptoScreenState();
}

class _SendCryptoScreenState extends State<SendCryptoScreen> {
  var selectedTab = 0;

  static final List _categories = <Widget>[
    const SendBtc(),
    const SendEth(),
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

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
          'Send Crypto',
          style: TextStyle(
            color: black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            SizedBox(
              height: screenSize.width / 15,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenSize.width / 25,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Send Crptocurrency",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.width / 50,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenSize.width / 25,
              ),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Send your cryptocurrencies here.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenSize.width / 10,
            ),
            _buildTransactionList(),
            _buildTransactionPage(),
          ],
        ),
      ),
    );
  }

  _buildTransactionList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(
        children: [
          ...List.generate(
            coin.length,
            (index) => SendCard(
              data: coin[index],
              isSelected: selectedTab == index,
              onTap: () {
                setState(() {
                  selectedTab = index;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  _buildTransactionPage() {
    return IndexedStack(
      index: selectedTab,
      children: List.generate(
        coin.length,
        (index) => _categories[index],
      ),
    );
  }
}
