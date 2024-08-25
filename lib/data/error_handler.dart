// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bytuswallet/util/toast.dart';
import 'package:dio/dio.dart';

// This handles the errors in the app, I made use of DioError
void handleError(dynamic error) {
  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.cancel:
        // showCustomToast("Request to API server was cancelled");
        print("Request to API server was cancelled");
        break;
      case DioExceptionType.connectionTimeout:
        showCustomToast("Connection timeout with API server");
        print("Connection timeout with API server");
        break;
      case DioExceptionType.connectionError:
        showCustomToast("Please Enable Internet Connection");
        break;
      case DioExceptionType.receiveTimeout:
        // showCustomToast("Receive timeout in connection with API server");
        break;
      case DioExceptionType.badResponse:
        print(error.response);
        final errorData = error.response?.data;

        if (errorData != null && errorData is Map<String, dynamic>) {
          final errors = errorData["errors"];

          if (errors != null && errors is Map<String, dynamic>) {
            errors.forEach((key, value) {
              if (value is List) {
                for (var errorMsg in value) {
                  showCustomToast(errorMsg);
                  print(errorMsg);
                }
              }
            });
          } else {
            // If no specific errors, show the main message
            final errorMessage = errorData["message"];
            if (errorMessage != null) {
              showCustomToast(errorMessage);
              print(errorMessage);
            }
          }
        } else {
          showCustomToast("Something went wrong");
        }
        break;
      case DioExceptionType.sendTimeout:
        // showCustomToast("Send timeout in connection with API server");
        print("Send timeout in connection with API server");
        break;
      default:
        showCustomToast("Something went wrong");
        break;
    }
  } else {
    var errorString = error.toString();
    var json = jsonDecode(errorString);
    var nameJson = json['message'];
    showCustomToast(nameJson);
    throw nameJson;
  }
}
