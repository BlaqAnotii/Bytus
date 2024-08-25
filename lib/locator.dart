import 'package:bytuswallet/base/base_vm.dart';
import 'package:bytuswallet/repository/auth_repository.dart';
import 'package:bytuswallet/repository/user_repository.dart';
import 'package:bytuswallet/services/auth_view_services.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:bytuswallet/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


BuildContext? locatorContext;

GetIt locator = GetIt.instance;



void setupLocator() {
 
  locator.registerLazySingleton<NavigationService>(() => NavigationService());
    locator.registerFactory<BaseViewModel>(() => BaseViewModel());
   locator.registerLazySingleton<AuthRepository>(() => AuthRepository());
  locator.registerLazySingleton<UserRepository>(() => UserRepository());
  locator.registerFactory<AuthViewModel>(() => AuthViewModel());
 locator.registerFactory<UserServices>(() => UserServices());
}
