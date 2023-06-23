import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/preferences_costances.dart';
import 'package:royalcruiser/main.dart';
import 'package:royalcruiser/moduals/screens/dashboard_screen.dart';
import 'package:royalcruiser/moduals/screens/forgot_password_screen.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/moduals/screens/registration_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:royalcruiser/utils/ui/ui_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml/xml.dart';

import '../../constants/color_constance.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';
  final String? appTitle;

  const LoginScreen({Key? key, this.appTitle}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SharedPreferences? _sharedPreferences;
  TextEditingController primary_email_textEditing = new TextEditingController();
  TextEditingController primary_password_textEditing =
      new TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    primary_email_textEditing.dispose();
    primary_password_textEditing.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
          '${widget.appTitle ?? "Login"}',
          style: const TextStyle(
            fontSize: 18,
            letterSpacing: 0.5,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
          ),
        ),
      ),
      body: Stack(
        children: [

          Container(
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
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Forgot Password ?',
                      style: TextStyle(
                          fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      if (_isValid()) {
                        _hideKeyBoard();
                        LoginApiCall(
                          email: primary_email_textEditing.text.trim().toString(),
                          password:
                              primary_password_textEditing.text.trim().toString(),
                        );
                      }
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'New User ?',
                        style: TextStyle(
                            fontFamily:
                                CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                            fontSize: 16),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RegistrationScreen.routeName);
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: const Text(
                            'SIGN UP',
                            style: TextStyle(
                              color: CustomeColor.main_bg,
                              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                              fontSize: 16,
                            ),
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
    );
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

  bool _isValid() {
    if (primary_email_textEditing.text.isEmpty) {
      //showToastMsg('Please Enter Email');
      UiUtils.errorSnackBar(message: 'Please Enter Email').show();
      return false;
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(primary_email_textEditing.text)) {
      // showToastMsg('Please enter valid email');
      UiUtils.errorSnackBar(message: 'Please enter valid email').show();
      return false;
    } else if (primary_password_textEditing.text.isEmpty) {
      // showToastMsg('Please enter password');
      UiUtils.errorSnackBar(message: 'Please enter password').show();
      return false;
    }
    return true;
  }

  void LoginApiCall({required String email, required String password}) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.MyBookingLoginApiImplementer(EmailID: email, Password: password)
        .then((XmlDocument xmlDocument) {
      Navigator.of(context).pop();
      if (!xmlDocument.isNull) {
        bool xmlElement = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
        if (xmlElement) {
          if (xmlDocument.findAllElements('StatusMessage').first.getElement('Status')!.text.compareTo("1") == 0) {
            setDataFromApi(
                xmlElement: xmlDocument.findAllElements('LoginDetails').first);
            Get.offAllNamed(DashboardAppScreen.routeName);
          } else if (xmlDocument
                  .findAllElements('StatusMessage')
                  .first
                  .getElement('Status')!
                  .text
                  .compareTo("0") ==
              0) {
            // showToastMsg('Invalide username or password');
            UiUtils.errorSnackBar(message: 'Invalide username or password')
                .show();
          }
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
      print('MyBookingLoginApiImplementeronError===>$onError');
    });
  }

  void _hideKeyBoard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Future<void> setDataFromApi({required XmlElement xmlElement}) async {
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
        primary_password_textEditing.text.trim().toString();

    _sharedPreferences!.setString(
        Preferences.CUST_ID, xmlElement.getElement('CustID')!.text.toString());
    _sharedPreferences!.setString(Preferences.CUST_NAME,
        xmlElement.getElement('CustName')!.text.toString());
    _sharedPreferences!.setString(Preferences.CUST_EMAIL,
        xmlElement.getElement('CustEmail')!.text.toString());
    _sharedPreferences!.setString(Preferences.CUST_PHONE,
        xmlElement.getElement('CustMobile')!.text.toString());
    _sharedPreferences!.setString(Preferences.CUST_PASSWORD,
        primary_password_textEditing.text.trim().toString());

    // print({
    //   'Shared____CUST_ID==>${_sharedPreferences!.getString(Preferences.CUST_ID)}'
    // });
    // print({
    //   'Shared____CUST_NAME==>${_sharedPreferences!.getString(Preferences.CUST_NAME)}'
    // });
    // print({
    //   'Shared____CUST_EMAIL==>${_sharedPreferences!.getString(Preferences.CUST_EMAIL)}'
    // });
    // print({
    //   'Shared____CUST_PHONE==>${_sharedPreferences!.getString(Preferences.CUST_PHONE)}'
    // });
    // print({
    //   'Shared____CUST_PASSWORD==>${_sharedPreferences!.getString(Preferences.CUST_PASSWORD)}'
    // });

    print('USER_ID====>${NavigatorConstants.USER_ID}');
    print('USER_NAME====>${NavigatorConstants.USER_NAME}');
    print('USER_EMAIL====>${NavigatorConstants.USER_EMAIL}');
    print('USER_PHONE====>${NavigatorConstants.USER_PHONE}');
    print('USER_PASSWORD====>${NavigatorConstants.USER_PASSWORD}');
  }
}
