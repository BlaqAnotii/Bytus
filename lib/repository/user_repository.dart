// ignore_for_file: avoid_print

// import 'package:dio/dio.dart';
// import 'package:keetapp/data/network/error_handler.dart';
// import 'package:keetapp/data/network/network_config.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {

   // final Dio _dio = Dio();

  
  // Future getUserBalance() async {
    
  //   SharedPreferences prefss = await SharedPreferences.getInstance();
  //   String? userToken = prefss.getString('api_token');

  //   SharedPreferences prefsss = await SharedPreferences.getInstance();
  //   String? userID = prefsss.getString('userid');

  //   print('tokennnn.....$userToken');

  //   var dio = Dio(BaseOptions(
  //       baseUrl: NetworkConfig.DEVELOP_BASE_URL,
  //       followRedirects: true,
  //       headers: {
  //         "Accept": "application/json",
  //         "Authorization": "Bearer $userToken"
  //       }));

  //   final Map<String, dynamic> params = {
  //     'userid': userID,
  //     'api_token': userToken,
  //     'action': 'balance',
  //   };
  //   try {
  //     var response = await dio.get(NetworkConfig.DEVELOP_BASE_URL,
  //         queryParameters: params);
  //     print(response.statusCode);
  //     print(response);
  //     if (response.statusCode == 200) {
  //       final responseData = response.data;
  //       return responseData['balance'].toString();
  //     }
  //   } on DioException catch (err) {
  //     handleError(err);
  //   } on Exception catch (err) {
  //     print(err);
  //   } catch (e, t) {
  //     print(e);
  //     print(t);
  //   }

  //   return null;
  // }
}
