import 'dart:developer';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/model/destination_city_model.dart';
import 'package:royalcruiser/model/source_city_model.dart';
import 'package:royalcruiser/moduals/screens/confirm_cancellation_screen.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/moduals/screens/terms_and_condition_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:royalcruiser/utils/ui/ui_utils.dart';
import 'package:xml/xml.dart';

class CancellationAppScreen extends StatefulWidget {
  static const routeName = '/cancellation_frg';

  const CancellationAppScreen({Key? key}) : super(key: key);

  @override
  State<CancellationAppScreen> createState() => _CancellationAppScreenState();
}

class _CancellationAppScreenState extends State<CancellationAppScreen> {
  RxBool _termsConditionCheckBox = false.obs;
  List<ITSSources> _selectSourceCityList = [];
  List<String> listSourceCityString = [];
  String? sourceCityID;
  String? sourceCityName;
  List<ITSDestinations> _selectDestinationCityList = [];
  List<String> listDestinationCityString = [];
  String? destinationCityID;
  String? destinationCityName;
  String currentText = "";

  TextEditingController primary_email_textEditing = new TextEditingController();
  TextEditingController primary_pnr_textEditing = new TextEditingController();
  TextEditingController ToCityTextField = TextEditingController();
  TextEditingController FormCityTextField = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key1 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = new GlobalKey();

  String? journeyDate;
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  bool _isHideAndShow = false;
  String htmlWidget = '';

  @override
  void initState() {
    getDate().then((value) => getSourceB2Cv2ApiCall());
    super.initState();
  }

