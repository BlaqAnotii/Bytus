import 'package:bytuswallet/data/view_state.dart';
import 'package:bytuswallet/locator.dart';
import 'package:bytuswallet/repository/auth_repository.dart';
import 'package:bytuswallet/repository/user_repository.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:bytuswallet/services/user_services.dart';
import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _viewState = ViewState.Idle;
  String? errorMessage;
  NavigationService navigationService = locator<NavigationService>();
  UserRepository userRepo = locator<UserRepository>();
  AuthRepository authRepo = locator<AuthRepository>();
  UserServices userServices = locator<UserServices>();



  //bool productSelected = false;

  ViewState get viewState => _viewState;

  //int cartItemsCount = 0;

  set viewState(ViewState newState) {
    _viewState = newState;
    notifyListeners();
  }

  

  void setError(String? error) {
    errorMessage = error;
    notifyListeners();
  }

  bool isLoading = false;

  void startLoader() {
    if (!isLoading) {
      isLoading = true;
      viewState = ViewState.Loading;
      notifyListeners();
    }
  }

  void stopLoader() {
    if (isLoading) {
      isLoading = false;
      viewState = ViewState.Loading;
      notifyListeners();
    }
  }
}