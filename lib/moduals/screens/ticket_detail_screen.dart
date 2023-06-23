import 'package:flutter/material.dart';

import '../../constants/color_constance.dart';
import '../../constants/common_constance.dart';
import '../../utils/ui/cliper_class.dart';

class TicketDetailScreen extends StatefulWidget {
  String fromCityname;
  String toCityname;
  String pickupTime;
  String dropTime;
  String journeyTime;
  String bustourName;
  String seatNumber;
  String passengerName;
  String ticketNo;
  String PNR;
  String fare;

  TicketDetailScreen(
      {required this.fromCityname,
      required this.toCityname,
      required this.pickupTime,
      required this.dropTime,
      required this.journeyTime,
      required this.bustourName,
      required this.seatNumber,
      required this.passengerName,
      required this.ticketNo,
      required this.PNR,
      required this.fare});

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white, size: 24),
            toolbarHeight: MediaQuery.of(context).size.height / 14,
            title:  Text(
              'My Booking Detail',
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 0.5,
                fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
              ),
            ),
          ),
          body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset('assets/images/royal_logo.png'),
            SizedBox(height: 10),
            PhysicalShape(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              clipper: DolDurmaClipper(bottom: 110, holeRadius: 15),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: CustomeColor.main_bg,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            children: [
                              Icon(Icons.location_city, color: Colors.white),
                              SizedBox(width: 5),
                              Text(
                                widget.fromCityname,
                                style: TextStyle(color: Colors.white,fontSize: 17),
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                            color: Colors.white,
                            width: 2,
                            height: 15),
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            children: [
                              Icon(Icons.location_city, color: Colors.white,),
                              SizedBox(width: 5),
                              Text(
                                widget.toCityname,
                                style: TextStyle(color: Colors.white,fontSize: 17),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Divider(color: Colors.white, thickness: 1),
                        SizedBox(height: 5),

                        // From To Time
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            children: [
                              Text(
                                widget.pickupTime,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.arrow_forward,
                                  color: Colors.white, size: 15),
                              SizedBox(width: 5),
                              Text(
                                widget.dropTime,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            children: [
                              Text(
                                widget.journeyTime,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),

                              // SizedBox(width: 5),
                              // Text(
                              //   'friday',
                              //   style: TextStyle(
                              //       color: Colors.white),
                              // ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          child: Text(
                            widget.bustourName,
                            style: TextStyle(color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Seat number
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          child: Row(
                            children: [
                              Text(
                                'Seat number ',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 5),
                              Text(
                                widget.seatNumber,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 5),

                      ],
                    ),
                  ),
                  Card(
                    clipBehavior: Clip.none,
                    margin: EdgeInsets.zero,
                    color: Colors.white,
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(flex: 1, child: Text("Passengers ")),
                              Expanded(flex: 2, child: Text(widget.passengerName)),
                            ],

                          ),
                          Divider(thickness: 1),

                          //Ticket No PNR
                          Row(
                            children: [
                              Expanded(flex: 1, child: Text("Ticket No")),
                              Expanded(flex: 2, child: Text(widget.ticketNo)),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex: 1, child: Text("PNR")),
                              Expanded(flex: 2, child: Text(widget.PNR)),
                            ],
                          ),
                          Divider(thickness: 1),

                          //Ticket No PNR
                          Row(
                            children: [
                              Expanded(flex: 1, child: Text("Fare")),
                              Expanded(flex: 2, child: Text(widget.fare)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}