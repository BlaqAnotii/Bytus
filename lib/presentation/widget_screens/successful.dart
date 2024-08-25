import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SuccessfulWidget extends StatefulWidget {
  const SuccessfulWidget({super.key});

  @override
  State<SuccessfulWidget> createState() => _SuccessfulWidgetState();
}

class _SuccessfulWidgetState extends State<SuccessfulWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          const Center(
            child: Text(
              'No Successful Transaction Yet!',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
