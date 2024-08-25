import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/presentation/auth/login.dart';
import 'package:bytuswallet/presentation/auth/sign_up.dart';
import 'package:bytuswallet/services/navigation_services.dart';
import 'package:bytuswallet/util/app_button.dart';
import 'package:bytuswallet/util/data.dart';
import 'package:bytuswallet/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  // ignore: unused_field
  int _currentIndex = 0;

  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOnboarded', true);
    navigationService.pushToAndRemoveUntil(const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _pageController,
                    itemCount: onboardData.length,
                    onPageChanged: (value) =>
                        setState(() => _currentIndex = value),
                    itemBuilder: (context, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * .12,
                          ),
                          Image.asset(
                            onboardData[i].image,
                            height: height * 0.3,
                            width: width,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            height: height * .19,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Column(
                              children: [
                                Text(
                                  onboardData[i].title,
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  onboardData[i].text,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                Positioned.fill(
                  child: Padding(
                      padding: EdgeInsets.only(top: height * .12),
                      child: _buidDot(_currentIndex)),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
            ),
            child: AppButton(
                color: black,
                text: _currentIndex == 3 ? 'Get Started' : 'Next',
                onPressed: () {
                  _currentIndex == 3 ? _completeOnboarding() : null;

                  _currentIndex == 3
                      ? navigationService.push(const SignUpScreen())
                      : _pageController.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                }),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buidDot(int? index) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          onboardData.length,
          (int? index) => Container(
            height: 8,
            margin: const EdgeInsets.only(right: 8),
            width: _currentIndex == index ? 16 : 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _currentIndex == index ? primary : Colors.grey[300],
            ),
          ),
        ));
  }
}
