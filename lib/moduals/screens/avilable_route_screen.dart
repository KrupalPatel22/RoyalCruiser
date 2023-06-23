import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/preferences_costances.dart';
import 'package:royalcruiser/model/recent_search_model.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:royalcruiser/utils/helpers/helper.dart';
import 'package:royalcruiser/widgets/available_route_widget.dart';
import 'package:royalcruiser/widgets/no_data_found_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

import '../../Controllers/booking_ticket_controller.dart';

class AvailableRoutesAppScreen extends StatefulWidget {
  static const String routeName = '/avilable_route_screen';

  const AvailableRoutesAppScreen({Key? key}) : super(key: key);

  @override
  State<AvailableRoutesAppScreen> createState() =>
      _AvailableRoutesAppScreenState();
}

class _AvailableRoutesAppScreenState extends State<AvailableRoutesAppScreen> {
  SharedPreferences? _sharedPreferences;
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String? sourceCityID;
  String? sourceCityName;
  String? destinationCityID;
  String? destinationCityName;
  String? journeyDate;
  String? tripType;
  final RxBool _isLoading = false.obs;
  var selectDateDynamic;
  var bookingTicketCtr = Get.put(BookingTicketController());
  ScrollController listCtr=ScrollController();
  ScrollController _scrollController = ScrollController();
  int scrollToIndex = 3;

  @override
  void initState() {
    _pref.then((SharedPreferences sharedPreferences) {
      _sharedPreferences = sharedPreferences;
      var _recentSearch = json.decode(
          _sharedPreferences!.getString(Preferences.RECENT_SEARCH).toString());
      if (_recentSearch != null){
        for (var rrr in _recentSearch) {
          recentSearch.add(RecentSeaechModel.fromJson(rrr));
        }
      }
    }).then((value) {
      getData().then((value) {
        selectDateDynamic = DateTime.parse(
            DateFormat("dd-MM-yyyy").parse(journeyDate.toString()).toString());
      });
      print('test date:- ${journeyDate}');
      /*_scrollController.addListener(() {
        // Add logic here to handle scroll events if needed
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(10);
      });*/
      bookingTicketCtr.selectedDate.value = DateTime.parse(
          DateFormat("dd-MM-yyyy").parse(journeyDate.toString()).toString());
      bookingTicketCtr.get30DaysDate();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToIndex();
      });
    }).then((value) => _isLoading.value = true);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

