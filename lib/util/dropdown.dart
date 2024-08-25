// ignore_for_file: must_be_immutable

import 'package:bytuswallet/constants/colors.dart';
import 'package:flutter/material.dart';

class FilterDropDown extends StatefulWidget {
  String? selectedValue;
  final String hint;
  final String? errorText;

  final Function(String?) onChanged;
  final List<String> items;

  FilterDropDown({
    super.key,
    required this.selectedValue,
    required this.hint,
    required this.onChanged,
    required this.items,
    this.errorText,
  });

  @override
  State<FilterDropDown> createState() => _FilterDropDownState();
}

class _FilterDropDownState extends State<FilterDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 304,
      height: 45,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 0.3,
          )),
      child: DropdownButton<String>(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        underline: Container(),
        isExpanded: true,
        hint: Text(widget.hint),
        value: widget.selectedValue,
        items: [
          DropdownMenuItem(
            value: null,
            child: Text(
              widget.hint,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: grey,
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          for (String item in widget.items)
            DropdownMenuItem(
              value: item,
              child: Text(
                item,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
        borderRadius: BorderRadius.circular(5),
        onChanged: widget.onChanged,
      ),

      // child: DropdownButton<String>(
      //   padding: EdgeInsets.only(right: 30.w, left: 5.w),
      //   underline: Container(),

      //   //hint: Text(hint),
      //   value: selectedValue,
      //   items: [
      //     for (String item in items)
      //       DropdownMenuItem(
      //         value: item,
      //         child: Text(
      //           item,
      //           textAlign: TextAlign.center,
      //           style: const TextStyle(
      //             color: AppColor.textblack,
      //             fontSize: 14,
      //             fontWeight: FontWeight.w400,
      //           ),
      //         ),
      //       ),
      //   ],
      //   borderRadius: BorderRadius.circular(5),
      //   onChanged: onChanged,
      // ),
    );
  }
}
