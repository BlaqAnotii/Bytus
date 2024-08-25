import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const primary = Color(0xff035F5C);
const offcolor = Colors.red;

const secondary = Color(0xffF8F8F8);
const white = Colors.white;
const black = Color.fromRGBO(0, 0, 0, 1);
const grey = Color(0xFF7A7B7D);
const lightGrey = Color.fromARGB(225, 255, 254, 254);

class App {
  App._();

  static convertToNairaString(String value) {
    double moneyAmount = double.parse(value);
    final currencyFormatter = NumberFormat.currency(symbol: '\$');
    return currencyFormatter.format(moneyAmount);
  }
}
