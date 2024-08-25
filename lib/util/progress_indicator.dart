import 'package:bytuswallet/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';

class ProgressIndcatorbar extends StatelessWidget {
  const ProgressIndcatorbar({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: const GradientProgressIndicator(
          duration: 1,
          radius: 30,
          strokeWidth: 6,
          gradientStops: [
            0.2,
            0.8,
          ],
          gradientColors: [
            grey,
            black,
          ],
          child: Text(
            "",
            style: TextStyle(fontSize: 10),
          )),
    );
  }
}
