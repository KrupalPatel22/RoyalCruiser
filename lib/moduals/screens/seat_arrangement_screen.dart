import 'dart:convert';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/model/available_route_stax_model.dart';
import 'package:royalcruiser/model/boarding_and_dropping_point_model.dart';
import 'package:royalcruiser/model/seat_arrangement_stax_model.dart';
import 'package:royalcruiser/moduals/screens/boarding_dropping_point_screen.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xml/xml.dart';
import 'package:flutter_svg/svg.dart';

class SeatArrangementAppScreen extends StatefulWidget {
  static const routeName = '/seat_management_screen';

  const SeatArrangementAppScreen({Key? key}) : super(key: key);

  @override
  State<SeatArrangementAppScreen> createState() =>
      _SeatArrangementAppScreenState();
}

class _SeatArrangementAppScreenState extends State<SeatArrangementAppScreen> {
  String? tripType;
  AllRouteBusLists? allRouteBusLists;

  RxBool _isLoading = false.obs;
  RxBool _isSeatApiCall = false.obs;
  RxBool _isLoadingfData = false.obs;

  RxInt _isTabbar = 0.obs;

  List<ITSSeatDetails> _lowerBerth = [];
  List<ITSSeatDetails> _upperBerth = [];
  List<ITSSeatDetails> _selected_seat_list = [];

  // List<PassengerDetailsModel> _selected_seat_list_gender = [];

  late Color available_seat_color;
  late Color ladies_seat_color;
  late Color selected_seat_color;
  late Color booked_seat_color;

  List<BoardingDroppingPointDetails> _boardingPoint = [];
  List<BoardingDroppingPointDetails> _droppingPoint = [];

