import 'package:bytuswallet/constants/colors.dart';
import 'package:flutter/material.dart';

class ServiceBox extends StatelessWidget {
  const ServiceBox({
    super.key,
    required this.title,
    required this.icon,
    this.color,
  });

  final IconData icon;
  final Color? color;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: black),
          child: Icon(
            icon,
            size: 25,
            color: white,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
