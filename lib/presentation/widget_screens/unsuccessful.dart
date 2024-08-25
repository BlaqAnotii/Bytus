import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UnSuccessfulWidget extends StatefulWidget {
  const UnSuccessfulWidget({super.key});

  @override
  State<UnSuccessfulWidget> createState() => _UnSuccessfulWidgetState();
}

class _UnSuccessfulWidgetState extends State<UnSuccessfulWidget> {
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
              'No Unsuccessful Transaction Yet!',
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
