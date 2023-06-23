import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/preferences_costances.dart';
import 'package:royalcruiser/moduals/screens/dashboard_screen.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

import '../../utils/ui/ui_utils.dart';

class VerificationScreen extends StatefulWidget {
  static const String routeName = '/verification_screen';

  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  SharedPreferences? _sharedPreferences;
  final RxBool _isLoading = false.obs;
  String custPhone = '';
  String custName = '';
  String custEmail = '';
  String custPassword = '';
  String custGender = '';
  final TextEditingController _text_OTP_controller = TextEditingController();

  @override
  void intialState() {
    _isLoading.value = true;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    Map<String, Object> rcvData = ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    custPhone = rcvData[NavigatorConstants.ENTERED_MOBILE_NO] as String;
    custName = rcvData[NavigatorConstants.ENTERED_USER_NAME] as String;
    custEmail = rcvData[NavigatorConstants.ENTERED_EMAIL] as String;
    custPassword = rcvData[NavigatorConstants.ENTERED_PASSWORD] as String;
    custGender = rcvData[NavigatorConstants.ENTERED_GENDER] as String;
    print('custPhone ${custPhone}');
    print('custName ${custName}');
    print('custEmail ${custEmail}');
    print('custPassword ${custPassword}');
    // getLoginOtpApiCall();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: const Text('User Verification'),
      ),
      body: /*Obx(
        () => _isLoading.value
            ? Container(
          child:  Text('faik'),
        )
            : */
      SizedBox(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: size.height * 0.01,),
                      Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: const FittedBox(
                            child: Text(
                              "Your verification code is sent to given mobile no. by SMS.\n"
                              "Please enter it below to confirm signup.",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: CustomeColor.sub_bg,
                                  fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01,),
                      Container(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: Colors.black54,
                              ),
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: size.height * 0.01,),
                                  Card(
                                    elevation: 5,
                                    child: Container(
                                      margin: const EdgeInsets.all(10),
                                      width: size.width,
                                      child: Text(
                                        custPhone,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.01,),
                                  Card(
                                    elevation: 5,
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: 16),
                                      controller: _text_OTP_controller,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Enter OTP',
                                        hintStyle: TextStyle(fontSize: 16, letterSpacing: 2.0),
                                        prefixIcon: Icon(Icons.smartphone_sharp),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 1,),
                                ],
                              ),
                            ),
                            const SizedBox(height: 1,),
                            Submit_OTP(),
                            Resend_OTP(),
                            // Change_Mobile_Number()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      /*),*/
    );
  }

  Widget Submit_OTP() {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Card(
        color: CustomeColor.sub_bg,
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Container(
          width: size.width,
          padding: const EdgeInsets.all(15),
          child: const Text('Submit',
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: 1.0,
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onTap: () {
        if (_isValid()) {
          applicationVerifyCallApi(
            MobileNo: custPhone,
            EmailID: custEmail,
            VerificationCode: _text_OTP_controller.text.trim().toString(),
          );
        }
      },
    );
  }

  bool _isValid() {
    if (_text_OTP_controller.text.isEmpty) {
      showToastMsg('Please Enter OTP');
      return false;
    }
    return true;
  }

  Widget Resend_OTP() {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Card(
        color: CustomeColor.sub_bg,
        elevation: 5,
        margin: const EdgeInsets.all(10),
        child: Container(
          width: size.width,
          padding: const EdgeInsets.all(15),
          child: const Text(
            'Resend Verification Code',
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: 1.0,
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onTap: () {
       /* registrationApiCall(
          EmailID: custEmail,
          Gender: custGender,
          MobileNo: custPhone,
          Name: custName,
          Password: custPassword,
        );*/
        getLoginOtpApiCall();
      },
    );
  }

  void applicationVerifyCallApi({
    required String EmailID,
    required String MobileNo,
    required String VerificationCode,
  }) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.getApplicationVerifyVerificationCode(
            EmailID: EmailID,
            MobileNo: MobileNo,
            VerificationCode: VerificationCode)
        .then((XmlDocument xmlDocument) {
      Navigator.of(context).pop();
      if (!xmlDocument.isNull) {
        bool element = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
        if (element) {
          if (xmlDocument.findAllElements('ApplicationVerifyVerificationCode').first.getElement('Status')!.text.compareTo("1") == 0) {
                _showVerificationResponseDialog(
                  context: context,
                  Msg: xmlDocument.findAllElements('ApplicationVerifyVerificationCode').first.getElement('StatusMessage')!.text,
                  function: () {
                    LoginApiCall(email: custEmail, password: custPassword);
                  },
                );
          } else if (xmlDocument.findAllElements('ApplicationVerifyVerificationCode').first.getElement('Status')!.text.compareTo("0") == 0) {
            _showVerificationResponseDialog(Msg: 'Invalid OTP', context: context, function: () {
              Get.back();
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

  void _showVerificationResponseDialog(
      {required BuildContext context,
      required String Msg,
      required Function function})  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(30),
        title: Text(
          Msg,
          style: const TextStyle(
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
          ),
        ),
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: CustomeColor.sub_bg),
            child: ElevatedButton(
              onPressed: () => function(),
              child: const Text(
                'Okay',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
        ],
      ),
    );
  }

  void registrationApiCall({
    required String EmailID,
    required String Gender,
    required String MobileNo,
    required String Name,
    required String Password,
  }) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.geAppRegApiImplementer(
            EmailID: EmailID,
            Gender: Gender,
            MobileNo: MobileNo,
            Name: Name,
            Password: Password,)
        .then((XmlDocument xmlDocument) {
      Navigator.of(context).pop();
      if (!xmlDocument.isNull) {
        bool element = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
        if (element) {
          if (xmlDocument.findAllElements('ApplicationRegistration').first.getElement('Status')!.text.compareTo("1") == 0) {
            _showVerificationResponseDialog(
                context: context,
                Msg: 'Successfully Send OTP',
                function: () {
                  Get.back();
                });
          }
        }
      }
    }).catchError((onError) {
      print('onError===>$onError');
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }

  void getLoginOtpApiCall() {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.getOTPLoginApiImplementer(
      CustMobile: custPhone.toString(),
    ).then((XmlDocument xmlDocument) {
      Navigator.of(context).pop();
      if (!xmlDocument.isNull) {
        bool xmlElement = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
        if (xmlElement) {
          if (xmlDocument.findAllElements('Status').first.getElement('Status')!.text.compareTo("1") == 0) {
            // UiUtils.successSnackBar(message: 'OTP Sent Successfully.').show();
              var otpText = xmlDocument.findAllElements('GetDetails').first.getElement('VerificationCode1')!.text;
              XmlElement loginDataElement = xmlDocument.findAllElements('GetDetails').first;
              print('otpTextV: ${otpText}');
          } else {
            UiUtils.errorSnackBar(message: 'Invalid Mobile Number. ${xmlDocument.findAllElements('Status').first.getElement('StatusMessage')!.text}').show();
          }
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
    });
  }

  void LoginApiCall({required String email, required String password}) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.MyBookingLoginApiImplementer(EmailID: email, Password: password).then((XmlDocument xmlDocument) {
      Navigator.of(context).pop();
      if (!xmlDocument.isNull) {
        bool xmlElement = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
        if (xmlElement) {
          if (xmlDocument.findAllElements('StatusMessage').first.getElement('Status')!.text.compareTo("1") == 0) {
            setDataFromApi(xmlElement: xmlDocument.findAllElements('LoginDetails').first);
            Get.offAllNamed(DashboardAppScreen.routeName);
          } else if (xmlDocument.findAllElements('StatusMessage').first.getElement('Status')!.text.compareTo("0") == 0) {
            showToastMsg('Invalid username or password');
          }
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
      print('login===>$onError');
    });
  }

  void showToastMsg(String msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: const TextStyle(fontSize: 16),
      ),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> setDataFromApi({required XmlElement xmlElement}) async {
    _sharedPreferences = await SharedPreferences.getInstance();
    NavigatorConstants.USER_ID = xmlElement.getElement('CustID')!.text.toString();
    NavigatorConstants.USER_NAME = xmlElement.getElement('CustName')!.text.toString();
    NavigatorConstants.USER_EMAIL = xmlElement.getElement('CustEmail')!.text.toString();
    NavigatorConstants.USER_PHONE = xmlElement.getElement('CustMobile')!.text.toString();
    NavigatorConstants.USER_PASSWORD = custPassword.trim().toString();

    setState(() {
      _sharedPreferences!.setString(Preferences.CUST_ID, xmlElement.getElement('CustID')!.text.toString());
      _sharedPreferences!.setString(Preferences.CUST_NAME, xmlElement.getElement('CustName')!.text.toString());
      _sharedPreferences!.setString(Preferences.CUST_EMAIL, xmlElement.getElement('CustEmail')!.text.toString());
      _sharedPreferences!.setString(Preferences.CUST_PHONE, xmlElement.getElement('CustMobile')!.text.toString());
      _sharedPreferences!.setString(Preferences.CUST_PASSWORD, custPassword.trim().toString());
    });

    print('USER_ID====>${NavigatorConstants.USER_ID}');
    print('USER_NAME====>${NavigatorConstants.USER_NAME}');
    print('USER_EMAIL====>${NavigatorConstants.USER_EMAIL}');
    print('USER_PHONE====>${NavigatorConstants.USER_PHONE}');
    print('USER_PASSWORD====>${NavigatorConstants.USER_PASSWORD}');
  }
}
