import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/model/my_ticket_model.dart';
import 'package:royalcruiser/utils/helpers/helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';

import '../../constants/color_constance.dart';
import '../../constants/common_constance.dart';
import '../../utils/ui/cliper_class.dart';
import '../../utils/ui/ui_utils.dart';
import 'dashboard_screen.dart';

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
  String OrderId;
  bool fromMybooking;

  TicketDetailScreen({
    required this.fromCityname,
    required this.toCityname,
    required this.pickupTime,
    required this.dropTime,
    required this.journeyTime,
    required this.bustourName,
    required this.seatNumber,
    required this.passengerName,
    required this.ticketNo,
    required this.PNR,
    required this.fare,
    required this.OrderId,
    this.fromMybooking = false,
  });

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  MyTicketModel? myTicketModel;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (widget.fromMybooking) {
          return Future.value(true);
        } else {
          Get.offUntil(
              MaterialPageRoute(builder: (ctx) => DashboardAppScreen()),
              (route) => false);
          return Future.value(false);
        }
      },
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            backgroundColor: Colors.grey,
            appBar: AppBar(
              centerTitle: false,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white, size: 24),
              toolbarHeight: MediaQuery.of(context).size.height / 14,
              title: Text('My Booking Detail',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.5,
                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                  )),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder(
                        future: getTicketDataApi(),
                        builder: (ctx, snap) {
                          if (snap.connectionState == ConnectionState.done) {

                            return myTicketModel != null
                                ?

                                //Old Design
                                //   PhysicalShape(
                                //   clipBehavior: Clip.antiAliasWithSaveLayer,
                                //   clipper: DolDurmaClipper(bottom: 110, holeRadius: 15),
                                //   color: Colors.transparent,
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     children: [
                                //       Container(
                                //         padding: EdgeInsets.only(top: 5, bottom: 5),
                                //         decoration: BoxDecoration(
                                //             color: CustomeColor.main_bg,
                                //             borderRadius: BorderRadius.only(
                                //                 topLeft: Radius.circular(5),
                                //                 topRight: Radius.circular(5))),
                                //         child: Column(
                                //           crossAxisAlignment: CrossAxisAlignment.start,
                                //           children: [
                                //             Container(
                                //               margin: EdgeInsets.only(right: 10, left: 10),
                                //               child: Row(
                                //                 children: [
                                //                   Icon(Icons.location_city,
                                //                       color: Colors.white),
                                //                   SizedBox(width: 5),
                                //                   Text(
                                //                     widget.fromCityname,
                                //                     style: TextStyle(
                                //                         color: Colors.white, fontSize: 17),
                                //                   )
                                //                 ],
                                //               ),
                                //             ),
                                //             Container(
                                //                 margin: EdgeInsets.only(
                                //                     left: 20, top: 5, bottom: 5),
                                //                 color: Colors.white,
                                //                 width: 2,
                                //                 height: 15),
                                //             Container(
                                //               margin: EdgeInsets.only(right: 10, left: 10),
                                //               child: Row(
                                //                 children: [
                                //                   Icon(
                                //                     Icons.location_city,
                                //                     color: Colors.white,
                                //                   ),
                                //                   SizedBox(width: 5),
                                //                   Text(
                                //                     widget.toCityname,
                                //                     style: TextStyle(
                                //                         color: Colors.white, fontSize: 17),
                                //                   )
                                //                 ],
                                //               ),
                                //             ),
                                //             SizedBox(height: 5),
                                //             Divider(color: Colors.white, thickness: 1),
                                //             SizedBox(height: 5),
                                //
                                //             // From To Time
                                //             Container(
                                //               margin: EdgeInsets.only(right: 10, left: 10),
                                //               child: Row(
                                //                 children: [
                                //                   Text(
                                //                     widget.pickupTime,
                                //                     style: TextStyle(
                                //                         color: Colors.white,
                                //                         fontWeight: FontWeight.bold),
                                //                   ),
                                //                   SizedBox(width: 5),
                                //                   Icon(Icons.arrow_forward,
                                //                       color: Colors.white, size: 15),
                                //                   SizedBox(width: 5),
                                //                   Text(
                                //                     widget.dropTime,
                                //                     style: TextStyle(
                                //                         color: Colors.white,
                                //                         fontWeight: FontWeight.bold),
                                //                   )
                                //                 ],
                                //               ),
                                //             ),
                                //             SizedBox(height: 10),
                                //             Container(
                                //               margin: EdgeInsets.only(right: 10, left: 10),
                                //               child: Row(
                                //                 children: [
                                //                   Text(
                                //                     widget.journeyTime,
                                //                     style: TextStyle(
                                //                         color: Colors.white,
                                //                         fontWeight: FontWeight.bold),
                                //                   ),
                                //
                                //                   // SizedBox(width: 5),
                                //                   // Text(
                                //                   //   'friday',
                                //                   //   style: TextStyle(
                                //                   //       color: Colors.white),
                                //                   // ),
                                //                 ],
                                //               ),
                                //             ),
                                //
                                //             SizedBox(height: 10),
                                //             Container(
                                //               margin: EdgeInsets.only(right: 10, left: 10),
                                //               child: Text(
                                //                 widget.bustourName,
                                //                 style: TextStyle(color: Colors.white),
                                //                 maxLines: 2,
                                //                 overflow: TextOverflow.ellipsis,
                                //               ),
                                //             ),
                                //
                                //             // Seat number
                                //             SizedBox(height: 10),
                                //             Container(
                                //               margin: EdgeInsets.only(right: 10, left: 10),
                                //               child: Row(
                                //                 children: [
                                //                   Text(
                                //                     'Seat number ',
                                //                     style: TextStyle(color: Colors.white),
                                //                   ),
                                //                   SizedBox(width: 5),
                                //                   Text(
                                //                     widget.seatNumber,
                                //                     style: TextStyle(
                                //                         color: Colors.white,
                                //                         fontWeight: FontWeight.bold),
                                //                   )
                                //                 ],
                                //               ),
                                //             ),
                                //             SizedBox(height: 5),
                                //           ],
                                //         ),
                                //       ),
                                //       Card(
                                //         clipBehavior: Clip.none,
                                //         margin: EdgeInsets.zero,
                                //         color: Colors.white,
                                //         elevation: 5,
                                //         child: Container(
                                //           padding: EdgeInsets.all(10),
                                //           child: Column(
                                //             children: [
                                //               Row(
                                //                 children: [
                                //                   Expanded(
                                //                       flex: 1, child: Text("Passengers ")),
                                //                   Expanded(
                                //                       flex: 2,
                                //                       child: Text(widget.passengerName)),
                                //                 ],
                                //               ),
                                //               Divider(thickness: 1),
                                //
                                //               //Ticket No PNR
                                //               Row(
                                //                 children: [
                                //                   Expanded(
                                //                       flex: 1, child: Text("Ticket No")),
                                //                   Expanded(
                                //                       flex: 2,
                                //                       child: Text(widget.ticketNo)),
                                //                 ],
                                //               ),
                                //               Row(
                                //                 children: [
                                //                   Expanded(flex: 1, child: Text("PNR")),
                                //                   Expanded(
                                //                       flex: 2, child: Text(widget.PNR)),
                                //                 ],
                                //               ),
                                //               Divider(thickness: 1),
                                //
                                //               //Ticket No PNR
                                //               Row(
                                //                 children: [
                                //                   Expanded(flex: 1, child: Text("Fare")),
                                //                   Expanded(
                                //                       flex: 2, child: Text(widget.fare)),
                                //                 ],
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // )

                                //new design

                                PhysicalShape(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    clipper: DolDurmaClipper(
                                        bottom: 0, holeRadius: 0),
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 0),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight:
                                                      Radius.circular(5))),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                  'assets/images/royal_logo.png'),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                width: Get.size.width,
                                                height: 90,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        CustomeColor.main_bg),
                                                child: Image.asset(
                                                    'assets/images/bus2.png'),
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: CustomeColor.main_bg,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  topRight:
                                                      Radius.circular(5))),
                                          width: Get.size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                          "PNR / Booking Reference",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      SizedBox(height: 5),
                                                      Text(
                                                          "${myTicketModel!.pNR}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text("Journey Date",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      SizedBox(height: 5),

                                                      Text(
                                                          "${myTicketModel!.pickupDate} ${myTicketModel!.pickuptime}",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 30),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Departure",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      SizedBox(height: 5),
                                                      Text(
                                                          "${myTicketModel!.fromCity}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      SizedBox(height: 5),
                                                      Text(
                                                          "${myTicketModel!.pickuptime}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white))
                                                    ],
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                  ),
                                                  Image.asset(
                                                      "assets/images/route_middle_pin.png"),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text("Arrival",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      SizedBox(height: 5),
                                                      Text(
                                                          "${myTicketModel!.toCity}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      SizedBox(height: 5),
                                                      //Comment for no drop time from api need to get drop-time  and uncomment
                                                      Text(
                                                          "${myTicketModel!.Droptime ?? "-"}",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white))
                                                    ],
                                                  )
                                                ],
                                              ),

                                              SizedBox(height: 30),

                                              Text("Bus Type",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              SizedBox(height: 5),
                                              Text("${myTicketModel!.cOACH}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),

                                              SizedBox(height: 30),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text("Boarding Point",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        SizedBox(height: 5),
                                                        InkWell(
                                                          onTap: () {
                                                            Helper.openMap(
                                                                myTicketModel!
                                                                        .PickupLatitude ??
                                                                    "",
                                                                myTicketModel!
                                                                        .PickupLongitude ??
                                                                    "");

                                                            print(
                                                                "Lat ${myTicketModel!.PickupLatitude} - ${myTicketModel!.PickupLongitude}");
                                                          },
                                                          child: Text(
                                                              "${myTicketModel!.pickupNameShort}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        )
                                                      ],
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text("Dropping Point",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        SizedBox(height: 5),

                                                        ///Todo Remove because need to get from api
                                                        InkWell(
                                                          onTap: () {
                                                            Helper.openMap(
                                                                myTicketModel!
                                                                        .DropLatitude ??
                                                                    "",
                                                                myTicketModel!
                                                                        .DropLongitude ??
                                                                    "");
                                                          },
                                                          child: Text(
                                                              "${myTicketModel!.DropName_Short ?? "-"}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            textAlign: TextAlign.end,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),

                                              // Container(
                                              //   margin: EdgeInsets.only(
                                              //       right: 10, left: 10),
                                              //   child: Row(
                                              //     children: [
                                              //       Icon(Icons.location_city,
                                              //           color: Colors.white),
                                              //       SizedBox(width: 5),
                                              //       Text(
                                              //         widget.fromCityname,
                                              //         style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontSize: 17),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),
                                              // Container(
                                              //     margin: EdgeInsets.only(
                                              //         left: 20, top: 5, bottom: 5),
                                              //     color: Colors.white,
                                              //     width: 2,
                                              //     height: 15),
                                              // Container(
                                              //   margin: EdgeInsets.only(
                                              //       right: 10, left: 10),
                                              //   child: Row(
                                              //     children: [
                                              //       Icon(
                                              //         Icons.location_city,
                                              //         color: Colors.white,
                                              //       ),
                                              //       SizedBox(width: 5),
                                              //       Text(
                                              //         widget.toCityname,
                                              //         style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontSize: 17),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),
                                              // SizedBox(height: 5),
                                              // Divider(
                                              //     color: Colors.white,
                                              //     thickness: 1),
                                              // SizedBox(height: 5),
                                              //
                                              // // From To Time
                                              // Container(
                                              //   margin: EdgeInsets.only(
                                              //       right: 10, left: 10),
                                              //   child: Row(
                                              //     children: [
                                              //       Text(
                                              //         widget.pickupTime,
                                              //         style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontWeight:
                                              //                 FontWeight.bold),
                                              //       ),
                                              //       SizedBox(width: 5),
                                              //       Icon(Icons.arrow_forward,
                                              //           color: Colors.white,
                                              //           size: 15),
                                              //       SizedBox(width: 5),
                                              //       Text(
                                              //         widget.dropTime,
                                              //         style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontWeight:
                                              //                 FontWeight.bold),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),
                                              // SizedBox(height: 10),
                                              // Container(
                                              //   margin: EdgeInsets.only(
                                              //       right: 10, left: 10),
                                              //   child: Row(
                                              //     children: [
                                              //       Text(
                                              //         widget.journeyTime,
                                              //         style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontWeight:
                                              //                 FontWeight.bold),
                                              //       ),
                                              //
                                              //       // SizedBox(width: 5),
                                              //       // Text(
                                              //       //   'friday',
                                              //       //   style: TextStyle(
                                              //       //       color: Colors.white),
                                              //       // ),
                                              //     ],
                                              //   ),
                                              // ),
                                              //
                                              // SizedBox(height: 10),
                                              // Container(
                                              //   margin: EdgeInsets.only(
                                              //       right: 10, left: 10),
                                              //   child: Text(
                                              //     widget.bustourName,
                                              //     style: TextStyle(
                                              //         color: Colors.white),
                                              //     maxLines: 2,
                                              //     overflow: TextOverflow.ellipsis,
                                              //   ),
                                              // ),
                                              //
                                              // // Seat number
                                              // SizedBox(height: 10),
                                              // Container(
                                              //   margin: EdgeInsets.only(
                                              //       right: 10, left: 10),
                                              //   child: Row(
                                              //     children: [
                                              //       Text(
                                              //         'Seat number ',
                                              //         style: TextStyle(
                                              //             color: Colors.white),
                                              //       ),
                                              //       SizedBox(width: 5),
                                              //       Text(
                                              //         widget.seatNumber,
                                              //         style: TextStyle(
                                              //             color: Colors.white,
                                              //             fontWeight:
                                              //                 FontWeight.bold),
                                              //       )
                                              //     ],
                                              //   ),
                                              // ),
                                              // SizedBox(height: 5),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/group_5_background.png"),
                                                  fit: BoxFit.cover)),
                                          width: Get.size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Passenger Details",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Name"),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "${myTicketModel!.jMPassengerName}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text("Seat"),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "${myTicketModel!.seatNo}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 30),
                                              Text(
                                                "Travellers Information",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                              SizedBox(height: 10),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Driver Number"),
                                                      SizedBox(height: 5),
                                                      InkWell(
                                                        onTap: () async {
                                                          final url =
                                                              "tel://${myTicketModel!.DriverPhone}";
                                                          //'${myTicketModel!.cMWebsite}';
                                                          Uri uri =
                                                              Uri.parse(url);
                                                          if (await canLaunchUrl(
                                                              uri)) {
                                                            await launchUrl(
                                                                uri);
                                                          } else {
                                                            print(
                                                                "Unable to open ${myTicketModel!.cMWebsite}");
                                                            UiUtils.errorSnackBar(
                                                                    title:
                                                                        "Error",
                                                                    message:
                                                                        "Unable to open ${myTicketModel!.cMWebsite}")
                                                                .show();
                                                            throw 'Could not launch $url';
                                                          }
                                                        },
                                                        child: Text(
                                                          "${myTicketModel!.DriverPhone}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text("Email Id"),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        "${myTicketModel!.cMEmail}",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Card(
                                          clipBehavior: Clip.none,
                                          margin: EdgeInsets.zero,
                                          color: Colors.white,
                                          elevation: 5,
                                          child: Container(
                                            width: Get.size.width,
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Transaction Information",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .underline),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Base fare"),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "INR ${myTicketModel!.baseFare}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text("Discount"),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "- INR ${myTicketModel!.discount}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Tax"),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "INR ${myTicketModel!.iGST}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text("Total Amount"),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "INR ${myTicketModel!.totalInvAmt}",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/group_background.png"),
                                                  fit: BoxFit.cover)),
                                          width: Get.size.width,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Our Contact Us",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                "Contact Details",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(height: 20),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Email id",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "support@rovalcruiser.com",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 30),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Contact No",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(height: 5),
                                                  InkWell(
                                                    onTap: () async {
                                                      final url =
                                                          'tel://91-033-22521 415';
                                                      Uri uri = Uri.parse(url);
                                                      if (await canLaunchUrl(
                                                          uri)) {
                                                        await launchUrl(uri);
                                                      } else {
                                                        UiUtils.errorSnackBar(
                                                                title: "Error",
                                                                message:
                                                                    "Unable to make call")
                                                            .show();
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
                                                    child: Text(
                                                      "91-033-22521 415",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 30),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Address",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    "${myTicketModel!.cMAddress}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                    "No Data Found",
                                    style: TextStyle(
                                        color: CustomeColor.main_bg,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ));
                          } else {
                            return Center(child: Text("Loading...."));
                          }
                        }),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Future<MyTicketModel?> getTicketDataApi() async {
    XmlDocument document =
        await ApiImplementer.getGetTicketPrintDataApiImplementer(
            OrderId:
                // ///This is for testing only don't forget to remove
                //"671592"
                widget.OrderId);

    if (document != null) {
//       document = XmlDocument.parse('''<s:Envelope
// 	xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
// 	<s:Body>
// 		<GetTicketPrintDataResponse
// 			xmlns="http://tempuri.org/">
// 			<GetTicketPrintDataResult>
// 				<xs:schema
// 					xmlns:xs="http://www.w3.org/2001/XMLSchema"
// 					xmlns=""
// 					xmlns:msdata="urn:schemas-microsoft-com:xml-msdata"
// 					id="NewDataSet">
// 					<xs:element
// 						name="NewDataSet"
// 						msdata:IsDataSet="true"
// 						msdata:UseCurrentLocale="true">
// 						<xs:complexType>
// 							<xs:choice
// 								minOccurs="0"
// 								maxOccurs="unbounded">
// 								<xs:element
// 									name="SingleJourny">
// 									<xs:complexType>
// 										<xs:sequence>
// 											<xs:element
// 												name="PNR"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="JM_BookingDateTime"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="JM_JourneyStartDate"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CM_CompanyLogo"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CM_Email"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CM_Website"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CompanyName"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CM_Address"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CompanyAddress"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CompanyGstNo"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="TaxPayableONRev"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="InvoiceNo"
// 												type="xs:int"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="SACCode"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="InvoiceDate"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="PlaceOfSupply"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="InvDescription"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="BaseFare"
// 												type="xs:decimal"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="Discount"
// 												type="xs:decimal"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="TaxableValue"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CGST"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="SGST"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="IGST"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="IGSTLbl"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="SGSTLbl"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CGSTLbl"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="TotalInvAmt"
// 												type="xs:decimal"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="AmountInWords"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="JM_EmailID"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="JM_PassengerName"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="JM_PassengerAddress"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CustState"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CustStateCode"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CustGSTRegNo"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="JourneyFromState"
// 												type="xs:int"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="FromCity"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="ToCity"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="COACH"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="PickupName"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="DropName"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="PaxDetails"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="JM_GSTCompanyName"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="PickupName_Short"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="DropName_Short"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CancelCGST"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CancelSGST"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CancelIGST"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="RefundCGST"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="RefundSGST"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="RefundIGST"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="RefundAmount"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CancellationAmount"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="PANCard"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CINNO"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="JM_RefundCharges"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="JM_RefundServiceTax"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="JM_ServiceTax"
// 												type="xs:double"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CGSTM_IGSTPer"
// 												type="xs:decimal"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CompanyStateCode"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="CompanyGSTNO1"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="SeatNo"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="PM_PickupID"
// 												type="xs:int"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="DM_DropID"
// 												type="xs:int"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="Pickuptime"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="PickupDate"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="Droptime"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="ServerFilePath"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="DropDate"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="PickupLatitude"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="PickupLongitude"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="DropLatitude"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="DropLongitude"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 											<xs:element
// 												name="DriverPhone"
// 												type="xs:string"
// 												minOccurs="0">
// 											</xs:element>
// 										</xs:sequence>
// 									</xs:complexType>
// 								</xs:element>
// 								<xs:element
// 									name="PNR"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_BookingDateTime"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_JourneyStartDate"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CM_CompanyLogo"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CM_Email"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CM_Website"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CM_Address"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyAddress"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyGstNo"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="TaxPayableONRev"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="InvoiceNo"
// 									type="xs:int"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="SACCode"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="InvoiceDate"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PlaceOfSupply"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="InvDescription"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="BaseFare"
// 									type="xs:decimal"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="Discount"
// 									type="xs:decimal"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="TaxableValue"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="SGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="IGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="IGSTLbl"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="SGSTLbl"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CGSTLbl"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="TotalInvAmt"
// 									type="xs:decimal"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="AmountInWords"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_EmailID"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_PassengerName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_PassengerAddress"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CustState"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CustStateCode"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CustGSTRegNo"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JourneyFromState"
// 									type="xs:int"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="FromCity"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="ToCity"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="COACH"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PaxDetails"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_GSTCompanyName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupName_Short"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropName_Short"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CancelCGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CancelSGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CancelIGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="RefundCGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="RefundSGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="RefundIGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="RefundAmount"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CancellationAmount"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PANCard"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CINNO"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_RefundCharges"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_RefundServiceTax"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_ServiceTax"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CGSTM_IGSTPer"
// 									type="xs:decimal"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyStateCode"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyGSTNO1"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="SeatNo"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PM_PickupID"
// 									type="xs:int"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DM_DropID"
// 									type="xs:int"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="Pickuptime"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupDate"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="Droptime"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="ServerFilePath"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropDate"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupLatitude"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupLongitude"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropLatitude"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropLongitude"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DriverPhone"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 							</xs:choice>
// 						</xs:complexType>
// 						<xs:complexType>
// 							<xs:sequence>
// 								<xs:element
// 									name="PNR"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_BookingDateTime"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_JourneyStartDate"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CM_CompanyLogo"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CM_Email"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CM_Website"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CM_Address"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyAddress"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyGstNo"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="TaxPayableONRev"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="InvoiceNo"
// 									type="xs:int"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="SACCode"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="InvoiceDate"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PlaceOfSupply"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="InvDescription"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="BaseFare"
// 									type="xs:decimal"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="Discount"
// 									type="xs:decimal"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="TaxableValue"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="SGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="IGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="IGSTLbl"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="SGSTLbl"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CGSTLbl"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="TotalInvAmt"
// 									type="xs:decimal"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="AmountInWords"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_EmailID"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_PassengerName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_PassengerAddress"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CustState"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CustStateCode"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CustGSTRegNo"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JourneyFromState"
// 									type="xs:int"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="FromCity"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="ToCity"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="COACH"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PaxDetails"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_GSTCompanyName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupName_Short"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropName_Short"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CancelCGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CancelSGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CancelIGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="RefundCGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="RefundSGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="RefundIGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="RefundAmount"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CancellationAmount"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PANCard"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CINNO"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_RefundCharges"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_RefundServiceTax"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_ServiceTax"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CGSTM_IGSTPer"
// 									type="xs:decimal"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyStateCode"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyGSTNO1"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="SeatNo"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PM_PickupID"
// 									type="xs:int"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DM_DropID"
// 									type="xs:int"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="Pickuptime"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupDate"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="Droptime"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="ServerFilePath"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropDate"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupLatitude"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupLongitude"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropLatitude"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropLongitude"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DriverPhone"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 							</xs:sequence>
// 						</xs:complexType>
// 					</xs:element>
// 					<xs:element
// 						name="SingleJourny">
// 						<xs:complexType>
// 							<xs:sequence>
// 								<xs:element
// 									name="PNR"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_BookingDateTime"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_JourneyStartDate"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CM_CompanyLogo"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CM_Email"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CM_Website"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CM_Address"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyAddress"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyGstNo"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="TaxPayableONRev"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="InvoiceNo"
// 									type="xs:int"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="SACCode"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="InvoiceDate"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PlaceOfSupply"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="InvDescription"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="BaseFare"
// 									type="xs:decimal"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="Discount"
// 									type="xs:decimal"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="TaxableValue"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="SGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="IGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="IGSTLbl"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="SGSTLbl"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CGSTLbl"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="TotalInvAmt"
// 									type="xs:decimal"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="AmountInWords"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_EmailID"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_PassengerName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_PassengerAddress"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CustState"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CustStateCode"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CustGSTRegNo"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JourneyFromState"
// 									type="xs:int"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="FromCity"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="ToCity"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="COACH"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PaxDetails"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_GSTCompanyName"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupName_Short"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropName_Short"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CancelCGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CancelSGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CancelIGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="RefundCGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="RefundSGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="RefundIGST"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="RefundAmount"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CancellationAmount"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PANCard"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CINNO"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_RefundCharges"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_RefundServiceTax"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="JM_ServiceTax"
// 									type="xs:double"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CGSTM_IGSTPer"
// 									type="xs:decimal"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyStateCode"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="CompanyGSTNO1"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="SeatNo"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PM_PickupID"
// 									type="xs:int"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DM_DropID"
// 									type="xs:int"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="Pickuptime"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupDate"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="Droptime"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="ServerFilePath"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropDate"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupLatitude"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="PickupLongitude"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropLatitude"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DropLongitude"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 								<xs:element
// 									name="DriverPhone"
// 									type="xs:string"
// 									minOccurs="0">
// 								</xs:element>
// 							</xs:sequence>
// 						</xs:complexType>
// 					</xs:element>
// 					<xs:element
// 						name="PNR"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="JM_BookingDateTime"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="JM_JourneyStartDate"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CM_CompanyLogo"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CM_Email"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CM_Website"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CompanyName"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CM_Address"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CompanyAddress"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CompanyGstNo"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="TaxPayableONRev"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="InvoiceNo"
// 						type="xs:int"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="SACCode"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="InvoiceDate"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="PlaceOfSupply"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="InvDescription"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="BaseFare"
// 						type="xs:decimal"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="Discount"
// 						type="xs:decimal"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="TaxableValue"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CGST"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="SGST"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="IGST"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="IGSTLbl"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="SGSTLbl"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CGSTLbl"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="TotalInvAmt"
// 						type="xs:decimal"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="AmountInWords"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="JM_EmailID"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="JM_PassengerName"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="JM_PassengerAddress"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CustState"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CustStateCode"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CustGSTRegNo"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="JourneyFromState"
// 						type="xs:int"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="FromCity"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="ToCity"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="COACH"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="PickupName"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="DropName"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="PaxDetails"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="JM_GSTCompanyName"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="PickupName_Short"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="DropName_Short"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CancelCGST"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CancelSGST"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CancelIGST"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="RefundCGST"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="RefundSGST"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="RefundIGST"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="RefundAmount"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CancellationAmount"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="PANCard"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CINNO"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="JM_RefundCharges"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="JM_RefundServiceTax"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="JM_ServiceTax"
// 						type="xs:double"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CGSTM_IGSTPer"
// 						type="xs:decimal"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CompanyStateCode"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="CompanyGSTNO1"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="SeatNo"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="PM_PickupID"
// 						type="xs:int"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="DM_DropID"
// 						type="xs:int"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="Pickuptime"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="PickupDate"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="Droptime"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="ServerFilePath"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="DropDate"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="PickupLatitude"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="PickupLongitude"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="DropLatitude"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="DropLongitude"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 					<xs:element
// 						name="DriverPhone"
// 						type="xs:string"
// 						minOccurs="0">
// 					</xs:element>
// 				</xs:schema>
// 				<diffgr:diffgram
// 					xmlns:diffgr="urn:schemas-microsoft-com:xml-diffgram-v1"
// 					xmlns:msdata="urn:schemas-microsoft-com:xml-msdata">
// 					<NewDataSet
// 						xmlns="">
// 						<SingleJourny
// 							diffgr:id="SingleJourny1"
// 							msdata:rowOrder="0">
// 							<PNR>182960023</PNR>
// 							<JM_BookingDateTime>16-04-2024 11:55:17</JM_BookingDateTime>
// 							<JM_JourneyStartDate>30-04-2024 12:00:00 AM</JM_JourneyStartDate>
// 							<CM_CompanyLogo>
// 							</CM_CompanyLogo>
// 							<CM_Email>info@royalcruiser.com</CM_Email>
// 							<CM_Website>royalcruiser.com</CM_Website>
// 							<CompanyName>ROYAL CRUISER</CompanyName>
// 							<CM_Address>Diamond Chambers,4, Chowringhee Lane Block I & II 2nd Floor Kolkata-700016</CM_Address>
// 							<TaxPayableONRev>No</TaxPayableONRev>
//
// 							<InvoiceDate>Apr 16 2024 11:56AM</InvoiceDate>
// 							<InvDescription>
// 							</InvDescription>
// 							<BaseFare>322.00</BaseFare>
// 							<Discount>0.00</Discount>
// 							<TaxableValue>322</TaxableValue>
// 							<CGST>0</CGST>
// 							<SGST>0</SGST>
// 							<IGST>16</IGST>
// 							<IGSTLbl>IGST @ 5.0 %</IGSTLbl>
// 							<SGSTLbl>SGST @ 2.5 %</SGSTLbl>
// 							<CGSTLbl>CGST @ 2.5 %</CGSTLbl>
// 							<TotalInvAmt>338.00</TotalInvAmt>
// 							<AmountInWords>Three Hundred Thirty Eight Rupees</AmountInWords>
// 							<JM_EmailID>krupalkorat@gmail.com</JM_EmailID>
// 							<JM_PassengerName>krupal</JM_PassengerName>
// 							<JM_PassengerAddress>
// 							</JM_PassengerAddress>
// 							<CustState>Jharkhand</CustState>
// 							<CustStateCode>JH</CustStateCode>
// 							<CustGSTRegNo>
// 							</CustGSTRegNo>
// 							<JourneyFromState>13</JourneyFromState>
// 							<FromCity>Bokaro</FromCity>
// 							<ToCity>Ramgarh (Jharkhand)</ToCity>
// 							<COACH>SCANIA  METROLINK MULTI-AXLE  A/C 53 SEATER (2+2)</COACH>
// 							<PickupName>City Centre Bus Stand Near P.N.B Bank - 9304496229) City Centre Bus Stand Near P.N.B Bank - 9304496229) City Centre Bus Stand Near P.N.B Bank - 9304496229)</PickupName>
// 							<PaxDetails>
// 							</PaxDetails>
// 							<JM_GSTCompanyName>
// 							</JM_GSTCompanyName>
// 							<PickupName_Short>City Centre Bus Stand Near P.N.B Bank - 9304496229)</PickupName_Short>
// 							<RefundIGST>16</RefundIGST>
// 							<RefundAmount>322</RefundAmount>
// 							<CancellationAmount>0</CancellationAmount>
// 							<PANCard>
// 							</PANCard>
// 							<JM_RefundCharges>0</JM_RefundCharges>
// 							<JM_RefundServiceTax>0</JM_RefundServiceTax>
// 							<JM_ServiceTax>16</JM_ServiceTax>
// 							<CompanyStateCode>JH</CompanyStateCode>
// 							<SeatNo>53</SeatNo>
// 							<PM_PickupID>44880</PM_PickupID>
// 							<DM_DropID>0</DM_DropID>
// 							<Pickuptime>02:20 AM</Pickuptime>
// 							<PickupDate>01-05-2024</PickupDate>
// 							<ServerFilePath>
// 							</ServerFilePath>
// 							<PickupLatitude>23.6664895</PickupLatitude>
// 							<PickupLongitude>86.1431909</PickupLongitude>
// 						</SingleJourny>
// 					</NewDataSet>
// 				</diffgr:diffgram>
// 			</GetTicketPrintDataResult>
// 		</GetTicketPrintDataResponse>
// 	</s:Body>
// </s:Envelope>
// ''');

      bool xmlElement = document.findAllElements('NewDataSet').isNotEmpty;
      if (xmlElement) {
        var xmlElement1 = document.findAllElements('SingleJourny');
       // Logger().d(xmlElement1);

        for (var item in xmlElement1) {
          XmlElement xmlElement = item;
          myTicketModel = null;
          myTicketModel = MyTicketModel(
            discount: xmlElement.findElements("Discount").first.text,
            amountInWords: xmlElement.findElements("AmountInWords").first.text,
            baseFare: xmlElement.findElements("BaseFare").first.text,
            cancellationAmount:
                xmlElement.findElements("CancellationAmount").first.text,
            cGST: xmlElement.findElements("CGST").first.text,
            cGSTLbl: xmlElement.findElements("CGSTLbl").first.text,
            cMAddress: xmlElement.findElements("CM_Address").first.text,
            cMCompanyLogo: xmlElement.findElements("CM_CompanyLogo").first.text,
            cMEmail: xmlElement.findElements("CM_Email").first.text,
            cMWebsite: xmlElement.findElements("CM_Website").first.text,
            cOACH: xmlElement.findElements("COACH").first.text,
            companyName: xmlElement.findElements("CompanyName").first.text,
            companyStateCode:
                xmlElement.findElements("CompanyStateCode").first.text,
            custGSTRegNo: xmlElement.findElements("CustGSTRegNo").first.text,
            custState: xmlElement.findElements("CustState").first.text,
            custStateCode: xmlElement.findElements("CustStateCode").first.text,
            dMDropID: xmlElement.findElements("DM_DropID").first.text,
            fromCity: xmlElement.findElements("FromCity").first.text,
            iGST: xmlElement.findElements("IGST").first.text,
            iGSTLbl: xmlElement.findElements("IGSTLbl").first.text,
            invDescription:
                xmlElement.findElements("InvDescription").first.text,
            invoiceDate: xmlElement.findElements("InvoiceDate").first.text,
            invoiceNo: xmlElement.findAllElements("InvoiceNo").isNotEmpty ? xmlElement.findElements("InvoiceNo").first.text:"0",
            jMBookingDateTime:
                xmlElement.findElements("JM_BookingDateTime").first.text,
            jMEmailID: xmlElement.findElements("JM_EmailID").first.text,
            jMGSTCompanyName:
                xmlElement.findElements("JM_GSTCompanyName").first.text,
            jMJourneyStartDate:
                xmlElement.findElements("JM_JourneyStartDate").first.text,
            jMPassengerAddress:
                xmlElement.findElements("JM_PassengerAddress").first.text,
            jMPassengerName:
                xmlElement.findElements("JM_PassengerName").first.text,
            jMRefundCharges:
                xmlElement.findElements("JM_RefundCharges").first.text,
            jMRefundServiceTax:
                xmlElement.findElements("JM_RefundServiceTax").first.text,
            jMServiceTax: xmlElement.findElements("JM_ServiceTax").first.text,
            journeyFromState:
                xmlElement.findElements("JourneyFromState").first.text,
            pANCard: xmlElement.findElements("PANCard").first.text,
            paxDetails: xmlElement.findElements("PaxDetails").first.text,
            pickupDate: xmlElement.findElements("PickupDate").first.text,
            pickupName: xmlElement.findElements("PickupName").first.text,
            pickupNameShort:
                xmlElement.findElements("PickupName_Short").first.text,
            pickuptime: xmlElement.findElements("Pickuptime").first.text,
            pMPickupID: xmlElement.findElements("PM_PickupID").first.text,
            pNR: xmlElement.findElements("PNR").first.text,
            refundAmount: xmlElement.findElements("RefundAmount").first.text,
            refundIGST: xmlElement.findElements("RefundIGST").first.text,
            seatNo: xmlElement.findElements("SeatNo").first.text,
            serverFilePath:
                xmlElement.findElements("ServerFilePath").first.text,
            sGST: xmlElement.findElements("SGST").first.text,
            sGSTLbl: xmlElement.findElements("SGSTLbl").first.text,
            taxableValue: xmlElement.findElements("TaxableValue").first.text,
            taxPayableONRev:
                xmlElement.findElements("TaxPayableONRev").first.text,
            toCity: xmlElement.findElements("ToCity").first.text,
            totalInvAmt: xmlElement.findElements("TotalInvAmt").first.text,
            PickupLatitude:
                xmlElement.findElements("PickupLatitude").first.text,
            PickupLongitude:
                xmlElement.findElements("PickupLongitude").first.text,
            DropLatitude: xmlElement.findElements("DropLatitude").isNotEmpty
                ? xmlElement.findElements("DropLatitude").first.text
                : "",
            DropLongitude: xmlElement.findElements("DropLongitude").isNotEmpty
                ? xmlElement.findElements("DropLongitude").first.text
                : "",
            DropDate: xmlElement.findElements("DropDate").isNotEmpty
                ? xmlElement.findElements("DropDate").first.text
                : "",
            DropName: xmlElement.findElements("DropName").isNotEmpty
                ? xmlElement.findElements("DropName").first.text
                : "",
            DropName_Short: xmlElement.findElements("DropName_Short").isNotEmpty
                ? xmlElement.findElements("DropName_Short").first.text
                : "",
            Droptime: xmlElement.findElements("Droptime").isNotEmpty
                ? xmlElement.findElements("Droptime").first.text
                : "",
            DriverPhone: xmlElement.findElements("DriverPhone").isNotEmpty
                ? xmlElement.findElements("DriverPhone").first.text
                : "",
          );



          print("PickupLatitude => ${myTicketModel!.toJson()}");
        }

      }
    }

  }
}