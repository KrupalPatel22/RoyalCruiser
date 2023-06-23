import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/preferences_costances.dart';
import 'package:royalcruiser/moduals/screens/about_us_screen.dart';
import 'package:royalcruiser/moduals/screens/dashboard_screen.dart';
import 'package:royalcruiser/moduals/screens/feedback_screen.dart';
import 'package:royalcruiser/moduals/screens/gallery_screen.dart';
import 'package:royalcruiser/moduals/screens/login_screen.dart';
import 'package:royalcruiser/moduals/screens/my_booking_screen.dart';
import 'package:royalcruiser/moduals/screens/pnr_enquiry_screen.dart';
import 'package:royalcruiser/moduals/screens/terms_and_condition_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:xml/xml.dart';

class MenuList {
  String title;
  String ontap;

  MenuList({required this.title, required this.ontap});
}

class MoreSectionScreen extends StatefulWidget {
  static const routeName = '/more_section_screen';

  const MoreSectionScreen({Key? key}) : super(key: key);

  @override
  State<MoreSectionScreen> createState() => _MoreSectionScreenState();
}

class _MoreSectionScreenState extends State<MoreSectionScreen> {
  String usertId = '';
  String userName = '';
  String usertEmail = '';
  String usertPhone = '';
  String userPassword = '';
  RxBool _isloading = false.obs;
  SharedPreferences? _sharedPreferences;

  @override
  void initState() {
    getdata().then((value) {
      isCheckLoginDetails();
    }).then((value) => _isloading.value = true);
    super.initState();
  }

  Future<void> getdata() async {
    usertId = NavigatorConstants.USER_ID;
    print('usertId===>$usertId');
    userName = NavigatorConstants.USER_NAME;
    usertEmail = NavigatorConstants.USER_EMAIL;
    usertPhone = NavigatorConstants.USER_PHONE;
    userPassword = NavigatorConstants.USER_PASSWORD;
  }

  bool isCheckLoginDetails() {
    if (usertId.compareTo("0") == 0) {
      return false;
    }
    return true;
  }

