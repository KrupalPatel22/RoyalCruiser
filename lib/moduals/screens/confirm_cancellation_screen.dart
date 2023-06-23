import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/moduals/screens/dashboard_screen.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/moduals/screens/terms_and_condition_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:xml/xml.dart';

class ConfirmCancellationAppScreen extends StatefulWidget {
  static const String routeName = '/confirm_cancellation_screen';

  const ConfirmCancellationAppScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmCancellationAppScreen> createState() =>
      _ConfirmCancellationAppScreenState();
}

class _ConfirmCancellationAppScreenState extends State<ConfirmCancellationAppScreen> {
  RxBool _termsConditionCheckBox = false.obs;

  RxBool _cancelOnwordTripCheckBox = false.obs;
  RxBool _cancelOnwordTripCheckBoxPartial = false.obs;
  RxBool _cancelReturnTripCheckBox = false.obs;

  RxBool _isLoading = false.obs;
  bool _isHideAndShow = false;
  String htmlWidget = '';

  RxBool finalresponse = false.obs;

  String? RefundStatusMsg;
  String? StatusMsg;

  String onwardCancelOrderDetailsID = '';
  String onworsCancelOrderID = '';
  String OnwordCancelOrderNo = '';
  String onwardCalcelPNRNo = '';
  String onwardCancelRefundAmount = '';
  String onwardCancelSeatNo = '';

  String returnCancelOrderDetailsID = '';
  String returnCancelOrderID = '';
  String returnCancelOrderNo = '';
  String returnCalcelPNRNo = '';
  String returnCancelRefundAmount = '';
  String returnCancelSeatNo = '';

  double TotalRefundAmt = 0.0;

  double onwardTotalRufundAmt = 0.0;
  double returnTotalRufundAmt = 0.0;

  RxString onwardRefundWithpercentage = ''.obs;
  RxString returnRefundWithpercentage = ''.obs;

  List<bool> dynamicCheckboxForOnword = [];
  List<bool> dynamicCheckboxForReturn = [];

  List onwardSeatList = [];
  List returnSeatList = [];
  List onwardSelectSeatWithCheckBox = [];
  List returnSelectSeatWithCheckBox = [];

  List<XmlElement> xmlList = [];

  bool twoData = false;

  String onwardSeatNameString() {
    String onwardSeatstring = '';
    for (int i = 0; i < onwardSelectSeatWithCheckBox.length; i++) {
      if (i == 0) {
        onwardSeatstring = onwardSelectSeatWithCheckBox[i].toString();
      } else {
        onwardSeatstring = "$onwardSeatstring,${onwardSelectSeatWithCheckBox[i]}";
      }
    }
    return onwardSeatstring;
  }

  String returnSeatNameString() {
    String onwardSeatstring = '';
    for (int i = 0; i < returnSelectSeatWithCheckBox.length; i++) {
      if (i == 0) {
        onwardSeatstring = returnSelectSeatWithCheckBox[i].toString();
      } else {
        onwardSeatstring = "$onwardSeatstring,${returnSelectSeatWithCheckBox[i]}";
      }
    }
    return onwardSeatstring;
  }

  @override
  void initState() {
    getData().then((value) => _isLoading.value);
    super.initState();
  }

  Future<void> getData() async {
    _isLoading.value = true;
  }

  void getResetData() {
    if (xmlList.length > 1) {
      var returnSeat = xmlList[1].getElement('SeatList')!.text;
      onwardTotalRufundAmt =
          double.parse(xmlList[0].getElement('RefundAmount')!.text.toString())
              .toPrecision(2)
              .toDouble();

      var onwardSeat = xmlList[0].getElement('SeatList')!.text;
      onwardSeatList = onwardSeat.split(',').toList();
      for (int i = 0; i < onwardSeatList.length; i++) {
        dynamicCheckboxForOnword.add(false);
      }

      returnTotalRufundAmt =
          double.parse(xmlList[1].getElement('RefundAmount')!.text.toString())
              .toPrecision(2)
              .toDouble();

      onwardRefundWithpercentage.value =
          '${double.parse(xmlList[0].getElement('RefundAmount')!.text.toString()).toPrecision(2)} (${double.parse(xmlList[0].getElement('RefundPer')!.text.toString()).toPrecision(2)} %)';

      returnRefundWithpercentage.value =
          '${double.parse(xmlList[1].getElement('RefundAmount')!.text.toString()).toPrecision(2)} (${double.parse(xmlList[1].getElement('RefundPer')!.text.toString()).toPrecision(2)} %)';

      returnSeatList = returnSeat.split(',').toList();
      for (int i = 0; i < returnSeatList.length; i++) {
        dynamicCheckboxForReturn.add(false);
      }
    } else {
      onwardTotalRufundAmt =
          double.parse(xmlList[0].getElement('RefundAmount')!.text.toString())
              .toPrecision(2)
              .toDouble();
      onwardRefundWithpercentage.value =
          '${double.parse(xmlList[0].getElement('RefundAmount')!.text.toString()).toPrecision(2)} (${double.parse(xmlList[0].getElement('RefundPer')!.text.toString()).toPrecision(2)} %)';

      var onwardSeat = xmlList[0].getElement('SeatList')!.text;
      onwardSeatList = onwardSeat.split(',').toList();
      for (int i = 0; i < onwardSeatList.length; i++) {
        dynamicCheckboxForOnword.add(false);
      }
    }
  }

