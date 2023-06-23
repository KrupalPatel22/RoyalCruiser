import 'package:get/get.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:xml/xml.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeedbackAppScreen extends StatefulWidget {
  static const routeName = '/feedback_frg';

  const FeedbackAppScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackAppScreen> createState() => _FeedbackAppScreenState();
}

class _FeedbackAppScreenState extends State<FeedbackAppScreen> {
  String? _select_services_main;
  String? _select_services_sub;
  RxBool _isLoading = false.obs;

  List<String> mainList = [
    'Suggestions',
    'Complaints',
    'Inquiry',
    'Compliments'
  ];

  List<String> subList = [
    'Bus Service',
    'Web Site',
    'Schedule',
    'Mobile Site',
    'Mobile Application'
  ];

  TextEditingController primary_name_textEditing = TextEditingController();
  TextEditingController primary_email_textEditing = TextEditingController();
  TextEditingController comment_textEditing = TextEditingController();
  TextEditingController primary_mobile_textEditing =
  TextEditingController();

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
    } else if (_select_services_main == null) {
      showToastMsg('Please select type');
      return false;
    } else if (_select_services_sub == null) {
      showToastMsg('Please select sub type');
      return false;
    } else if (comment_textEditing.text.isEmpty) {
      showToastMsg('Please enter comment');
      return false;
    }
    return true;
  }

  @override
  void initState() {
    getData().then((value) => _isLoading.value = true);
    super.initState();
  }

  Future<void> getData() async {
    if (NavigatorConstants.USER_ID.compareTo("0") != 0) {
      primary_email_textEditing.text = NavigatorConstants.USER_EMAIL;
      primary_mobile_textEditing.text = NavigatorConstants.USER_PHONE;
      primary_name_textEditing.text = NavigatorConstants.USER_NAME;
    }
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        iconTheme: const IconThemeData(
            color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: const Text(
          'Feedback',
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 0.5,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
          ),
        ),
      ),
      body: Obx(
            () => _isLoading.value
            ? Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '${NavigatorConstants.APPLICATION_VERSION_NAME}  (${NavigatorConstants.APPLICATION_VERSION_CODE})',
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily:
                        CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 10,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _select_services_main,
                        isExpanded: true,
                        hint: const Text("-Select-"),
                        icon: const Image(
                          image:
                          AssetImage('assets/images/ic_dropdown.png'),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _select_services_main = value as String?;
                          });
                        },
                        items: [
                          ...mainList
                              .map(
                                (e) => DropdownMenuItem(
                              value: e,
                              child: SizedBox(
                                child: Text(
                                  '${e}',
                                  style: const TextStyle(
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          )
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 10,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: _select_services_sub,
                        isExpanded: true,
                        hint: const Text("-Select-"),
                        icon: const Image(
                          image:
                          AssetImage('assets/images/ic_dropdown.png'),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _select_services_sub = value as String?;
                          });
                        },
                        items: [
                          ...subList
                              .map(
                                (e) => DropdownMenuItem(
                              value: e,
                              child: SizedBox(
                                child: Text(
                                  '${e}',
                                  style: const TextStyle(
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          )
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
                detailsFeedbackForm(),
                submitButton(),
              ],
            ),
          ),
        )
            : Container(),
      ),
    );
  }

  void feedback() {
    AppDialogs.showProgressDialog(context: context,isDismissible: false);
    ApiImplementer.getSendFeedback(
      EmailID: primary_email_textEditing.text.toString(),
      MobileNo: primary_mobile_textEditing.text.toString(),
      Name: primary_name_textEditing.text.toString(),
      Observation: '',
      Subject: getType(select_services_main: _select_services_main!),
      Type: getSubType(select_services_sub: _select_services_sub!),
    ).then((XmlDocument document) {
      Navigator.of(context).pop();
      XmlElement xmlElement = document.findAllElements('NewDataSet').first;
      if (xmlElement != null) {
        AppDialogs.showErrorDialog(
          title: '',
            context: context,
            errorMsg: xmlElement
                .findAllElements('SendFeedBack')
                .first
                .getElement('StatusMessage')!
                .text
                .toString(),
            onOkBtnClickListener: () {
              primary_name_textEditing.clear();
              primary_email_textEditing.clear();
              comment_textEditing.clear();
              primary_mobile_textEditing.clear();
              Navigator.of(context).pop();
            });
      }
    }).catchError((onError) {
      Navigator.of(context).pop();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }

  String getType({required String select_services_main}) {
    String type = '';
    if (select_services_main.compareTo("Suggestions") == 0) {
      type = '1';
    } else if (select_services_main.compareTo("Complaints") == 0) {
      type = '2';
    } else if (select_services_main.compareTo("Inquiry") == 0) {
      type = '3';
    } else if (select_services_main.compareTo("Compliments") == 0) {
      type = '4';
    }
    return type;
  }

  String getSubType({required String select_services_sub}) {
    String subtype = '';
    if (select_services_sub.compareTo("Bus Service") == 0) {
      subtype = '1';
    } else if (select_services_sub.compareTo("Web Site") == 0) {
      subtype = '2';
    } else if (select_services_sub.compareTo("Schedule") == 0) {
      subtype = '3';
    } else if (select_services_sub.compareTo("Mobile Site") == 0) {
      subtype = '4';
    } else if (select_services_sub.compareTo("Mobile Application") == 0) {
      subtype = '5';
    }
    return subtype;
  }

  Widget detailsFeedbackForm() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                fontSize: 14,
              ),
            ),
            style: const TextStyle(
              fontSize: 14,
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
                fontSize: 14,
              ),
            ),
            style: const TextStyle(
              fontSize: 14,
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
                fontSize: 14,
              ),
            ),
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
            ),
          ),
          TextFormField(
            controller: comment_textEditing,
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Write Your Comment',
              labelStyle: TextStyle(
                fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                fontSize: 14,
              ),
            ),
            style: const TextStyle(
              fontSize: 14,
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
            ),
          ),
        ],
      ),
    );
  }

  Widget submitButton() {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
        ),
        onPressed: () {
          if (_isValid()) {
            feedback();
          }
        },
        child: const Text(
          'Submit',
          style: TextStyle(
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
              fontSize: 16),
        ),
      ),
    );
  }
}
