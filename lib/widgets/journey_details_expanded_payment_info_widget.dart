import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/model/available_route_stax_model.dart';
import 'package:royalcruiser/model/passenegr_details_model.dart';

class JourneyDetailsExpandedPaymentWidget extends StatelessWidget {
  final AllRouteBusLists allRouteBusLists;
  final String BoardingPointName;
  final String DroppingPointName;
  final List<PassangersModel> passangers_ListModel;

  const JourneyDetailsExpandedPaymentWidget(
      {Key? key,
      required this.allRouteBusLists,
      required this.BoardingPointName,
      required this.DroppingPointName,
      required this.passangers_ListModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleHearder = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: CustomeColor.main_bg,
    );
    TextStyle textStyleLower = const TextStyle(
      fontSize: 14,
      color: Colors.grey,
      fontWeight: FontWeight.w800,
    );

    TextStyle textStyleLower1 = const TextStyle(
      fontSize: 13,
      color: CustomeColor.sub_bg,
      fontWeight: FontWeight.w800,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${allRouteBusLists.FromCityName.toString()}',
                      style: textStyleHearder,
                    ),
                    Text(
                      '${allRouteBusLists.BookingDate.toString()}',
                      style: textStyleHearder,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Boarding Point',
                      style: textStyleLower,
                    ),
                    Text(
                      '${allRouteBusLists.CityTime}',
                      style: textStyleLower1,
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '${BoardingPointName.toString()}',
                  style: const TextStyle(color: CustomeColor.main_bg),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${allRouteBusLists.ToCityName.toString()}',
                      style: textStyleHearder,
                    ),
                    Text(

                      // '${allRouteBusLists.BookingDate.toString()}',
                      getFormatedArrivelDate(
                          allRouteBusLists.ApproxArrival.toString()),
                      style: textStyleHearder,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Droping Point',
                      style: textStyleLower,
                    ),
                    Text(
                      '${allRouteBusLists.ArrivalTime}',
                      style: textStyleLower1,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '${DroppingPointName.toString()}',
                  style: const TextStyle(color: CustomeColor.main_bg),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            color: Colors.black,
            thickness: 0.2,
          ),
          for (int e = 0; e < passangers_ListModel.length; e++) ...[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${e == 0 ? 'Primary Passenger' : 'Co Passenger ${e}'}',
                        style: textStyleHearder,
                      ),
                      Text(
                        'Seat Number',
                        style: textStyleHearder,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${passangers_ListModel[e].passengerName}',
                        textAlign: TextAlign.center,
                        style: textStyleLower,
                      ),
                      Text(
                        '${passangers_ListModel[e].seatNo.toString()}',
                        textAlign: TextAlign.start,
                        style: textStyleLower,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String getFormatedArrivelDate(String string) {

    String returnDate = "";

    DateFormat inputFormat = DateFormat("dd-MM-yyyy hh:mm a");
    DateTime dateTime = inputFormat.parse(string);

    DateFormat outputFormat = DateFormat("dd-MM-yyyy");
    String dateString = outputFormat.format(dateTime);

    print(dateString); // Output: 18-04-2024
    returnDate = dateString;
    return returnDate;

  }

}