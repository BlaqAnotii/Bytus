import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AllWidget extends StatefulWidget {
  const AllWidget({super.key});

  @override
  State<AllWidget> createState() => _AllWidgetState();
}

class _AllWidgetState extends State<AllWidget> {
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
              'No Transaction Yet!',
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
