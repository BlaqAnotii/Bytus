import 'package:bytuswallet/constants/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutline;
  final Color? color;
  final Color? txtColor;
  final bool isActive;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.txtColor,
    this.isActive = true,
  }) : isOutline = false;
  const AppButton.outline({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.isActive = true,
    this.txtColor,
  }) : isOutline = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isOutline
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: const BorderSide(
                  color: black,
                ),
              ),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: black,
                      fontSize: 16,
                    ),
              ),
            )
          : TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                backgroundColor:
                    color ?? (isActive ? black : black.withOpacity(.5)),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(text,
                  style: const TextStyle(
                    fontSize: 14,
                    color: white,
                  )),
            ),
    );
  }
}