  //Todo PNR
  //142909168
  Future<void> getDate() async {
    journeyDate = dateFormat.format(DateTime.now());
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
          'Cancellation',
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.blueGrey,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Please enter booking detail given at the time of ticket booking and Select your journey.',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                        fontSize: 14,
                      ),
                    ),
                  ),
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
                        style: const TextStyle(
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
                  ).paddingAll(10),
                  Visibility(
                    visible: _isHideAndShow,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      child: HtmlWidget(
                        htmlWidget,
                        textStyle: const TextStyle(
                          fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  cancellationDetailsWidget(),
                  Obx(() => CheckTermsAndConditionWidget()),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text(
                        'Cancel Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                        ),
                      ),
                      onPressed: () {

                        if (_isValid()) {

                          getCancellationDetailsApiCall();
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
    );
  }

  void ToastMsg({required String message}) {
    SnackBar snackBar = SnackBar(
      content: Text(
        '$message',
        style: const TextStyle(
          fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
          fontSize: 16,
        ),
      ),
      duration: const Duration(seconds: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget cancellationDetailsWidget() {
    double LablefirstWidt = 120;
    TextStyle lableTextStyle = const TextStyle(
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
                child: TextFormField(
                  controller: primary_pnr_textEditing,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'PNR No',
                    hintStyle: TextStyle(
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                      fontSize: 16,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(0.0),
          margin: const EdgeInsets.all(0.0),
          height: 45,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: LablefirstWidt,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text(
                  'Email',
                  style: lableTextStyle,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: primary_email_textEditing,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                      fontSize: 16,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
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
                child: Text(
                  'From',
                  style: lableTextStyle,
                ),
              ),
              Expanded(
                child: SimpleAutoCompleteTextField(
                  key: key1,
                  decoration: InputDecoration(
                      hintText: "From",
                      helperStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily:
                              CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR),
                      hintStyle: TextStyle(
                          fontSize: 16,
                          fontFamily:
                              CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          color: Colors.grey.shade500),
                      helperMaxLines: 1,
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true),
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily:
                          CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR),
                  suggestions: listSourceCityString,
                  clearOnSubmit: false,
                  submitOnSuggestionTap: mounted,
                  textChanged: (text) => currentText = text,
                  controller: FormCityTextField,
                  textSubmitted: (item) {
                    setState(() => FormCityTextField.text = item);
                    for (int i = 0; i < _selectSourceCityList.length; i++) {
                      if (FormCityTextField.text ==
                          _selectSourceCityList[i].CM_CityName) {
                        sourceCityID = _selectSourceCityList[i].CM_CityID;

                        sourceCityName = _selectSourceCityList[i].CM_CityName;

                        _selectDestinationCityList.clear();
                        listDestinationCityString.clear();
                        ToCityTextField.clear();
                        destinationCityName = null;
                        destinationCityID = null;
                        getDestinationsBasedOnSource(
                            sourceCityID: sourceCityID!);
                        break;
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        AbsorbPointer(
          absorbing: sourceCityID == null ? true : false,
          child: Container(
            width: double.infinity,
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
                  child: Text('To', style: lableTextStyle),
                ),
                Expanded(
                  child: SimpleAutoCompleteTextField(
                    key: key2,
                    decoration: InputDecoration(
                        hintText: "To",
                        helperStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily:
                                CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR),
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontFamily:
                                CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                            color: Colors.grey.shade500),
                        helperMaxLines: 1,
                        border: InputBorder.none,
                        fillColor: Colors.white,
                        filled: true),
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily:
                            CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR),
                    suggestions: listDestinationCityString,
                    clearOnSubmit: false,
                    submitOnSuggestionTap: mounted,
                    textChanged: (text) => currentText = text,
                    controller: ToCityTextField,
                    textSubmitted: (item) {
                      setState(() => ToCityTextField.text = item);
                      for (int i = 0;
                          i < _selectDestinationCityList.length;
                          i++) {
                        if (ToCityTextField.text ==
                            _selectDestinationCityList[i].CM_CityName) {
                          destinationCityID =
                              _selectDestinationCityList[i].CM_CityID;
                          destinationCityName =
                              _selectDestinationCityList[i].CM_CityName;
                          break;
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
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
                child: Text('Journey Date', style: lableTextStyle),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 8,
                child: InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              // primary: CustomeColor.sub_bg,
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                  // primary: CustomeColor.sub_bg,
                                  ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      setState(() {
                        journeyDate = dateFormat.format(pickedDate);
                      });
                    }
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Image(
                          image: AssetImage('assets/images/ic_calender.png'),
                          height: 25,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${journeyDate}',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontFamily:
                                CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
              Navigator.of(context).pushNamed(TermsAndConditionScreen.routeName);
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

  bool _isValid() {

    if (primary_pnr_textEditing.text.isEmpty) {
      ToastMsg(message: 'Enter PNR No.');
      return false;
    } else if (primary_email_textEditing.text.isEmpty) {
      ToastMsg(message: 'Enter email');
      return false;
    } else if ((!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(primary_email_textEditing.text))) {
      ToastMsg(message: 'Please enter valid email');
      return false;
    } else if (FormCityTextField.text.isEmpty) {
      ToastMsg(message: 'Please select form city');
      return false;
    } else if (ToCityTextField.text.isEmpty) {
      ToastMsg(message: 'Please select to city');
      return false;
    } else if (_termsConditionCheckBox.value != true) {
      ToastMsg(message: 'Please agree to terms and condition');
      return false;
    } else if (_termsConditionCheckBox.value != true) {
      ToastMsg(message: 'Please agree to terms and condition');
      return false;
    }
    return true;
  }

  void getCancellationApiCall() {
    ApiImplementer.getCancellationPolicyApiImplementer().then((XmlDocument document) {
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
    });
  }

  void getSourceB2Cv2ApiCall() {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.getSourceB2Cv2ApiImplementer().then((XmlDocument document) {
      Get.back();
      bool xmlElement = document.findAllElements('NewDataSet').isNotEmpty;
      if (xmlElement) {
        List<XmlElement> element =
            document.findAllElements('ITSSources').toList();
        for (int i = 0; i < element.length; i++) {
          ITSSources itsSources = ITSSources(
              CM_CityID: element[i].getElement('CM_CityID')!.text,
              CM_CityName: element[i].getElement('CM_CityName')!.text,
          );
          _selectSourceCityList.add(itsSources);
          listSourceCityString
              .add(element[i].getElement('CM_CityName')!.text.toString());
        }
      }
    }).catchError((onError) {
      Get.back();
    });
  }

  void getDestinationsBasedOnSource({required String sourceCityID}) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.getDestinationsBasedOnSourceApiImplementer(
            sourceID: sourceCityID)
        .then((XmlDocument document) {
      Get.back();
      bool xmlElement = document.findAllElements('NewDataSet').isNotEmpty;
      if (xmlElement) {
        List<XmlElement> element =
            document.findAllElements('ITSDestinations').toList();
        for (int i = 0; i < element.length; i++) {
          ITSDestinations destinations = ITSDestinations(
              CM_CityID: element[i].getElement('CM_CityID')!.text,
              CM_CityName: element[i].getElement('CM_CityName')!.text);
          _selectDestinationCityList.add(destinations);
          listDestinationCityString
              .add(element[i].getElement('CM_CityName')!.text);
        }
      } else {
      }
    }).catchError((onError) {
      Get.back();
    });
  }

  void getCancellationDetailsApiCall() {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.CancellationDetailsApiImplementer(
            EmailID: primary_email_textEditing.text.trim().toString(),
            FromCityID: sourceCityID!,
            JourneyDate: journeyDate!,
            PNRNo: primary_pnr_textEditing.text.trim().toString(),
            ToCityID: destinationCityID!)
        .then((XmlDocument xmlDocument) {
      Navigator.of(context).pop();
      if (!xmlDocument.isNull) {
        bool xmlElement = xmlDocument.findAllElements('NewDataSet').isNotEmpty;
        if (xmlElement) {
          if (xmlDocument
                  .findAllElements('StatusMessage')
                  .first
                  .getElement('Status')!
                  .text
                  .compareTo("1") ==
              0) {
            List<XmlElement> listCancellationDetails =
                xmlDocument.findAllElements('CancellationDetails').toList();
            if(listCancellationDetails[0].getElement('RefundAmount')!=null){
              Navigator.of(context).pushNamed(
                  ConfirmCancellationAppScreen.routeName,
                  arguments: listCancellationDetails);
            }else{
              if(listCancellationDetails[0].getElement('StatusMsg')!=null){

              UiUtils.errorSnackBar(message: listCancellationDetails[0].getElement('StatusMsg')!.text).show();
              }else{
                UiUtils.errorSnackBar(message: "Something went Wrong").show();

              }
            }
            log(listCancellationDetails.toString());

          } else if (xmlDocument
                  .findAllElements('StatusMessage')
                  .first
                  .getElement('Status')!
                  .text
                  .compareTo("0") ==
              0) {
            dialogAlert();
          }
        }
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
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
              const Text(
                'Invalid Details .',
                style: TextStyle(
                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                    fontSize: 16),
              ).paddingAll(10),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(5),
                  ),
                  child: const Text('Ok'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