  @override
  void initState() {
    getData().then((value) {
      _isLoadingfData.value = true;
      getSeatArrangementSTaxApiCall();
    }).then((value) {
      getBoardingPointStore();
      getDroppingPointStore();
    }).then((value) => _isLoading.value = true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 13,
        title: Obx(
          () => !_isLoadingfData.value
              ? const Text('')
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${allRouteBusLists!.FromCityName} To ${allRouteBusLists!.ToCityName}',
                      style: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                      ),
                    ),
                    Text(
                      allRouteBusLists!.ArrangementName,
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: 0.5,
                        fontFamily:
                            CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                      ),
                    ),
                    Text(
                      'Journey on ${DateFormat('EEEE').format(
                        DateTime.parse(
                          DateFormat('dd-MM-yyyy')
                              .parse(allRouteBusLists!.BookingDate)
                              .toString(),
                        ),
                      )} ${allRouteBusLists!.BookingDate} ${allRouteBusLists!.CityTime}',
                      style: const TextStyle(
                        fontSize: 12,
                        letterSpacing: 0.5,
                        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                      ),
                    ),
                  ],
                ),
        ),
      ),
      body: Obx(
        () => !_isLoading.value
            ? Container()
            : Stack(
                children: [
                  new Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/bannerbg.png"),
                        opacity: 80.0,
                        fit: BoxFit.fill,
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
                        seatColorInfoWidget(),
                        const Divider(
                          color: Colors.black,
                          height: 1,
                          thickness: 0.5,
                        ),
                        Obx(
                          () => _isSeatApiCall.value
                              ? Expanded(
                                  child: Custome_Tabbar_View_Widget(),
                                )
                              : Expanded(
                                  child: Container(),
                                ),
                        ),
                        Container(
                          height: 50,
                          color: Colors.grey.shade200,
                          padding:
                              const EdgeInsets.only(left: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Wrap(
                                  children: <Widget>[
                                    StrselectedSeat(),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: _selected_seat_list.length > 0
                                        ? StrselectedSeatAmt()
                                        : const SizedBox.shrink(),
                                  ),
                                  const SizedBox(width: 10),
                                     selectedSeatStrikeFare(),
                                ],),
                              ),

                              const SizedBox(width: 20),

                              IntrinsicHeight(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // for (int i = 0;
                                    //     i < _selected_seat_list.length;
                                    //     i++) {
                                    //   print(_selected_seat_list[i].SeatNo +
                                    //       '  ===>  ' +
                                    //       _selected_seat_list_gender[i].gender);
                                    // }
                                    onTapEvent();
                                  },
                                  child: Text(
                                    'Done'.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize:
                                            16,
                                        fontFamily: CommonConstants
                                            .FONT_FAMILY_OPEN_SANS_REGULAR),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void snackbarMsg(String msg) {
    final SnackBar snakBar = SnackBar(
      content: Text(
        msg,
        style: const TextStyle(
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
            fontSize: 16),
      ),
      duration: const Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).showSnackBar(snakBar);
  }

  void onTapEvent() {
    if (_selected_seat_list.isEmpty) {
      snackbarMsg('Please select seat');
    } else {
      if (tripType == "0" || tripType == "1") {
        NavigatorConstants.SELECTED_SEAT_LIST_RETURN = '';
        NavigatorConstants.ALL_ROUTE_LIST_RETURN = '';
        NavigatorConstants.BOARDING_POINT_RETURN_ARRAY = '';
        NavigatorConstants.DROPPING_POINT_RETURN_ARRAY = '';

        NavigatorConstants.SelectedBoardingPointReturnID = '';
        NavigatorConstants.SelectedDroppingPointReturnID = '';

        NavigatorConstants.SelectedBoardingPointOnwordID = '';
        NavigatorConstants.SelectedDroppingPointOnwordID = '';

        NavigatorConstants.SelectedBoardingPointNameForPage = '';
        NavigatorConstants.SelectedDroppingPointNameForPage = '';

        NavigatorConstants.SelectedBoardingPointReturnName = '';
        NavigatorConstants.SelectedDroppingPointReturnName = '';

        NavigatorConstants.SelectedBoardingPointOnwordName = '';
        NavigatorConstants.SelectedDroppingPointOnwordName = '';

        NavigatorConstants.SelectedBoardingPointOnwordTime = '';
        NavigatorConstants.SelectedDroppingPointOnwordTime = '';

        NavigatorConstants.SelectedBoardingPointReturnTime = '';
        NavigatorConstants.SelectedDroppingPointReturnTime = '';

        NavigatorConstants.SELECTED_SEAT_LIST_ONWARD =
            json.encode(_selected_seat_list);
        NavigatorConstants.BOARDING_POINT_ONWARD_ARRAY =
            json.encode(_boardingPoint as List<BoardingDroppingPointDetails>);
        NavigatorConstants.DROPPING_POINT_ONWARD_ARRAY =
            json.encode(_droppingPoint as List<BoardingDroppingPointDetails>);
      } else if (tripType == "2") {
        NavigatorConstants.SelectedBoardingPointReturnID = '';
        NavigatorConstants.SelectedDroppingPointReturnID = '';

        NavigatorConstants.SelectedBoardingPointReturnTime = '';
        NavigatorConstants.SelectedDroppingPointReturnTime = '';

        NavigatorConstants.SelectedBoardingPointReturnName = '';
        NavigatorConstants.SelectedDroppingPointReturnName = '';

        NavigatorConstants.SelectedBoardingPointReturnID = '';
        NavigatorConstants.SelectedDroppingPointReturnID = '';

        NavigatorConstants.SELECTED_SEAT_LIST_RETURN =
            json.encode(_selected_seat_list);
        NavigatorConstants.BOARDING_POINT_RETURN_ARRAY =
            json.encode(_boardingPoint);
        NavigatorConstants.DROPPING_POINT_RETURN_ARRAY =
            json.encode(_droppingPoint);
      }
      Navigator.of(context).pushNamed(BoardingAndDroppingPointScreen.routeName);
    }
  }

  void getBoardingPointStore() async {
    if (allRouteBusLists!.BoardingPoints.isNotEmpty) {
      List<String> boarding = allRouteBusLists!.BoardingPoints.split('#');

      for (int i = 0; i < boarding.length; i++) {
        String boardingId = boarding[i].split('|')[0] ?? '';
        String boardingName = boarding[i].split('|')[1] ?? '';
        String boardingTime = boarding[i].split('|')[2] ?? '';
        String boardingMobile = boarding[i].split('|')[3] ?? '';

        BoardingDroppingPointDetails boardingDroppingPointDetails =
            BoardingDroppingPointDetails(
          PickUpID: boardingId,
          PickUpName: boardingName,
          PickUpTime: boardingTime,
          PickupPhone: boardingMobile,
        );
        _boardingPoint.add(boardingDroppingPointDetails);
      }
    }
  }

  void getDroppingPointStore()  {
    if (allRouteBusLists!.DroppingPoints.isNotEmpty) {
      List<String> dropping = allRouteBusLists!.DroppingPoints.split('#');

      for (int i = 0; i < dropping.length; i++) {
        String droppingId = '';
        String droppingName = '';
        String droppingTime = '';
        String droppingMobile = '';
        droppingId = dropping[i].split('|')[0] ?? '';
        droppingName = dropping[i].split('|')[1] ?? '';
        droppingTime = dropping[i].split('|')[2] ?? '';
        droppingMobile = '';

        BoardingDroppingPointDetails boardingDroppingPointDetails1 =
            BoardingDroppingPointDetails(
          PickUpID: droppingId,
          PickUpName: droppingName,
          PickUpTime: droppingTime,
          PickupPhone: droppingMobile,
        );
        _droppingPoint.add(boardingDroppingPointDetails1);
      }
    }
  }

  Widget StrselectedSeat() {
    String onwardSeatstring = '';
    for (int i = 0; i < _selected_seat_list.length; i++) {
      if (i == 0) {
        onwardSeatstring = _selected_seat_list[i].SeatNo;
      } else {
        onwardSeatstring =
            "$onwardSeatstring,${_selected_seat_list[i].SeatNo}";
      }
    }

    return Text(
      onwardSeatstring,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
      ),
    );
  }


  Widget selectedSeatStrikeFare() {
    double onwardSeatString = 0.0;
    for (int i = 0; i < _selected_seat_list.length; i++) {
      onwardSeatString += double.parse(_selected_seat_list[i].OriginalSeatRate);
    }
    return onwardSeatString != 0.0 /*&& NavigatorConstants.USER_ID != '0'*/ ? Text(
      '$onwardSeatString',
      style: const TextStyle(
        fontSize: 14,
        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
        decoration: TextDecoration.lineThrough,
        color: Colors.black,
      ),
    ) : const SizedBox.shrink();
  }

  Widget StrselectedSeatAmt() {
    double onwardSeatString = 0.0;
    double onwardSeatStrike = 0.0;
    for (int i = 0; i < _selected_seat_list.length; i++) {
      /*if(NavigatorConstants.USER_ID != '0'){*/
        onwardSeatString += double.parse(_selected_seat_list[i].BaseFare);
     /* }else{
        onwardSeatStrike += double.parse(_selected_seat_list[i].OriginalSeatRate);
        if(onwardSeatStrike > 0){
          onwardSeatString += double.parse(_selected_seat_list[i].OriginalSeatRate);
        }
      }*/
    }
    return Text(
      '$onwardSeatString',
      style: const TextStyle(
        fontSize: 14,
        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
        color: Colors.red,
      ),
    );
  }

  Widget Custome_Tabbar_View_Widget() {
    return DefaultTabController(
      length: _isTabbar.value,
      initialIndex: 0,
      child: SeatManagementWidget(),
    );
  }

  Widget SeatManagementWidget() {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          color: Colors.grey.shade300,
          child: TabBar(
            unselectedLabelColor: Colors.black,
            labelColor: Colors.black,
            indicatorWeight: 4,
            indicatorColor: Colors.red,
            tabs: _isTabbar.value.compareTo(2) == 0
                ? [
                    Tab(
                      child: Text(
                        "Lower".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily:
                              CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Upper".toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily:
                              CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                        ),
                      ),
                    )
                  ]
                : [
                    const Tab(
                      child: Text(
                        "Lower",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
          ),
        ),
        Expanded(
          child: TabBarView(
            children: _isTabbar.value.compareTo(2) == 0
                ? [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 3),
                      decoration: const BoxDecoration(
                        // color: CustomeColor.main_bg,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: lbSeatManage(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 3),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: ubSeatManage(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                : [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 3),
                      decoration: const BoxDecoration(
                        // color: CustomeColor.main_bg,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: lbSeatManage(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
          ),
        ),
      ],
    );
  }

  Widget lbSeatManage() {
    double width1 = MediaQuery.of(context).size.width;
    double buttonWidth = width1 / 4;
    double buttonHeight = width1 / 11;
    double buttonSpace = (width1 / 8);
    double seatNameSize = ((width1 / 6) / 4) - 8;
    return Stack(
      children: List.generate(_lowerBerth.length, (i) {
        EdgeInsets margin = EdgeInsets.only(
            left: (int.parse(_lowerBerth[i].Column) - 1) * buttonSpace + 10,
            top: (int.parse(_lowerBerth[i].Row) - 1) * buttonSpace + 10,
            right: 0,
            bottom: 0);
        Color color = _selected_seat_list.contains(_lowerBerth[i])
            ? selected_seat_color
            : seatColorDefine(index: _lowerBerth[i]);
        BoxDecoration decoration = const BoxDecoration(
          // borderRadius: const BorderRadius.all(Radius.circular(15)),
          // color: color,
        );
        TextStyle textStyle = TextStyle(
            fontSize: seatNameSize,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
            color: _selected_seat_list.contains(_lowerBerth[i])
                ? Colors.white
                : textColorDefineFunction(index: _lowerBerth[i]),
            letterSpacing: 1.0);
        return int.parse(_lowerBerth[i].BlockType) != 3
            ? int.parse(_lowerBerth[i].ColumnSpan) > 0
                ? GestureDetector(
                    onTap: () {
                      onTapFunctionLower(i: i);
                      // onTapPassenerModelWithGenderLower(
                      //     context: context, index: i);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: buttonWidth,
                      height: buttonHeight,
                      margin: margin,
                      decoration: decoration,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // SvgPicture.asset('assets/images/blue_seat.svg'),
                          Text(
                            _lowerBerth[i].SeatNo,
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                  )
                : int.parse(_lowerBerth[i].RowSpan) > 0
                    ? GestureDetector(
                        onTap: () {
                          onTapFunctionLower(i: i);
                          // onTapPassenerModelWithGenderLower(
                          //     context: context, index: i);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: buttonHeight,
                          height: buttonWidth,
                          margin: margin,
                          decoration: decoration,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // SvgPicture.asset('assets/images/blue_seat.svg'),
                              Text(
                                _lowerBerth[i].SeatNo,
                                textAlign: TextAlign.center,
                                style: textStyle,
                              ),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          onTapFunctionLower(i: i);
                          // onTapPassenerModelWithGenderLower(
                          //     context: context, index: i);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: buttonHeight,
                          height: buttonHeight,
                          margin: margin,
                          decoration: decoration,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // SvgPicture.asset('assets/images/blue_seat.svg',
                              SvgPicture.asset('assets/images/bg.svg',
                              // SvgPicture.asset('assets/images/single-b.svg',
                              // SvgPicture.asset('assets/images/double-b.svg',
                              color: color,
                              height: buttonHeight,
                              width: buttonHeight,),
                              Text(
                                _lowerBerth[i].SeatNo,
                                textAlign: TextAlign.center,
                                style: textStyle,
                              ),
                            ],
                          ),
                        ),
                      )
            : const SizedBox.shrink();
      }),
    );
  }

  Widget ubSeatManage() {
    double width1 = MediaQuery.of(context).size.width;
    double buttonWidth = width1 / 4;
    double buttonHeight = width1 / 8;
    double buttonSpace = (width1 / 7);
    double seatNameSize = ((width1 / 6) / 3) - 5;
    return Stack(
      children: List.generate(_upperBerth.length, (i) {
        double space;
        if (int.parse(_upperBerth[i].Column) > 4) {
          space = (buttonSpace * (int.parse(_upperBerth[i].Column) - 4) + 10);
        } else {
          space = (buttonSpace * (int.parse(_upperBerth[i].Column) - 1) + 10);
        }
        EdgeInsets margin = EdgeInsets.only(
            left: space,
            top: (int.parse(_upperBerth[i].Row) - 1) * buttonSpace + 10,
            right: 0,
            bottom: 0);
        EdgeInsets margin1 = EdgeInsets.only(
            left: (int.parse(_upperBerth[i].Column) - 1) * buttonSpace + 10,
            top: (int.parse(_upperBerth[i].Row) - 1) * buttonSpace + 10,
            right: 0,
            bottom: 0);
        Color color = _selected_seat_list.contains(_upperBerth[i])
            ? selected_seat_color
            : seatColorDefine(index: _upperBerth[i]);
        BoxDecoration decoration = BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: color,
        );
        TextStyle textStyle = TextStyle(
            fontSize: seatNameSize,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
            color: _selected_seat_list.contains(_upperBerth[i])
                ? Colors.white
                : textColorDefineFunction(index: _upperBerth[i]),
            letterSpacing: 1.0);
        return int.parse(_upperBerth[i].BlockType) != 3
            ? int.parse(_upperBerth[i].ColumnSpan) > 0
                ? GestureDetector(
                    onTap: () {
                      onTapFunctionUpper(i: i);
                      // onTapPassenerModelWithGenderUpper(
                      //     context: context, index: i);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: buttonWidth,
                      height: buttonHeight,
                      margin: margin,
                      decoration: decoration,
                      child: Text(
                        _upperBerth[i].SeatNo,
                        textAlign: TextAlign.center,
                        style: textStyle,
                      ),
                    ),
                  )
                : int.parse(_upperBerth[i].RowSpan) > 0
                    ? GestureDetector(
                        onTap: () {
                          onTapFunctionUpper(i: i);
                          // onTapPassenerModelWithGenderUpper(
                          //     context: context, index: i);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: buttonHeight,
                          height: buttonWidth,
                          margin: margin,
                          decoration: decoration,
                          child: Text(
                            _upperBerth[i].SeatNo,
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          onTapFunctionUpper(i: i);
                          // onTapPassenerModelWithGenderUpper(
                          //     context: context, index: i);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: buttonHeight,
                          height: buttonHeight,
                          margin: margin,
                          decoration: decoration,
                          child: Text(
                            _upperBerth[i].SeatNo,
                            textAlign: TextAlign.center,
                            style: textStyle,
                          ),
                        ),
                      )
            : const SizedBox.shrink();
      }),
    );
  }

  void onTapFunctionLower({required int i}) {
    if (ClickEventDynamicBool(index: _lowerBerth[i])) {
      if (_selected_seat_list.length < 10) {
        setState(() {
          if (_selected_seat_list.contains(_lowerBerth[i]) == false) {
            _selected_seat_list.add(_lowerBerth[i]);
          } else {
            _selected_seat_list.remove(_lowerBerth[i]);
          }
        });
      } else if (_selected_seat_list.contains(_lowerBerth[i])) {
        setState(() {
          _selected_seat_list.remove(_lowerBerth[i]);
        });
      } else {
        AppDialogs.showErrorDialog(
            context: context,
            errorMsg: 'You can not select more then 10 seats',
            onOkBtnClickListener: () {
              Navigator.of(context).pop();
            }, title: 'Alert!!');
      }
    }
  }

  void onTapFunctionUpper({required int i}) {
    if (ClickEventDynamicBool(index: _upperBerth[i])) {
      if (_selected_seat_list.length < 10) {
        setState(() {
          if (_selected_seat_list.contains(_upperBerth[i]) == false) {
            _selected_seat_list.add(_upperBerth[i]);
          } else {
            _selected_seat_list.remove(_upperBerth[i]);
          }
        });
      } else if (_selected_seat_list.contains(_upperBerth[i])) {
        setState(() {
          _selected_seat_list.remove(_upperBerth[i]);
        });
      } else {
        AppDialogs.showErrorDialog(
            context: context,
            errorMsg: 'You can not select more then 10 seats',
            onOkBtnClickListener: () {
              Navigator.of(context).pop();
            }, title: 'Alert!!');
      }
    }
  }

  bool ClickEventDynamicBool({required ITSSeatDetails index}) {
    bool boolSelected;
    if ((double.parse(index.SeatRate.toString())) == 0) {
      boolSelected = false;
    } else if (index.IsLadiesSeat.compareTo("N") == 0 &&
        index.Available.compareTo("N") == 0) {
      boolSelected = false;
    } else if (index.IsLadiesSeat.compareTo("Y") == 0 &&
        index.Available.compareTo("N") == 0) {
      boolSelected = false;
    } else {
      boolSelected = true;
    }
    return boolSelected;
  }

  Color seatColorDefine({required ITSSeatDetails index}) {
    Color colorsDynamic;
    if ((double.parse(index.SeatRate.toString())) == 0) {
      colorsDynamic = booked_seat_color;
    } else if (index.IsLadiesSeat.compareTo("N") == 0 &&
        index.Available.compareTo("N") == 0) {
      colorsDynamic = booked_seat_color;
    } else if (index.IsLadiesSeat.compareTo("Y") == 0 &&
        index.Available.compareTo("N") == 0) {
      colorsDynamic = ladies_seat_color;
    } else {
      colorsDynamic = available_seat_color;
    }
    return colorsDynamic;
  }

  Color textColorDefineFunction({required ITSSeatDetails index}) {
    Color colorsDynamics;
    if ((double.parse(index.SeatRate.toString())) == 0) {
      colorsDynamics = Colors.white;
    } else if (index.IsLadiesSeat.compareTo("N") == 0 &&
        index.Available.compareTo("N") == 0) {
      colorsDynamics = Colors.white;
    } else if (index.IsLadiesSeat.compareTo("Y") == 0 &&
        index.Available.compareTo("N") == 0) {
      colorsDynamics = Colors.white;
    } else {
      colorsDynamics = Colors.black;
    }
    return colorsDynamics;
  }

  Future<void> getData() async {
    tripType = NavigatorConstants.TRIP_TYPE;
    if (tripType == "0" || tripType == "1") {
      var data = NavigatorConstants.ALL_ROUTE_LIST_ONWARD;
      if (data.isNotEmpty) {
        allRouteBusLists = AllRouteBusLists.fromJson(json.decode(data));
      }
    } else if (tripType == "2") {
      var data = NavigatorConstants.ALL_ROUTE_LIST_RETURN;
      if (data.isNotEmpty) {
        allRouteBusLists = AllRouteBusLists.fromJson(json.decode(data));
      }
    }
    available_seat_color = NavigatorConstants.AVAILABLE_SEAT_COLOR.isNotEmpty
        ? Color(int.parse(
            NavigatorConstants.AVAILABLE_SEAT_COLOR.replaceAll("#", "0xFF")))
        : Colors.grey;
    ladies_seat_color = NavigatorConstants.LADIES_SEAT_COLOR.isNotEmpty
        ? Color(int.parse(
            NavigatorConstants.LADIES_SEAT_COLOR.replaceAll("#", "0xFF")))
        : Colors.purple;
    selected_seat_color = NavigatorConstants.SELECTED_SEAT_COLOR.isNotEmpty
        ? Color(int.parse(
            NavigatorConstants.SELECTED_SEAT_COLOR.replaceAll("#", "0xFF")))
        : Colors.green;
    booked_seat_color = NavigatorConstants.BOOKED_SEAT_COLOR.isNotEmpty
        ? Color(int.parse(
            NavigatorConstants.BOOKED_SEAT_COLOR.replaceAll("#", "0xFF")))
        : Colors.red;

    // print('booked: ${NavigatorConstants.BOOKED_SEAT_COLOR}');
    // print('available: ${NavigatorConstants.AVAILABLE_SEAT_COLOR}');
    // print('lady: ${NavigatorConstants.LADIES_SEAT_COLOR}');
    // print('selected: ${NavigatorConstants.SELECTED_SEAT_COLOR}');
  }

  void getSeatArrangementSTaxApiCall() {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.getSeatArrabgementDetailsSTaxApiImplementer(
            ReferenceNumber: allRouteBusLists!.ReferenceNumber)
        .then((XmlDocument document) {
      Navigator.of(context).pop();
      _isSeatApiCall.value = true;
      bool xmlElement = document.findAllElements('NewDataSet').isNotEmpty;
      if (xmlElement) {
        List<XmlElement> element =
            document.findAllElements('ITSSeatDetails').toList();
        if (element.isNotEmpty) {
          for (int i = 0; i < element.length; i++) {
            if (element[i].getElement('UpLowBerth')!.text == "LB") {
              ITSSeatDetails itsSeatDetails = ITSSeatDetails(
                SeatNo: element[i].getElement('SeatNo')!.text,
                IsLadiesSeat: element[i].getElement('IsLadiesSeat')!.text,
                Available: element[i].getElement('Available')!.text,
                SeatType: element[i].getElement('SeatType')!.text,
                Row: element[i].getElement('Row')!.text,
                Column: element[i].getElement('Column')!.text,
                UpLowBerth: element[i].getElement('UpLowBerth')!.text,
                BlockType: element[i].getElement('BlockType')!.text,
                RowSpan: element[i].getElement('RowSpan')!.text,
                ColumnSpan: element[i].getElement('ColumnSpan')!.text,
                SeatCategory: element[i].getElement('SeatCategory')!.text,
                SeatRate: element[i].getElement('SeatRate')!.text,
                IsLowPrice: element[i].getElement('IsLowPrice')!.text,
                BaseFare: element[i].getElement('BaseFare')!.text,
                ServiceTax: element[i].getElement('ServiceTax')!.text,
                Surcharges: element[i].getElement('Surcharges')!.text,
                OnlineCharge: element[i].getElement('OnlineCharge')!.text,

                BaseFareServicTax: element[i].getElement('BaseFareServicTax')!.text,
                CDH_DiscountIfDoubleSeatBooked: element[i].getElement('CDH_DiscountIfDoubleSeatBooked')!.text,
                CouponCodeDetails: element[i].getElement('CouponCodeDetails')!.text,
                DiscountAmount: element[i].getElement('DiscountAmount')!.text,
                InsuranceCharges: element[i].getElement('InsuranceCharges')!.text,
                IsHomeDrop: element[i].getElement('IsHomeDrop')!.text,
                IsHomePickup: element[i].getElement('IsHomePickup')!.text,
                IsSocialDistanceBlockSeat: element[i].getElement('IsSocialDistanceBlockSeat')!.text,
                OriginalSeatRate: element[i].getElement('OriginalSeatRate')!.text,
                SocialDistancePercentage: element[i].getElement('SocialDistancePercentage')!.text,
                SocialDistanceTransactionType: element[i].getElement('SocialDistanceTransactionType')!.text
              );
              _lowerBerth.add(itsSeatDetails);
            }
            else if (element[i].getElement('UpLowBerth')!.text == "UB") {
              ITSSeatDetails itsSeatDetails = ITSSeatDetails(
                SeatNo: element[i].getElement('SeatNo')!.text,
                IsLadiesSeat: element[i].getElement('IsLadiesSeat')!.text,
                Available: element[i].getElement('Available')!.text,
                SeatType: element[i].getElement('SeatType')!.text,
                Row: element[i].getElement('Row')!.text,
                Column: element[i].getElement('Column')!.text,
                UpLowBerth: element[i].getElement('UpLowBerth')!.text,
                BlockType: element[i].getElement('BlockType')!.text,
                RowSpan: element[i].getElement('RowSpan')!.text,
                ColumnSpan: element[i].getElement('ColumnSpan')!.text,
                SeatCategory: element[i].getElement('SeatCategory')!.text,
                SeatRate: element[i].getElement('SeatRate')!.text,
                IsLowPrice: element[i].getElement('IsLowPrice')!.text,
                BaseFare: element[i].getElement('BaseFare')!.text,
                ServiceTax: element[i].getElement('ServiceTax')!.text,
                Surcharges: element[i].getElement('Surcharges')!.text,
                OnlineCharge: element[i].getElement('OnlineCharge')!.text,
                  BaseFareServicTax: element[i].getElement('BaseFareServicTax')!.text,
                  CDH_DiscountIfDoubleSeatBooked: element[i].getElement('CDH_DiscountIfDoubleSeatBooked')!.text,
                  CouponCodeDetails: element[i].getElement('CouponCodeDetails')!.text,
                  DiscountAmount: element[i].getElement('DiscountAmount')!.text,
                  InsuranceCharges: element[i].getElement('InsuranceCharges')!.text,
                  IsHomeDrop: element[i].getElement('IsHomeDrop')!.text,
                  IsHomePickup: element[i].getElement('IsHomePickup')!.text,
                  IsSocialDistanceBlockSeat: element[i].getElement('IsSocialDistanceBlockSeat')!.text,
                  OriginalSeatRate: element[i].getElement('OriginalSeatRate')!.text,
                  SocialDistancePercentage: element[i].getElement('SocialDistancePercentage')!.text,
                  SocialDistanceTransactionType: element[i].getElement('SocialDistanceTransactionType')!.text
              );
              _upperBerth.add(itsSeatDetails);
            }
          }
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
      print('  ::onError:: getSeatArrangementSTaxApiCall == >$onError');
    }).then((value) {
      if (_lowerBerth.isNotEmpty && _upperBerth.isNotEmpty) {
        _isTabbar.value = 2;
      } else {
        _isTabbar.value = 1;
      }
    });
  }

  Widget seatColorInfoWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.white30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: available_seat_color,
                  shape: BoxShape.rectangle,
                ),
              ),
              const SizedBox(width: 5),
              const Text('Available')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: booked_seat_color,
                  shape: BoxShape.rectangle,
                ),
              ),
              const SizedBox(width: 5),
              const Text('Booked'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: selected_seat_color,
                  shape: BoxShape.rectangle,
                ),
              ),
              const SizedBox(width: 5),
              const Text('Selected')
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: <Widget>[
          //     Container(
          //       height: 15,
          //       width: 15,
          //       decoration: BoxDecoration(
          //         color: ladies_seat_color,
          //         shape: BoxShape.rectangle,
          //       ),
          //     ),
          //     SizedBox(width: 5),
          //     Text('Ladies')
          //   ],
          // ),
        ],
      ),
    );
  }
}
