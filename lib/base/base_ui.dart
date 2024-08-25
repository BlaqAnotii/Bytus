import 'dart:async';

import 'package:bytuswallet/base/base_vm.dart';
import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/locator.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? child)? builder;
  final Function(T)? onModelReady;
  final Function(T)? onModelDispose;
  final Color color;
  const BaseView(
      {super.key,
      this.builder,
      this.onModelReady,
      this.color = Colors.white,
      this.onModelDispose});

  @override
  // ignore: library_private_types_in_public_api
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = locator<T>();

  Timer? _timer;

  void startTimer() {
    // appData.adStarted = true;
    const duration = Duration(minutes: 3);
    _timer = Timer.periodic(
      duration,
      (Timer timer) {},
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.onModelReady != null) {
      widget.onModelReady!(model);
    }
    /*print("initState is calling ============= ========== !!!!!!!!!!!!!!!");
    if (appData.adStarted == false) {
      model.loadAds().then((value) {
        startTimer();
        showAd();
      });
    }*/
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.onModelDispose != null) {
      widget.onModelDispose!(model);
    }
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
        create: (_) => model,
        child: Consumer<T>(
          builder: (_, model, __) => Stack(
            children: [
              widget.builder!.call(_, model, __),
              if (model.isLoading)
                Stack(children: [
                  ModalBarrier(
                    color: Colors.black12.withOpacity(.5),
                    dismissible: false,
                  ),
                  Center(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CircularProgressIndicator(
                      backgroundColor: primary,
                      strokeWidth: 1.w,
                      strokeCap: StrokeCap.round,
                    ),
                  ))
                ])
              // ShimmerUser()
            ],
          ),
        ));
  }
}
