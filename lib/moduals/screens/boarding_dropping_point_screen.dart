import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/model/boarding_and_dropping_point_model.dart';
import 'package:royalcruiser/moduals/screens/avilable_route_screen.dart';
import 'package:royalcruiser/moduals/screens/passenger_info_screen.dart';
import 'package:royalcruiser/widgets/boarding_point_widget.dart';
import 'package:royalcruiser/widgets/dropping_point_widget.dart';
import 'package:xml/xml.dart';

class BoardingAndDroppingPointScreen extends StatefulWidget {
  static const routeName = '/boarding_dropping_point_screen';
  String ReferenceNumber;

  BoardingAndDroppingPointScreen({required this.ReferenceNumber});

  @override
  State<BoardingAndDroppingPointScreen> createState() =>
      _BoardingAndDroppingPointScreenState();
}

class _BoardingAndDroppingPointScreenState
    extends State<BoardingAndDroppingPointScreen>
    with SingleTickerProviderStateMixin {
  String? tripType;
  RxString formCity = "".obs;
  RxString toCity = "".obs;
  RxBool _isLoading = false.obs;

  RxString selectedBoardingPointOnwardID = "".obs;
  RxString selectedDroppingPointOnwardID = "".obs;

  RxString selectedBoardingPointReturnID = "".obs;
  RxString selectedDroppingPointReturnID = "".obs;

  List<BoardingDroppingPointDetails> _boardingPointList = [];
  List<BoardingDroppingPointDetails> _droppingPointList = [];

  RxString SelectedBoardingPointNameForPage = "".obs;
  RxString SelectedDroppingPointNameForPage = "".obs;

  late final _tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    getData().then((value) {
      _isLoading.value = true;
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: Obx(
          () => new Text(
            '$formCity' + ' To ' + '$toCity',
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 0.5,
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/bannerbg.png"),
                opacity: 80.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TabBar(
                  controller: _tabController,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.black,
                  indicatorWeight: 4,
                  indicatorColor: Colors.red,
                  labelPadding: SelectedBoardingPointNameForPage.isNotEmpty ||
                          SelectedDroppingPointNameForPage.isNotEmpty
                      ? EdgeInsets.only(
                          bottom: 30,
                          top: 5,
                        )
                      : EdgeInsets.all(5),
                  tabs: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.black54,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                      child: Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Boarding",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily:
                                    CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                              ),
                            ),
                            Obx(
                              () => SelectedBoardingPointNameForPage
                                      .value.isNotEmpty
                                  ? Flexible(
                                      child: Wrap(
                                        children: [
                                          Text(
                                            '$SelectedBoardingPointNameForPage',
                                            maxLines: 3,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: CommonConstants
                                                  .FONT_FAMILY_OPEN_SANS_REGULAR,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      child: Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Dropping",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily:
                                    CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                              ),
                            ),
                            Obx(
                              () => SelectedDroppingPointNameForPage
                                      .value.isNotEmpty
                                  ? Flexible(
                                      child: Wrap(
                                        children: [
                                          Text(
                                            '$SelectedDroppingPointNameForPage',
                                            maxLines: 3,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: CommonConstants
                                                  .FONT_FAMILY_OPEN_SANS_REGULAR,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      BoardingPointWidget(
                          boardingPointList: _boardingPointList,
                          onNext: () {
                            setState(() {
                              SelectedBoardingPointNameForPage.value =
                                  NavigatorConstants
                                      .SelectedBoardingPointNameForPage;
                              if (tripType == "0" || tripType == "1") {
                                selectedBoardingPointOnwardID.value =
                                    NavigatorConstants
                                        .SelectedBoardingPointOnwordID;
                              } else if (tripType == "2") {
                                selectedBoardingPointReturnID.value =
                                    NavigatorConstants
                                        .SelectedBoardingPointReturnID;
                              }
                            });
                            if (_droppingPointList.length > 0) {
                              _tabController.index = 1;
                            } else {
                              pageRedirectWithoutDropupList();
                              pageSetValueWithoutDroupList();
                            }
                          }),
                      DroppingPointWidget(
                        droppingPointList: _droppingPointList,
                        onNext: () {
                          setState(() {
                            if (NavigatorConstants
                                .SelectedBoardingPointNameForPage.isEmpty) {
                              _tabController.index = 0;
                            }
                            SelectedDroppingPointNameForPage.value =
                                NavigatorConstants
                                    .SelectedDroppingPointNameForPage;
                            if (tripType == "0" || tripType == "1") {
                              selectedDroppingPointOnwardID.value =
                                  NavigatorConstants
                                      .SelectedDroppingPointOnwordID;
                            } else if (tripType == "2") {
                              selectedDroppingPointReturnID.value =
                                  NavigatorConstants
                                      .SelectedDroppingPointReturnID;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void pageRedirectWithoutDropupList() {
    if (tripType == "0") {
      Navigator.of(context).pushNamed(PassengerInfoScreen.routeName);
    } else if (tripType == "1") {
      NavigatorConstants.TRIP_TYPE = "2";
      Navigator.of(context).pushNamed(AvailableRoutesAppScreen.routeName);
    } else if (tripType == "2") {
      Navigator.of(context).pushNamed(PassengerInfoScreen.routeName);
    }
  }

  void pageSetValueWithoutDroupList() {
    if (tripType == "0" || tripType == "1") {
      setState(() {
        NavigatorConstants.SelectedDroppingPointOnwordID = '0';
        NavigatorConstants.SelectedDroppingPointOnwordName = '';
        NavigatorConstants.SelectedDroppingPointOnwordTime = '';
      });
    } else if (tripType == "2") {
      setState(() {
        NavigatorConstants.SelectedDroppingPointReturnID = '0';
        NavigatorConstants.SelectedDroppingPointReturnName = '';
        NavigatorConstants.SelectedDroppingPointReturnTime = '';
      });
    }
  }

  //Old Method Get Boarding Dropping Date From GetAvailableRoutes_STax
  // Future<void> getData() async {
  //   tripType = NavigatorConstants.TRIP_TYPE;
  //   if (tripType == "0" || tripType == "1") {
  //
  //     print("My refNumber = ${widget.ReferenceNumber}");
  //
  //     formCity.value = NavigatorConstants.SOURCE_CITY_NAME;
  //     toCity.value = NavigatorConstants.DESTINATION_CITY_NAME;
  //     if (NavigatorConstants.BOARDING_POINT_ONWARD_ARRAY.isNotEmpty) {
  //       var jsonList = json.decode(NavigatorConstants.BOARDING_POINT_ONWARD_ARRAY);
  //       for (var seatList in jsonList) {
  //         _boardingPointList
  //             .add(BoardingDroppingPointDetails.fromJson(seatList));
  //       }
  //     }
  //
  //     if (NavigatorConstants.DROPPING_POINT_ONWARD_ARRAY.isNotEmpty) {
  //       var jsonList = json.decode(NavigatorConstants.DROPPING_POINT_ONWARD_ARRAY);
  //       for (var seatList in jsonList) {
  //         _droppingPointList
  //             .add(BoardingDroppingPointDetails.fromJson(seatList));
  //       }
  //     }
  //   }
  //   else if (tripType == "2") {
  //     toCity.value = NavigatorConstants.SOURCE_CITY_NAME;
  //     formCity.value = NavigatorConstants.DESTINATION_CITY_NAME;
  //
  //     if (NavigatorConstants.BOARDING_POINT_RETURN_ARRAY.isNotEmpty) {
  //       var jsonList = json.decode(NavigatorConstants.BOARDING_POINT_RETURN_ARRAY);
  //       for (var seatList in jsonList) {
  //         _boardingPointList
  //             .add(BoardingDroppingPointDetails.fromJson(seatList));
  //       }
  //     }
  //
  //     if (NavigatorConstants.DROPPING_POINT_RETURN_ARRAY.isNotEmpty) {
  //       var jsonList = json.decode(NavigatorConstants.DROPPING_POINT_RETURN_ARRAY);
  //       for (var seatList in jsonList) {
  //         _droppingPointList
  //             .add(BoardingDroppingPointDetails.fromJson(seatList));
  //       }
  //     }
  //   }
  // }

  //New Method Get Boarding Dropping Date From GetBoardingDropDetails_V2

  Future<void> getData() async {
    tripType = NavigatorConstants.TRIP_TYPE;

    NavigatorConstants.BOARDING_POINT_ONWARD_ARRAY="";
    NavigatorConstants.DROPPING_POINT_ONWARD_ARRAY="";

    if (tripType == "0" || tripType == "1") {
      print("My refNumber = ${widget.ReferenceNumber}");


      XmlDocument document =
          await ApiImplementer.getBoardingDropDetails_V2ApiImplementer(
              ReferenceNumber: widget.ReferenceNumber);

      List<BoardingDroppingPointDetails> bdPointList = [];

      if (document != null) {
        bool xmlElement =
            document.findAllElements('DocumentElement').isNotEmpty;

        if (xmlElement) {
          var xmlElement1 = document.findAllElements('BoardingDropping');

          for (var item in xmlElement1) {
            XmlElement xmlElement = item;

            BoardingDroppingPointDetails boardingDroppingPointDetails = BoardingDroppingPointDetails(
              PickUpID: xmlElement.findElements("PickUpID").first.text,
              latitude: xmlElement.findElements("Latitude").first.text,
              longitude: xmlElement.findElements("Longitude").first.text,
              onlyPickupName:
                  xmlElement.findElements("OnlyPickupName").first.text,
              pickUpAddress:
                  xmlElement.findElements("PickUpAddress").first.text,
              pickupDrop: xmlElement.findElements("PickupDrop").first.text,
              PickUpName: xmlElement.findElements("PickUpName").first.text,
              PickupPhone: xmlElement.findElements("PickupPhone").first.text,
              PickUpTime: xmlElement.findElements("PickUpTime").first.text,
              pSIDepartTime:
                  xmlElement.findElements("PSI_departTime").first.text,
            );

            bdPointList.add(boardingDroppingPointDetails);

            print(
                "My dat :- ${xmlElement.findElements("PickUpID").first.text}");
          }
        }
      }

      List<BoardingDroppingPointDetails> BoardingList = [];
      List<BoardingDroppingPointDetails> DroppingList = [];

      for (var item in bdPointList) {
        if (item.pickupDrop == "1") {
          BoardingList.add(item);
        } else if (item.pickupDrop == "2") {
          DroppingList.add(item);
        }
      }

      if (BoardingList.isNotEmpty) {
        NavigatorConstants.BOARDING_POINT_ONWARD_ARRAY = json.encode(BoardingList);
        print("BOARDING_POINT_ONWARD_ARRAY ${NavigatorConstants.BOARDING_POINT_ONWARD_ARRAY}");
      }

      if (DroppingList.isNotEmpty) {
        NavigatorConstants.DROPPING_POINT_ONWARD_ARRAY = json.encode(DroppingList);
      }

      formCity.value = NavigatorConstants.SOURCE_CITY_NAME;
      toCity.value = NavigatorConstants.DESTINATION_CITY_NAME;
      if (NavigatorConstants.BOARDING_POINT_ONWARD_ARRAY.isNotEmpty) {
        var jsonList =
            json.decode(NavigatorConstants.BOARDING_POINT_ONWARD_ARRAY);
        for (var seatList in jsonList) {
          _boardingPointList
              .add(BoardingDroppingPointDetails.fromJson(seatList));
        }
      }

      if (NavigatorConstants.DROPPING_POINT_ONWARD_ARRAY.isNotEmpty) {
        var jsonList =
            json.decode(NavigatorConstants.DROPPING_POINT_ONWARD_ARRAY);
        for (var seatList in jsonList) {
          _droppingPointList
              .add(BoardingDroppingPointDetails.fromJson(seatList));
        }
      }
    }
    else if (tripType == "2") {
      toCity.value = NavigatorConstants.SOURCE_CITY_NAME;
      formCity.value = NavigatorConstants.DESTINATION_CITY_NAME;

      if (NavigatorConstants.BOARDING_POINT_RETURN_ARRAY.isNotEmpty) {
        var jsonList =
            json.decode(NavigatorConstants.BOARDING_POINT_RETURN_ARRAY);
        for (var seatList in jsonList) {
          _boardingPointList
              .add(BoardingDroppingPointDetails.fromJson(seatList));
        }
      }

      if (NavigatorConstants.DROPPING_POINT_RETURN_ARRAY.isNotEmpty) {
        var jsonList =
            json.decode(NavigatorConstants.DROPPING_POINT_RETURN_ARRAY);
        for (var seatList in jsonList) {
          _droppingPointList
              .add(BoardingDroppingPointDetails.fromJson(seatList));
        }
      }
    }
  }
}
