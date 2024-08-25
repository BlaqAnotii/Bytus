// ignore_for_file: library_private_types_in_public_api

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/locator.dart';
import 'package:bytuswallet/presentation/auth/login.dart';
import 'package:bytuswallet/presentation/bottom_navbar/bottom_navbar.dart';
import 'package:bytuswallet/presentation/onboarding.dart';
import 'package:bytuswallet/presentation/widget_screens/home.dart';
import 'package:bytuswallet/repository/auth_repository.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:bytuswallet/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  setupLocator();

  WidgetsFlutterBinding.ensureInitialized();
final userServices = UserServices();
  await userServices.initializer();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isOnboarded = prefs.getBool('isOnboarded') ?? false;

  final authRepo = AuthRepository();

  await authRepo.authenticate();

  runApp(MyApp(isOnboarded: isOnboarded, authRepo: authRepo,));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

var keyako = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  final bool isOnboarded;
  final AuthRepository authRepo;
  const MyApp({super.key, required this.isOnboarded, required this.authRepo});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  final userService = UserServices();

  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    await userService.initializer();
    setState(() {
      _isLoggedIn = userService.isUserLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return OKToast(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: locator<NavigationService>().navigatorKey,
          scaffoldMessengerKey: locator<NavigationService>().snackBarKey,
          title: 'Bytus Wallet',
          theme: ThemeData(
            fontFamily: "Poppins",
            useMaterial3: true,
          ),
          home: _isLoggedIn
              ? const BottomNavBarScreen()
              : AnimatedSplashScreen(
                  splash: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/bytus1.jpg"),
                    ],
                  ),
                  curve: Curves.bounceInOut,
                  nextScreen: widget.isOnboarded
                      ? const LoginScreen()
                      : const OnboardingScreen(),
                  backgroundColor: black,
                  splashIconSize: 500,
                  centered: true,
                  duration: 2000,
                  splashTransition: SplashTransition.slideTransition,
                ),
        ),
      );
    });
  }
}
