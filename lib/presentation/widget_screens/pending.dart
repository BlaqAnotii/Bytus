import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PendingWidget extends StatefulWidget {
  const PendingWidget({super.key});

  @override
  State<PendingWidget> createState() => _PendingWidgetState();
}

class _PendingWidgetState extends State<PendingWidget> {
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
              'No Pending Transaction Yet!',
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
