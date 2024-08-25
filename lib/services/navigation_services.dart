import 'package:bytuswallet/locator.dart';
import 'package:flutter/material.dart';

final NavigationService navigationService = locator<NavigationService>();

BuildContext materialC =
    locator<NavigationService>().navigatorKey.currentContext!;

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> snackBarKey =
      GlobalKey<ScaffoldMessengerState>();

  Future<dynamic> navigateTo(String routeName, {dynamic argument}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: argument);
  }

  Future<dynamic> navigateToReplace(String routeName, {dynamic argument}) {
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: argument);
  }

  Future<dynamic> navigateToAndRemoveUntil(String routeName,
      {dynamic argument}) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  Future<dynamic> pushToAndRemoveUntil(routeObject, {dynamic argument}) {
    return navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => routeObject), (route) => false);
  }

  Future<dynamic> push(routeObject, {dynamic argument}) {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (context) => routeObject));
  }

  Future<dynamic> pushAndReplace(routeObject, {dynamic argument}) {
    return navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (context) => routeObject));
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }

  void goBackWithResult(result) {
    return navigatorKey.currentState!.pop(result);
  }
}
