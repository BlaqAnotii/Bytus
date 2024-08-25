// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables, unnecessary_string_interpolations

import 'package:bytuswallet/data/error_handler.dart';
import 'package:bytuswallet/data/network_config.dart';
import 'package:bytuswallet/locator.dart';
import 'package:bytuswallet/services/user_services.dart';
import 'package:dio/dio.dart';

UserServices userServices = locator<UserServices>();

Dio dio = Dio(BaseOptions(
    baseUrl: NetworkConfig.DEVELOP_BASE_URL,
    followRedirects: true,
    headers: getHeaders()));

getHeaders() {
  var headrs = {
    "Accept": "application/json",
  };

  return headrs;
}

Future<dynamic> httpGet(String path, {bool hasAuth = false}) async {
  dio.options.headers = getHeaders();
  print(dio.options.baseUrl + path);
  print(dio.options.headers);
  try {
    var response = await dio.get(path);
    //printLog(response);
    return response;
  } on DioException catch (err) {
    print("error happening @ " + dio.options.baseUrl + path);
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

Future<dynamic> httpPost(String path, dynamic fData,
    {List<MapEntry<String, MultipartFile>>? mapEntry,
    bool hasAuth = false}) async {
  dio.options.headers = getHeaders();
  print("${NetworkConfig.DEVELOP_BASE_URL}$path");
  print(dio.options.headers);
  try {
    var formData = FormData.fromMap(fData);
    if (mapEntry != null) {
      formData.files.addAll(mapEntry);
    }
    var response = await dio.post(path, data: formData);
    return response;
  } on DioException catch (err) {
    print("error happening @ " + dio.options.baseUrl + path);
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

Future<dynamic> httpPut(String path, dynamic fData,
    {List<MapEntry<String, MultipartFile>>? mapEntry,
    bool hasAuth = false}) async {
  dio.options.headers = getHeaders();
  //print(fData);
  try {
    var formData = FormData.fromMap(fData);
    if (mapEntry != null) {
      formData.files.addAll(mapEntry);
    }
    var response = await dio.put(path, data: fData);
    return response;
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

Future<dynamic> httpDelete(String path, dynamic fData,
    {bool hasAuth = false}) async {
  dio.options.headers = getHeaders();
  //printLog(fData);
  try {
    var formData;
    if (fData != null) {
      formData = FormData.fromMap(fData);
    }

    var response = await dio.delete(path, data: formData);
    return response;
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
