import 'package:bytuswallet/constants/colors.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    this.onTap,
    this.color = Colors.white,
    this.isSelected = false,
    required this.data,
  });

  // ignore: prefer_typing_uninitialized_variables
  final data;
  final Color color;
  final bool isSelected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 10),
          width: 150,
          decoration: BoxDecoration(
            color: isSelected ? black : grey,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.05),
                spreadRadius: .5,
                blurRadius: .5,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Text(
            data["name"],
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              color: isSelected ? white : white,
            ),
          )),
    );
  }
}

List transactioncategories = [
  {
    "name": "Bitcoin",
  },
  {
    "name": "Ethereum",
  },
];
