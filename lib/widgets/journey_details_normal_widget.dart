import 'package:flutter/material.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/model/available_route_stax_model.dart';

import '../constants/navigation_constance.dart';

class JourneyDetailsNormalWidget extends StatelessWidget {
  final AllRouteBusLists allRouteBusLists;
  final int seatLength;
  final double seatPrice;
  final double discount;

  const JourneyDetailsNormalWidget(
      {Key? key,
      required this.allRouteBusLists,
      required this.seatLength,
      required this.seatPrice,
      required this.discount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleHeader =
        const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
    TextStyle textStyleLower = const TextStyle(
        fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w800);
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(allRouteBusLists.BookingDate,
                    style: textStyleHeader),
                Text(
                  '₹ $seatPrice',
                  style: textStyleHeader,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$seatLength Seats(s)', style: textStyleLower),
              //add price
              discount != 0.0 /*&& NavigatorConstants.USER_ID != '0'*/ ? Text('$discount',
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w800,
                    decoration: TextDecoration.lineThrough
                  )) : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
