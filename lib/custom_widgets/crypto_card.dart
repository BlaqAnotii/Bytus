import 'package:bytuswallet/constants/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CryptoCard extends StatelessWidget {
   CryptoCard({
    super.key,
   // required this.data,
    this.onTap,
    required this.name,
    required this.symbol,
    required this.img,
    required this.currentPrice,
    required this.percentChange,
  });

// ignore: prefer_typing_uninitialized_variables
  //final data;
  final GestureTapCallback? onTap;

  String name;
  String symbol;
  String img;
  num currentPrice;
  double percentChange;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    img,
                    scale: 8,
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: black,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    symbol,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )),
              Column(
                children: <Widget>[
                  Text(
                  App.convertToNairaString(currentPrice.toDouble().toString()),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: primary,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    percentChange.toDouble().toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