  List<MenuList> menu = [
    MenuList(title: 'My Booking', ontap: MyBookingAppScreen.routeName),
    MenuList(title: 'PNR Enquiry', ontap: PNREnquiryScreen.routeName),
    MenuList(
        title: 'Terms And Condition', ontap: TermsAndConditionScreen.routeName),
    MenuList(title: 'About Us', ontap: AboutUsAppScreen.routeName),
    MenuList(title: 'Gallery', ontap: GalleryAppScreen.routeName),
    MenuList(title: 'Feedback', ontap: FeedbackAppScreen.routeName),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(),
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ...menu.map(
                  (e) => Card(
                    elevation: 1.5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      //horizontal: 15,
                    ),
                    child: ListTile(
                      tileColor: CustomeColor.sub_bg,
                      title: Center(
                        child: Text(
                          e.title.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      trailing: const Icon(CupertinoIcons.forward, color: Colors.white),
                      onTap: () {
                        Navigator.of(context).pushNamed(e.ontap);
                      },
                    ),
                  ),
                ),
                Card(
                  elevation: 1.5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    //horizontal: 15,
                  ),
                  child: ListTile(
                    tileColor: CustomeColor.sub_bg,
                    title: const Center(
                      child: Text(
                        'Rate Us',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0),
                      ),
                    ),
                    trailing: const Icon(CupertinoIcons.forward, color: Colors.white),
                    onTap: () {
                      StoreRedirect.redirect(
                          androidAppId: "com.infinityinfoway.royalcruiser",
                          iOSAppId: "id6443929868");
                    },
                  ),
                ),
                Card(
                  elevation: 1.5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 6,
                    // horizontal: 15,
                  ),
                  child: ListTile(
                    tileColor: CustomeColor.sub_bg,
                    title: const Center(
                      child: Text(
                        'Share Application',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0),
                      ),
                    ),
                    trailing: const Icon(CupertinoIcons.forward, color: Colors.white),
                    onTap: () {
                      shareApp();
                    },
                  ),
                ),
                isCheckLoginDetails()
                    ? Card(
                        elevation: 1.5,
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          // horizontal: 15,
                        ),
                        child: ListTile(
                          tileColor: CustomeColor.sub_bg,
                          title: const Center(
                            child: Text(
                              'Delete Account',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0),
                            ),
                          ),
                          trailing:
                              const Icon(CupertinoIcons.forward, color: Colors.white),
                          onTap: () {
                            AppDialogs.showCommonDialog(
                                context: context,
                                barrierDismissible: false,
                                title: 'Are you sure delete account',
                                positiveButtonText: 'Yes',
                                nagativeButtonTexts: 'No',
                                onOkBtnClickListener: () {
                                  DeleteAccountApicall();
                                },
                                onCancelBtnClickListener: () {
                                  Get.back();
                                });
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void DeleteAccountApicall() {
    ApiImplementer.getDeleteCoutomerApiImplementer(
            CustID: usertId,
            CustMobileNumber: usertPhone,
            CustEmail: usertEmail)
        .then((XmlDocument xmlDocument) {
      XmlElement xmlElement =
          xmlDocument.findAllElements('Delete_Coutomer').first;
      if (xmlElement != null) {
        if (xmlElement.getElement('Status')!.text.toString().compareTo("1") ==
            0) {
          AppDialogs.showErrorDialog(
            title: '',
              context: context,
              errorMsg: xmlElement.getElement('Msg')!.text.toString(),
              onOkBtnClickListener: () {
                getShared();
                Get.offAllNamed(DashboardAppScreen.routeName);
              });
        } else if (xmlElement
                .getElement('Status')!
                .text
                .toString()
                .compareTo("0") ==
            0) {
          AppDialogs.showErrorDialog(
            title: '',
              context: context,
              errorMsg: xmlElement.getElement('Msg')!.text.toString(),
              onOkBtnClickListener: () {
                Get.back();
              });
        }
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  Future<void> shareApp() async {
    await FlutterShare.share(
        title: 'Royal Crusier',
        text: 'Official Application Of Royal Crusier',
        linkUrl:
            'https://play.google.com/store/apps/details?id=com.infinityinfoway.royalcruiser',
        chooserTitle: 'Royal Crusier');
  }

  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(65),
      child: Container(
    decoration: const BoxDecoration(
    color: CustomeColor.main_bg,
    ),
    child:Obx(
        () => _isloading.value
            ? SafeArea(
            child:Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: CustomeColor.main_bg,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isCheckLoginDetails()
                              ? Text(
                                  '$usertEmail',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Hi Guest',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                          const SizedBox(
                              height: 5),
                          isCheckLoginDetails()
                              ? Text(
                                  '$usertPhone',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      )
                    ],
                  ),
                  isCheckLoginDetails()
                      ? IconButton(
                          onPressed: () {
                            getShared().then((value) {
                              Get.offAllNamed(DashboardAppScreen.routeName);
                            });
                          },
                          icon: const Icon(
                            Icons.logout,
                            size: 25,
                            color: Colors.white,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(LoginScreen.routeName);
                          },
                          icon: const Icon(
                            Icons.supervised_user_circle,
                            size: 25,
                            color: Colors.white,
                          ),
                        )
                ],
              ),
            ),)
            : const SizedBox.shrink(),
      ),),
    );
  }

  Future<void> getShared() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _sharedPreferences!.remove(Preferences.CUST_EMAIL);
    _sharedPreferences!.remove(Preferences.CUST_ID);
    _sharedPreferences!.remove(Preferences.CUST_NAME);
    _sharedPreferences!.remove(Preferences.CUST_PHONE);
    _sharedPreferences!.remove(Preferences.CUST_PASSWORD);
    _sharedPreferences!.remove(Preferences.UPDATE_APP_VERSION_CODE);
    _sharedPreferences!.remove(Preferences.RECENT_SEARCH);
    NavigatorConstants.USER_NAME = '';
    NavigatorConstants.USER_EMAIL = '';
    NavigatorConstants.USER_PHONE = '';
    NavigatorConstants.USER_PASSWORD = '';
    NavigatorConstants.USER_ID = '0';
  }
}
