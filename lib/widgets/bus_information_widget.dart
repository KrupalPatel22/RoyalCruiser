import 'package:flutter/material.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/model/available_route_stax_model.dart';


class BusInformationWidget extends StatelessWidget {
  final AllRouteBusLists? allRouteBusLists;

  const BusInformationWidget({Key? key, required this.allRouteBusLists})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle lableTextStyle = TextStyle(
        color: Colors.grey, fontSize: 15);
    TextStyle dataTextStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 15);
    return Container(
      padding: EdgeInsets.only(
        bottom: 15,
      ),
      width: double.infinity,
      color: CustomeColor.main_bg,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            color: CustomeColor.sub_bg.withOpacity(0.6),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Departure',
                            style: lableTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            allRouteBusLists!.BookingDate.toString(),
                            style: dataTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From',
                            style: lableTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${allRouteBusLists!.FromCityName}\n${allRouteBusLists!.RouteTime.toString()}',
                            style: dataTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'To',
                            style: lableTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${allRouteBusLists!.ToCityName}',
                            style: dataTextStyle,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bus',
                        style: lableTextStyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${allRouteBusLists!.ArrangementName.toString()}',
                        style: dataTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
