import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:xml/xml.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot_password_screen';

  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController primary_email_textEditing = new TextEditingController();
  TextEditingController primary_mobile_textEditing =
      new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    primary_email_textEditing.dispose();
    primary_mobile_textEditing.dispose();
    super.dispose();
  }

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
          'Forgot Password',
          style: TextStyle(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                  margin: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'We will send the password to your registered email address using which you will be able to login.',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                          ),
                        ),
                        TextFormField(
                          controller: primary_email_textEditing,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontFamily:
                                  CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                              fontSize: 16,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily:
                                CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          ),
                        ),
                        TextFormField(
                          controller: primary_mobile_textEditing,
                          keyboardType: TextInputType.number,
                          inputFormatters: [LengthLimitingTextInputFormatter(10)],
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Mobile No.',
                            labelStyle: TextStyle(
                              fontFamily:
                                  CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                              fontSize: 16,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily:
                                CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_isValid()) {
                                forgotPasswordApiCall(
                                    EmailID: primary_email_textEditing.text
                                        .trim()
                                        .toString(),
                                    MobileNo: primary_mobile_textEditing.text
                                        .trim()
                                        .toString());
                              }
                            },
                            style: ElevatedButton.styleFrom(),
                            child: Text(
                              'Process',
                              style: TextStyle(
                                  fontFamily:
                                      CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
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
        style: TextStyle(fontSize: 16),
      ),
      duration: Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void forgotPasswordApiCall(
      {required String EmailID, required String MobileNo}) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.getForgetPasswordApiImplementer(
            EmailID: EmailID, MobileNo: MobileNo)
        .then((XmlDocument xmlDocument) {
      Navigator.of(context).pop();
      if (!xmlDocument.isNull) {
        bool element = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
        if (element) {
          String msg = xmlDocument
              .findAllElements('SendFeedBack')
              .first
              .getElement('StatusMessage')!
              .text;

          print('msg=======$msg');

          showForgotPasswordDialog(
              context: context,
              title: 'Alert!!!!',
              content: '$msg',
              positiveButtonText: 'ok',
              onOkBtnClickListener: () {
                Get.close(2);
              });
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }

  static Future<void> showForgotPasswordDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String positiveButtonText,
    required Function onOkBtnClickListener,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '${title}',
          style: TextStyle(
            color: Colors.black,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
            fontSize: 16,
          ),
        ),
        content: Text(content),
        actions: [
          ElevatedButton(
            onPressed: () => onOkBtnClickListener(),
            child: Text(
              '${positiveButtonText}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isValid() {
    if (primary_email_textEditing.text.isEmpty) {
      showToastMsg('Please Enter Email');
      return false;
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(primary_email_textEditing.text)) {
      showToastMsg('Please enter valid email');
      return false;
    } else if (primary_mobile_textEditing.text.isEmpty) {
      showToastMsg('Enter mobile no.');
      return false;
    } else if (primary_mobile_textEditing.text.length != 10) {
      showToastMsg('Please enter valid mobile no.');
      return false;
    }
    return true;
  }
}