  @override
  void didChangeDependencies() {
    final rcvData = ModalRoute.of(context)!.settings.arguments;
    xmlList = rcvData as List<XmlElement>;

    getResetData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double LablefirstWidt = 120;
    TextStyle lableTextStyle = TextStyle(
      fontSize: 15,
      color: Colors.white,
    );
    return Scaffold(
      appBar: new AppBar(
        centerTitle: false,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: new Text(
          'Confirm Cancellation',
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
            : Stack(
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text(
                              'Cancel Details',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontFamily:
                                      CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                                  letterSpacing: 0.5),
                            ).paddingAll(10),
                          ),
                          if (finalresponse.value) ...[
                            Container(
                              padding: const EdgeInsets.all(0.0),
                              margin: const EdgeInsets.all(0.0),
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    color: Colors.red,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Refund Status',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text('$RefundStatusMsg'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(0.0),
                              margin: const EdgeInsets.all(0.0),
                              height: 40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 120,
                                    color: Colors.red,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Ticket Status',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text('$StatusMsg'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ] else
                            Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (htmlWidget.isEmpty) {
                                    getCancellationApiCall();
                                  }
                                  setState(() {
                                    _isHideAndShow = !_isHideAndShow;
                                  });
                                },
                                child: Text(
                                  _isHideAndShow != true
                                      ? 'View Cancellation Policy'
                                      : 'Hide Cancellation Policy',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.all(15),
                                  side: const BorderSide(
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ).paddingSymmetric(
                                horizontal: 10,
                                vertical: 5),
                          Visibility(
                            visible: _isHideAndShow,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              child: HtmlWidget(
                                htmlWidget,
                                textStyle: TextStyle(
                                  fontFamily:
                                      CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          onwardCheckBoxWidget(),
                          if (onwardSeatList.length > 1 ||
                              returnSeatList.length > 1) ...{
                            onwardPatialCancellWidget(),
                          },
                          cancellationDetailsOnwordWidget(),
                          if (xmlList.length > 1) ...{
                            ReturnCheckBoxWidget(),
                          },
                          if (xmlList.length > 1) ...{
                            cancellationDetailsReturnWidget(),
                          },
                          if (_cancelOnwordTripCheckBoxPartial.value) ...{
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Onward Partial \n Cancel Seats',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: CommonConstants
                                                .FONT_FAMILY_OPEN_SANS_REGULAR,
                                          ),
                                        ),
                                        for (int i = 0;
                                            i < dynamicCheckboxForOnword.length;
                                            i++) ...{
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value: dynamicCheckboxForOnword[i],
                                                onChanged: (onChanged) {
                                                  setState(() {
                                                    if (dynamicCheckboxForOnword[
                                                            i] ==
                                                        true) {
                                                      dynamicCheckboxForOnword[i] =
                                                          false;

                                                      onwardSelectSeatWithCheckBox
                                                          .remove(onwardSeatList[i]
                                                              .toString());

                                                      for (int i = 0;
                                                          i <
                                                              onwardSelectSeatWithCheckBox
                                                                  .length;
                                                          i++) {
                                                      }
                                                    } else {
                                                      dynamicCheckboxForOnword[i] =
                                                          true;
                                                      onwardSelectSeatWithCheckBox
                                                          .add(onwardSeatList[i]
                                                              .toString());
                                                      for (int i = 0;
                                                          i <
                                                              onwardSelectSeatWithCheckBox
                                                                  .length;
                                                          i++) {
                                                      }
                                                    }
                                                  });
                                                },
                                              ),
                                              Text(
                                                  '${onwardSeatList[i].toString()}'),
                                            ],
                                          ),
                                        },
                                      ],
                                    ),
                                    if (xmlList.length > 1) ...{
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Return Partial \nCancel Seats',
                                            style: TextStyle(
                                              fontSize:
                                                  16,
                                              fontFamily: CommonConstants
                                                  .FONT_FAMILY_OPEN_SANS_REGULAR,
                                            ),
                                          ),
                                          for (int i = 0;
                                              i < dynamicCheckboxForReturn.length;
                                              i++) ...{
                                            Row(
                                              children: [
                                                Checkbox(
                                                  value:
                                                      dynamicCheckboxForReturn[i],
                                                  onChanged: (onChanged) {
                                                    setState(() {
                                                      if (dynamicCheckboxForReturn[
                                                              i] ==
                                                          true) {
                                                        dynamicCheckboxForReturn[
                                                            i] = false;

                                                        returnSelectSeatWithCheckBox
                                                            .remove(
                                                                returnSeatList[i]
                                                                    .toString());

                                                        for (int i = 0;
                                                            i <
                                                                returnSelectSeatWithCheckBox
                                                                    .length;
                                                            i++) {
                                                        }
                                                      } else {
                                                        dynamicCheckboxForReturn[
                                                            i] = true;
                                                        returnSelectSeatWithCheckBox
                                                            .add(returnSeatList[i]
                                                                .toString());
                                                        for (int i = 0;
                                                            i <
                                                                returnSelectSeatWithCheckBox
                                                                    .length;
                                                            i++) {
                                                        }
                                                      }
                                                    });
                                                  },
                                                ),
                                                Text(
                                                    '${returnSeatList[i].toString()}'),
                                              ],
                                            ),
                                          },
                                        ],
                                      ),
                                    }
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: Text(
                                      'Load',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: CommonConstants
                                            .FONT_FAMILY_OPEN_SANS_REGULAR,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (onwardSelectSeatWithCheckBox.length > 0 ||
                                          returnSelectSeatWithCheckBox.length > 0) {
                                        PartialCancellationDetailsApiCAll(
                                          apicall: '0',
                                          Type:
                                              returnSelectSeatWithCheckBox.length >
                                                      0
                                                  ? "1"
                                                  : "0",
                                          EmailID: xmlList[0]
                                              .getElement('CustEmail')!
                                              .text
                                              .toString(),
                                          FromCityID: xmlList[0]
                                              .getElement('FromCityId')!
                                              .text
                                              .toString(),
                                          JourneyDate: xmlList[0]
                                              .getElement('JourneyDate')!
                                              .text
                                              .toString(),
                                          PNRNo: xmlList[0]
                                              .getElement('PNRNo')!
                                              .text
                                              .toString(),
                                          SeatNo:
                                              onwardSeatNameString().toString(),
                                          ToCityID: xmlList[0]
                                              .getElement('ToCityId')!
                                              .text
                                              .toString(),
                                          EmailID_R:
                                              returnSelectSeatWithCheckBox.length >
                                                      0
                                                  ? xmlList[1]
                                                      .getElement('CustEmail')!
                                                      .text
                                                      .toString()
                                                  : '',
                                          FromCityID_R:
                                              returnSelectSeatWithCheckBox.length >
                                                      0
                                                  ? xmlList[1]
                                                      .getElement('FromCityId')!
                                                      .text
                                                      .toString()
                                                  : '',
                                          JourneyDate_R:
                                              returnSelectSeatWithCheckBox.length >
                                                      0
                                                  ? xmlList[1]
                                                      .getElement('JourneyDate')!
                                                      .text
                                                      .toString()
                                                  : '',
                                          PNRNo_R:
                                              returnSelectSeatWithCheckBox.length >
                                                      0
                                                  ? xmlList[1]
                                                      .getElement('PNRNo')!
                                                      .text
                                                      .toString()
                                                  : '',
                                          SeatNo_R: returnSelectSeatWithCheckBox
                                                      .length >
                                                  0
                                              ? returnSeatNameString().toString()
                                              : '',
                                          ToCityID_R:
                                              returnSelectSeatWithCheckBox.length >
                                                      0
                                                  ? xmlList[1]
                                                      .getElement('ToCityId')!
                                                      .text
                                                      .toString()
                                                  : '',
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(horizontal: 10)
                          },
                          const SizedBox(height: 10),
                          const Divider(thickness: 5.0, color: Colors.grey),
                          Container(
                            padding: const EdgeInsets.all(0.0),
                            margin: const EdgeInsets.all(0.0),
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: LablefirstWidt,
                                  color: Colors.grey,
                                  alignment: Alignment.center,
                                  child: Text('Total Refund Amount',
                                      style: lableTextStyle,
                                      textAlign: TextAlign.center),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                          'assets/images/ic_rs_white.png',
                                        ),
                                        color: Colors.blue,
                                      ),
                                      Container(
                                        child: Text('${TotalRefundAmt}'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Obx(() => CheckTermsAndConditionWidget()),
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text(
                                'Cancel Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily:
                                      CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                                ),
                              ),
                              onPressed: () {

                                if (_cancelOnwordTripCheckBoxPartial.isTrue) {
                                  if (_isValid1()) {

                                    PartialCancellationDetailsApiCAll(
                                      apicall: "1",
                                      Type:
                                      returnSelectSeatWithCheckBox.length >
                                          0
                                          ? "1"
                                          : "0",
                                      EmailID: xmlList[0]
                                          .getElement('CustEmail')!
                                          .text
                                          .toString(),
                                      FromCityID: xmlList[0]
                                          .getElement('FromCityId')!
                                          .text
                                          .toString(),
                                      JourneyDate: xmlList[0]
                                          .getElement('JourneyDate')!
                                          .text
                                          .toString(),
                                      PNRNo: xmlList[0]
                                          .getElement('PNRNo')!
                                          .text
                                          .toString(),
                                      SeatNo:
                                      onwardSeatNameString().toString(),
                                      ToCityID: xmlList[0]
                                          .getElement('ToCityId')!
                                          .text
                                          .toString(),
                                      EmailID_R:
                                      returnSelectSeatWithCheckBox.length >
                                          0
                                          ? xmlList[1]
                                          .getElement('CustEmail')!
                                          .text
                                          .toString()
                                          : '',
                                      FromCityID_R:
                                      returnSelectSeatWithCheckBox.length >
                                          0
                                          ? xmlList[1]
                                          .getElement('FromCityId')!
                                          .text
                                          .toString()
                                          : '',
                                      JourneyDate_R:
                                      returnSelectSeatWithCheckBox.length >
                                          0
                                          ? xmlList[1]
                                          .getElement('JourneyDate')!
                                          .text
                                          .toString()
                                          : '',
                                      PNRNo_R:
                                      returnSelectSeatWithCheckBox.length >
                                          0
                                          ? xmlList[1]
                                          .getElement('PNRNo')!
                                          .text
                                          .toString()
                                          : '',
                                      SeatNo_R: returnSelectSeatWithCheckBox
                                          .length >
                                          0
                                          ? returnSeatNameString().toString()
                                          : '',
                                      ToCityID_R:
                                      returnSelectSeatWithCheckBox.length >
                                          0
                                          ? xmlList[1]
                                          .getElement('ToCityId')!
                                          .text
                                          .toString()
                                          : '',
                                    );

                                  }
                                } else if (_cancelOnwordTripCheckBoxPartial.isFalse) {
                                  if (_isValid()) {
                                    dialogAlert();
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(
                                  10,
                                ),
                              ),
                            ),
                          ).paddingAll(10)
                        ],
                      ),
                    ),
                  ),
              ],
            ),
      ),
    );
  }

  Future<void> dialogAlert() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(10),
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Are you sure want to cancel this ticket ?',
                style: TextStyle(
                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                    fontSize: 16),
              ).paddingAll(10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5),
                      ),
                      child: const Text('No'),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        confirmCAncellationApicall(
                          OrderDetailsID: xmlList[0]
                              .getElement('OrderDetailID')!
                              .text
                              .toString(),
                          OrderNo: xmlList[0]
                              .getElement('M_OrderID')!
                              .text
                              .toString(),
                          PNRNo:
                              xmlList[0].getElement('PNRNo')!.text.toString(),
                          RefundAmount: _cancelReturnTripCheckBox.value
                              ? double.parse(xmlList[0]
                                          .getElement('RefundAmount')!
                                          .text
                                          .toString() +
                                      xmlList[1]
                                          .getElement('RefundAmount')!
                                          .text
                                          .toString())
                                  .toString()
                              : xmlList[0]
                                  .getElement('RefundAmount')!
                                  .text
                                  .toString(),
                          OrderDetailsID_Return: _cancelReturnTripCheckBox.value
                              ? xmlList[1]
                                  .getElement('OrderDetailID')!
                                  .text
                                  .toString()
                              : '',
                          PNRNo_Return: _cancelReturnTripCheckBox.value
                              ? xmlList[1].getElement('PNRNo')!.text.toString()
                              : '',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5),
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
    if (_cancelOnwordTripCheckBox.value != true &&
        _cancelReturnTripCheckBox.value != true) {
      ToastMsg(
          message: 'Please select onward or return journey to cancel trip');
      return false;
    } else if (_termsConditionCheckBox.value != true) {
      ToastMsg(message: 'Please agree to terms and condition');
      return false;
    }
    return true;
  }

  bool _isValid1() {
    if (onwardSelectSeatWithCheckBox.length < 1 ||
        returnSelectSeatWithCheckBox.length < 1) {
      ToastMsg(message: 'Please select minimum one seat ');
      return false;
    }
    return true;
  }

  void ToastMsg({required String message}) {
    SnackBar snackBar = SnackBar(
      content: Text(
        '$message',
        style: TextStyle(
          fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
          fontSize: 16,
        ),
      ),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget cancellationDetailsOnwordWidget() {
    double LablefirstWidt = 120;
    TextStyle lableTextStyle = TextStyle(
      fontSize: 15,
      color: Colors.white,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('PNR No', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                      '${xmlList[0].getElement('PNRNo')!.text.toString()}'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Name', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                      '${xmlList[0].getElement('CustName')!.text.toString()}' +
                          ' - ' +
                          xmlList[0].getElement('CustMobile')!.text.toString()),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Route', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                      '${xmlList[0].getElement('SubRoute')!.text.toString()}'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Journey On', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                      '${xmlList[0].getElement('JourneyDate')!.text.toString()}'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Seats', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                      '${xmlList[0].getElement('SeatNames')!.text.toString()}'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Amount', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Row(
                children: [
                  const Image(
                    image: AssetImage(
                      'assets/images/ic_rs_white.png',
                    ),
                    color: Colors.blue,
                  ),
                  Container(
                    child: Text(
                        '${xmlList[0].getElement('PNRAmount')!.text.toString()}'),
                  ),
                ],
              )),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Refund Amount', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/images/ic_rs_white.png',
                      ),
                      color: Colors.blue,
                    ),
                    Container(
                      //RefundAmount
                      child: Obx(
                        () => Text('${onwardRefundWithpercentage.value}'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 1),
      ],
    ).paddingAll(8);
  }

  Widget cancellationDetailsReturnWidget() {
    double LablefirstWidt = 120;
    TextStyle lableTextStyle = TextStyle(
      fontSize: 15,
      color: Colors.white,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('PNR No', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                      '${xmlList[1].getElement('PNRNo')!.text.toString()}'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Name', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                      '${xmlList[1].getElement('CustName')!.text.toString()}' +
                          ' - ' +
                          xmlList[1].getElement('CustMobile')!.text.toString()),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Route', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                      '${xmlList[1].getElement('SubRoute')!.text.toString()}'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Journey On', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                      '${xmlList[1].getElement('JourneyDate')!.text.toString()}'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Seats', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                      '${xmlList[1].getElement('SeatNames')!.text.toString()}'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Amount', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/images/ic_rs_white.png',
                      ),
                      color: Colors.blue,
                    ),
                    Container(
                      child: Text(
                          '${xmlList[1].getElement('PNRAmount')!.text.toString()}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Refund Amount', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  children: [
                    const Image(
                      image: AssetImage(
                        'assets/images/ic_rs_white.png',
                      ),
                      color: Colors.blue,
                    ),
                    Container(
                      child: Obx(
                        () => Text('${returnRefundWithpercentage.value}'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 1),
        const SizedBox(height: 10),
        const Divider(thickness: 5.0, color: Colors.grey),
      ],
    ).paddingAll(8);
  }

  Widget CheckTermsAndConditionWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: _termsConditionCheckBox.value,
            onChanged: (onchanged) {
              _termsConditionCheckBox.value = onchanged!;
            },
          ),
          Text(
            'I agree to ',
            style: TextStyle(
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
              color: Colors.red.shade600,
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
          ),
        ],
      ),
    );
  }

  Widget onwardCheckBoxWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: _cancelOnwordTripCheckBox.value,
            onChanged: (onchanged) {
              _cancelOnwordTripCheckBox.value = onchanged!;
              if (_cancelOnwordTripCheckBoxPartial.isFalse) {
                if (_cancelOnwordTripCheckBox.isTrue) {
                  setState(() {
                    TotalRefundAmt += onwardTotalRufundAmt;
                  });
                } else {
                  setState(() {
                    TotalRefundAmt -= onwardTotalRufundAmt;
                  });
                }
              }
            },
          ),
          Text(
            'Cancel Onword Trip ?',
            style: TextStyle(
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
              color: Colors.red.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget onwardPatialCancellWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: _cancelOnwordTripCheckBoxPartial.value,
            onChanged: (onchanged) {
              _cancelOnwordTripCheckBoxPartial.value = onchanged!;
              if (_cancelOnwordTripCheckBoxPartial.isTrue) {
                setState(() {
                  onwardRefundWithpercentage.value = '0.0';
                  returnRefundWithpercentage.value = '0.0';
                  _cancelReturnTripCheckBox.value = true;
                  _cancelOnwordTripCheckBox.value = true;
                });
              } else {
                if (xmlList.length > 1) {
                  setState(() {
                    returnTotalRufundAmt = double.parse(xmlList[1]
                            .getElement('RefundAmount')!
                            .text
                            .toString())
                        .toPrecision(2)
                        .toDouble();
                    dynamicCheckboxForReturn.clear();
                    for (int i = 0; i < returnSeatList.length; i++) {
                      dynamicCheckboxForReturn.add(false);
                    }
                  });

                  returnRefundWithpercentage.value =
                      '${double.parse(xmlList[1].getElement('RefundAmount')!.text.toString()).toPrecision(2)} (${double.parse(xmlList[1].getElement('RefundPer')!.text.toString()).toPrecision(2)} %)';
                }
                onwardRefundWithpercentage.value =
                    '${double.parse(xmlList[0].getElement('RefundAmount')!.text.toString()).toPrecision(2)} (${double.parse(xmlList[0].getElement('RefundPer')!.text.toString()).toPrecision(2)} %)';

                setState(() {
                  onwardTotalRufundAmt = double.parse(xmlList[0]
                          .getElement('RefundAmount')!
                          .text
                          .toString())
                      .toPrecision(2)
                      .toDouble();
                  dynamicCheckboxForOnword.clear();
                  for (int i = 0; i < onwardSeatList.length; i++) {
                    dynamicCheckboxForOnword.add(false);
                  }
                  TotalRefundAmt = onwardTotalRufundAmt + returnTotalRufundAmt;
                });
              }
            },
          ),
          Text(
            'Partial Cancel ?',
            style: TextStyle(
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
              color: Colors.red.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget ReturnCheckBoxWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Checkbox(
            value: _cancelReturnTripCheckBox.value,
            onChanged: (onchanged) {
              _cancelReturnTripCheckBox.value = onchanged!;
              if (_cancelReturnTripCheckBox.isTrue) {
                setState(() {
                  TotalRefundAmt += returnTotalRufundAmt;
                });
              } else {
                setState(() {
                  TotalRefundAmt -= returnTotalRufundAmt;
                });
              }
            },
          ),
          Text(
            'Cancel Return Trip ?',
            style: TextStyle(
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
              color: Colors.red.shade600,
            ),
          ),
        ],
      ),
    );
  }

  void getCancellationApiCall() {
    ApiImplementer.getCancellationPolicyApiImplementer()
        .then((XmlDocument document) {
      if (document != null) {
        bool xmlElement = document.findAllElements('NewDataSet').isNotEmpty;
        if (xmlElement) {
          if (document
                  .findAllElements('StatusMessage')
                  .first
                  .getElement('Status')!
                  .text
                  .compareTo("1") ==
              0) {
            setState(() {
              htmlWidget = document
                  .findAllElements('GetCancellationPolicy')
                  .first
                  .getElement('CancellationPolicy')!
                  .text;
            });
          }
        }
      }
    }).catchError((onError) {
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }

  void PartialConfirmCancellationApiCall({
    required String OrderDetailsID,
    required String OrderID,
    required String OrderNo,
    required String PNRNo,
    required String RefundAmount,
    required String SeatNo,
    required String OrderDetailsID_R,
    required String OrderID_R,
    required String OrderNo_R,
    required String PNRNo_R,
    required String RefundAmount_R,
    required String SeatNo_R,
  }) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.PartialConfirmCancellationApiImplementer(
      OrderDetailsID: OrderDetailsID.toString(),
      OrderID: OrderID,
      OrderNo: OrderNo,
      PNRNo: PNRNo,
      RefundAmount: RefundAmount,
      SeatNo: SeatNo,
      OrderDetailsID_R: OrderDetailsID_R,
      OrderID_R: OrderID_R,
      OrderNo_R: OrderNo_R,
      PNRNo_R: PNRNo_R,
      RefundAmount_R: RefundAmount_R,
      SeatNo_R: SeatNo_R,
    ).then((XmlDocument xmlDocument) {
      Get.back();
      bool xmlElement = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
      if (xmlElement) {
        if (xmlDocument
                .findAllElements('StatusMessage')
                .first
                .getElement('Status')!
                .text
                .compareTo("1") ==
            0) {
          List<XmlElement> element =
              xmlDocument.findAllElements('ConfirmCancellation').toList();
          // print(element[0].getElement('Message')!.text);
          // print(element[0].getElement('NewPNRNO')!.text);
          _alertBox(
              title: element[0].getElement('Message')!.text,
              barrierDismissible: true,
              cancelButton: false,
              OkButtonName: 'Okay',
              twoData: twoData,
              subtitle: twoData
                  ? 'New PNR No. onward :${"${element[0].getElement('NewPNRNO')!.text}\nNew PNR No. return :${element[1].getElement('NewPNRNO')!.text}"} '
                  : 'New PNR No.${element[0].getElement('NewPNRNO')!.text}',
              onTapYes: () {
                Get.offAllNamed(DashboardAppScreen.routeName);
              });
        } else if (xmlDocument
                .findAllElements('StatusMessage')
                .first
                .getElement('Status')!
                .text
                .compareTo("0") ==
            0) {

          _alertBox(
              title: xmlDocument
                  .findAllElements('StatusMessage')
                  .first
                  .getElement('StatusMessage')!
                  .text,
              twoData: twoData,
              barrierDismissible: true,
              cancelButton: false,
              OkButtonName: 'Okay',
              onTapYes: () {
                Get.back();
              });
        }
      }
    }).catchError((onError) {
      Get.back();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }

  Future<void> _alertBox({
    required bool barrierDismissible,
    required String title,
    String subtitle = '',
    String? cancelButtonName,
    required String OkButtonName,
    required bool cancelButton,
    required Function onTapYes,
    Function? onTapNo,
    required bool twoData,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(30),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Wrap(
                children: [
                  Text(
                    '$title',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$subtitle',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (cancelButton) ...{
                    OutlinedButton(
                      onPressed: () => onTapNo!(),
                      child: Text('$cancelButtonName'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black54),
                      ),
                    ),
                  },
                  OutlinedButton(
                    onPressed: () => onTapYes(),
                    child: Text('$OkButtonName'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black54),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void PartialCancellationDetailsApiCAll({
    required String apicall,
    required String Type,
    required String EmailID,
    required String FromCityID,
    required String JourneyDate,
    required String PNRNo,
    required String SeatNo,
    required String ToCityID,
    required String EmailID_R,
    required String FromCityID_R,
    required String JourneyDate_R,
    required String PNRNo_R,
    required String SeatNo_R,
    required String ToCityID_R,
  }) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.PartialCancellationDetailsApiImplementer(
      Type: Type,
      EmailID: EmailID,
      FromCityID: FromCityID,
      JourneyDate: JourneyDate,
      PNRNo: PNRNo,
      SeatNo: SeatNo,
      ToCityID: ToCityID,
      EmailID_R: EmailID_R,
      FromCityID_R: FromCityID_R,
      JourneyDate_R: JourneyDate_R,
      PNRNo_R: PNRNo_R,
      SeatNo_R: SeatNo_R,
      ToCityID_R: ToCityID_R,
    ).then((XmlDocument xmlDocument) {
      Get.back();
      bool xmlElement = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
      if (xmlElement) {
        List<XmlElement> element =
            xmlDocument.findAllElements('CancellationDetails').toList();

        onwardRefundWithpercentage.value =
            '${double.parse(element[0].getElement('RefundAmount')!.text.toString()).toPrecision(2)} (${double.parse(element[0].getElement('RefundPer')!.text.toString()).toPrecision(2)} %)';

        setState(() {
          TotalRefundAmt = double.parse(
                  element[0].getElement('RefundAmount')!.text.toString())
              .toPrecision(2)
              .toDouble();
          onwardCancelOrderDetailsID =
              '${element[0].getElement('OrderDetailID')!.text.toString()}';
          onworsCancelOrderID =
              '${element[0].getElement('OrderID')!.text.toString()}';
          OnwordCancelOrderNo =
              '${element[0].getElement('M_OrderID')!.text.toString()}';
          onwardCalcelPNRNo =
              '${element[0].getElement('PNRNo')!.text.toString()}';
          onwardCancelRefundAmount =
              '${element[0].getElement('RefundAmount')!.text.toString()}';
          onwardCancelSeatNo =
              '${element[0].getElement('Cancel_SeatList')!.text.toString()}';

        });

        if (element.length > 1) {
          twoData = true;

          returnTotalRufundAmt = double.parse(
                  element[1].getElement('RefundAmount')!.text.toString())
              .toPrecision(2)
              .toDouble();
          returnRefundWithpercentage.value =
              '${double.parse(element[1].getElement('RefundAmount')!.text.toString()).toPrecision(2)} (${double.parse(element[1].getElement('RefundPer')!.text.toString()).toPrecision(2)} %)';

          setState(() {
            TotalRefundAmt = TotalRefundAmt + returnTotalRufundAmt;
            returnCancelOrderDetailsID =
                '${element[1].getElement('OrderDetailID')!.text.toString()}';
            returnCancelOrderID =
                '${element[1].getElement('OrderID')!.text.toString()}';
            returnCancelOrderNo =
                '${element[1].getElement('M_OrderID')!.text.toString()}';
            returnCalcelPNRNo =
                '${element[1].getElement('PNRNo')!.text.toString()}';
            returnCancelRefundAmount =
                '${element[1].getElement('RefundAmount')!.text.toString()}';
            returnCancelSeatNo =
                '${element[1].getElement('Cancel_SeatList')!.text.toString()}';

          });
        } else {}

      }
    }).catchError((onError) {
      Get.back();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);

    }).then((value) {
      if(apicall == "1")
        {
          PartialConfirmCancellationApiCall(
            OrderDetailsID: onwardCancelOrderDetailsID,
            OrderID: onworsCancelOrderID,
            OrderNo: OnwordCancelOrderNo,
            PNRNo: onwardCalcelPNRNo,
            RefundAmount: onwardCancelRefundAmount,
            SeatNo: onwardCancelSeatNo,
            OrderDetailsID_R:
            twoData ? returnCancelOrderDetailsID : "",
            OrderID_R: twoData ? returnCancelOrderID : "",
            OrderNo_R: twoData ? returnCancelOrderNo : "",
            PNRNo_R: twoData ? returnCalcelPNRNo : "",
            RefundAmount_R:
            twoData ? returnCancelRefundAmount : "",
            SeatNo_R: twoData ? returnCancelSeatNo : "",
          );
        }
    });
  }

  void confirmCAncellationApicall({
    required String OrderDetailsID,
    required String OrderNo,
    required String PNRNo,
    required String RefundAmount,
    required String OrderDetailsID_Return,
    required String PNRNo_Return,
  }) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.ConfirmCancellationApiImplementer(
            OrderDetailsID: OrderDetailsID,
            OrderNo: OrderNo,
            PNRNo: PNRNo,
            RefundAmount: RefundAmount,
            OrderDetailsID_Return: OrderDetailsID_Return,
            PNRNo_Return: PNRNo_Return)
        .then((XmlDocument xmlDocument) {
      Navigator.of(context).pop();
      if (!xmlDocument.isNull) {
        debugPrint('$xmlDocument');

        bool xmlElement = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
        if (xmlElement) {
          if (xmlDocument
                  .findAllElements('StatusMessage')
                  .first
                  .getElement('Status')!
                  .text
                  .compareTo("1") ==
              0) {
            finalresponse.value = true;
            RefundStatusMsg = xmlDocument
                .findAllElements('CancellationDetails')
                .first
                .getElement('RefundStatusMsg')!
                .text;
            StatusMsg = xmlDocument
                .findAllElements('CancellationDetails')
                .first
                .getElement('StatusMsg')!
                .text;
          } else if (xmlDocument
                  .findAllElements('StatusMessage')
                  .first
                  .getElement('Status')!
                  .text
                  .compareTo("0") ==
              0) {
          }
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }
}
