import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/moduals/screens/verification_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:xml/xml.dart';

import '../../utils/ui/ui_utils.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = '/registration_screen';


  String? mobileNo;
  RegistrationScreen({this.mobileNo});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController primary_name_textEditing = new TextEditingController();
  TextEditingController primary_email_textEditing = new TextEditingController();
  TextEditingController primary_mobile_textEditing =
      new TextEditingController();

  TextEditingController primary_password_textEditing =
      new TextEditingController();
  TextEditingController primary_confirm_password_textEditing =
      new TextEditingController();

  bool _obscureText = true;
  String? gender;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.mobileNo!=null){
       primary_mobile_textEditing =
      new TextEditingController(text: widget.mobileNo!);
      //primary_mobile_textEditing.text=;
    }

    if(GetPlatform.isIOS){
      gender = 'Male';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        centerTitle: false,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: new Text(
          'User Registration',
          style: const TextStyle(
            fontSize: 18,
            letterSpacing: 0.5,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
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
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
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
                    controller: primary_mobile_textEditing,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(10)],
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Mobile No.',
                      labelStyle: TextStyle(
                        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                        fontSize: 16,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
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
                        fontSize: 16,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Visibility(
                    visible: GetPlatform.isAndroid ? true : false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily:
                                CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          ),
                        ),
                        Transform.scale(
                          scale: 1,
                          child: Radio(
                              value: "Male",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                });
                              }),
                        ),
                        const Text(
                          'Male',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily:
                                CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          ),
                        ),
                        Transform.scale(
                          scale: 1,
                          child: Radio(
                              value: "Female",
                              groupValue: gender,
                              onChanged: (value) {
                                setState(() {
                                  gender = value.toString();
                                });
                              }),
                        ),
                        const Text(
                          'Female',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily:
                                CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: primary_password_textEditing,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: InkWell(
                        onTap: _toggle,
                        child: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                      labelStyle: const TextStyle(
                        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                        fontSize: 16,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                    ),
                  ),
                  TextFormField(
                    controller: primary_confirm_password_textEditing,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                        fontSize: 16,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 15),
                    child: ElevatedButton(
                      child: Text(
                        'Registration'.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                      ),
                      onPressed: () {
                        if (_isValid()) {
                          _hideKeyBoard();
                          registrationApiCall(
                              EmailID: primary_email_textEditing.text.trim().toString(),
                              Gender: gender!,
                              MobileNo: primary_mobile_textEditing.text.trim().toString(),
                              Name: primary_name_textEditing.text.trim().toString(),
                              Password: primary_password_textEditing.text.trim().toString());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _hideKeyBoard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
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
        Password: Password).then((XmlDocument xmlDocument) {
      Navigator.of(context).pop();
      if(!xmlDocument.isNull) {
         bool element = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
         if (element) {
          if (xmlDocument.findAllElements('ApplicationRegistration').first.getElement('Status')!.text.compareTo("1") == 0) {
            // print('object1');
            // Future.delayed(Duration(milliseconds: 100), () {
              getLoginOtpApiCall();
            // },);
          }
          else if (xmlDocument.findAllElements('ApplicationRegistration').first.getElement('Status')!.text.compareTo("0") == 0) {
            showToastMsg('Mobile number already registered.');
            // showToastMsg(xmlDocument.findAllElements('ApplicationRegistration').first.getElement('StatusMessage')!.text.toString());
          } else {
            showToastMsg('Something went wrong.');
          }
        }
      }
    }).catchError((onError) {
      print('onError===>$onError');
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }

  Future<void> getLoginOtpApiCall() async {
    // AppDialogs.showProgressDialog(context: context);
    ApiImplementer.getOTPLoginApiImplementer(
      CustMobile: primary_mobile_textEditing.text.toString(),
    ).then((XmlDocument xmlDocument) {
      // Navigator.of(context).pop();
      if (!xmlDocument.isNull) {
        bool xmlElement = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
        if (xmlElement) {
          if (xmlDocument.findAllElements('Status').first.getElement('Status')!.text.compareTo("1") == 0) {
            // UiUtils.successSnackBar(message: 'OTP Sent Successfully.').show();
            var otpText = xmlDocument.findAllElements('GetDetails').first.getElement('VerificationCode1')!.text;
            XmlElement loginDataElement = xmlDocument.findAllElements('GetDetails').first;
            print('otpTextR: ${otpText}');
            Navigator.of(context).pushNamed(
                VerificationScreen.routeName, arguments: {
              NavigatorConstants.ENTERED_MOBILE_NO: primary_mobile_textEditing
                  .text.toString(),
              NavigatorConstants.ENTERED_USER_NAME: primary_name_textEditing
                  .text.toString(),
              NavigatorConstants.ENTERED_EMAIL: primary_email_textEditing.text
                  .toString(),
              NavigatorConstants.ENTERED_PASSWORD: primary_password_textEditing
                  .text.toString(),
              NavigatorConstants.ENTERED_GENDER: gender!.toString(),
            });

          } else {
            UiUtils.errorSnackBar(message: 'Invalid Mobile Number. ${xmlDocument.findAllElements('Status').first.getElement('StatusMessage')!.text}').show();
          }
        }
      }
    }).catchError((onError) {
      // Navigator.of(context).pop();
    });
  }

  void showToastMsg(String msg) {
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: const TextStyle(fontSize: 16),
      ),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool _isValid() {
    if (primary_name_textEditing.text.isEmpty) {
      showToastMsg('Please enter username');
      return false;
    } else if (primary_mobile_textEditing.text.isEmpty) {
      showToastMsg('Please enter phone no.');
      return false;
    } else if (primary_mobile_textEditing.text.length != 10) {
      showToastMsg('Please enter valid phone no.');
      return false;
    } else if (primary_email_textEditing.text.isEmpty) {
      showToastMsg('Please enter email');
      return false;
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(primary_email_textEditing.text)) {
      showToastMsg('Please enter valid email');
      return false;
    } else if (gender == null) {
      showToastMsg('Please select gender');
      return false;
    } else if (primary_password_textEditing.text.isEmpty) {
      showToastMsg('Please enter password');
      return false;
    } else if (primary_confirm_password_textEditing.text.isEmpty) {
      showToastMsg('Please enter confirm password');
      return false;
    } else if (primary_password_textEditing.text !=
        primary_confirm_password_textEditing.text) {
      showToastMsg('password does not match');
      return false;
    }
    return true;
  }

  void _showRegistrationResponseDialog(
      {required BuildContext context,
      required String Msg,
      required Function function}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
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
              onPressed: function(),
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
}
