// ignore_for_file: constant_identifier_names, unused_element, library_private_types_in_public_api, prefer_const_constructors, unnecessary_new, avoid_print, prefer_interpolation_to_compose_strings, use_key_in_widget_constructors

library custom_splash;

import 'package:bytuswallet/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget? _home;
Function? _customFunction;
String? _imagePath;
int? _duration;
SplashType? _runfor;
Color? _backGroundColor;
String? _animationEffect;
double? _logoSize;

enum SplashType { StaticDuration, BackgroundProcess }

Map<dynamic, Widget> _outputAndHome = {};

class Splash extends StatefulWidget {
  Splash(
      {@required String? imagePath,
      @required Widget? home,
      Function? customFunction,
      int? duration,
      SplashType? type,
      Color backGroundColor = Colors.white,
      String animationEffect = 'fade-in',
      double logoSize = 250.0,
      Map<dynamic, Widget>? outputAndHome}) {
    assert(duration != null);
    assert(home != null);
    assert(imagePath != null);

    _home = home;
    _duration = duration;
    _customFunction = customFunction;
    _imagePath = imagePath;
    _runfor = type;
    _outputAndHome = outputAndHome!;
    _backGroundColor = backGroundColor;
    _animationEffect = animationEffect;
    _logoSize = 250.0;
  }

  @override
  _CustomSplashState createState() => _CustomSplashState();
}

class _CustomSplashState extends State<Splash>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    print("initState ==== @ Splash");
    if (_duration! < 1000) _duration = 2000;
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.easeInCirc));
    _animationController!.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController!.reset();
  }

  navigator(home) {
    Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (BuildContext context) => home));
  }

  Widget _buildAnimation() {
    Widget? x;
    switch (_animationEffect) {
      case 'fade-in':
        {
          x = FadeTransition(opacity: _animation!, child: getContent());
        }
        break;
      case 'zoom-in':
        {
          x = ScaleTransition(scale: _animation!, child: getContent());
        }
        break;
      case 'zoom-out':
        {
          x = ScaleTransition(
              scale: Tween(begin: 1.5, end: 0.6).animate(CurvedAnimation(
                  parent: _animationController!, curve: Curves.easeInCirc)),
              child: getContent());
        }
        break;
      case 'top-down':
        {
          x = SizeTransition(sizeFactor: _animation!, child: getContent());
        }
        break;
    }
    return x!;
  }

  Widget getContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/bytus1.jpg',
            scale: 6,
          ),
          // ignore: sized_box_for_whitespace

          // ignore: sized_box_for_whitespace
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _runfor == SplashType.BackgroundProcess
        ? Future.delayed(Duration.zero).then((value) async {
            print("prewait-------");

            var res = await _customFunction!();
            print("res: " + res.toString());
            //print("$res+${_outputAndHome[res]}");

            Future.delayed(Duration(milliseconds: _duration!)).then((value) {
              Navigator.of(context).pushReplacement(CupertinoPageRoute(
                  builder: (BuildContext context) => _outputAndHome[res]!));
            });
          })
        : Future.delayed(Duration(milliseconds: _duration!)).then((value) {
            Navigator.of(context).pushReplacement(
                CupertinoPageRoute(builder: (BuildContext context) => _home!));
          });

    return Scaffold(
        backgroundColor: _backGroundColor,
        body: Stack(children: [
          Container(decoration: const BoxDecoration(color: black)),
          _buildAnimation()
        ]));
  }
}
