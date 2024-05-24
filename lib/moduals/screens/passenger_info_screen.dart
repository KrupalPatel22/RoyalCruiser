import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/model/available_route_stax_model.dart';
import 'package:royalcruiser/model/passenegr_details_model.dart';
import 'package:royalcruiser/model/seat_arrangement_stax_model.dart';
import 'package:royalcruiser/moduals/screens/payment_main_screen_v1.dart';
import 'package:royalcruiser/widgets/bus_information_widget.dart';
import 'package:royalcruiser/widgets/expandeble_card_widget.dart';
import 'package:royalcruiser/widgets/journey_details_expanded_widget.dart';
import 'package:royalcruiser/widgets/journey_details_normal_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PassengerInfoScreen extends StatefulWidget {
  static final routeName = '/passenger_info_screen';

  const PassengerInfoScreen({Key? key}) : super(key: key);

  @override
  State<PassengerInfoScreen> createState() => _PassengerInfoScreenState();
}

class _PassengerInfoScreenState extends State<PassengerInfoScreen> {
  String? userId;
  String? tripType;

  final RxBool _isLoading = false.obs;
  final _formKey = GlobalKey<FormState>();

  AllRouteBusLists? allRouteBusOnwardLists;
  final List<ITSSeatDetails> selectedOnSeatList = [];
  final List<PassangersModel> passOnListModel = [];
  List<TextEditingController> txtFieldOnNameController = [];
  List<TextEditingController> txtFieldOnSeatController = [];
  List<TextEditingController> txtFieldOnAgeController = [];
  List<int> txtFieldOnGenderController = [];

  AllRouteBusLists? allRouteBusReturnLists;
  final List<ITSSeatDetails> selectedReSeatList = [];
  final List<PassangersModel> passReListModel = [];
  List<TextEditingController> txtFieldReNameController = [];
  List<TextEditingController> txtFieldReSeatController = [];
  List<TextEditingController> txtFieldReAgeController = [];
  List<int> txtFieldReGenderController = [];

  @override
  void initState() {
    getData().then((value) {
      onwardTxtEdtController();
      returnTxtEdtController();
    }).then((value) => _isLoading.value = true);
    super.initState();
  }

  Future<void> getData() async {
    tripType = NavigatorConstants.TRIP_TYPE;
    userId = NavigatorConstants.USER_ID;
    if (tripType == "0") {
      allRouteBusOnwardLists = AllRouteBusLists.fromJson(
        json.decode(NavigatorConstants.ALL_ROUTE_LIST_ONWARD),
      );
      var jsonList1 = json.decode(NavigatorConstants.SELECTED_SEAT_LIST_ONWARD);
      for (var seatList in jsonList1) {
        selectedOnSeatList.add(
          ITSSeatDetails.fromJson(seatList),
        );
      }
    } else if (tripType == "2") {
      allRouteBusOnwardLists = AllRouteBusLists.fromJson(
        json.decode(NavigatorConstants.ALL_ROUTE_LIST_ONWARD),
      );
      allRouteBusReturnLists = AllRouteBusLists.fromJson(
        json.decode(NavigatorConstants.ALL_ROUTE_LIST_RETURN),
      );
      var jsonList1 = json.decode(NavigatorConstants.SELECTED_SEAT_LIST_ONWARD);
      for (var seatList in jsonList1) {
        selectedOnSeatList.add(
          ITSSeatDetails.fromJson(seatList),
        );
      }
      var jsonList2 = json.decode(NavigatorConstants.SELECTED_SEAT_LIST_RETURN);
      for (var seatList in jsonList2) {
        selectedReSeatList.add(
          ITSSeatDetails.fromJson(seatList),
        );
      }
    }
  }