/*  void _scrollToIndex() {
    if (scrollToIndex > 0) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        scrollToIndex--;
      });
      Future.delayed(Duration(milliseconds: 600), _scrollToIndex);
    }
  }*/
  void _scrollToIndex() {
    if (scrollToIndex >= 0) {
      _scrollController.animateTo(
        scrollToIndex * 70.0, // Width of each item
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      // scrollToIndex--;
      /*setState(() {
        scrollToIndex--;
      });*/
      Future.delayed(const Duration(milliseconds: 600), _scrollToIndex);
    }
  }

  Future<void> getData() async {
    tripType = NavigatorConstants.TRIP_TYPE;
    if (tripType == "0" || tripType == "1") {
      journeyDate = NavigatorConstants.ONWARD_DATE;
      sourceCityID = NavigatorConstants.SOURCE_CITY_ID;
      destinationCityID = NavigatorConstants.DESTINATION_CITY_ID;
      sourceCityName = NavigatorConstants.SOURCE_CITY_NAME;
      destinationCityName = NavigatorConstants.DESTINATION_CITY_NAME;
    } else if (tripType == "2") {
      journeyDate = NavigatorConstants.RETURN_DATE;
      destinationCityID = NavigatorConstants.SOURCE_CITY_ID;
      sourceCityID = NavigatorConstants.DESTINATION_CITY_ID;
      destinationCityName = NavigatorConstants.SOURCE_CITY_NAME;
      sourceCityName = NavigatorConstants.DESTINATION_CITY_NAME;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        _setPref();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GetPlatform.isAndroid
              ? IconButton(
                  onPressed: () {
                    _setPref();
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back))
              : IconButton(
                  onPressed: () {
                    _setPref();
                    Get.back();
                  },
                  icon: const Icon(CupertinoIcons.back)),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white, size: 24),
          toolbarHeight: MediaQuery.of(context).size.height / 14,
          title: const Text(
            'Select Services',
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 0.5,
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
            ),
          ),
        ),
        body: Obx(
          () => !_isLoading.value
              ? Container()
              : SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      showNewDateWidget(),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/bannerbg.png"),
                                  opacity: 80.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            FutureBuilder<XmlDocument>(
                                future: ApiImplementer.getAvailableRouteSTaxApiImplementer(FromID: sourceCityID!, ToID: destinationCityID!, JourneyDate: journeyDate!),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return AppDialogs.screenAppShowDiloag(context);
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        snapshot.error.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }/*else if(snapshot.hasData){

                                  }*/
                                  List<XmlElement> response = snapshot.data!.findAllElements('AllRouteBusLists').toList();
                                  if (response.isNotEmpty && (tripType == "0" || tripType == "1")){
                                    searchSetPref();
                                  }
                                  return snapshot.data!.findAllElements('AllRouteBusLists').isNotEmpty
                                      ? ListView.builder(
                                          itemCount: response.length,
                                          itemBuilder: (context, index) {
                                            return AvailableRouteWidget(allRouteBusLists: response[index],);
                                          },
                                        )
                                      : const NoDataFoundWidget(
                                          msg: 'No Trip(s) Available',
                                    );
                             }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void discardReturnTripOnTap() async {
    // NavigatorConstants.TRIP_TYPE = "0";
    // removeData();
    // final result = await Navigator.of(context)
    //     .pushNamed(PassengerInfoScreen.routeName, arguments: true);
    // if (result != null) {
    //   print(result);
    //   print('result');
    //   NavigatorConstants.TRIP_TYPE = result.toString();
    // }
  }

  void removeData() {
    NavigatorConstants.SELECTED_SEAT_LIST_RETURN = '';

    NavigatorConstants.ALL_ROUTE_LIST_RETURN = '';
    NavigatorConstants.BOARDING_POINT_RETURN_ARRAY = '';
    NavigatorConstants.DROPPING_POINT_RETURN_ARRAY = '';

    NavigatorConstants.SelectedBoardingPointReturnID = '';
    NavigatorConstants.SelectedDroppingPointReturnID = '';

    NavigatorConstants.SelectedBoardingPointReturnName = '';
    NavigatorConstants.SelectedDroppingPointReturnName = '';

    NavigatorConstants.SelectedBoardingPointReturnTime = '';
    NavigatorConstants.SelectedDroppingPointReturnTime = '';
  }

  final List<RecentSeaechModel> recentSearch = [];

  void searchSetPref() {
    recentSearch.removeWhere((element) {
      return element.S_CityID == sourceCityID &&
          element.D_CityID == destinationCityID;
    });
    _sharedPreferences!.remove(Preferences.RECENT_SEARCH);
    RecentSeaechModel model = RecentSeaechModel(
        S_CityID: sourceCityID!,
        D_CityID: destinationCityID!,
        S_CityName: sourceCityName!,
        D_CityName: destinationCityName!,
        J_Date: journeyDate!);
    recentSearch.add(model);
    _sharedPreferences!.setString(Preferences.RECENT_SEARCH,
        json.encode(recentSearch as List<RecentSeaechModel>));
  }

  //Old Date Widget
  Widget showDateWidget() {
    return Card(
      elevation: 2.0,
      color: Colors.grey.shade200,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ...[
              if (tripType == "0" || tripType == "1") ...[
                if (journeyDate!.compareTo(
                        DateFormat('dd-MM-yyyy').format(DateTime.now())) !=
                    0)
                  InkWell(
                    child: const Image(
                      image:
                          AssetImage('assets/images/ic_arrow_left.png'),
                      height: 25,
                      color: CustomeColor.sub_bg,
                    ),
                    onTap: () {
                      setState(() {
                        selectDateDynamic = DateTime(selectDateDynamic.year,
                            selectDateDynamic.month, selectDateDynamic.day - 1);
                        journeyDate = DateFormat('dd-MM-yyyy')
                            .format(selectDateDynamic)
                            .toString();
                        NavigatorConstants.ONWARD_DATE = journeyDate!;
                      });
                    },
                  )
                else
                  const SizedBox()
              ] else if (tripType == "2") ...[
                if (journeyDate!.compareTo(DateFormat('dd-MM-yyyy').format(
                      DateTime.parse(
                        DateFormat('dd-MM-yyyy')
                            .parse(NavigatorConstants.ONWARD_DATE)
                            .toString(),
                      ),
                    )) !=
                    0)
                  InkWell(
                    child: const Image(
                      image:
                          AssetImage('assets/images/ic_arrow_left.png'),
                      height: 25,
                      color: CustomeColor.sub_bg,
                    ),
                    onTap: () {
                      setState(() {
                        selectDateDynamic = DateTime(selectDateDynamic.year,
                            selectDateDynamic.month, selectDateDynamic.day - 1);
                        journeyDate = DateFormat('dd-MM-yyyy')
                            .format(selectDateDynamic)
                            .toString();
                        NavigatorConstants.RETURN_DATE = journeyDate!;
                      });
                    },
                  )
                else
                  const SizedBox()
              ],
            ],
            Text(
              DateFormat('EEEE dd MMMM yyyy').format(
                DateTime.parse(
                  DateFormat('dd-MM-yyyy').parse(journeyDate!).toString(),
                ),
              ),
              style: const TextStyle(
                fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                fontSize: 16,
              ),
            ),
            ...[
              if (tripType == "0" || tripType == "1")
                InkWell(
                  child: const Image(
                    image: AssetImage('assets/images/ic_arrow_right.png'),
                    height: 25,
                    color: CustomeColor.sub_bg,
                  ),
                  onTap: () {
                    setState(() {
                      selectDateDynamic = DateTime(selectDateDynamic.year,
                          selectDateDynamic.month, selectDateDynamic.day + 1);
                      journeyDate = DateFormat('dd-MM-yyyy')
                          .format(selectDateDynamic)
                          .toString();
                      NavigatorConstants.ONWARD_DATE = journeyDate!;
                    });
                  },
                )
              else if (tripType == "2")
                InkWell(
                  child: const Image(
                    image: AssetImage('assets/images/ic_arrow_right.png'),
                    height: 25,
                    color: CustomeColor.sub_bg,
                  ),
                  onTap: () {
                    setState(() {
                      selectDateDynamic = DateTime(selectDateDynamic.year,
                          selectDateDynamic.month, selectDateDynamic.day + 1);
                      journeyDate = DateFormat('dd-MM-yyyy')
                          .format(selectDateDynamic)
                          .toString();
                      NavigatorConstants.RETURN_DATE = journeyDate!;
                    });
                  },
                )
            ],
          ],
        ),
      ),
    );
  }
  //New Current Date Widget (20-05-2023)
  Widget showNewDateWidget() {
    //Future.delayed(Duration(seconds: 3)).then((value) => listCtr.jumpTo(15));
    // Future.delayed(const Duration(seconds: 3)).then((value) => bookingTicketCtr.selectedDate.value = DateTime.parse(
    //     DateFormat("dd-MM-yyyy").parse(journeyDate.toString()).toString()));
    // bookingTicketCtr.get30DaysDate();
    return Container(
      //elevation: 2.0,
      decoration: const BoxDecoration(
          color: CustomeColor.main_bg,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Obx(() => SizedBox(
            height: 80,
            width: MediaQuery.of(context).size.width,
            // padding: EdgeInsets.symmetric(
            //     horizontal: 10,
            //     vertical: 10),
            child: ListView.builder(
              controller: listCtr,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: bookingTicketCtr.dateList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    bookingTicketCtr.selectedDate(bookingTicketCtr.dateList[index]);

                    setState(() {
                      selectDateDynamic = bookingTicketCtr.dateList[index];
                      journeyDate = DateFormat('dd-MM-yyyy')
                          .format(selectDateDynamic)
                          .toString();
                      NavigatorConstants.RETURN_DATE = journeyDate!;
                    });

                  },
                  child: Container(
                    height: 50,
                    width: 80,
                    decoration: BoxDecoration(
                        color: (bookingTicketCtr.selectedDate.value.day ==
                                    bookingTicketCtr.dateList[index].day &&
                                Helper.getMonthNameFromDate(
                                        bookingTicketCtr.selectedDate.value) ==
                                    Helper.getMonthNameFromDate(
                                        bookingTicketCtr.dateList[index]))
                            ? Colors.white
                            : CustomeColor.main_bg,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      Text(
                        '${bookingTicketCtr.dateList[index].day}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: (bookingTicketCtr.selectedDate.value.day ==
                                        bookingTicketCtr.dateList[index].day &&
                                    Helper.getMonthNameFromDate(bookingTicketCtr
                                            .selectedDate.value) ==
                                        Helper.getMonthNameFromDate(
                                            bookingTicketCtr.dateList[index]))
                                ? CustomeColor.main_bg
                                : Colors.white),
                      ),
                      Text(
                          Helper.getMonthNameFromDate(bookingTicketCtr.dateList[index]),
                          style: TextStyle(
                              fontSize: 12,
                              color: (bookingTicketCtr.selectedDate.value.day ==
                                          bookingTicketCtr
                                              .dateList[index].day &&
                                      Helper.getMonthNameFromDate(
                                              bookingTicketCtr
                                                  .selectedDate.value) ==
                                          Helper.getMonthNameFromDate(
                                              bookingTicketCtr.dateList[index]))
                                  ? CustomeColor.main_bg
                                  : Colors.white)),
                    ]),
                  ),
                );
              },
            ),
          )),
    );
  }

  void _setPref() {
    if (tripType == "2") {
      NavigatorConstants.TRIP_TYPE = "1";
    }
  }
}
