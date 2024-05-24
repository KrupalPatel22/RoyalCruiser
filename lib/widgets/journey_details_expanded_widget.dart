import 'package:flutter/material.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/model/available_route_stax_model.dart';


class JourneyDetailsExpandedWidget extends StatelessWidget {
  final AllRouteBusLists allRouteBusLists;

  const JourneyDetailsExpandedWidget({Key? key, required this.allRouteBusLists})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleHearder = TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold);
    TextStyle textStyleLower = TextStyle(
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.w800);
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Time', style: textStyleHearder),
                      SizedBox(height: 5),
                      Text('${allRouteBusLists.RouteTime}',
                          style: textStyleLower),
                    ],
                  ),
                ),

                SizedBox(
                  width: 25,
                ),


                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Bus Type',
                        style: textStyleHearder,
                      ),
                      SizedBox(height: 5),
                      Text('${allRouteBusLists.BusTypeName ?? "___"}',
                        textAlign: TextAlign.end,
                        style: textStyleLower,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),

                // Column(
                //   children: [
                //     Text(
                //       'Bus Type',
                //       style: textStyleHearder,
                //     ),
                //     SizedBox(height: 5),
                //
                //     Text('my test tyui p jhgv vh vjh  ${allRouteBusLists.BusTypeName ?? "___"}',
                //         style: textStyleLower,
                //     ),
                //   ],
                // ),
                // Spacer(),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