  @override
  void dispose() {
    txtFieldOnNameController.clear();
    txtFieldOnSeatController.clear();
    txtFieldOnAgeController.clear();
    txtFieldOnGenderController.clear();
    passOnListModel.clear();
    txtFieldReNameController.clear();
    txtFieldReSeatController.clear();
    txtFieldReAgeController.clear();
    txtFieldReGenderController.clear();
    passReListModel.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passenger Info'),
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height / 14,
      ),
      body: Obx(
        () => !_isLoading.value
            ? Container()
            : SafeArea(
                bottom: true,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/bannerbg.png"),
                          opacity: 80.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height,
                      width: size.width,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              BusInformationWidget(allRouteBusLists: allRouteBusOnwardLists),
                              passReListModel.length != null && allRouteBusReturnLists != null ? BusInformationWidget(allRouteBusLists: allRouteBusReturnLists) : const SizedBox.shrink(),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                child: ExpandableCardContainerWidget(
                                  expandedwidgetWidth: size.width,
                                  normalWidgetWidth: size.width,
                                  headerWidth: size.width,
                                  isCardExpandedBool: false,
                                  normalWidgetHeight: 52,
                                  avatarRadius: 20,
                                  expandedwidgetHeight: 75,
                                  expandedwidget: JourneyDetailsExpandedWidget(allRouteBusLists: allRouteBusOnwardLists!),
                                  normalWidget: JourneyDetailsNormalWidget(
                                    seatPrice: onTotalSeatRate(),
                                    allRouteBusLists: allRouteBusOnwardLists!,
                                    seatLength: selectedOnSeatList.length,
                                    discount: selectedSeatOriginal(),
                                  ),
                                  headerText: 'Journey Details Onward',
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              passReListModel.length != null && allRouteBusReturnLists != null
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                      child: ExpandableCardContainerWidget(
                                        expandedwidgetWidth: size.width,
                                        normalWidgetWidth: size.width,
                                        headerWidth: size.width,
                                        isCardExpandedBool: false,
                                        normalWidgetHeight: 52,
                                        avatarRadius: 20,
                                        expandedwidgetHeight: 75,
                                        expandedwidget: JourneyDetailsExpandedWidget(allRouteBusLists: allRouteBusReturnLists!),
                                        normalWidget: JourneyDetailsNormalWidget(
                                          allRouteBusLists: allRouteBusReturnLists!,
                                          seatLength: selectedReSeatList.length,
                                          seatPrice: reTotalSeatRate(),
                                          discount: selectedSeatOriginalReturn(),
                                        ),
                                        headerText: 'Journey Details Return',
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(
                                height: 3,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 5,
                                ),
                                child: onwardTicketInfo(),
                              ),
                              passReListModel.length != null && allRouteBusReturnLists != null
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 5,
                                      ),
                                      child: returnTctInfo(),
                                    )
                                  : const SizedBox.shrink(),
                              continueWidget()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget onwardTicketInfo() {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: size.width,
          height: 35,
          color: CustomeColor.main_bg,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: const Text(
            'Passenger Information(Onward)',
            style: TextStyle(letterSpacing: 1.0, color: Colors.white, fontSize: 18),
          ),
        ),
        ...[for (var index = 0; index < selectedOnSeatList.length; index++) seatNameOrPassDetailsOnward(index: index)],
      ],
    );
  }

  Widget seatNameOrPassDetailsOnward({required int index}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (index != 0) ...{
              Container(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      txtFieldOnNameController[index].text = txtFieldOnNameController[index - 1].text.toString();
                      txtFieldOnAgeController[index].text = txtFieldOnAgeController[index - 1].text.toString();
                      txtFieldOnGenderController[index] = txtFieldOnGenderController[index - 1];
                    });
                  },
                  child: const Text(
                    'Copy From Above',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            },
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Passenger - ${index + 1}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            TextFormField(
              controller: txtFieldOnNameController[index],
              style: const TextStyle(fontSize: 16),
              validator: (val) => val!.length > 2 ? null : 'Name is invalid',
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter name',
                icon: Icon(Icons.person, size: 20),
                isDense: true,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Seat No',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 13),
                    Container(
                      alignment: Alignment.center,
                      child: Text(selectedOnSeatList[index].SeatNo, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
                Container(),
                Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Age',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 1),
                    SizedBox(
                      width: 80,
                      height: 50,
                      child: TextFormField(
                        controller: txtFieldOnAgeController[index],
                        keyboardType: TextInputType.number,
                        validator: (val) => val!.isNotEmpty ? null : 'Enter Age ',
                        inputFormatters: [LengthLimitingTextInputFormatter(2)],
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Age',
                          hintStyle: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 2, bottom: 2),
                      child: const Text(
                        'Gender',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              txtFieldOnGenderController[index] = 1;
                            });
                          },
                          child: Column(
                            children: [
                              Card(
                                margin: const EdgeInsets.only(top: 8),
                                elevation: txtFieldOnGenderController[index] == 1 ? 2.0 : 0.0,
                                color: txtFieldOnGenderController[index] == 1 ? CustomeColor.main_bg : Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Image(
                                    image: const AssetImage('assets/images/ic_male_white.png'),
                                    color: txtFieldOnGenderController[index] == 1 ? Colors.white : CustomeColor.sub_bg,
                                    height: 20,
                                  ),
                                ),
                              ),
                              Text(
                                'Male',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            setState(() {
                              txtFieldOnGenderController[index] = 2;
                            });
                          },
                          child: Column(
                            children: [
                              Card(
                                margin: const EdgeInsets.only(top: 8),
                                elevation: txtFieldOnGenderController[index] == 2 ? 2.0 : 0.0,
                                color: txtFieldOnGenderController[index] == 2 ? CustomeColor.main_bg : Colors.white,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Image(
                                    image: const AssetImage('assets/images/ic_female_green.png'),
                                    color: txtFieldOnGenderController[index] == 2 ? Colors.white : CustomeColor.sub_bg,
                                    height: 20,
                                  ),
                                ),
                              ),
                              Text(
                                'Female',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget returnTctInfo() {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: size.width,
          height: 35,
          color: CustomeColor.main_bg,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          child: const Text(
            'Passenger Information(Return)',
            style: TextStyle(letterSpacing: 1.0, color: Colors.white, fontSize: 18),
          ),
        ),
        ...[for (var index = 0; index < selectedReSeatList.length; index++) seatNameOrPassDetailsReturn(index: index)],
      ],
    );
  }

  Widget seatNameOrPassDetailsReturn({required int index}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (index != 0) ...{
              Container(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      txtFieldReNameController[index].text = txtFieldReNameController[index - 1].text.toString();
                      txtFieldReAgeController[index].text = txtFieldReAgeController[index - 1].text.toString();
                      txtFieldReGenderController[index] = txtFieldReGenderController[index - 1];
                    });
                  },
                  child: const Text(
                    'Copy From Above',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            },
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Passenger - ${index + 1}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            TextFormField(
              controller: txtFieldReNameController[index],
              style: const TextStyle(fontSize: 16),
              validator: (val) => val!.length > 2 ? null : 'Name is invalid',
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter name',
                icon: Icon(Icons.person, size: 20),
                isDense: true,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Seat No',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 13),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        selectedReSeatList[index].SeatNo,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Container(),
                Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Age',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 1),
                    SizedBox(
                      width: 80,
                      height: 50,
                      child: TextFormField(
                        controller: txtFieldReAgeController[index],
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(2)],
                        validator: (val) => val!.isNotEmpty ? null : 'Enter Age ',
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Age',
                          hintStyle: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(left: 2, bottom: 2),
                      child: const Text(
                        'Gender',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              txtFieldReGenderController[index] = 1;
                            });
                          },
                          child: Card(
                            margin: const EdgeInsets.only(top: 8),
                            elevation: txtFieldReGenderController[index] == 1 ? 2.0 : 0.0,
                            color: txtFieldReGenderController[index] == 1 ? CustomeColor.main_bg : Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Image(
                                image: const AssetImage('assets/images/ic_male_white.png'),
                                color: txtFieldReGenderController[index] == 1 ? Colors.white : CustomeColor.sub_bg,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            setState(() {
                              txtFieldReGenderController[index] = 2;
                            });
                          },
                          child: Card(
                            margin: const EdgeInsets.only(top: 8),
                            elevation: txtFieldReGenderController[index] == 2 ? 2.0 : 0.0,
                            color: txtFieldReGenderController[index] == 2 ? CustomeColor.main_bg : Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              child: Image(
                                image: const AssetImage('assets/images/ic_female_green.png'),
                                color: txtFieldReGenderController[index] == 2 ? Colors.white : CustomeColor.sub_bg,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double onTotalSeatRate() {
    double _seat_rate = 0;
    double seatStrikeRate = 0;
    for (int i = 0; i < selectedOnSeatList.length; i++) {
      _seat_rate += double.parse(selectedOnSeatList[i].BaseFare).toDouble();
      seatStrikeRate += double.parse(selectedOnSeatList[i].OriginalSeatRate).toDouble();
    }
    if (seatStrikeRate > 0 /*&& NavigatorConstants.USER_ID == '0'*/) {
      _seat_rate = _seat_rate;
    }
    return _seat_rate;
  }

  double selectedSeatOriginal() {
    double onwardSeatString = 0.0;
    for (int i = 0; i < selectedOnSeatList.length; i++) {
      onwardSeatString += double.parse(selectedOnSeatList[i].OriginalSeatRate);
    }
    return onwardSeatString;
  }

  double selectedSeatOriginalReturn() {
    double returnSeatString = 0.0;
    for (int i = 0; i < selectedReSeatList.length; i++) {
      returnSeatString += double.parse(selectedReSeatList[i].OriginalSeatRate);
    }
    return returnSeatString;
  }

  double reTotalSeatRate() {
    double _seat_rate = 0.0;
    double seatStrikeRate = 0;
    for (int i = 0; i < selectedReSeatList.length; i++) {
      _seat_rate += double.parse(selectedReSeatList[i].BaseFare).toDouble();
      seatStrikeRate += double.parse(selectedReSeatList[i].OriginalSeatRate).toDouble();
    }
    if (seatStrikeRate > 0 /*&& NavigatorConstants.USER_ID == '0'*/) {
      _seat_rate = _seat_rate;
    }
    return _seat_rate;
  }

  void onwardTxtEdtController() {
    for (int i = 0; i < selectedOnSeatList.length; i++) {
      txtFieldOnNameController.add(TextEditingController());
      txtFieldOnSeatController.add(TextEditingController());
      txtFieldOnAgeController.add(TextEditingController());
      txtFieldOnGenderController.add(0);
    }
  }

  void returnTxtEdtController() {
    for (int i = 0; i < selectedReSeatList.length; i++) {
      txtFieldReNameController.add(TextEditingController());
      txtFieldReSeatController.add(TextEditingController());
      txtFieldReAgeController.add(TextEditingController());
      txtFieldReGenderController.add(0);
    }
  }

  void onSave() {
    removePassengerModel();
    _hideKeyBoard();
    _valueStoreInArrayPassengerOnward();
    valueStoreInArrayPassengerReturn();
    redirectPaymentScreen();
  }

  void removePassengerModel() {
    passOnListModel.clear();
    passReListModel.clear();
  }

  void _valueStoreInArrayPassengerOnward() {
    for (int k = 0; k < selectedOnSeatList.length; k++) {
      String? gender;
      if (txtFieldOnGenderController[k] == 1) {
        gender = "M";
      } else if (txtFieldOnGenderController[k] == 2) {
        gender = "F";
      }
      PassangersModel passengersModel = PassangersModel(
        passengerName: txtFieldOnNameController[k].text.toString(),
        seatGst: double.parse(selectedOnSeatList[k].ServiceTax).toDouble(),
        seatBasefare: int.parse(selectedOnSeatList[k].BaseFare).toInt(),
        seatNo: selectedOnSeatList[k].SeatNo.toString(),
        passengerGender: gender!.toString(),
        passengerAge: txtFieldOnAgeController[k].text.toString(),
      );
      passOnListModel.add(passengersModel);
    }
  }

  void valueStoreInArrayPassengerReturn() {
    for (int k = 0; k < selectedReSeatList.length; k++) {
      String? gender;
      if (txtFieldReGenderController[k] == 1) {
        gender = "M";
      } else if (txtFieldReGenderController[k] == 2) {
        gender = "F";
      }
      PassangersModel passengersModel = PassangersModel(
        passengerName: txtFieldReNameController[k].text.toString(),
        seatGst: double.parse(selectedReSeatList[k].ServiceTax).toDouble(),
        seatBasefare: int.parse(selectedReSeatList[k].BaseFare).toInt(),
        seatNo: selectedReSeatList[k].SeatNo.toString(),
        passengerGender: gender!,
        passengerAge: txtFieldReAgeController[k].text.toString(),
      );
      passReListModel.add(passengersModel);
    }
  }

  void redirectPaymentScreen() {
    Navigator.of(context).pushNamed(PaymentMainScreenV1.routeName, arguments: {
      NavigatorConstants.PASSENGER_DETAILS_ONWARD_MODEL_LIST: passOnListModel,
      NavigatorConstants.PASSENGER_DETAILS_RETURN_MODEL_LIST: passReListModel,
    });
  }

  void _hideKeyBoard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget continueWidget() {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: CustomeColor.sub_bg,
        ),
        width: size.width,
        child: Text(
          'Continue'.toUpperCase(),
          style: const TextStyle(letterSpacing: 1.0, fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: () {
        if (_formKey.currentState!.validate() && _isValid()) {
          onSave();
        }
      },
    );
  }

  bool _isValid() {
    if (txtFieldOnGenderController.contains(0)) {
      showToastMsg('Please enter gender.');
      return false;
    } else if (passReListModel != null && txtFieldReGenderController.contains(0)) {
      showToastMsg('Please enter gender.');
      return false;
    }
    return true;
  }

  void showToastMsg(String msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: const TextStyle(fontSize: 15),
      ),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
