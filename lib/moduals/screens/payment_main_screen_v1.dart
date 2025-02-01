import 'dart:convert';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/preferences_costances.dart';
import 'package:royalcruiser/model/available_route_stax_model.dart';
import 'package:royalcruiser/model/passenegr_details_model.dart';
import 'package:royalcruiser/model/seat_arrangement_stax_model.dart';
import 'package:royalcruiser/moduals/screens/dashboard_screen.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/moduals/screens/payment_main_screen_v2.dart';
import 'package:royalcruiser/moduals/screens/terms_and_condition_screen.dart';
import 'package:royalcruiser/moduals/screens/webview_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:royalcruiser/utils/helpers/helper.dart';
import 'package:royalcruiser/widgets/expandeble_card_widget.dart';
import 'package:royalcruiser/widgets/journey_details_expanded_payment_info_widget.dart';
import 'package:royalcruiser/widgets/journey_details_normal_payment_info_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/insurance_model.dart';
import '../../utils/ui/ui_utils.dart';
import '../../widgets/app_button.dart';

class PaymentMainScreenV1 extends StatefulWidget {
  static const routeName = '/payment_main_screen_v1';

  const PaymentMainScreenV1({Key? key}) : super(key: key);

  @override
  State<PaymentMainScreenV1> createState() => _PaymentMainScreenV1State();
}

class _PaymentMainScreenV1State extends State<PaymentMainScreenV1> {
  SharedPreferences? _sharedPreferences;
  String? userId;
  String? tripType;
  String? journeyDateOnward;
  String? journeyDateReturn;
  String? IsSurCharge;

  String? BoardingPointOnwardID;
  String? BoardingPointReturnID;
  String? BoardingPointOnwardName;
  String? BoardingPointReturnName;
  String? BoardingPointOnwardTime;
  String? BoardingPointReturnTime;

  String DroppingPointOnwardID = '0';
  String DroppingPointReturnID = '0';
  String DroppingPointOnwardName = '';
  String DroppingPointReturnName = '';
  String DroppingPointOnwardTime = '';
  String DroppingPointReturnTime = '';

  final RxBool _isLoading = false.obs;
  final RxBool _termsConditionCheckBox = false.obs;
  bool _redeemYesButton = false;
  final bool _walletBool = false;
  final bool _generetOTPwalletbool = false;
  bool isLogin = false;

  AllRouteBusLists? allRouteBusOnwardLists;
  AllRouteBusLists? allRouteBusReturnLists;

  final List<ITSSeatDetails> _selected_return_seat_list = [];
  final List<ITSSeatDetails> _selected_onward_seat_list = [];

  List<PassangersModel> _passangers_Onward_ListModel = [];
  List<PassangersModel> _passangers_Return_ListModel = [];

  TextEditingController primary_name_textEditing = TextEditingController();
  TextEditingController primary_email_textEditing = TextEditingController();
  TextEditingController primary_mobile_textEditing = TextEditingController();
  TextEditingController primary_reedem_textEditing = TextEditingController();
  TextEditingController primary_wallet_textEditing = TextEditingController();
  TextEditingController primary_otp_textEditing = TextEditingController();

  double totalSeaterAmtOnward = 0.0;
  int totalSeatersOnward = 0;
  double totalSemiSleeperAmtOnward = 0.0;
  int totalSemiSleepersOnward = 0;
  double totalSleeperAmtOnward = 0.0;
  int totalSleepersOnward = 0;

  double totalSeaterAmtReturn = 0.0;
  int totalSeatersReturn = 0;
  double totalSemiSleeperAmtReturn = 0.0;
  int totalSemiSleepersReturn = 0;
  double totalSleeperAmtReturn = 0.0;
  int totalSleepersReturn = 0;

  String? onwardBaseFareList;
  String? onwardServiceTaxList;
  String? onwardRoundUpList;
  String? onwardSTaxWithOutRoundUpAmount;
  String? onwardSTaxRoundUpAmount;
  String? onwardSeatStringPara;
  double onwardPNRAmount = 0.0;
  double onwardStax = 0.0;

  String? returnBaseFareList;
  String? returnServiceTaxList;
  String? returnRoundUpList;
  String? returnSTaxWithOutRoundUpAmount;
  String? returnSTaxRoundUpAmount;
  String? returnSeatStringPara;
  double returnPNRAmount = 0.0;
  double returnStax = 0.0;

  double AllTotalpayableamount = 0.0;
  double AllTotalBaseFare = 0.0;
  double AllTotalStax = 0.0;
  double AllTotalDiscount = 0.0;

  double AllCouponRate = 0.0;
  double AllDiscPerAmount = 0.0;
  double AllDiscPerAmount_R = 0.0;

  double OrderDisount = 0.0;

  String CouponCode = "";
  String CouponID = "0";

  bool? pageArgumentForWillPopScope;
  final RxBool _isDiscountB2cApiCAll = false.obs;
  final RxBool _isDiscountSuccess = false.obs;
  final RxBool _isGstSuccess = false.obs;
  final RxBool _isBaseFareSuccess = false.obs;

  ValueNotifier isInsuranceEnable = ValueNotifier(false);

  // ValueNotifier insuranceChangeListner = ValueNotifier(0);
  String selectedinsurance = "";
  List<InsuranceModel> insuranceList = [];

  String InsuranceChargeListOnward = '';
  String InsuranceChargeList_R = '';

  String TotalInsuranceCharge = '';
  String TotalInsuranceCharge_R = '';

  String imgAssets = "assets/images/insurance/";

  @override
  void initState() {
    getData().then((value) {
      seatTypeOnward();
      getSharedData();
      if (tripType == "2") {
        seatTypeReturn();
      }
    }).then((value) {
      _isLoading.value = true;
    });

    //Future.delayed(Duration(seconds: 5)).then((value) => SaveAmountDialog());
    super.initState();
  }

  Future<void> getData() async {
    tripType = NavigatorConstants.TRIP_TYPE;
    userId = NavigatorConstants.USER_ID;
    IsSurCharge = NavigatorConstants.IS_SEARCH_CHARGE;

    if (tripType == "0") {
      DateTime onwardDate = DateTime.parse(DateFormat('dd-MM-yyyy')
          .parse(NavigatorConstants.ONWARD_DATE)
          .toString());
      journeyDateOnward = DateFormat('yyyy-MM-dd').format(onwardDate);

      allRouteBusOnwardLists = AllRouteBusLists.fromJson(
        json.decode(NavigatorConstants.ALL_ROUTE_LIST_ONWARD),
      );
      var jsonList1 = json.decode(NavigatorConstants.SELECTED_SEAT_LIST_ONWARD);
      for (var seatList in jsonList1) {
        _selected_onward_seat_list.add(
          ITSSeatDetails.fromJson(seatList),
        );
      }

      BoardingPointOnwardID = NavigatorConstants.SelectedBoardingPointOnwordID;
      DroppingPointOnwardID = NavigatorConstants.SelectedDroppingPointOnwordID;
      BoardingPointOnwardName =
          NavigatorConstants.SelectedBoardingPointOnwordName;
      DroppingPointOnwardName =
          NavigatorConstants.SelectedDroppingPointOnwordName;
      BoardingPointOnwardTime =
          NavigatorConstants.SelectedBoardingPointOnwordTime;
      DroppingPointOnwardTime =
          NavigatorConstants.SelectedDroppingPointOnwordTime;
    } else if (tripType == "2") {
      DateTime onwardDate = DateTime.parse(DateFormat('dd-MM-yyyy')
          .parse(NavigatorConstants.ONWARD_DATE)
          .toString());
      journeyDateOnward = DateFormat('yyyy-MM-dd').format(onwardDate);

      DateTime returnDate = DateTime.parse(DateFormat('dd-MM-yyyy')
          .parse(NavigatorConstants.RETURN_DATE)
          .toString());
      journeyDateReturn = DateFormat('yyyy-MM-dd').format(returnDate);

      allRouteBusOnwardLists = AllRouteBusLists.fromJson(
        json.decode(NavigatorConstants.ALL_ROUTE_LIST_ONWARD),
      );
      allRouteBusReturnLists = AllRouteBusLists.fromJson(
        json.decode(NavigatorConstants.ALL_ROUTE_LIST_RETURN),
      );
      var jsonList1 = json.decode(NavigatorConstants.SELECTED_SEAT_LIST_ONWARD);
      for (var seatList in jsonList1) {
        _selected_onward_seat_list.add(
          ITSSeatDetails.fromJson(seatList),
        );
      }

      var jsonList2 = json.decode(NavigatorConstants.SELECTED_SEAT_LIST_RETURN);
      for (var seatList in jsonList2) {
        _selected_return_seat_list.add(
          ITSSeatDetails.fromJson(seatList),
        );
      }

      BoardingPointOnwardID = NavigatorConstants.SelectedBoardingPointOnwordID;
      BoardingPointReturnID = NavigatorConstants.SelectedBoardingPointReturnID;
      DroppingPointOnwardID = NavigatorConstants.SelectedDroppingPointOnwordID;
      DroppingPointReturnID = NavigatorConstants.SelectedDroppingPointReturnID;
      BoardingPointOnwardName =
          NavigatorConstants.SelectedBoardingPointOnwordName;
      BoardingPointReturnName =
          NavigatorConstants.SelectedBoardingPointReturnName;
      DroppingPointOnwardName =
          NavigatorConstants.SelectedDroppingPointOnwordName;
      DroppingPointReturnName =
          NavigatorConstants.SelectedDroppingPointReturnName;
      BoardingPointOnwardTime =
          NavigatorConstants.SelectedBoardingPointOnwordTime;
      DroppingPointOnwardTime =
          NavigatorConstants.SelectedDroppingPointOnwordTime;
      BoardingPointReturnTime =
          NavigatorConstants.SelectedBoardingPointReturnTime;
      DroppingPointReturnTime =
          NavigatorConstants.SelectedDroppingPointReturnTime;
    }
    AllTotalpayableamount = Totalpayableamount();
    onwardSeatDetailsString();
    returnSeatDetailsString();
  }

