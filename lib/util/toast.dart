// ignore_for_file: deprecated_member_use

import 'package:bytuswallet/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

Widget toast(String message, {bool? success}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: success! ? Colors.green : Colors.red),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
                color: white,
               
                shape: BoxShape.circle),
            child: success
                ? const Icon(
                    Icons.check,
                    size: 20,
                  )
                : const Icon(
                    Icons.close,
                    size: 20,
                  ),
          ),
          title: Text(
            textScaleFactor: 1.0,
            message,
            style: const TextStyle(
              color: white,
              fontWeight: FontWeight.w600,
              fontSize: 14.0,
            ),
          ),
        ),
      ),
    ),
  );
}

showCustomToast(String message, {bool success = false, int time = 5}) {
  // dialogLocation(message: message, success: success, time: time);
  showToastWidget(
    toast(message, success: success),
    duration: Duration(seconds: time),
    onDismiss: () {},
  );
}
