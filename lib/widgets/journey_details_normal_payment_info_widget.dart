import 'package:flutter/material.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/model/available_route_stax_model.dart';


class JourneyDetailsNormalPaymentWidget extends StatelessWidget {
  final AllRouteBusLists allRouteBusLists;

  const JourneyDetailsNormalPaymentWidget(
      {Key? key, required this.allRouteBusLists})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleHeader = const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: CustomeColor.main_bg,
        letterSpacing: 0.5);
    TextStyle textStyleLower = const TextStyle(
        fontSize: 12,
        color: Colors.grey,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.5);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          Text('${allRouteBusLists.RouteName}', style: textStyleHeader,),
          const SizedBox(height: 12),
          Text(
            '${allRouteBusLists.ArrangementName}',
            style: textStyleLower,
          ),
        ],
      ),
    );
  }
}
