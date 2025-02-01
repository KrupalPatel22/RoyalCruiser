import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/moduals/screens/pnr_html_widget_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:xml/xml.dart';

class PNREnquiryScreen extends StatefulWidget {
  static const routeName = '/pnr_enquiry_screen';

  const PNREnquiryScreen({Key? key}) : super(key: key);

  @override
  State<PNREnquiryScreen> createState() => _PNREnquiryScreenState();
}

class _PNREnquiryScreenState extends State<PNREnquiryScreen> {
  TextEditingController primary_pnr_textEditing =new TextEditingController();
  TextEditingController primary_captha_textEditing = new TextEditingController();
  TextEditingController primary_OTP_textEditing = new TextEditingController();

  String MobileOTP = '';
  String HtmlWidgetData = '';
  String randomCode = '';

  RxBool _otpTextfield = false.obs;
  RxBool _resendOtpButton = false.obs;
  RxBool _isLoading = false.obs;

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  void initState() {
    getData().then((value) => _isLoading.value = true);
    super.initState();
  }

  Future<void> getData() async {
    randomCode = randomString();
  }

  String randomString() {
    var random = getRandomString(5);
    return random;
  }
@override
  void dispose() {
  primary_pnr_textEditing.clear();
  primary_captha_textEditing.clear();
  primary_OTP_textEditing.clear();
    // TODO: implement dispose
    super.dispose();
  }
  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        centerTitle: false,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: new Text(
          'PNR Enquiry ',
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 0.5,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
          ),
        ),
      ),
      body: Obx(
        () => _isLoading.value
            ? Stack(
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
                          Card(
                            margin: EdgeInsets.all(5),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    controller: primary_pnr_textEditing,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      labelText: 'Enter PNR No.',
                                      prefixIcon:
                                          const Icon(Icons.format_list_numbered_rounded),
                                      labelStyle: TextStyle(
                                        fontFamily: CommonConstants
                                            .FONT_FAMILY_OPEN_SANS_REGULAR,
                                        fontSize: 16,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: CommonConstants
                                          .FONT_FAMILY_OPEN_SANS_REGULAR,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    'Retype the caracter from the picture',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: CommonConstants
                                          .FONT_FAMILY_OPEN_SANS_BOLD,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/bannerbg.png'),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '$randomCode',
                                          style: TextStyle(
                                              fontFamily: CommonConstants
                                                  .FONT_FAMILY_OPEN_SANS_BOLD,
                                              fontSize:
                                                  18,
                                              color: Colors.red,
                                              letterSpacing: 2.0),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              randomCode = randomString();
                                            });
                                          },
                                          icon: const Icon(Icons.refresh),
                                        )
                                      ],
                                    ),
                                  ),
                                  TextFormField(
                                    controller: primary_captha_textEditing,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(RegExp(r'\s')), // Deny any whitespace character
                                    ],
                                    decoration: InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      labelText: 'Type Here Captcha.',

                                      prefixIcon: const Icon(Icons.qr_code_sharp),
                                      labelStyle: TextStyle(
                                        fontFamily: CommonConstants
                                            .FONT_FAMILY_OPEN_SANS_REGULAR,
                                        fontSize: 16,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: CommonConstants
                                          .FONT_FAMILY_OPEN_SANS_REGULAR,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Obx(
                                    () => Visibility(
                                      visible: _otpTextfield.value,
                                      child: TextFormField(
                                        controller: primary_OTP_textEditing,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: const UnderlineInputBorder(),
                                          labelText: 'Enter OTP Here',
                                          prefixIcon: const Icon(Icons.sms_outlined),
                                          labelStyle: TextStyle(
                                            fontFamily: CommonConstants
                                                .FONT_FAMILY_OPEN_SANS_REGULAR,
                                            fontSize: 16,
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: CommonConstants
                                              .FONT_FAMILY_OPEN_SANS_REGULAR,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    child: Text(
                                      'Reset',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: CommonConstants
                                            .FONT_FAMILY_OPEN_SANS_BOLD,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        randomCode = randomString();
                                        primary_captha_textEditing.text = '';
                                        primary_pnr_textEditing.text = '';
                                        primary_OTP_textEditing.text = '';
                                        _otpTextfield.value = false;
                                        _resendOtpButton.value = false;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: ElevatedButton(
                                    child: Text(
                                      'Verify PNR',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: CommonConstants
                                            .FONT_FAMILY_OPEN_SANS_BOLD,
                                      ),
                                    ),
                                    onPressed: () {
                                      verifyPNROnTap();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () => Visibility(
                              visible: _resendOtpButton.value,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                width: double.infinity,
                                child: ElevatedButton(
                                  child: Text(
                                    'Resend OTP',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: CommonConstants
                                          .FONT_FAMILY_OPEN_SANS_BOLD,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      primary_OTP_textEditing.text = '';
                                    });
                                    _hideKeyBoard();
                                    CheckValidPNRNOAndFetchTicketPrintDataApiCall(
                                      PNRNo: primary_pnr_textEditing.text
                                          .trim()
                                          .toString(),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            )
            : Container(),
      ),
    );
  }

  void ToastMsg({required String message}) {
    SnackBar snackBar = SnackBar(
      content: Text(
        '$message',
        style: TextStyle(
          fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
          fontSize: 14,
        ),
      ),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool _isValid() {
    if (primary_pnr_textEditing.text.isEmpty) {
      ToastMsg(message: 'Enter PNR No.');
      return false;
    } else if (primary_captha_textEditing.text.isEmpty) {
      ToastMsg(message: 'Enter Captcha Code');
      return false;
    } else if (primary_captha_textEditing.text.compareTo(randomCode) != 0) {
      ToastMsg(message: 'Enter Valid Captcha Code');
      return false;
    }
    // else if (primary_mobile_textEditing.text.length != 10) {
    //   ToastMsg(message: 'Please enter valid mobile no.');
    //   return false;
    // } else if (_termsConditionCheckBox.value != true) {
    //   ToastMsg(message: 'Please agree to terms and condition');
    //   return false;
    // }
    return true;
  }

  bool _isValidOTP() {
    if (primary_OTP_textEditing.text.isEmpty) {
      ToastMsg(message: 'Please enter OTP Here');
      return false;
    } else if (primary_OTP_textEditing.text.compareTo(MobileOTP) != 0) {
      ToastMsg(message: 'Enter Valid OTP');
      return false;
    }
    return true;
  }

  void verifyPNROnTap() {
    if (_otpTextfield.isFalse) {
      if (_isValid()) {
        _hideKeyBoard();
        CheckValidPNRNOAndFetchTicketPrintDataApiCall(
            PNRNo: primary_pnr_textEditing.text.trim().toString());
      }
    } else if (_otpTextfield.isTrue) {
      if (_isValid() && _isValidOTP()) {

        Get.toNamed(PNRhtmlScreen.routeName,arguments: HtmlWidgetData);
      }
    }
  }

  void _hideKeyBoard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void CheckValidPNRNOAndFetchTicketPrintDataApiCall({
    required String PNRNo,
  }) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.CheckValidPNRNOAndFetchTicketPrintDataApiImplementer(
            PNRNo: PNRNo)
        .then((XmlDocument xmlDocument) {
      Get.back();
      bool xmlElement = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
      if (xmlElement) {
        if (xmlDocument
                .findAllElements('StatusMessage')
                .first
                .getElement('Status')!
                .text
                .toString()
                .compareTo("1") ==
            0) {
          if (xmlDocument
                  .findAllElements('IB2C_CheckValidPNRNO')
                  .first
                  .getElement('StatusID')!
                  .text
                  .toString()
                  .compareTo("1") ==
              0) {
            String OTP = xmlDocument
                .findAllElements('IB2C_FetchTicketPrintOTP')
                .first
                .getElement('OTP')!
                .text
                .toString();

            String ticketData = xmlDocument
                .findAllElements('IB2C_AppTicketPrintData')
                .first
                .getElement('AppTicketPrintData')!
                .text
                .toString();

            setState(() {
              _otpTextfield.value = true;
              _resendOtpButton.value = true;
              MobileOTP = OTP;
              HtmlWidgetData = ticketData;
              print(MobileOTP);
              print(HtmlWidgetData);
            });

          }
        }
        else {

          ToastMsg(message: xmlDocument
              .findAllElements('StatusMessage')
              .first
              .getElement('StatusMessage')!
              .text
              .toString());

        }
      }
    }).catchError((onError) {
      Get.back();
      print(onError);
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }
}
