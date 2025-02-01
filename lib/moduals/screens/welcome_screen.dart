import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/utils/sp.dart';
import 'package:royalcruiser/widgets/app_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:xml/xml.dart';

import '../../api/api_imlementer.dart';
import '../../constants/common_constance.dart';
import '../../constants/navigation_constance.dart';
import '../../constants/preferences_costances.dart';
import '../../utils/app_dialog.dart';
import '../../utils/ui/ui_utils.dart';
import 'dashboard_screen.dart';
import 'package:flutter_svg/svg.dart';

import 'no_internet_or_error_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController phNumberCtr = TextEditingController();

  final _key = GlobalKey<FormState>();

  PageController slideCtr = PageController();

  Timer? _timer;
  int _currentPage = 0;
  TextStyle sliderTextStyle =
      TextStyle(fontSize: 18, color: CustomeColor.main_bg);
  ValueNotifier otpNotify = ValueNotifier<bool>(false);
  String verificationCode = "";
  XmlDocument? loginResponce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      slideCtr.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  String otpTxt = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SafeArea(
        child: Container(
          child: Column(children: [
            Center(
              child: Container(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: Image.asset('assets/images/royal_logo.png')),
            ),
            Expanded(
              child: Stack(children: [
                PageView(
                  controller: slideCtr,
                  onPageChanged: (index) {
                    print(index);
                  },
                  children: [
                    Stack(children: [
                      Center(
                        child: Image.asset('assets/images/charges.png'),
                      ),
                      // Positioned(
                      //     bottom: 15,
                      //     right: 0,
                      //     left: 0,
                      //     child: Text(
                      //       'Get 8% discount on all routes',
                      //       textAlign: TextAlign.center,
                      //       style: sliderTextStyle,
                      //     ))
                    ]),
                    Stack(children: [
                      Center(
                        child: Image.asset('assets/images/reclining_seat.png'),
                      ),
                      // Positioned(
                      //     bottom: 15,
                      //     right: 0,
                      //     left: 0,
                      //     child: Text(
                      //       'Get 8% discount on all routes',
                      //       textAlign: TextAlign.center,
                      //       style: sliderTextStyle,
                      //     ))
                    ]),
                    // Stack(children: [
                    //   Center(
                    //     child: Image.asset('assets/images/insured.png'),
                    //   ),
                    //   // Positioned(
                    //   //     bottom: 15,
                    //   //     right: 0,
                    //   //     left: 0,
                    //   //     child: Text(
                    //   //       'Reclining seats',
                    //   //       textAlign: TextAlign.center,
                    //   //       style: sliderTextStyle,
                    //   //     ))
                    // ]),
                    Stack(children: [
                      Center(
                        child: Image.asset('assets/images/ontime.png'),
                      ),
                      // Positioned(
                      //     bottom: 15,
                      //     right: 0,
                      //     left: 0,
                      //     child: Text(
                      //       'Punctuality at its best',
                      //       textAlign: TextAlign.center,
                      //       style: sliderTextStyle,
                      //     ))
                    ]),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: SmoothPageIndicator(
                      controller: slideCtr,
                      count: 3,
                      effect: WormEffect(
                          dotWidth: 8,
                          dotHeight: 8,
                          activeDotColor: CustomeColor.main_bg),
                    ),
                  ),
                )
              ]),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              padding: EdgeInsets.all(30),
              alignment: Alignment.centerLeft,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to ROYAL CRUISER',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'We will send on OTP on this mobile number.',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),

                    //Phone Number
                    Form(
                      key: _key,
                      child: ValueListenableBuilder(
                          valueListenable: otpNotify,
                          builder: (ctx, val, _) {
                            return Visibility(
                              visible: !val,
                              child: TextFormField(
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'please enter mobile number';
                                  } else if (val.length != 10) {
                                    return 'mobile number is not valid.';
                                  }
                                },
                                controller: phNumberCtr,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]")),
                                ],
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Enter mobile number',
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
                            );
                          }),
                    ),

                    SizedBox(height: 10),

                    ValueListenableBuilder(
                        valueListenable: otpNotify,
                        builder: (ctx, val, _) {
                          return Visibility(
                            visible: val,
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Enter Otp',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: CustomeColor.main_bg)),
                                SizedBox(height: 10),
                                OtpTextField(
                                  numberOfFields: 4,
                                  borderColor: CustomeColor.main_bg,
                                  cursorColor: CustomeColor.main_bg,
                                  enabledBorderColor: CustomeColor.main_bg,
                                  focusedBorderColor: CustomeColor.main_bg,
                                  showFieldAsBox: true,
                                  onCodeChanged: (String code) {
                                    verificationCode = code;
                                  },
                                  onSubmit: (String code) {
                                    verificationCode = code;
                                    print(verificationCode);

                                    // showDialog(
                                    //     context: context,
                                    //     builder: (context) {
                                    //       return AlertDialog(
                                    //         title: Text("Verification Code"),
                                    //         content: Text(
                                    //             'Code entered is $verificationCode'),
                                    //         actions: [
                                    //           ElevatedButton(onPressed: (){
                                    //             Get.offAllNamed(DashboardAppScreen.routeName);
                                    //           }, child: Text('Ok'))
                                    //         ],
                                    //       );
                                    //     });

                                  }, // end onSubmit
                                ),
                              ],
                            ),
                          );
                        }),

                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ValueListenableBuilder(
                          valueListenable: otpNotify,
                          builder: (ctx, val, _) {
                            return AppButton(
                              () {

                                if (otpNotify.value) {
                                  //Old Code
                                  // print("$otpTxt == $verificationCode");
                                  // if (otpTxt == verificationCode) {
                                  //   setDataFromApi(
                                  //       xmlElement: loginResponce!
                                  //           .findAllElements('GetDetails')
                                  //           .first);
                                  //   UiUtils.successSnackBar(
                                  //           message: 'Login Successfully')
                                  //       .show();
                                  // }
                                  // else {
                                  //   UiUtils.errorSnackBar(
                                  //           message: 'Invalid otp')
                                  //       .show();
                                  // }

                                  //New Code
                                  ApiImplementer.VerifyOTPApiImplimenter(
                                          CustMobile: phNumberCtr.value.text,
                                          CustVerificationCode: verificationCode
                                  ).then((XmlDocument xmlDocument) {
                                    // Navigator.of(context).pop();
                                    if (!xmlDocument.isNull) {
                                      print('Otp:- ${xmlDocument}');

                                      bool xmlElement = xmlDocument
                                          .findAllElements('VerifyStatus')
                                          .isNotEmpty;


                                      String verifyOtpStatus = xmlDocument
                                          .findAllElements('VerifyStatus')
                                          .first.getElement('Status')!.text;

                                      print("My Test ${verifyOtpStatus}");


                                      if (xmlElement) {
                                        //loginResponce = xmlDocument;

                                        print("Mytst = $xmlDocument");

                                        if (verifyOtpStatus.compareTo("1") == 0) {

                                          print("My Test otp is right ${loginResponce!
                                              .findAllElements('Status')
                                              .first
                                              .getElement('Status')!
                                              .text}");


                                          if (loginResponce!
                                                  .findAllElements('Status')
                                                  .first
                                                  .getElement('Status')!
                                                  .text
                                                  .compareTo("0") == 0) {

                                            print("My Test Go to register");



                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        RegistrationScreen(
                                                            mobileNo:
                                                                phNumberCtr
                                                                    .value
                                                                    .text)));
                                          }
                                          else {
                                            print("My Test Login User");

                                            setDataFromApi(xmlElement: loginResponce!
                                                .findAllElements('GetDetails')
                                                .first);
                                            // Get.offAllNamed(DashboardAppScreen.routeName);

                                          }
                                        }
                                        else {
                                          print("My Test otp is Wrong");
                                            UiUtils.errorSnackBar(message: 'Invalid otp')
                                                .show();
                                        }

                                      }
                                    }

                                  });

                                }
                                else {
                                  if (_key.currentState!.validate()) {
                                    getOTPApiCall(
                                        phnNumber: phNumberCtr.value.text);

                                    //Get.offAllNamed(DashboardAppScreen.routeName);
                                  }
                                }
                              },
                              text: otpNotify.value ? 'Login' : 'PROCEED',
                              round: 10,
                            );
                          }),
                    ),
                    SizedBox(height: 10),

                    ValueListenableBuilder(valueListenable: otpNotify, builder: (ctx,val,_){

                      if(otpNotify.value){
                        return InkWell(
                          onTap: () {
                            otpNotify.value=false;
                            // setUserIsNotFirstTime();
                            // Get.offAllNamed(DashboardAppScreen.routeName);
                          },
                          child: Center(
                            child: Text('Change Mobile Number',
                                style: TextStyle(
                                    color: CustomeColor.main_bg,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15)),
                          ),
                        );
                      }else{
                        return SizedBox.shrink();
                      }

                    }),

                  ]),
            )
          ]),
        ),
      )),
    );
  }

  void getOTPApiCall({required String phnNumber}) {
    AppDialogs.showProgressDialog(context: context);

    ///Old Code
    // ApiImplementer.getOTPLoginApiImplementer(
    //   CustMobile: phnNumber,
    // ).then((XmlDocument xmlDocument) {
    //   Navigator.of(context).pop();
    //   if (!xmlDocument.isNull) {
    //     print('Otp:- ${xmlDocument}');
    //
    //     bool xmlElement = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
    //     if (xmlElement) {
    //       loginResponce = xmlDocument;
    //       if (xmlDocument.findAllElements('Status').first.getElement('Status')!.text.compareTo("1") == 0) {
    //         otpNotify.value = true;
    //         //_text_OTP_controller.text = xmlDocument.findAllElements('GetDetails').first.getElement('VerificationCode1')!.text;
    //         otpTxt = xmlDocument.findAllElements('GetDetails').first.getElement('VerificationCode1')!.text.toString();
    //
    //         print('Otp:- ${otpTxt}');
    //       } else {
    //         setUserIsNotFirstTime();
    //         //User Not Found Navigate to Register
    //         Navigator.of(context).push(MaterialPageRoute(builder: (_) => RegistrationScreen(mobileNo: phNumberCtr.value.text)));
    //       }
    //     }
    //   }
    // }).catchError((onError) {
    //   Navigator.of(context).pop();
    //   Navigator.of(context).pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    //   print('MyBookingLoginApiImplementeronError===>$onError');
    // });

    ///New Code
    ApiImplementer.getOTPBaseLogin_MobileBase(
      CustMobile: phnNumber,
    ).then((XmlDocument xmlDocument) {
      Navigator.of(context).pop();
      if (!xmlDocument.isNull) {
        print('Otp:- ${xmlDocument}');

        bool xmlElement = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
        if (xmlElement) {
          loginResponce = xmlDocument;
          if (xmlDocument
                  .findAllElements('Status')
                  .first
                  .getElement('Status')!
                  .text
                  .compareTo("1") ==
              0) {
            otpNotify.value = true;
            otpTxt = xmlDocument
                .findAllElements('GetDetails')
                .first
                .getElement('VerificationCode')!
                .text
                .toString();
            print('Otp:- ${otpTxt}');
          } else {
            //  setUserIsNotFirstTime();
            //User Not Found Navigate to Register

            ApiImplementer.NewUser_GetOTPApiImplimenter(CustMobile: phnNumber).then((XmlDocument xmlDoc) {
              log("Send otp to new user Responce :- $xmlDoc");
            });

            otpNotify.value = true;
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (_) =>
            //         RegistrationScreen(mobileNo: phNumberCtr.value.text)));
          }
        }
      }
    })
        //     .catchError((onError) {
        //   Navigator.of(context).pop();
        //   print('MyBookingLoginApiImplementeronError===>$onError');
        //   Navigator.of(context).pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
        // })
        ;
  }

  SharedPreferences? _sharedPreferences;

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
        xmlElement.getElement('CustPassword')!.text.toString();

    _sharedPreferences!.setString(
        Preferences.CUST_ID, xmlElement.getElement('CustID')!.text.toString());
    _sharedPreferences!.setString(Preferences.CUST_NAME,
        xmlElement.getElement('CustName')!.text.toString());
    _sharedPreferences!.setString(Preferences.CUST_EMAIL,
        xmlElement.getElement('CustEmail')!.text.toString());
    _sharedPreferences!.setString(Preferences.CUST_PHONE,
        xmlElement.getElement('CustMobile')!.text.toString());
    _sharedPreferences!.setString(Preferences.CUST_PASSWORD,
        xmlElement.getElement('CustPassword')!.text.toString());

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
    Get.offAllNamed(DashboardAppScreen.routeName);
    // setUserIsNotFirstTime();
  }

  setUserIsNotFirstTime() async {
    await Sp().setUserFirstTime();
  }
}