  Future<void> getSharedData() async {
    if (userId != "0") {
      isLogin = true;
      primary_name_textEditing.text = NavigatorConstants.USER_NAME;
      primary_email_textEditing.text = NavigatorConstants.USER_EMAIL;
      primary_mobile_textEditing.text = NavigatorConstants.USER_PHONE;
      defaultDiscountCouponCodeApiCall(
        EmailID: primary_email_textEditing.text.trim().toString(),
        Name: primary_name_textEditing.text.trim().toString(),
        MobileNo: primary_mobile_textEditing.text.trim().toString(),
      );
    }
  }

  double Totalpayableamount() {
    double totalpayableamount = 0.0;
    totalpayableamount = onwardTotalAmount() + returnTotalAmount();
    return totalpayableamount;
  }

  @override
  void didChangeDependencies() {
    Map<String, Object> rcvData =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    _passangers_Onward_ListModel =
        rcvData[NavigatorConstants.PASSENGER_DETAILS_ONWARD_MODEL_LIST]
            as List<PassangersModel>;
    _passangers_Return_ListModel =
        rcvData[NavigatorConstants.PASSENGER_DETAILS_RETURN_MODEL_LIST]
            as List<PassangersModel>;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment Screen',
        ),
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height / 14,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Obx(
          () => !_isLoading.value
              ? Container()
              : Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/bannerbg.png"),
                          opacity: 80.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: size.height,
                      width: size.width,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 5,
                                // horizontal: 5,
                              ),
                              child: ExpandableCardContainerWidget(
                                expandedwidgetWidth: size.width,
                                normalWidgetWidth: size.width,
                                headerWidth: size.width,
                                isCardExpandedBool: false,
                                normalWidgetHeight: 85,
                                avatarRadius: 20,
                                expandedwidgetHeight: 215.0 +
                                    (70) * _selected_onward_seat_list.length,
                                expandedwidget:
                                    JourneyDetailsExpandedPaymentWidget(
                                  DroppingPointName: DroppingPointOnwardName,
                                  allRouteBusLists: allRouteBusOnwardLists!,
                                  BoardingPointName: BoardingPointOnwardName!,
                                  passangers_ListModel:
                                      _passangers_Onward_ListModel,
                                ),
                                normalWidget: JourneyDetailsNormalPaymentWidget(
                                  allRouteBusLists: allRouteBusOnwardLists!,
                                ),
                                headerText: 'Bus Details Onward',
                              ),
                            ),
                            tripType!.compareTo("2") == 0
                                ? Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      // horizontal: 5,
                                    ),
                                    child: ExpandableCardContainerWidget(
                                      expandedwidgetWidth: size.width,
                                      normalWidgetWidth: size.width,
                                      headerWidth: size.width,
                                      isCardExpandedBool: false,
                                      normalWidgetHeight: 85,
                                      avatarRadius: 20,
                                      expandedwidgetHeight: 215.0 +
                                          (70) *
                                              _selected_return_seat_list.length,
                                      expandedwidget:
                                          JourneyDetailsExpandedPaymentWidget(
                                        DroppingPointName:
                                            DroppingPointReturnName,
                                        allRouteBusLists:
                                            allRouteBusReturnLists!,
                                        BoardingPointName:
                                            BoardingPointReturnName!,
                                        passangers_ListModel:
                                            _passangers_Return_ListModel,
                                      ),
                                      normalWidget:
                                          JourneyDetailsNormalPaymentWidget(
                                              allRouteBusLists:
                                                  allRouteBusReturnLists!),
                                      headerText: 'Bus Details Return',
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(height: 5),
                            PassengerDetails_Widget(),
                            const SizedBox(height: 5),
                            //Redeem_Coupon_Code_widget(),
                            Redeem_Coupon_Code_widget(context),
                            const SizedBox(height: 10),

                            Helper.InsuranceDeatils.isNotEmpty
                                ? getCheckBoxList(context)
                                : SizedBox.shrink(),
                            const SizedBox(height: 10),
                            // TotalPayableAmount_Widget(),
                            Rs_Expanded_info_Widget(),
                            const SizedBox(height: 2),
                            CheckTermsAndConditionWidget(),
                            const SizedBox(height: 2),
                            buttonWidget(),
                            const SizedBox(height: 2),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget PassengerDetails_Widget() {
    return Card(
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 35,
            color: CustomeColor.main_bg,
            child: const Text(
              'Ticket Information',
              style: TextStyle(
                  letterSpacing: 1.0, color: Colors.white, fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: primary_name_textEditing,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                      fontSize: 15,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                  ),
                ),
                TextFormField(
                  controller: primary_email_textEditing,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                      fontSize: 15,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                  ),
                ),
                TextFormField(
                  controller: primary_mobile_textEditing,
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Mobile No.',
                    labelStyle: TextStyle(
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                      fontSize: 15,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                  ),
                  onChanged: (value) {
                    if (primary_name_textEditing.text.isEmpty) {
                      ToastMsg(message: 'Enter UserName');
                      primary_mobile_textEditing.clear();
                    } else if (primary_email_textEditing.text.isEmpty) {
                      ToastMsg(message: 'Enter Email');
                      primary_mobile_textEditing.clear();
                    } else if ((!RegExp(
                            "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(primary_email_textEditing.text))) {
                      ToastMsg(message: 'Please enter valid email');
                    } else {
                      value = primary_mobile_textEditing.text.toString();
                      if (value.length == 10) {
                        _hideKeyBoard();
                        defaultDiscountCouponCodeApiCall(
                          EmailID:
                              primary_email_textEditing.text.trim().toString(),
                          Name: primary_name_textEditing.text.trim().toString(),
                          MobileNo:
                              primary_mobile_textEditing.text.trim().toString(),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Redeem_Coupon_Code_widget(BuildContext ctx) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Card(
        elevation: 1.0,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                color: CustomeColor.main_bg,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Do You Have Coupon ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          letterSpacing: 1.0,
                          color: Colors.white,
                          fontFamily:
                              CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          fontSize: 16),
                    ),
                    Icon(
                      _redeemYesButton ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              if (_redeemYesButton)
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Card(
                          elevation: 5,
                          shadowColor: CustomeColor.sub_bg,
                          child: TextFormField(
                            controller: primary_reedem_textEditing,
                            decoration: const InputDecoration(
                              hintText: 'Enter Coupon',
                              prefixIcon: Icon(Icons.discount_outlined),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomeColor.sub_bg,
                            ),
                            width: size.width,
                            child: Text(
                              'Redeem'.toUpperCase(),
                              style: const TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            if (primary_reedem_textEditing.text.isNotEmpty) {
                              ApplyDiscountCouponApiCall(ctx);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
      onTap: () {
        setState(() {
          _redeemYesButton = !_redeemYesButton;
        });
      },
    );
  }

  Widget CheckTermsAndConditionWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: _termsConditionCheckBox.value,
            onChanged: (onChanged) {
              _termsConditionCheckBox.value = onChanged!;
            },
          ),
          const Text(
            'I agree to ',
            style: TextStyle(
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(TermsAndConditionScreen.routeName);
            },
            child: const Text(
              'Terms And Condition',
              style: TextStyle(
                fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                decoration: TextDecoration.underline,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                cancelTransactionDialog();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(
                  color: Colors.black,
                  width: 0.6,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
              child: const Text('Cancel'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // insertOrderApiCall();
                if (_isValid()) {
                  /*if(!isLogin){
                    chkRegApiCall();
                  }*/
                  blockTypeV2ApiCall(
                    Type: tripType == "0" ? "1" : "2",
                    ReferenceNumber:
                        allRouteBusOnwardLists!.ReferenceNumber.toString(),
                    PassengerName:
                        primary_name_textEditing.text.trim().toString(),
                    SeatNames: onwardSeatNameString().toString(),
                    Email: primary_email_textEditing.text.trim().toString(),
                    Phone: primary_mobile_textEditing.text.trim().toString(),
                    PickupID: BoardingPointOnwardID.toString(),
                    PayableAmount: AllTotalpayableamount.toString(),
                    TotalPassengers:
                        _selected_onward_seat_list.length.toString(),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
              child: const Text('Confirm'),
            ),
          ),
        ],
      ),
    );
  }

  Future cancelTransactionDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(15),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Are you sure want to cancel this transaction?',
                style: TextStyle(
                  fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                  fontSize: 14,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(
                          color: Colors.black,
                          width: 0.6,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      child: const Text('No'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed(DashboardAppScreen.routeName);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                      ),
                      child: const Text('Yes'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isValid() {
    if (primary_name_textEditing.text.isEmpty) {
      ToastMsg(message: 'Enter username');
      return false;
    } else if (primary_email_textEditing.text.isEmpty) {
      ToastMsg(message: 'Enter email');
      return false;
    } else if ((!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(primary_email_textEditing.text))) {
      ToastMsg(message: 'Please enter valid email');
      return false;
    } else if (primary_mobile_textEditing.text.isEmpty) {
      ToastMsg(message: 'Enter mobile no.');
      return false;
    } else if (primary_mobile_textEditing.text.length != 10) {
      ToastMsg(message: 'Please enter valid mobile no.');
      return false;
    } else if (_termsConditionCheckBox.value != true) {
      ToastMsg(message: 'Please agree to terms and condition');
      return false;
    }
    return true;
  }

  Widget Rs_Expanded_info_Widget() {
    return Card(
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 35,
            color: CustomeColor.sub_bg,
            child: const Text(
              'Ticket Information',
              style: TextStyle(
                  letterSpacing: 1.0, color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 5),

          /*New Code*/
          Obx(
            () => Visibility(
              visible: _isBaseFareSuccess.value,
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Text(
                  'Base Fare : ' "₹" ' ${TotalBaseFare()}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isBaseFareSuccess.value &&
                    (TotaliscountAmount() >
                        0) /* && NavigatorConstants.USER_ID != '0' */
                ? true
                : false,
            child: Container(
              margin: const EdgeInsets.all(5),
              child: Text(
                'Save Fare (-) : ' "₹" ' ${TotaliscountAmount()}',
                style: const TextStyle(
                    color: CustomeColor.main_bg,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0),
              ),
            ),
          ),

          //Discount price
          /*TotalDiscountBaseFare() > 0 && NavigatorConstants.USER_ID != '0' ? */
          Obx(
            () => Visibility(
              visible: _isBaseFareSuccess.value,
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Text(
                  'Discounted Fare : ' "₹" ' ${TotalDiscountBaseFare()}',
                  style: const TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0),
                ),
              ),
            ),
          ) /* : const SizedBox.shrink()*/,
          Obx(
            () => Visibility(
              visible: _isDiscountB2cApiCAll.value && _isGstSuccess.value,
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Text(
                  'Gst (+) : ' "₹" ' $AllTotalStax',
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0),
                ),
              ),
            ),
          ),

          /*New Code*/
          // Obx(
          //       () => Visibility(
          //     visible: _isBaseFareSuccess.value,
          //     child: Container(
          //       margin: const EdgeInsets.all(5),
          //       child: Text(
          //         'Base Fare : ' "₹" ' ${TotalDiscountBaseFare()}',
          //         style: const TextStyle(
          //             color: Colors.black,
          //             fontSize: 16,
          //             fontWeight: FontWeight.w600,
          //             letterSpacing: 1.0),
          //       ),
          //     ),
          //   ),
          // ),
          // Obx(
          //       () => Visibility(
          //     visible: _isDiscountB2cApiCAll.value && _isGstSuccess.value,
          //     child: Container(
          //       margin: const EdgeInsets.all(5),
          //       child: Text(
          //         'Gst (+) : ' "₹" ' $AllTotalStax',
          //         style: const TextStyle(
          //             color: Colors.red,
          //             fontSize: 16,
          //             fontWeight: FontWeight.w600,
          //             letterSpacing: 1.0),
          //       ),
          //     ),
          //   ),
          // ),

          Obx(
            () => Visibility(
              visible: _isDiscountB2cApiCAll.value && _isDiscountSuccess.value,
              child: Container(
                margin: const EdgeInsets.all(5),
                child: Text(
                  'Discount (-) : ' "₹" ' $AllTotalDiscount',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0),
                ),
              ),
            ),
          ),

          if (IsSurCharge!.compareTo("1") == 0 && totalIsSurCharge() != 0) ...{
            Container(
              margin: const EdgeInsets.all(5),
              child: Text(
                'Total Surcharge Amount : ' "₹" ' ${totalIsSurCharge()}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0),
              ),
            ),
          },

          if (selectedinsurance.isNotEmpty && getInsurance() > 0)
            Container(
              margin: const EdgeInsets.all(5),
              child: Text(
                'Insurance Charge : ' "₹" ' ${getInsurance()}',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                    letterSpacing: 0.5),
              ),
            ),

          Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              'Total Payable Amount : '
              "₹"
              ' ${AllTotalpayableamount + getInsurance()}',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                  letterSpacing: 0.5),
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  double totalIsSurCharge() {
    double abc = 0.0;

    if (tripType == "0") {
      abc = onwardSurcharges();
    } else if (tripType == "2") {
      abc = onwardSurcharges() + returnSurcharges();
    }
    return abc;
  }

  void ToastMsg({required String message}) {
    SnackBar snackBar = SnackBar(
      content: Text(
        '$message',
        style: const TextStyle(
          fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
          fontSize: 14,
        ),
      ),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void defaultDiscountCouponCodeApiCall({
    required String EmailID,
    required String MobileNo,
    required String Name,
  }) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.getFetchDefaultDiscountCouponApiImplementer(
      TripType: tripType!.compareTo("0") == 0 ? "1" : "2",
      EmailID: EmailID,
      JourneyDate: journeyDateOnward!,
      MobileNo: MobileNo,
      Name: Name,
      ReferenceNumber: allRouteBusOnwardLists!.ReferenceNumber.toString(),
      Return_JourneyDate:
          tripType!.compareTo("2") == 0 ? journeyDateReturn : "",
      Return_ReferenceNumber: tripType!.compareTo("2") == 0
          ? allRouteBusReturnLists!.ReferenceNumber
          : "",
    ).then((XmlDocument document) {
      Navigator.of(context).pop();
      bool xmlElement = document.findAllElements('NewDataSet').isNotEmpty;
      if (xmlElement) {
        XmlElement xmlElement = document.findAllElements('StatusMessage').first;
        if (xmlElement.getElement('Status')!.text == "1") {
          List<XmlElement> xmlElement1 =
              document.findAllElements('GetDiscountCoupons').toList();
          if (xmlElement1 != null)
            CouponCode = xmlElement1[0].getElement('couponcode')!.text;
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    }).then((value) {
      ApplyDiscountCouponApiCall(context);
    });
  }

  void ApplyDiscountCouponApiCall(BuildContext ctx,{bool showDialog = true}) {
    AppDialogs.showProgressDialog(context: ctx);
    print(
        "My coupon test :- ${primary_reedem_textEditing.text.isNotEmpty} && ${_redeemYesButton}");
    ApiImplementer.getApplyDiscountCouponApiImplementer(
      isInsurance: selectedinsurance.isEmpty ? "0" : selectedinsurance,
      TripType: tripType!.compareTo("0") == 0 ? "1" : "2",
      CouponCode:
          primary_reedem_textEditing.text.isNotEmpty && _redeemYesButton == true
              ? primary_reedem_textEditing.text.trim().toString()
              : CouponCode.toString(),
      EmailID: primary_email_textEditing.text.trim().toString(),
      MobileNo: primary_mobile_textEditing.text.trim().toString(),
      ReferenceNumber: allRouteBusOnwardLists!.ReferenceNumber.toString(),
      IsIncludeTax: allRouteBusOnwardLists!.IsIncludeTax.toString(),
      OnwardSeatTotal: _selected_onward_seat_list.length.toString(),
      OnwardTotalAmount: onwardTotalAmount().toString(),
      SeatDetails: onwardSeatDetailsString(),
      ServiceTaxPer: allRouteBusOnwardLists!.ServiceTax.toString(),
      ServiceTaxRoundUP: allRouteBusOnwardLists!.ServiceTaxRoundUp.toString(),
      RReferenceNumber: tripType!.compareTo("2") == 0
          ? allRouteBusReturnLists!.ReferenceNumber.toString()
          : "",
      ReturnSeatTotal: tripType!.compareTo("2") == 0
          ? _selected_onward_seat_list.length.toString()
          : "",
      ReturnTotalAmount:
          tripType!.compareTo("2") == 0 ? returnTotalAmount().toString() : "",
      RIsIncludeTax: tripType!.compareTo("2") == 0
          ? allRouteBusReturnLists!.IsIncludeTax.toString()
          : "",
      RSeatDetails:
          tripType!.compareTo("2") == 0 ? returnSeatDetailsString() : "",
      RServiceTaxPer: tripType!.compareTo("2") == 0
          ? allRouteBusReturnLists!.ServiceTax.toString()
          : "",
      RServiceTaxRoundUP: tripType!.compareTo("2") == 0
          ? allRouteBusReturnLists!.ServiceTaxRoundUp.toString()
          : "",
    ).then((XmlDocument document) {
      Navigator.of(ctx).pop();
      bool xmlElement = document.findAllElements('NewDataSet').isNotEmpty;
      if (xmlElement) {
        XmlElement statusMsg = document.findAllElements('StatusMessage').first;
        if (statusMsg.getElement('Status')!.text.compareTo("1") == 0) {
          List<XmlElement> xmlElement =
              document.findAllElements('DefaultDiscountCoupon').toList();

          if (!xmlElement.isNullOrBlank!) {
            if (primary_reedem_textEditing.text.isNotEmpty &&
                _redeemYesButton == true) {
              AppDialogs.showErrorDialog(
                  title: '',
                  context: ctx,
                  errorMsg:
                      xmlElement[0].getElement('CouponMsg')!.text.toString(),
                  onOkBtnClickListener: () {
                    Navigator.of(ctx).pop();
                  });
            }
            setState(() {
              AllTotalpayableamount = 0.0;
              AllTotalStax = 0.0;
              AllTotalBaseFare = 0.0;
              AllTotalDiscount = 0.0;

              for (int i = 0; i < xmlElement.length; i++) {
                // CouponID = xmlElement[0].getElement('CouponId')!.text;
                CouponCode = xmlElement[0].getElement('CouponCode')!.text;
                OrderDisount += double.parse(
                        xmlElement[i].getElement('TotalDiscount')!.text)
                    .toDouble();

                InsuranceChargeListOnward =
                    xmlElement[i].getElement('InsuranceChargeList')!.text;
                TotalInsuranceCharge =
                    xmlElement[i].getElement('TotalInsuranceCharge')!.text;

                AllTotalpayableamount += double.parse(
                        xmlElement[i].getElement('Totalpayableamount')!.text)
                    .toDouble();
                AllTotalStax +=
                    double.parse(xmlElement[i].getElement('TotalStax')!.text)
                        .toDouble();

                AllTotalDiscount += double.parse(
                        xmlElement[i].getElement('TotalDiscount')!.text)
                    .toDouble();

                AllTotalBaseFare += double.parse(xmlElement[i]
                            .getElement('TotalBaseFare')!
                            .text
                            .toString())
                        .toDouble()
                    // +
                    // double.parse(
                    //     xmlElement[i].getElement('TotalStax')!.text.toString()).toDouble()
                    ;
                AllCouponRate += double.parse(
                    xmlElement[i].getElement('TotalDiscount')!.text.toString());
                AllDiscPerAmount = double.parse(
                    xmlElement[i].getElement('TotalDiscount')!.text.toString());
                if (xmlElement[i]
                        .getElement('DiscountStatus')!
                        .text
                        .toString() ==
                    "1") {
                  _isDiscountSuccess.value = true;
                }
                if (AllTotalStax.compareTo(0.0) != 0) {
                  _isGstSuccess.value = true;
                }
                if (AllTotalBaseFare.compareTo(0.0) != 0) {
                  _isBaseFareSuccess.value = true;
                }

                onwardPNRAmount = double.parse(xmlElement[0]
                    .getElement('Totalpayableamount')!
                    .text
                    .toString());
                onwardBaseFareList =
                    xmlElement[0].getElement('BaseFareList')!.text.toString();
                onwardServiceTaxList =
                    xmlElement[0].getElement('ServiceTaxList')!.text.toString();
                onwardRoundUpList =
                    xmlElement[0].getElement('RoundUpList')!.text.toString();
                onwardSTaxWithOutRoundUpAmount = xmlElement[0]
                    .getElement('TotalStaxWithOutRoundUp')!
                    .text
                    .toString();
                onwardSTaxRoundUpAmount = xmlElement[0]
                    .getElement('STaxRoundUpAmount')!
                    .text
                    .toString();
                onwardSeatStringPara =
                    xmlElement[0].getElement('SeatStringPara')!.text.toString();

                onwardStax =
                    double.parse(xmlElement[0].getElement('TotalStax')!.text)
                        .toDouble();

                if (i == 1) {
                  InsuranceChargeList_R =
                      xmlElement[1].getElement('InsuranceChargeList')!.text;
                  TotalInsuranceCharge_R =
                      xmlElement[1].getElement('TotalInsuranceCharge')!.text;

                  returnPNRAmount = double.parse(xmlElement[1]
                      .getElement('Totalpayableamount')!
                      .text
                      .toString());
                  returnBaseFareList =
                      xmlElement[1].getElement('BaseFareList')!.text.toString();
                  returnServiceTaxList = xmlElement[1]
                      .getElement('ServiceTaxList')!
                      .text
                      .toString();
                  returnRoundUpList =
                      xmlElement[1].getElement('RoundUpList')!.text.toString();
                  returnSTaxWithOutRoundUpAmount = xmlElement[1]
                      .getElement('TotalStaxWithOutRoundUp')!
                      .text
                      .toString();
                  returnSTaxRoundUpAmount = xmlElement[1]
                      .getElement('STaxRoundUpAmount')!
                      .text
                      .toString();
                  returnSeatStringPara = xmlElement[1]
                      .getElement('SeatStringPara')!
                      .text
                      .toString();

                  returnStax =
                      double.parse(xmlElement[1].getElement('TotalStax')!.text)
                          .toDouble();
                }
              }
              _isDiscountB2cApiCAll.value = true;
            });

            /*display discount popup
            Need to code when discount come display that popup
            current code is display discount if strikeout dis is comming
            new code needed for any other discount
            website and other common app dont display strikeout discount as discount in Payment screen so we temp hide this popup */

            if (TotaliscountAmount() > 0 &&
                statusMsg.getElement('Status')!.text.compareTo("1") ==
                    0 /* && NavigatorConstants.USER_ID != '0'*/) {

              if(showDialog){
              saveAmountDialog();
              }
            }
          }
        }
      }
    }).catchError((onError) {
      Get.back();
      print("onError => ${onError}");
      AppDialogs.showErrorDialog(
          context: ctx,
          errorMsg: onError.toString(),
          title: "Error",
          onOkBtnClickListener: () {
            Get.back();
          });
      // Navigator.of(context)
      //     .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }

  void chkRegApiCall() {
    ApiImplementer.chkRegCust(
            mailId: primary_email_textEditing.text.toString(),
            phnNo: primary_mobile_textEditing.text.toString())
        .then((XmlDocument document) {
      bool xmlElement = document.findAllElements('Info').isNotEmpty;
      if (xmlElement) {
        if (document.findAllElements('Info').isNotEmpty) {
          if (document
                  .findAllElements('Info')
                  .first
                  .getElement('Status')!
                  .text
                  .toString() ==
              '1') {
            //user already registered in this case
            // XmlElement responseList = document.findAllElements('Info').toList().first;
            getLoginApiCall();
          } else if (document
                  .findAllElements('Info')
                  .first
                  .getElement('Status')!
                  .text
                  .toString() ==
              '0') {
            //user not registered in this case
            registrationApiCall();
          }
        }
      }
    }).catchError((onError) {
      UiUtils.errorSnackBar(message: 'Something went wrong.').show();
    });
  }

  void getLoginApiCall() {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.getOTPLoginApiImplementer(
      CustMobile: primary_mobile_textEditing.text.toString(),
    ).then((XmlDocument xmlDocument) {
      Navigator.of(context).pop();
      if (!xmlDocument.isNull) {
        bool xmlElement = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
        if (xmlElement) {
          if (xmlDocument
                  .findAllElements('Status')
                  .first
                  .getElement('Status')!
                  .text
                  .compareTo("1") ==
              0) {
            // UiUtils.successSnackBar(message: 'OTP Sent Successfully.').show();
            setState(() {
              var otpText = xmlDocument
                  .findAllElements('GetDetails')
                  .first
                  .getElement('VerificationCode1')!
                  .text;
              XmlElement loginDataElement =
                  xmlDocument.findAllElements('GetDetails').first;
              setLoginData(xmlElement: loginDataElement);
              // print('otpText: ${otpText}');
            });
          } else {
            UiUtils.errorSnackBar(
                    message:
                        'Invalid Mobile Number. ${xmlDocument.findAllElements('Status').first.getElement('StatusMessage')!.text}')
                .show();
          }
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
    });
  }

  Future<void> setLoginData({required XmlElement xmlElement}) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    NavigatorConstants.USER_ID =
        xmlElement.getElement('CustID')!.text.toString();
    NavigatorConstants.USER_NAME =
        xmlElement.getElement('CustName')!.text.toString();
    NavigatorConstants.USER_EMAIL =
        xmlElement.getElement('CustEmail')!.text.toString();
    NavigatorConstants.USER_PHONE =
        xmlElement.getElement('CustMobile')!.text.toString();
    NavigatorConstants.USER_PASSWORD =
        xmlElement.getElement('CustPassword')!.text.toString() != ''
            ? '123456'
            : xmlElement.getElement('CustPassword')!.text.toString();

    setState(() {
      _sharedPreferences!.setString(Preferences.CUST_ID,
          xmlElement.getElement('CustID')!.text.toString());
      _sharedPreferences!.setString(Preferences.CUST_NAME,
          xmlElement.getElement('CustName')!.text.toString());
      _sharedPreferences!.setString(Preferences.CUST_EMAIL,
          xmlElement.getElement('CustEmail')!.text.toString());
      _sharedPreferences!.setString(Preferences.CUST_PHONE,
          xmlElement.getElement('CustMobile')!.text.toString());
      _sharedPreferences!.setString(
          Preferences.CUST_PASSWORD,
          xmlElement.getElement('CustPassword')!.text.toString() != ''
              ? '123456'
              : xmlElement.getElement('CustPassword')!.text.toString());
    });
  }

  void registrationApiCall() {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.geAppRegApiImplementer(
            EmailID: primary_email_textEditing.text.toString(),
            Gender: _passangers_Onward_ListModel[0].passengerGender,
            MobileNo: primary_mobile_textEditing.text.toString(),
            Name: _passangers_Onward_ListModel[0].passengerName,
            Password:
                '123456' /*, DOB: '', Age: _passangers_Onward_ListModel[0].passengerAge.toString()*/)
        .then((XmlDocument xmlDocument) {
      Navigator.of(context).pop();
      if (!xmlDocument.isNull) {
        bool element = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
        if (element) {
          if (xmlDocument
                  .findAllElements('ApplicationRegistration')
                  .first
                  .getElement('Status')!
                  .text
                  .compareTo("1") ==
              0) {
            getLoginApiCall();
            // print('getLoginApiCall0');
          } else {
            // registration failed
            // print('registration failed');
          }
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      // Navigator.of(context).pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }

  void blockTypeV2ApiCall({
    required String Type,
    required String ReferenceNumber,
    required String PassengerName,
    required String SeatNames,
    required String Email,
    required String Phone,
    required String PickupID,
    required String PayableAmount,
    required String TotalPassengers,
  }) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.blockTypeV2ApiImplementer(
      ReferenceNumber: ReferenceNumber,
      PassengerName: PassengerName,
      SeatNames: SeatNames,
      Email: Email,
      Phone: Phone,
      PickupID: PickupID,
      PayableAmount: PayableAmount,
      TotalPassengers: TotalPassengers,
    ).then((XmlDocument document) {
      if (!document.isNull) {
        Navigator.of(context).pop();
        bool xmlElement = document.findAllElements('NewDataSet').isNotEmpty;
        if (xmlElement) {
          XmlElement xmlElement1 =
              document.findAllElements('ITSBlockSeatV2').first;
          if (xmlElement1 != null) {
            if (xmlElement1.getElement('Status')!.text.compareTo("1") == 0) {
              if (Type == "2") {
                blockTypeV2ApiCall(
                  Type: "3",
                  ReferenceNumber:
                      allRouteBusReturnLists!.ReferenceNumber.toString(),
                  PassengerName:
                      primary_name_textEditing.text.trim().toString(),
                  SeatNames: returnSeatNameString().toString(),
                  Email: primary_email_textEditing.text.trim().toString(),
                  Phone: primary_mobile_textEditing.text.trim().toString(),
                  PickupID: BoardingPointReturnID.toString(),
                  PayableAmount: AllTotalpayableamount.toString(),
                  TotalPassengers: _selected_return_seat_list.length.toString(),
                );
              } else {
                insertOrderApiCall();
              }
            } else {
              AppDialogs.showErrorDialog(
                  title: '',
                  context: context,
                  errorMsg: xmlElement1.getElement('Message')!.text.toString(),
                  onOkBtnClickListener: () {
                    Get.close(4);
                  });
            }
          }
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }

  void insertOrderApiCall() {
    if (AllDiscPerAmount <= 0) {
      DiscountPerAmountonW();
    }
    if (AllDiscPerAmount_R <= 0) {
      DiscountPerAmountRet();
    }

    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.insertOrderApiImplementer(
      TotalInsuranceChargeOnword: getInsurance().toString(),
      TotalInsuranceCharge_R: getInsurance().toString(),
      InsuranceChargeOnward: TotalInsuranceCharge,
      InsuranceCharge_R: TotalInsuranceCharge_R,
      InsuranceListOnward: InsuranceChargeListOnward,
      InsuranceList_R: InsuranceChargeList_R,
      TripType: tripType!.compareTo("0") == 0 ? "0" : "1",
      CouponCode: CouponCode,
      CouponID: CouponID,
      EmailID: primary_email_textEditing.text.trim().toString(),
      MobileNo: primary_mobile_textEditing.text.trim().toString(),
      Name: primary_name_textEditing.text.trim().toString(),
      OrderAmount: AllTotalpayableamount.toString(),
      OrderDiscount: OrderDisount.toString(),
      Surcharges_total: IsSurCharge!.compareTo("1") == 0
          ? onwardSurcharges().toString()
          : "0.0",
      //Todo onward
      Surcharges: IsSurCharge!.compareTo("1") == 0
          ? onwardSurcharges().toString()
          : "0.0",
      AgeList: onwardAgeListString().toString(),
      ArrangementID: allRouteBusOnwardLists!.ArrangementID.toString(),
      ArrangementName: allRouteBusOnwardLists!.ArrangementName
          .replaceAll("&", "&amp;")
          .toString(),
      BaseFare: onwardTotalBaseFare().toString(),
      BaseFareList: onwardBaseFareList!.toString(),
      BusType: allRouteBusOnwardLists!.BusType.toString(),
      BusTypeName: allRouteBusOnwardLists!.BusTypeName
          .replaceAll("&", "&amp;")
          .toString(),
      CityTime: allRouteBusOnwardLists!.CityTime.toString(),
      DiscPerAmount: AllDiscPerAmount.toString(),
      DiscountSeatDetails: onwardSeatDetailsString().toString(),
      DropID: DroppingPointOnwardID.toString(),
      DropName: DroppingPointOnwardName.toString(),
      DropTime: DroppingPointOnwardTime.toString(),
      FromCityId: allRouteBusOnwardLists!.FromCityId.toString(),
      FromCityName: allRouteBusOnwardLists!.FromCityName.toString(),
      ITS_SeatString: onwardSeatStringPara!.toString(),
      IsIncludeTax: allRouteBusOnwardLists!.IsIncludeTax.toString(),
      JourneyDate: journeyDateOnward!.toString(),
      MainRouteName:
          allRouteBusOnwardLists!.RouteName.replaceAll("&", "&amp;").toString(),
      OriginalAmount: onwardTotalAmount().toString(),
      PNRAmount: onwardPNRAmount.toString(),
      Passengerlist: onwardPassengerList().toString(),
      PickUpID: BoardingPointOnwardID!.toString(),
      PickupName: BoardingPointOnwardName!.toString(),
      PickupTime: BoardingPointOnwardTime!.toString(),
      ReferenceNumber: allRouteBusOnwardLists!.ReferenceNumber.toString(),
      RoundUpList: onwardRoundUpList!.toString(),
      RouteId: allRouteBusOnwardLists!.RouteID.toString(),
      RouteTime: allRouteBusOnwardLists!.RouteTime.toString(),
      RouteTimeId: allRouteBusOnwardLists!.RouteTimeID.toString(),
      STax: double.parse(onwardSTaxWithOutRoundUpAmount!.toString()).toString(),
      STaxRoundUp: double.parse(onwardSTaxRoundUpAmount!.toString()).toString(),
      SeatFares: onwardSeatFares().toString(),
      SeatGenders: onwardSeatGenders().toString(),
      SeatList: onwardSeatList().toString(),
      SeatNames: onwardSeatNameString().toString(),
      ServiceTax: onwardStax.toString(),
      ServiceTaxList: onwardServiceTaxList.toString(),
      ServiceTaxPer: allRouteBusOnwardLists!.ServiceTax.toString(),
      ServiceTaxRoundUP: allRouteBusOnwardLists!.ServiceTaxRoundUp.toString(),
      SubRoute:
          "${allRouteBusOnwardLists!.FromCityName} To ${allRouteBusOnwardLists!.ToCityName}",
      ToCityId: allRouteBusOnwardLists!.ToCityId.toString(),
      ToCityName: allRouteBusOnwardLists!.ToCityName.toString(),
      TotalPax: _selected_onward_seat_list.length.toString(),
      TotalSeaterAmt: totalSeaterAmtOnward.toString(),
      TotalSeaters: totalSeatersOnward.toString(),
      TotalSemiSleeperAmt: totalSemiSleeperAmtOnward.toString(),
      TotalSemiSleepers: totalSemiSleepersOnward.toString(),
      TotalSleeperAmt: totalSleeperAmtOnward.toString(),
      TotalSleepers: totalSleepersOnward.toString(),
      //Todo return
      Surcharges_total_R: IsSurCharge!.compareTo("0") == 0
          ? "0.0"
          : (onwardSurcharges() + returnSurcharges()).toString(),
      Surcharges_R: IsSurCharge!.compareTo("0") == 0
          ? "0.0"
          : returnSurcharges().toString(),

      AgeList_R: tripType != "2" ? "" : returnAgeListString().toString(),
      ArrangementID_R: tripType != "2"
          ? ""
          : allRouteBusReturnLists!.ArrangementID.toString(),
      ArrangementName_R: tripType != "2"
          ? ""
          : allRouteBusReturnLists!.ArrangementName
              .replaceAll("&", "&amp;")
              .toString(),
      BaseFare_R: tripType != "2" ? "" : returnTotalBaseFare().toString(),
      BaseFareList_R: tripType != "2" ? "" : returnBaseFareList!.toString(),
      BusType_R:
          tripType != "2" ? "" : allRouteBusReturnLists!.BusType.toString(),
      BusTypeName_R: tripType != "2"
          ? ""
          : allRouteBusReturnLists!.BusTypeName
              .replaceAll("&", "&amp;")
              .toString(),
      CityTime_R:
          tripType != "2" ? "" : allRouteBusReturnLists!.CityTime.toString(),
      DiscPerAmount_R: tripType != "2" ? "" : AllDiscPerAmount_R.toString(),
      DiscountSeatDetails_R:
          tripType != "2" ? "" : returnSeatDetailsString().toString(),
      DropID_R: tripType != "2" ? "" : DroppingPointReturnID.toString(),
      DropName_R: tripType != "2" ? "" : DroppingPointReturnName.toString(),
      DropTime_R: tripType != "2" ? "" : DroppingPointReturnTime.toString(),
      FromCityId_R:
          tripType != "2" ? "" : allRouteBusReturnLists!.FromCityId.toString(),
      FromCityName_R: tripType != "2"
          ? ""
          : allRouteBusReturnLists!.FromCityName.toString(),
      ITS_SeatString_R: tripType != "2" ? "" : returnSeatStringPara!.toString(),
      IsIncludeTax_R: tripType != "2"
          ? ""
          : allRouteBusReturnLists!.IsIncludeTax.toString(),
      JourneyDate_R: tripType != "2" ? "" : journeyDateReturn!.toString(),
      MainRouteName_R: tripType != "2"
          ? ""
          : allRouteBusReturnLists!.RouteName
              .replaceAll("&", "&amp;")
              .toString(),
      OriginalAmount_R: tripType != "2" ? "" : returnTotalAmount().toString(),
      PNRAmount_R: tripType != "2" ? "" : returnPNRAmount.toString(),
      Passengerlist_R: tripType != "2" ? "" : returnPassengerList().toString(),
      PickUpID_R: tripType != "2" ? "" : BoardingPointReturnID!.toString(),
      PickupName_R: tripType != "2" ? "" : BoardingPointReturnName!.toString(),
      PickupTime_R: tripType != "2" ? "" : BoardingPointReturnTime!.toString(),
      ReferenceNumber_R: tripType != "2"
          ? ""
          : allRouteBusReturnLists!.ReferenceNumber.toString(),
      RoundUpList_R: tripType != "2" ? "" : returnRoundUpList!.toString(),
      RouteId_R:
          tripType != "2" ? "" : allRouteBusReturnLists!.RouteID.toString(),
      RouteTime_R:
          tripType != "2" ? "" : allRouteBusReturnLists!.RouteTime.toString(),
      RouteTimeId_R:
          tripType != "2" ? "" : allRouteBusReturnLists!.RouteTimeID.toString(),
      STax_R: tripType != "2"
          ? ""
          : double.parse(returnSTaxWithOutRoundUpAmount!.toString()).toString(),
      STaxRoundUp_R: tripType != "2"
          ? ""
          : double.parse(returnSTaxRoundUpAmount!.toString()).toString(),
      SeatFares_R: tripType != "2" ? "" : returnSeatFares().toString(),
      SeatGenders_R: tripType != "2" ? "" : returnSeatGenders().toString(),
      SeatList_R: tripType != "2" ? "" : returnSeatList().toString(),
      SeatNames_R: tripType != "2" ? "" : returnSeatNameString().toString(),
      ServiceTax_R: tripType != "2" ? "" : returnStax.toString(),
      ServiceTaxList_R: tripType != "2" ? "" : returnServiceTaxList.toString(),
      ServiceTaxPer_R:
          tripType != "2" ? "" : allRouteBusReturnLists!.ServiceTax.toString(),
      ServiceTaxRoundUP_R: tripType != "2"
          ? ""
          : allRouteBusReturnLists!.ServiceTaxRoundUp.toString(),
      SubRoute_R: tripType != "2"
          ? ""
          : "${allRouteBusReturnLists!.FromCityName} To ${allRouteBusReturnLists!.ToCityName}",
      ToCityId_R:
          tripType != "2" ? "" : allRouteBusReturnLists!.ToCityId.toString(),
      ToCityName_R:
          tripType != "2" ? "" : allRouteBusReturnLists!.ToCityName.toString(),
      TotalPax_R:
          tripType != "2" ? "" : _selected_return_seat_list.length.toString(),
      TotalSeaterAmt_R: tripType != "2" ? "" : totalSeaterAmtReturn.toString(),
      TotalSeaters_R: tripType != "2" ? "" : totalSeatersReturn.toString(),
      TotalSemiSleeperAmt_R:
          tripType != "2" ? "" : totalSemiSleeperAmtReturn.toString(),
      TotalSemiSleepers_R:
          tripType != "2" ? "" : totalSemiSleepersReturn.toString(),
      TotalSleeperAmt_R:
          tripType != "2" ? "" : totalSleeperAmtReturn.toString(),
      TotalSleepers_R: tripType != "2" ? "" : totalSleepersReturn.toString(),
    ).then((XmlDocument document) {
      Navigator.of(context).pop();
      if (document.findAllElements('NewDataSet').isNotEmpty) {
        XmlElement xmlElementmain =
            document.findAllElements('Insert_Order').first;

        Logger().d(xmlElementmain);
        if (xmlElementmain != null) {
          if (xmlElementmain.getElement('Status')!.text.compareTo("1") == 0) {
            String url =
                "${xmlElementmain.getElement('PGURL')!.text}&HS=${xmlElementmain.getElement('OrderNo')!.text}";
            print(url);
            Navigator.of(context).pushReplacementNamed(
                PaymentMainScreenV2.routeName,
                arguments: {
                  'PGURL': xmlElementmain.getElement('PGURL')!.text.toString(),
                  'OrderNo':
                      xmlElementmain.getElement('OrderNo')!.text.toString(),
                });
          }
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }

  Future<void> setDataFromDymanic({required String password}) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    NavigatorConstants.USER_ID = '0';
    NavigatorConstants.USER_NAME =
        primary_name_textEditing.text.trim().toString();
    NavigatorConstants.USER_EMAIL =
        primary_email_textEditing.text.trim().toString();
    NavigatorConstants.USER_PHONE =
        primary_mobile_textEditing.text.trim().toString();
    NavigatorConstants.USER_PASSWORD = password.trim().toString();
    setState(() {
      _sharedPreferences!.setString(Preferences.CUST_NAME,
          primary_name_textEditing.text.trim().toString());
      _sharedPreferences!.setString(Preferences.CUST_EMAIL,
          primary_email_textEditing.text.trim().toString());
      _sharedPreferences!.setString(Preferences.CUST_PHONE,
          primary_mobile_textEditing.text.trim().toString());
      _sharedPreferences!
          .setString(Preferences.CUST_PASSWORD, password.trim().toString());
    });
  }

  Future<void> setDataFromApi(
      {required XmlElement xmlElement, required String password}) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    NavigatorConstants.USER_ID =
        xmlElement.getElement('CustID')!.text.toString();
    NavigatorConstants.USER_NAME =
        xmlElement.getElement('CustName')!.text.toString();
    NavigatorConstants.USER_EMAIL =
        xmlElement.getElement('CustEmail')!.text.toString();
    NavigatorConstants.USER_PHONE =
        xmlElement.getElement('CustMobile')!.text.toString();
    NavigatorConstants.USER_PASSWORD = password.trim().toString();

    setState(() {
      _sharedPreferences!.setString(Preferences.CUST_ID,
          xmlElement.getElement('CustID')!.text.toString());
      _sharedPreferences!.setString(Preferences.CUST_NAME,
          xmlElement.getElement('CustName')!.text.toString());
      _sharedPreferences!.setString(Preferences.CUST_EMAIL,
          xmlElement.getElement('CustEmail')!.text.toString());
      _sharedPreferences!.setString(Preferences.CUST_PHONE,
          xmlElement.getElement('CustMobile')!.text.toString());
      _sharedPreferences!
          .setString(Preferences.CUST_PASSWORD, password.trim().toString());
    });
  }

  void _hideKeyBoard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  double onwardSurcharges() {
    double seatFares = 0.0;
    for (int i = 0; i < _selected_onward_seat_list.length; i++) {
      seatFares =
          double.parse(_selected_onward_seat_list[i].Surcharges.toString())
              .toDouble();
    }
    // print('seatFares===>${seatFares}');
    return seatFares;
  }

  double returnSurcharges() {
    double seatFares = 0.0;
    for (int i = 0; i < _selected_return_seat_list.length; i++) {
      seatFares =
          double.parse(_selected_return_seat_list[i].Surcharges.toString())
              .toDouble();
    }
    // print('seatFares===>${seatFares}');
    return seatFares;
  }

  void seatTypeOnward() {
    for (int i = 0; i < _selected_onward_seat_list.length; i++) {
      if (_selected_onward_seat_list[i].SeatType.compareTo("0") == 0) {
        totalSeatersOnward++;
        totalSeaterAmtOnward +=
            double.parse(_selected_onward_seat_list[i].SeatRate).toDouble();
      } else if (_selected_onward_seat_list[i].SeatType.compareTo("1") == 0) {
        totalSleepersOnward++;
        totalSleeperAmtOnward +=
            double.parse(_selected_onward_seat_list[i].SeatRate).toDouble();
      } else if (_selected_onward_seat_list[i].SeatType.compareTo("2") == 0) {
        totalSemiSleepersOnward++;
        totalSemiSleeperAmtOnward +=
            double.parse(_selected_onward_seat_list[i].SeatRate).toDouble();
      }
    }
  }

  void seatTypeReturn() {
    for (int i = 0; i < _selected_return_seat_list.length; i++) {
      if (_selected_return_seat_list[i].SeatType.compareTo("0") == 0) {
        totalSeatersReturn++;
        totalSeaterAmtReturn +=
            double.parse(_selected_return_seat_list[i].SeatRate).toDouble();
      } else if (_selected_return_seat_list[i].SeatType.compareTo("1") == 0) {
        totalSleepersReturn++;
        totalSleeperAmtReturn +=
            double.parse(_selected_return_seat_list[i].SeatRate).toDouble();
      } else if (_selected_return_seat_list[i].SeatType.compareTo("2") == 0) {
        totalSemiSleepersReturn++;

        totalSemiSleeperAmtReturn +=
            double.parse(_selected_return_seat_list[i].SeatRate).toDouble();
      }
    }
  }

  String onwardSeatFares() {
    String seatFares = '';
    for (int i = 0; i < _passangers_Onward_ListModel.length; i++) {
      if (i == 0) {
        seatFares = (_passangers_Onward_ListModel[i].seatBasefare.toDouble() +
                _passangers_Onward_ListModel[i].seatGst.toDouble())
            .toString();
      } else {
        seatFares =
            "$seatFares,${_passangers_Onward_ListModel[i].seatBasefare.toDouble() + _passangers_Onward_ListModel[i].seatGst.toDouble()}";
      }
    }
    // print('seatFares===>${seatFares}');
    return seatFares;
  }

  String returnSeatFares() {
    String seatFares = '';
    for (int i = 0; i < _passangers_Return_ListModel.length; i++) {
      if (i == 0) {
        seatFares = (_passangers_Return_ListModel[i].seatBasefare.toDouble() +
                _passangers_Return_ListModel[i].seatGst.toDouble())
            .toString();
      } else {
        seatFares =
            "$seatFares,${_passangers_Return_ListModel[i].seatBasefare.toDouble() + _passangers_Return_ListModel[i].seatGst.toDouble()}";
      }
    }
    // print('seatFares===>${seatFares}');
    return seatFares;
  }

  String onwardSeatList() {
    String seatList = '';
    for (int i = 0; i < _passangers_Onward_ListModel.length; i++) {
      if (i == 0) {
        seatList = _passangers_Onward_ListModel[i].seatNo.toString();
      } else {
        seatList = "$seatList,${_passangers_Onward_ListModel[i].seatNo}";
      }
    }
    // print('seatList===>${seatList}');
    return seatList;
  }

  String returnSeatList() {
    String seatList = '';
    for (int i = 0; i < _passangers_Return_ListModel.length; i++) {
      if (i == 0) {
        seatList = _passangers_Return_ListModel[i].seatNo.toString();
      } else {
        seatList = "$seatList,${_passangers_Return_ListModel[i].seatNo}";
      }
    }
    // print('seatList===>${seatList}');
    return seatList;
  }

  String onwardSeatGenders() {
    String seatGenders = '';
    for (int i = 0; i < _passangers_Onward_ListModel.length; i++) {
      if (i == 0) {
        seatGenders =
            _passangers_Onward_ListModel[i].passengerGender.toString();
      } else {
        seatGenders =
            "$seatGenders,${_passangers_Onward_ListModel[i].passengerGender}";
      }
    }
    // print('seatGenders===>${seatGenders}');
    return seatGenders;
  }

  String returnSeatGenders() {
    String seatGenders = '';
    for (int i = 0; i < _passangers_Return_ListModel.length; i++) {
      if (i == 0) {
        seatGenders =
            _passangers_Return_ListModel[i].passengerGender.toString();
      } else {
        seatGenders =
            "$seatGenders,${_passangers_Return_ListModel[i].passengerGender}";
      }
    }
    // print('seatGenders===>${seatGenders}');
    return seatGenders;
  }

  String onwardSeatNameString() {
    String onwardSeatstring = '';
    for (int i = 0; i < _passangers_Onward_ListModel.length; i++) {
      if (i == 0) {
        onwardSeatstring =
            "${_passangers_Onward_ListModel[i].seatNo},${_passangers_Onward_ListModel[i].passengerGender}";
      } else {
        onwardSeatstring =
            "$onwardSeatstring|${_passangers_Onward_ListModel[i].seatNo},${_passangers_Onward_ListModel[i].passengerGender}";
      }
    }
    // print('onwardSeatstring===>${onwardSeatstring}');
    return onwardSeatstring;
  }

  String returnSeatNameString() {
    String onwardSeatstring = '';
    for (int i = 0; i < _passangers_Return_ListModel.length; i++) {
      if (i == 0) {
        onwardSeatstring =
            "${_passangers_Return_ListModel[i].seatNo},${_passangers_Return_ListModel[i].passengerGender}";
      } else {
        onwardSeatstring =
            "$onwardSeatstring|${_passangers_Return_ListModel[i].seatNo},${_passangers_Return_ListModel[i].passengerGender}";
      }
    }
    return onwardSeatstring;
  }

  String onwardSeatDetailsString() {
    String onwardSeatDetails = '';
    for (int i = 0; i < _passangers_Onward_ListModel.length; i++) {
      if (i == 0) {
        onwardSeatDetails =
            "${_passangers_Onward_ListModel[i].seatNo},${_passangers_Onward_ListModel[i].passengerGender},${double.parse(_passangers_Onward_ListModel[i].seatBasefare.toString()).toDouble()},${_passangers_Onward_ListModel[i].seatGst},${_passangers_Onward_ListModel[i].seatGst + _passangers_Onward_ListModel[i].seatBasefare}";
      } else {
        onwardSeatDetails =
            "$onwardSeatDetails#${_passangers_Onward_ListModel[i].seatNo},${_passangers_Onward_ListModel[i].passengerGender},${double.parse(_passangers_Onward_ListModel[i].seatBasefare.toString()).toDouble()},${_passangers_Onward_ListModel[i].seatGst},${_passangers_Onward_ListModel[i].seatGst + _passangers_Onward_ListModel[i].seatBasefare}";
      }
    }
    return onwardSeatDetails;
  }

  String returnSeatDetailsString() {
    String returnSeatDetails = '';
    for (int i = 0; i < _passangers_Return_ListModel.length; i++) {
      if (i == 0) {
        returnSeatDetails =
            "${_passangers_Return_ListModel[i].seatNo},${_passangers_Return_ListModel[i].passengerGender},${_passangers_Return_ListModel[i].seatBasefare},${_passangers_Return_ListModel[i].seatGst},${_passangers_Return_ListModel[i].seatGst + _passangers_Return_ListModel[i].seatBasefare}";
      } else {
        returnSeatDetails =
            "$returnSeatDetails#${_passangers_Return_ListModel[i].seatNo},${_passangers_Return_ListModel[i].passengerGender},${_passangers_Return_ListModel[i].seatBasefare},${_passangers_Return_ListModel[i].seatGst},${_passangers_Return_ListModel[i].seatGst + _passangers_Return_ListModel[i].seatBasefare}";
      }
    }
    // print('onwardSeatDetails===>${onwardSeatDetails}');
    return returnSeatDetails;
  }

  double onwardTotalAmount() {
    double seatRate = 0.0;
    for (int i = 0; i < _selected_onward_seat_list.length; i++) {
      // if(TotalDiscountBaseFare() > 0 && NavigatorConstants.USER_ID != '0'){
      seatRate +=
          double.parse(_selected_onward_seat_list[i].SeatRate).toDouble();
      /*}else{
        seat_rate += double.parse(_selected_onward_seat_list[i].OriginalSeatRate).toDouble();
      }*/
    }
    // print('onward all seatRate $seat_rate');
    return seatRate;
  }

  double returnTotalAmount() {
    double seatRate = 0.0;
    for (int i = 0; i < _selected_return_seat_list.length; i++) {
      // if(TotalDiscountBaseFare() > 0 && NavigatorConstants.USER_ID != '0'){
      seatRate +=
          double.parse(_selected_return_seat_list[i].SeatRate).toDouble();
      /*}else{
        seat_rate += double.parse(_selected_return_seat_list[i].OriginalSeatRate).toDouble();
      }*/
    }
    // print('retuen all seatRate $seat_rate');
    return seatRate;
  }

  double TotaliscountAmount() {
    double seatRate = 0.0;

    for (int i = 0; i < _selected_onward_seat_list.length; i++) {
      seatRate +=
          double.parse(_selected_onward_seat_list[i].DiscountAmount).toDouble();
    }

    if (tripType == "2") {
      for (int i = 0; i < _selected_return_seat_list.length; i++) {
        seatRate += double.parse(_selected_return_seat_list[i].DiscountAmount)
            .toDouble();
      }
    }
    // print('retuen all seatRate $seat_rate');
    OrderDisount = seatRate;
    return seatRate;
  }

  double DiscountPerAmountonW() {
    double seatRate = 0.0;

    for (int i = 0; i < _selected_onward_seat_list.length; i++) {
      seatRate +=
          double.parse(_selected_onward_seat_list[i].DiscountAmount).toDouble();
    }

    AllDiscPerAmount = seatRate;
    return seatRate;
  }

  double DiscountPerAmountRet() {
    double seatRate = 0.0;
    if (tripType == "2") {
      for (int i = 0; i < _selected_return_seat_list.length; i++) {
        seatRate += double.parse(_selected_return_seat_list[i].DiscountAmount)
            .toDouble();
      }
    }
    AllDiscPerAmount_R = seatRate;
    return seatRate;
  }

  double TotalBaseFare() {
    double seatRate = 0.0;

    for (int i = 0; i < _selected_onward_seat_list.length; i++) {
      seatRate += double.parse(_selected_onward_seat_list[i].OriginalSeatRate)
          .toDouble();
    }

    if (tripType == "2") {
      for (int i = 0; i < _selected_return_seat_list.length; i++) {
        seatRate += double.parse(_selected_return_seat_list[i].OriginalSeatRate)
            .toDouble();
      }
    }
    // print('retuen all seatRate $seat_rate');
    return seatRate;
  }

  double TotalDiscountBaseFare() {
    double seatRate = 0.0;

    for (int i = 0; i < _selected_onward_seat_list.length; i++) {
      seatRate +=
          double.parse(_selected_onward_seat_list[i].BaseFare).toDouble();
    }

    if (tripType == "2") {
      for (int i = 0; i < _selected_return_seat_list.length; i++) {
        seatRate +=
            double.parse(_selected_return_seat_list[i].BaseFare).toDouble();
      }
    }
    // print('retuen all seatRate $seat_rate');
    return seatRate;
  }

  double onwardTotalStax() {
    double tax = 0.0;
    for (int i = 0; i < _selected_onward_seat_list.length; i++) {
      tax += double.parse(_selected_onward_seat_list[i].ServiceTax).toDouble();
    }
    return tax;
  }

  double returnTotalStax() {
    double tax = 0.0;
    for (int i = 0; i < _selected_return_seat_list.length; i++) {
      tax += double.parse(_selected_return_seat_list[i].ServiceTax).toDouble();
    }
    return tax;
  }

  double onwardTotalBaseFare() {
    double tax = 0.0;
    for (int i = 0; i < _selected_onward_seat_list.length; i++) {
      tax += double.parse(_selected_onward_seat_list[i].BaseFare).toDouble();
    }
    return tax;
  }

  double returnTotalBaseFare() {
    double tax = 0.0;
    for (int i = 0; i < _selected_return_seat_list.length; i++) {
      tax += double.parse(_selected_return_seat_list[i].BaseFare).toDouble();
    }
    return tax;
  }

  String onwardSeatDetailsDiscount() {
    String onwardSeatDetailsDiscount = '';
    for (int i = 0; i < _passangers_Onward_ListModel.length; i++) {
      if (i == 0) {
        onwardSeatDetailsDiscount =
            '${_passangers_Onward_ListModel[i].seatNo},${_passangers_Onward_ListModel[i].passengerGender},${double.parse(_passangers_Onward_ListModel[i].seatBasefare.toString())},${double.parse(_passangers_Onward_ListModel[i].seatGst.toString())},${double.parse(_passangers_Onward_ListModel[i].seatBasefare.toString()) + double.parse(_passangers_Onward_ListModel[i].seatGst.toString())}';
      } else {
        onwardSeatDetailsDiscount =
            '$onwardSeatDetailsDiscount*${_passangers_Onward_ListModel[i].seatNo},${_passangers_Onward_ListModel[i].passengerGender},${double.parse(_passangers_Onward_ListModel[i].seatBasefare.toString())},${double.parse(_passangers_Onward_ListModel[i].seatGst.toString())},${double.parse(_passangers_Onward_ListModel[i].seatBasefare.toString()) + double.parse(_passangers_Onward_ListModel[i].seatGst.toString())}';
      }
    }
    return onwardSeatDetailsDiscount;
  }

  String returnSeatDetailsDiscount() {
    String onwardSeatDetailsDiscount = '';
    for (int i = 0; i < _passangers_Return_ListModel.length; i++) {
      if (i == 0) {
        onwardSeatDetailsDiscount =
            '${_passangers_Return_ListModel[i].seatNo},${_passangers_Return_ListModel[i].passengerGender},${double.parse(_passangers_Return_ListModel[i].seatBasefare.toString())},${double.parse(_passangers_Return_ListModel[i].seatGst.toString())},${double.parse(_passangers_Return_ListModel[i].seatBasefare.toString()) + double.parse(_passangers_Return_ListModel[i].seatGst.toString())}';
      } else {
        onwardSeatDetailsDiscount =
            '$onwardSeatDetailsDiscount*${_passangers_Return_ListModel[i].seatNo},${_passangers_Return_ListModel[i].passengerGender},${double.parse(_passangers_Return_ListModel[i].seatBasefare.toString())},${double.parse(_passangers_Return_ListModel[i].seatGst.toString())},${double.parse(_passangers_Return_ListModel[i].seatBasefare.toString()) + double.parse(_passangers_Return_ListModel[i].seatGst.toString())}';
      }
    }
    return onwardSeatDetailsDiscount;
  }

  String onwardPassengerList() {
    String passengerlist = '';
    for (int i = 0; i < _passangers_Onward_ListModel.length; i++) {
      if (i == 0) {
        passengerlist =
            _passangers_Onward_ListModel[i].passengerName.toString();
      } else {
        passengerlist =
            "$passengerlist,${_passangers_Onward_ListModel[i].passengerName}";
      }
    }

    return passengerlist;
  }

  String returnPassengerList() {
    String passengerlist = '';
    for (int i = 0; i < _passangers_Return_ListModel.length; i++) {
      if (i == 0) {
        passengerlist =
            _passangers_Return_ListModel[i].passengerName.toString();
      } else {
        passengerlist =
            "$passengerlist,${_passangers_Return_ListModel[i].passengerName}";
      }
    }

    return passengerlist;
  }

  String onwardAgeListString() {
    String ageList = '';
    for (int i = 0; i < _passangers_Onward_ListModel.length; i++) {
      if (i == 0) {
        ageList = _passangers_Onward_ListModel[i].passengerAge;
      } else {
        ageList = "$ageList,${_passangers_Onward_ListModel[i].passengerAge}";
      }
    }
    // print('ageList===>${ageList}');
    return ageList;
  }

  String returnAgeListString() {
    String ageList = '';
    for (int i = 0; i < _passangers_Return_ListModel.length; i++) {
      if (i == 0) {
        ageList = _passangers_Return_ListModel[i].passengerAge;
      } else {
        ageList = "$ageList,${_passangers_Return_ListModel[i].passengerAge}";
      }
    }
    // print('ageList===>${ageList}');
    return ageList;
  }

  void saveAmountDialog() {
    showDialog(
        context: context,
        builder: (_) => Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Stack(
                  children: [
                    Lottie.network(
                        "https://assets7.lottiefiles.com/packages/lf20_aJNnbie7MX.json"),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(Icons.close))),
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: SvgPicture.asset(
                            'assets/images/congratulations_icon.svg',
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Woohoo!!',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '₹ ${TotaliscountAmount()}',
                          style: TextStyle(
                              color: CustomeColor.saveAmountColor,
                              fontSize: 28),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'saved on this booking',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        AppButton(() {
                          Get.back();
                        }, text: "Yay!!")
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  Widget getCheckBoxList(BuildContext ctx) {

    try{


    List insList = Helper.InsuranceDeatils.isNotEmpty
     ? Helper.InsuranceDeatils.split("|")
     : [];

    insuranceList = [];

    for (var item in insList) {
      insuranceList.add(InsuranceModel(
          id: item.toString().split("*")[1],
          price: item.toString().split("*").first));
    }

    return ValueListenableBuilder(
        valueListenable: isInsuranceEnable,
        builder: (ctx, val, _) {
          return Column(children: [
            securetripWidget(),
            // if (_isDiscountB2cApiCAll.value)
            //   InkWell(
            //     onTap: () {
            //       if (isInsuranceEnable.value) {
            //         isInsuranceEnable.value = false;
            //       } else {
            //         isInsuranceEnable.value = true;
            //
            //         for (var item in insuranceList) {
            //           if (item.price == "20") {
            //             selectedinsurance = item.id;
            //             ApplyDiscountCouponApiCall(ctx);
            //             break;
            //           }
            //         }
            //       }
            //       setState(() {});
            //     },
            //     child: Row(children: [
            //       Container(
            //           height: 25,
            //           width: 25,
            //           child: Checkbox(
            //               value: isInsuranceEnable.value,
            //               onChanged: (value) {
            //                 isInsuranceEnable.value = value;
            //
            //                 print("My check test :- $value");
            //
            //                 if (value ?? false) {
            //                   for (var item in insuranceList) {
            //                     if (item.price == "20") {
            //                       selectedinsurance = item.id;
            //                       ApplyDiscountCouponApiCall(ctx);
            //                       break;
            //                     }
            //                   }
            //                 }
            //                 setState(() {});
            //               })),
            //       SizedBox(width: 10),
            //       Text("Reliance General Insurance",
            //           style:
            //               TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
            //     ]),
            //   ),
            // if (_isDiscountB2cApiCAll.value && isInsuranceEnable.value)
            //   Row(children: [
            //     Container(
            //         height: 25,
            //         width: 25,
            //         child: Checkbox(
            //             value: isInsuranceEnable.value,
            //             onChanged: (value) {
            //               isInsuranceEnable.value = value;
            //
            //               print("My check test :- $value");
            //
            //               setState(() {});
            //             })),
            //     SizedBox(width: 10),
            //     RichText(
            //       text: TextSpan(
            //           text: "i agree ",
            //           style: TextStyle(color: Colors.black),
            //           children: [
            //             TextSpan(
            //                 text: "Terms And Conditions",
            //                 recognizer: TapGestureRecognizer()
            //                   ..onTap = () {
            //                     print('Sign up tapped');
            //
            //                     showDialog(
            //                         context: context,
            //                         builder: (ctx) {
            //                           return Dialog(
            //                             child: Container(
            //                                 decoration: BoxDecoration(
            //                                     borderRadius:
            //                                         BorderRadius.circular(20)),
            //                                 padding: EdgeInsets.all(10),
            //                                 child:
            //                                     Html(data: Helper.Disclaimer)),
            //                           );
            //                         });
            //                   },
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.black,
            //                     decoration: TextDecoration.underline))
            //           ]),
            //     ),
            //   ]),
            // if (isInsuranceEnable.value) SizedBox(height: 10),
            // if (isInsuranceEnable.value)
            //   ValueListenableBuilder(
            //       valueListenable: insuranceChangeListner,
            //       builder: (ctx, val, _) {
            //         return Container(
            //           child: Column(
            //             children: List.generate(
            //                 insuranceList.length,
            //                 (index) => InkWell(
            //                       onTap: () {
            //                         if (selectedinsurance !=
            //                             insuranceList[index].id) {
            //                           selectedinsurance =
            //                               insuranceList[index].id;
            //                           insuranceChangeListner.value =
            //                               Random().nextInt(99999999);
            //                           ApplyDiscountCouponApiCall(ctx);
            //                         }
            //                       },
            //                       child: Container(
            //                         margin: EdgeInsets.only(bottom: 5),
            //                         child: Row(
            //                           children: [
            //                             customCheckBox(
            //                                 insuranceModel:
            //                                     insuranceList[index],
            //                                 onchange: (value) {
            //                                   if (selectedinsurance !=
            //                                       insuranceList[index].id) {
            //                                     selectedinsurance =
            //                                         insuranceList[index].id;
            //                                     insuranceChangeListner.value =
            //                                         Random().nextInt(9000000);
            //
            //                                     ApplyDiscountCouponApiCall(
            //                                         context);
            //                                   }
            //                                 })
            //                           ],
            //                         ),
            //                       ),
            //                     )),
            //           ),
            //         );
            //       })
          ]);
        });
    } catch(e) {
      return SizedBox.shrink();
    }
  }

  customCheckBox({
    double height = 20,
    double width = 20,
    required InsuranceModel insuranceModel,
    ValueChanged<bool?>? onchange,
  }) {
    return Row(
      children: [
        Container(
            height: height,
            width: width,
            child: Checkbox(
                value: selectedinsurance == insuranceModel.id,
                onChanged: onchange)),
        SizedBox(width: 10),
        Text(insuranceModel.price, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  num getInsurance() {
    if (isInsuranceEnable.value) {
      num insCharge = 0;
      if (TotalInsuranceCharge.isNotEmpty) {
        insCharge = num.parse(TotalInsuranceCharge);
      }
      if (TotalInsuranceCharge_R.isNotEmpty) {
        insCharge += num.parse(TotalInsuranceCharge_R);
      }
      return insCharge;
    } else {
      return 0;
    }
  }

  Widget securetripWidget() {
    return _isDiscountB2cApiCAll.value
        ? Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.6)),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        border: Border(bottom: BorderSide(color: Colors.grey))),
                    child: Row(
                      children: [
                        Image.asset(
                          imgAssets + "secure.png",
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Secure Trip",
                          style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),

                // ValueListenableBuilder(
                //     valueListenable: isInsuranceEnable,
                //     builder: (ctx, val, _) {
                //       if (isInsuranceEnable.value) {
                //         return Column(
                //           children: [
                //             SizedBox(height: 20),
                //             Container(
                //               padding: EdgeInsets.symmetric(horizontal: 15),
                //               child: Row(
                //                 children: [
                //                   Text(
                //                     "₹${insuranceList[0].price}",
                //                     style: TextStyle(
                //                         fontSize: 20,
                //                         fontWeight: FontWeight.bold),
                //                   ),
                //                   Text(
                //                     "/Traveller",
                //                     style: TextStyle(fontSize: 16),
                //                   )
                //                 ],
                //               ),
                //             ),
                //             SizedBox(height: 20),
                //             Row(
                //               children: [
                //                 Expanded(
                //                     child: CardView(
                //                         img: imgAssets + "patient.png",
                //                         heading: "Personal Accident",
                //                         subHeading: "Accidental Death",
                //                         coverage: "Coverage ₹3,00,000")),
                //                 Expanded(
                //                     child: CardView(
                //                         img: imgAssets + "hospitalistion.png",
                //                         heading:
                //                             "Emergency Hospitalisation For injury",
                //                         subHeading: "",
                //                         coverage: "Coverage ₹50,000")),
                //               ],
                //             ),
                //             Row(
                //               children: [
                //                 Expanded(
                //                     child: CardView(
                //                         img: imgAssets + "luggage.png",
                //                         heading:
                //                             "Total Loss of Checked - In Baggages",
                //                         subHeading: "",
                //                         coverage:
                //                             "50% or 100% per baggeges or per article limit subject to maximum of ₹5,000")),
                //                 Expanded(
                //                     child: CardView(
                //                         img: imgAssets + "cancellation.png",
                //                         heading:
                //                             "Trip Cancellation And interruption",
                //                         subHeading: "",
                //                         coverage:
                //                             "Upto the Orginal cost of the ticket. subject to muximum of ₹ 1500/- whichever is lower")),
                //               ],
                //             ),
                //             Row(
                //               children: [
                //                 Expanded(
                //                     child: CardView(
                //                         img: imgAssets + "ambulance.png",
                //                         heading:
                //                             "Daily allowance in case of emergency hospitalisation",
                //                         subHeading: "",
                //                         coverage:
                //                             "₹ 400/- per day for upto 3 days")),
                //               ],
                //             ),
                //             SizedBox(height: 20),
                //           ],
                //         );
                //       } else {
                //         return SizedBox.shrink();
                //       }
                //     }),

                Container(
                    width: Get.width,
                    child:
                        HtmlWidget(Helper.InsuranceHTML.replaceAll("?", "₹"))),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            child: Checkbox(
                                value: isInsuranceEnable.value,
                                onChanged: (value) {
                                  isInsuranceEnable.value = value;

                                  if (value ?? true) {
                                    selectedinsurance = insuranceList[0].id;
                                    // insuranceChangeListner.value =
                                    //     Random().nextInt(99999999);
                                    ApplyDiscountCouponApiCall(context,showDialog: false);
                                  }
                                  else {
                                    TotalInsuranceCharge = "0";
                                    TotalInsuranceCharge_R = "0";
                                    InsuranceChargeListOnward = "";
                                    InsuranceChargeList_R = "";
                                  }

                                  print("My check test :- $value");

                                  setState(() {});
                                }),
                          ),
                          SizedBox(width: 5),
                          SizedBox(width: 5),
                          RichText(
                            text: TextSpan(
                                text: "Yes, ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: CustomeColor.main_bg,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: "Secure My trip",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal))
                                ]),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                            text: Helper.Disclaimer,
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                  text: "Terms and Condition",
                                  style: TextStyle(
                                      color: CustomeColor.main_bg,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {

                                      Get.to(() => WebviewScreen(pdfUrl: Helper.InsuranceDocs));

                                      print(
                                          'launch my url ${Helper.InsuranceDocs}');
                                      // Uri uri = Uri.parse(Helper.InsuranceDocs);
                                      //
                                      // if (await canLaunchUrl(uri)) {
                                      //  // await launchUrl(uri);
                                      //
                                      // }
                                      // else {
                                      //   UiUtils.errorSnackBar(
                                      //           title: "Error",
                                      //           message: "Unable to make call")
                                      //       .show();
                                      //   throw 'Could not launch $uri';
                                      // }
                                    })
                            ]),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        : SizedBox.shrink();
  }

  CardView(
      {required String img,
      required String heading,
      required String subHeading,
      required String coverage}) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(img, height: 30, width: 30),
          SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$heading",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                subHeading.isEmpty
                    ? SizedBox.shrink()
                    : Text("$subHeading",
                        style: TextStyle(color: Colors.black)),
                Text(
                  "$coverage",
                  style: TextStyle(color: CustomeColor.main_bg),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
