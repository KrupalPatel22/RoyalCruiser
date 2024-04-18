import 'dart:convert';
import 'dart:math';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/model/available_route_stax_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/moduals/screens/seat_arrangement_screen.dart';
import 'package:royalcruiser/widgets/app_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ticketview/ticketview.dart';
import 'package:xml/xml.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/color_constance.dart';
import '../utils/ui/ui_utils.dart';

class AvailableRouteWidget extends StatefulWidget {
  final XmlElement? allRouteBusLists;

  const AvailableRouteWidget({Key? key, required this.allRouteBusLists})
      : super(key: key);

  @override
  State<AvailableRouteWidget> createState() => _AvailableRouteWidgetState();
}

class _AvailableRouteWidgetState extends State<AvailableRouteWidget> {
  String? tripType;
  RxBool _isLoading = false.obs;

  @override
  void initState() {
    tripType = NavigatorConstants.TRIP_TYPE;
    _isLoading.value = true;
    super.initState();
  }

  void onTapStoreRouteDetails() {

    AllRouteBusLists allRouteBusLists = AllRouteBusLists(
        CompanyID: widget.allRouteBusLists!.getElement('CompanyID')!.text,
        CompanyName: widget.allRouteBusLists!.getElement('CompanyName')!.text,
        FromCityId: widget.allRouteBusLists!.getElement('FromCityId')!.text,
        FromCityName: widget.allRouteBusLists!.getElement('FromCityName')!.text,
        ToCityId: widget.allRouteBusLists!.getElement('ToCityId')!.text,
        ToCityName: widget.allRouteBusLists!.getElement('ToCityName')!.text,
        RouteID: widget.allRouteBusLists!.getElement('RouteID')!.text,
        RouteTimeID: widget.allRouteBusLists!.getElement('RouteTimeID')!.text,
        RouteName: widget.allRouteBusLists!.getElement('RouteName')!.text,
        RouteTime: widget.allRouteBusLists!.getElement('RouteTime')!.text,
        Kilometer: widget.allRouteBusLists!.getElement('Kilometer')!.text,
        CityTime: widget.allRouteBusLists!.getElement('CityTime')!.text,
        ArrivalTime: widget.allRouteBusLists!.getElement('ArrivalTime')!.text,
        BusType: widget.allRouteBusLists!.getElement('BusType')!.text,
        BusTypeName: widget.allRouteBusLists!.getElement('BusTypeName')!.text,
        BookingDate: widget.allRouteBusLists!.getElement('BookingDate')!.text,
        ArrangementID:
        widget.allRouteBusLists!.getElement('ArrangementID')!.text,
        ArrangementName:
        widget.allRouteBusLists!.getElement('ArrangementName')!.text,
        AcSeatRate: widget.allRouteBusLists!.getElement('AcSeatRate')!.text,
        AcSleeperRate:
        widget.allRouteBusLists!.getElement('AcSleeperRate')!.text,
        AcSlumberRate:
        widget.allRouteBusLists!.getElement('AcSlumberRate')!.text,
        NonAcSeatRate:
        widget.allRouteBusLists!.getElement('NonAcSeatRate')!.text,
        NonAcSleeperRate:
        widget.allRouteBusLists!.getElement('NonAcSleeperRate')!.text,
        NonAcSlumberRate:
        widget.allRouteBusLists!.getElement('NonAcSlumberRate')!.text,
        BoardingPoints: widget.allRouteBusLists!.getElement('BoardingPoints')!
            .text,
        DroppingPoints: widget.allRouteBusLists!.getElement('DroppingPoints')!
            .text,
        EmptySeats: widget.allRouteBusLists!.getElement('EmptySeats')!.text,
        ReferenceNumber:
        widget.allRouteBusLists!.getElement('ReferenceNumber')!.text,
        IsSameDay: widget.allRouteBusLists!.getElement('IsSameDay')!.text,
        RouteAmenities:
        widget.allRouteBusLists!.getElement('RouteAmenities')!.text,
        IsPackage: widget.allRouteBusLists!.getElement('IsPackage')!.text,
        PackageAmenities:
        widget.allRouteBusLists!.getElement('PackageAmenities')!.text,
        AcSeatServiceTax:
        widget.allRouteBusLists!.getElement('AcSeatServiceTax')!.text,
        AcSlpServiceTax:
        widget.allRouteBusLists!.getElement('AcSlpServiceTax')!.text,
        AcSlmbServiceTax:
        widget.allRouteBusLists!.getElement('AcSlmbServiceTax')!.text,
        NonAcSeatServiceTax:
        widget.allRouteBusLists!.getElement('NonAcSeatServiceTax')!.text,
        NonAcSlpServiceTax:
        widget.allRouteBusLists!.getElement('NonAcSlpServiceTax')!.text,
        NonAcSlmbServiceTax:
        widget.allRouteBusLists!.getElement('NonAcSlmbServiceTax')!.text,
        BaseAcSeat: widget.allRouteBusLists!.getElement('BaseAcSeat')!.text,
        BaseAcSlp: widget.allRouteBusLists!.getElement('BaseAcSlp')!.text,
        BaseAcSlmb: widget.allRouteBusLists!.getElement('BaseAcSlmb')!.text,
        BaseNonAcSeat:
        widget.allRouteBusLists!.getElement('BaseNonAcSeat')!.text,
        BaseNonAcSlp: widget.allRouteBusLists!.getElement('BaseNonAcSlp')!.text,
        BaseNonAcSlmb:
        widget.allRouteBusLists!.getElement('BaseNonAcSlmb')!.text,
        AcSeatSurcharges:
        widget.allRouteBusLists!.getElement('AcSeatSurcharges')!.text,
        AcSlpSurcharges:
        widget.allRouteBusLists!.getElement('AcSlpSurcharges')!.text,
        AcSlmbSurcharges:
        widget.allRouteBusLists!.getElement('AcSlmbSurcharges')!.text,
        NonAcSeatSurcharges:
        widget.allRouteBusLists!.getElement('NonAcSeatSurcharges')!.text,
        NonAcSlpSurcharges:
        widget.allRouteBusLists!.getElement('NonAcSlpSurcharges')!.text,
        NonAcSlmbSurcharges:
        widget.allRouteBusLists!.getElement('NonAcSlmbSurcharges')!.text,
        BusSeatType: widget.allRouteBusLists!.getElement('BusSeatType')!.text,
        IsChargeAmenities:
        widget.allRouteBusLists!.getElement('IsChargeAmenities')!.text,
        ServiceTax: widget.allRouteBusLists!.getElement('ServiceTax')!.text,
        ServiceTaxRoundUp:
        widget.allRouteBusLists!.getElement('ServiceTaxRoundUp')!.text,
        IsIncludeTax: widget.allRouteBusLists!.getElement('IsIncludeTax')!.text,
        OnlineACSeatCharge:
        widget.allRouteBusLists!.getElement('OnlineACSeatCharge')!.text,
        OnlineACSlumberCharge:
        widget.allRouteBusLists!.getElement('OnlineACSlumberCharge')!.text,
        OnlineACSleeperCharge:
        widget.allRouteBusLists!.getElement('OnlineACSleeperCharge')!.text,
        OnlineNonACSeatCharge:
        widget.allRouteBusLists!.getElement('OnlineNonACSeatCharge')!.text,
        OnlineNonACSlumberCharge: widget.allRouteBusLists!
            .getElement('OnlineNonACSlumberCharge')!
            .text,
        OnlineNonACSleeperCharge: widget.allRouteBusLists!
            .getElement('OnlineNonACSleeperCharge')!
            .text,
        Duration: widget.allRouteBusLists!.getElement('Duration')!.text,
        CM_CGST: widget.allRouteBusLists!.getElement('CM_CGST')!.text,
        CM_SGST: widget.allRouteBusLists!.getElement('CM_SGST')!.text,
        CompanyStateID:
        widget.allRouteBusLists!.getElement('CompanyStateID')!.text,
        FromCityState:
        widget.allRouteBusLists!.getElement('FromCityState')!.text,
        StrikeOutACSeatFare:
        widget.allRouteBusLists!.getElement('StrikeOutACSeatFare')!.text,
        StrikeOutACSleeperFare:
        widget.allRouteBusLists!.getElement('StrikeOutACSleeperFare')!.text,
        StrikeOutACSlumberFare: widget.allRouteBusLists!.getElement(
            'StrikeOutACSlumberFare')!.text,
        StrikeOutNonACSeatFare: widget.allRouteBusLists!.getElement(
            'StrikeOutNonACSeatFare')!.text,
        StrikeOutNonACSleeperFare: widget.allRouteBusLists!.getElement(
            'StrikeOutNonACSleeperFare')!.text,
        StrikeOutNonACSlumberFare: widget.allRouteBusLists!.getElement(
            'StrikeOutNonACSlumberFare')!.text,
        RouteType: widget.allRouteBusLists!.getElement('RouteType')!.text,
        ID: widget.allRouteBusLists!.getElement('ID')!.text,
        TripNo: widget.allRouteBusLists!.getElement('TripNo')!.text,
        HoldTime: widget.allRouteBusLists!.getElement('HoldTime')!.text,
        REV_ExtraValue:
        widget.allRouteBusLists!.getElement('REV_ExtraValue')!.text,
        REV_ValueType:
        widget.allRouteBusLists!.getElement('REV_ValueType')!.text,
        CityTime24: widget.allRouteBusLists!.getElement('CityTime24')!.text,
        ArrivalTime24:
        widget.allRouteBusLists!.getElement('ArrivalTime24')!.text,
        RouteScheduleCode:
        widget.allRouteBusLists!.getElement('RouteScheduleCode')!.text,
        DurationMinutes:
        widget.allRouteBusLists!.getElement('DurationMinutes')!.text,
        RT_IsNonStopSchedule:
        widget.allRouteBusLists!.getElement('RT_IsNonStopSchedule')!.text,
        RTPD_CityList:
        widget.allRouteBusLists!.getElement('RTPD_CityList')!.text,
        DiscountRate: widget.allRouteBusLists!.getElement('DiscountRate')!.text,
        ApproxArrival: widget.allRouteBusLists!.getElement('ApproxArrival')!
            .text,
        AreaIDName: widget.allRouteBusLists!.getElement('AreaIDName')!.text,
        PickupIDNameTimeDetails: widget.allRouteBusLists!.getElement(
            'PickupIDNameTimeDetails')!.text,
        TotalRating: widget.allRouteBusLists!.getElement('TotalRating')!.text,
        RatingAVG: widget.allRouteBusLists!.getElement('RatingAVG')!.text);

    if (tripType == "0" || tripType == "1") {
      NavigatorConstants.ALL_ROUTE_LIST_ONWARD = json.encode(allRouteBusLists);
    } else if (tripType == "2") {
      NavigatorConstants.ALL_ROUTE_LIST_RETURN = json.encode(allRouteBusLists);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
      _isLoading.value
          ? InkWell(
        onTap: () {
          if (widget.allRouteBusLists!.getElement('EmptySeats')!.text != "0") {
            onTapStoreRouteDetails();
            Navigator.of(context).pushNamed(SeatArrangementAppScreen.routeName);
          }else{
            UiUtils.errorSnackBar(message: 'No Seats Available!').show();
          }
        },
        child: TicketView(
          backgroundColor: Colors.transparent,
          triangleAxis: Axis.vertical,
          contentPadding: const EdgeInsets.only(right: 15,left: 15,top: 20),
          drawDivider: true,
          drawShadow: true,
          drawArc: true,
          drawTriangle: true,
          contentBackgroundColor: Colors.white,
          dividerColor: CustomeColor.main_bg,
          child: Container(
            margin: const EdgeInsets.only(right: 15, left: 15),
            child: Column(
              children: [
                const SizedBox(height: 10),

                Row(
                  children: [
                    Text(
                        widget.allRouteBusLists!.getElement('BusTypeName')!
                            .text,
                        style: const TextStyle(fontSize: 15)),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Start point
                    Column(
                      children: [
                        Text(widget.allRouteBusLists!.getElement('CityTime')!
                            .text,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text(
                            widget.allRouteBusLists!.getElement('FromCityName')!
                                .text,
                            style: const TextStyle(fontSize: 15)),
                      ],
                    ),

                    Container(
                        margin: const EdgeInsets.only(right: 5,left: 5),
                        child: SvgPicture.asset('assets/images/route_bus_Icon.svg')),

                    //End point
                    Expanded(
                      child: Column(
                        children: [
                          Text(widget.allRouteBusLists!.getElement('ArrivalTime')!
                              .text,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(
                              widget.allRouteBusLists!.getElement('ToCityName')!
                                  .text,
                              style: const TextStyle(fontSize: 15)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                //Rout Name
                Text(
                    widget.allRouteBusLists!.getElement('RouteName')!.text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w200,
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                    )),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.allRouteBusLists!
                              .getElement('BusType')!
                              .text ==
                              "0"
                              ? const Image(
                            image: AssetImage('assets/images/icon_ac.png'),
                            fit: BoxFit.fill,
                            height: 17,
                          )
                              : const Image(
                            image: AssetImage('assets/images/icon_nonac.png'),
                            fit: BoxFit.fill,
                            height: 17,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (int.parse(widget.allRouteBusLists!
                              .getElement('BaseAcSeat')!
                              .text) >
                              0 ||
                              int.parse(widget.allRouteBusLists!
                                  .getElement('NonAcSeatRate')!
                                  .text) >
                                  0)
                            const Image(
                              image: AssetImage('assets/images/icon_seater.png'),
                              fit: BoxFit.fill,
                              height:
                              17,
                            ),
                          const SizedBox(
                            width: 10,
                          ),

                          if (int.parse(widget.allRouteBusLists!
                              .getElement('AcSleeperRate')!
                              .text) > 0 ||
                              int.parse(widget.allRouteBusLists!
                                  .getElement('NonAcSleeperRate')!
                                  .text) > 0)
                            const Image(
                              image: AssetImage('assets/images/icon_sleeper.png'),
                              fit: BoxFit.fill,
                              height:
                              17,
                            ),

                          if (int.parse(widget.allRouteBusLists!.getElement('AcSlumberRate')!.text) > 0 ||
                              int.parse(widget.allRouteBusLists!.getElement('NonAcSlumberRate')!.text) > 0)
                            const Image(
                              image: AssetImage('assets/images/icon_slumber.png'),
                              fit: BoxFit.fill,
                              height:
                              17,
                            ),
                          const SizedBox(
                            width: 5,
                          ),
                          widget.allRouteBusLists!.getElement('RouteAmenities')!
                              .text.isNotEmpty
                              ? const Image(
                            image:
                            AssetImage('assets/images/amenities_icon_new.png'),
                            fit: BoxFit.fill,
                            height: 17,
                          )
                              : const Text(''),

                        ]),
                    //Coupon Applied
                    int.parse(widget.allRouteBusLists!.getElement('StrikeOutACSeatFare')!.text) != null?
                    Row(children: const [
                      Icon(
                        Icons.verified_outlined,
                        color: Colors.green,
                      ),
                      SizedBox(width: 5),
                      Text('ROYAL8',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),)
                    ]):const SizedBox.shrink()

                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: BusRate(
                      allRouteBusLists:
                      widget.allRouteBusLists!),
                )
              ],
            ),
          ),
        ),
      )
          : Container(),
    );
  }

  Widget BusRate({required XmlElement allRouteBusLists}) {
    String strFare = "";
    String strStrikeFare = "";
    List<int> strFareList = [];
    List<int> strServiceTaxList = [];
    List<int> strStrikeFareList = [];

    if (allRouteBusLists
        .getElement('BaseAcSeat')
        .isNullOrBlank == true) {
      // strFareList.add(0);
    } else {
      if (int.parse(
          allRouteBusLists.getElement('BaseAcSeat')!.text.toString()) != 0) {
        strFareList.add(
            int.parse(allRouteBusLists.getElement('BaseAcSeat')!.text));
      }
      if (int.parse(
          allRouteBusLists.getElement('AcSeatServiceTax')!.text.toString()) !=
          0) {
        strServiceTaxList.add(
            int.parse(allRouteBusLists.getElement('AcSeatServiceTax')!.text));
      }
    }

    if (allRouteBusLists
        .getElement('BaseAcSlmb')
        .isNullOrBlank == true) {
      // strFareList.add(0);
    } else {
      if (int.parse(
          allRouteBusLists.getElement('BaseAcSlmb')!.text.toString()) != 0) {
        strFareList.add(
            int.parse(allRouteBusLists.getElement('BaseAcSlmb')!.text));
      }
      if (int.parse(
          allRouteBusLists.getElement('AcSlmbServiceTax')!.text.toString()) !=
          0) {
        strServiceTaxList.add(
            int.parse(allRouteBusLists.getElement('AcSlmbServiceTax')!.text));
      }
    }

    if (allRouteBusLists
        .getElement('BaseAcSlp')
        .isNullOrBlank == true) {
      // strFareList.add(0);
    } else {
      if (int.parse(
          allRouteBusLists.getElement('BaseAcSlp')!.text.toString()) != 0) {
        strFareList.add(
            int.parse(allRouteBusLists.getElement('BaseAcSlp')!.text));
      }
      if (int.parse(
          allRouteBusLists.getElement('AcSlpServiceTax')!.text.toString()) !=
          0) {
        strServiceTaxList.add(
            int.parse(allRouteBusLists.getElement('AcSlpServiceTax')!.text));
      }
    }

    if (allRouteBusLists
        .getElement('BaseNonAcSeat')
        .isNullOrBlank == true) {
      // strFareList.add(0);
    } else {
      if (int.parse(
          allRouteBusLists.getElement('BaseNonAcSeat')!.text.toString()) != 0) {
        strFareList.add(
            int.parse(allRouteBusLists.getElement('BaseNonAcSeat')!.text));
      }
      if (int.parse(allRouteBusLists.getElement('NonAcSeatServiceTax')!.text
          .toString()) != 0) {
        strServiceTaxList.add(int.parse(
            allRouteBusLists.getElement('NonAcSeatServiceTax')!.text));
      }
    }

    if (allRouteBusLists
        .getElement('BaseNonAcSlp')
        .isNullOrBlank == true) {
      // strFareList.add(0);
    } else {
      if (int.parse(
          allRouteBusLists.getElement('BaseNonAcSlp')!.text.toString()) != 0) {
        strFareList.add(
            int.parse(allRouteBusLists.getElement('BaseNonAcSlp')!.text));
      }
      if (int.parse(
          allRouteBusLists.getElement('NonAcSlpServiceTax')!.text.toString()) !=
          0) {
        strServiceTaxList.add(
            int.parse(allRouteBusLists.getElement('NonAcSlpServiceTax')!.text));
      }
    }

    if (allRouteBusLists
        .getElement('BaseNonAcSlmb')
        .isNullOrBlank == true) {
      // strFareList.add(0);
    } else {
      if (int.parse(
          allRouteBusLists.getElement('BaseNonAcSlmb')!.text.toString()) != 0) {
        strFareList.add(
            int.parse(allRouteBusLists.getElement('BaseNonAcSlmb')!.text));
      }
      if (int.parse(allRouteBusLists.getElement('NonAcSlmbServiceTax')!.text
          .toString()) != 0) {
        strServiceTaxList.add(int.parse(
            allRouteBusLists.getElement('NonAcSlmbServiceTax')!.text));
      }
    }

    if (allRouteBusLists
        .getElement('StrikeOutACSeatFare')
        .isNullOrBlank == true) {
      // strFareList.add(0);
    } else {
      if (int.parse(allRouteBusLists.getElement('StrikeOutACSeatFare')!.text
          .toString()) != 0) {
        strStrikeFareList.add(int.parse(
            allRouteBusLists.getElement('StrikeOutACSeatFare')!.text));
      }
    }

    if (allRouteBusLists
        .getElement('StrikeOutACSlumberFare')
        .isNullOrBlank == true) {
      // strFareList.add(0);
    } else {
      if (int.parse(allRouteBusLists.getElement('StrikeOutACSlumberFare')!.text
          .toString()) != 0) {
        strStrikeFareList.add(int.parse(
            allRouteBusLists.getElement('StrikeOutACSlumberFare')!.text));
      }
    }

    if (allRouteBusLists
        .getElement('StrikeOutACSleeperFare')
        .isNullOrBlank == true) {
      // strFareList.add(0);
    } else {
      if (int.parse(allRouteBusLists.getElement('StrikeOutACSleeperFare')!.text
          .toString()) != 0) {
        strStrikeFareList.add(int.parse(
            allRouteBusLists.getElement('StrikeOutACSleeperFare')!.text));
      }
    }

    if (allRouteBusLists
        .getElement('StrikeOutNonACSeatFare')
        .isNullOrBlank == true) {
      // strFareList.add(0);
    } else {
      if (int.parse(allRouteBusLists.getElement('StrikeOutNonACSeatFare')!.text
          .toString()) != 0) {
        strStrikeFareList.add(int.parse(
            allRouteBusLists.getElement('StrikeOutNonACSeatFare')!.text));
      }
    }

    if (allRouteBusLists
        .getElement('StrikeOutNonACSleeperFare')
        .isNullOrBlank == true) {
      // strFareList.add(0);
    } else {
      if (int.parse(
          allRouteBusLists.getElement('StrikeOutNonACSleeperFare')!.text
              .toString()) != 0) {
        strStrikeFareList.add(int.parse(
            allRouteBusLists.getElement('StrikeOutNonACSleeperFare')!.text));
      }
    }

    if (allRouteBusLists
        .getElement('StrikeOutNonACSlumberFare')
        .isNullOrBlank == true) {
      // strFareList.add(0);
    } else {
      if (int.parse(
          allRouteBusLists.getElement('StrikeOutNonACSlumberFare')!.text
              .toString()) != 0) {
        strStrikeFareList.add(int.parse(
            allRouteBusLists.getElement('StrikeOutNonACSlumberFare')!.text));
      }
    }

    var largestValueStrike;
    var smallestValueStrike;
    if (strStrikeFareList.isNotEmpty) {
      largestValueStrike = strStrikeFareList[0];
      smallestValueStrike = strStrikeFareList[0];
      for (var i = 0; i < strStrikeFareList.length; i++) {
        if (strStrikeFareList[i] > largestValueStrike) {
          largestValueStrike = strStrikeFareList[i];
        }

        if (strStrikeFareList[i] < smallestValueStrike) {
          smallestValueStrike = strStrikeFareList[i];
        }
      }
    }

    if (allRouteBusLists.getElement('EmptySeats')!.text == "0") {
      return Wrap(
        children: const [
          Text(
            'Sold Out',
            style: TextStyle(
              fontSize: 15,
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
              // color: CustomColor.button_text_color,
            ),
          )
        ],
      );
    }
    else {
      var fareWithGST = strFareList.reduce(min) + strServiceTaxList.reduce(min);
      return Row(
        children: [

          //TODO Save Price Here
          Text(
            //'${strFareList.reduce(min)}',
            smallestValueStrike != null /*&& NavigatorConstants.USER_ID != '0' */? '₹ ${strFareList.reduce(min)}' : '₹ ${smallestValueStrike}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 19,
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
              // color: CustomColor.button_text_color,
            ),
          ),
          smallestValueStrike != null
              ? const SizedBox(width: 10,)
              : const SizedBox.shrink(),

          smallestValueStrike != null /*&& NavigatorConstants.USER_ID != '0'*/ ?
          Text(
            '₹ ${smallestValueStrike}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w400,
              // fontFamily: CommonConstants.FONT_SEMI_BOLD,
            ),
          ) : const SizedBox.shrink(),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: AppButton(() {
                if (widget.allRouteBusLists!.getElement('EmptySeats')!.text != "0") {
                  onTapStoreRouteDetails();
                  Navigator.of(context).pushNamed(
                      SeatArrangementAppScreen.routeName);
                }else{
                  UiUtils.errorSnackBar(message: 'No Seats Available!').show();
                }
              },
                text: 'Select Seat',
                round: 10,
              ),
            ),
          )

        ],
      );
    }
  }
}
