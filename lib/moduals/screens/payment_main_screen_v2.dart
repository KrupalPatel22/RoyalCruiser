import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/moduals/screens/dashboard_screen.dart';
import 'package:royalcruiser/moduals/screens/ticket_detail_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentMainScreenV2 extends StatefulWidget {
  static const String routeName = '/payment_screen_v2';

  const PaymentMainScreenV2({Key? key}) : super(key: key);

  @override
  State<PaymentMainScreenV2> createState() => _PaymentMainScreenV2State();
}

class _PaymentMainScreenV2State extends State<PaymentMainScreenV2> {
  late String webURL;
  bool _isLoadingWebView = true;
  final RxBool _isLoading = true.obs;
  bool checkTktStatus = false;

  @override
  void didChangeDependencies() {
    final rcvData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    webURL = "${rcvData['PGURL']}&HS=${rcvData['OrderNo']}";
    super.didChangeDependencies();
  }

/*  @override
  void dispose() {
    _isLoading.value = false;
    super.dispose();
  }*/

  Future<void> _alertBox(String alertMsg) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(50),
        child: Container(
          margin: const EdgeInsets.all(20),
          height: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Wrap(
                children: [
                  Text(
                    alertMsg.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black54),
                    ),
                    child: const Text('No'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      // Navigator.of(context)
                      //     .pushReplacementNamed(DashboardAppScreen.routeName);
                      Get.offAllNamed(DashboardAppScreen.routeName);
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black54),
                    ),
                    child: const Text('Yes'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<IconData> iconList = [
    Icons.airplane_ticket_outlined,
    Icons.contact_phone_outlined,
    Icons.cancel_presentation_sharp,
    Icons.more_vert_sharp,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        checkTktStatus
            ? _alertBox('Are you sure you want to go back ?')
            : _alertBox('Are you sure cancel this transaction ?');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 24,
          ),
          toolbarHeight: MediaQuery.of(context).size.height / 14,
          title: const Text(
            'Royal Cruiser',
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
                  children: <Widget>[
                    WebView(
                      initialUrl: webURL,
                      javascriptMode: JavascriptMode.unrestricted,
                      zoomEnabled: true,
                      onPageStarted: (String url) {
                        print('on page start ::::: $url');
                        setState(() {
                          _isLoadingWebView = true;
                        });
                        if (url.toLowerCase().contains("ticket") ||
                            url.contains("E-Ticket") ||
                            url.toLowerCase().contains('eticket')) {
                          showDialogDynamic(
                              msg: 'Successfully booked ticket',
                              status: 's',
                              url: url);
                        } else if (url.contains("Error.aspx") ||
                            url.contains("error.aspx") ||
                            url.contains("LatestNews.aspx") ||
                            url.contains("Index.aspx") ||
                            url.contains("transtatus.aspx") ||
                            url.contains("index.aspx") ||
                            url.contains("Cancel_txn.jsp") ||
                            url.contains("cancel_txn.jsp") ||
                            url.toLowerCase().contains("cancel")) {
                          showDialogDynamic(
                              msg: 'error! please try again`',
                              status: 'f',
                              url: url);
                        }
                      },
                      onPageFinished: (String url) {
                        print('on page finish ::::: $url');
                        setState(() {
                          _isLoadingWebView = false;
                        });
                        if (url.toLowerCase().contains('blank') ||
                            url.toLowerCase().contains('about:blank')) {
                          Get.offAllNamed(DashboardAppScreen.routeName);
                        }
                        if (url.toLowerCase().contains("ticket") ||
                            url.contains("E-Ticket") ||
                            url.toLowerCase().contains('eticket')) {
                          showDialogDynamic(
                              msg: 'Successfully booked ticket',
                              status: 's',
                              url: url);
                        }
                        if (url.toLowerCase().contains("paymentfailed")) {
                          showDialogDynamic(
                              msg: 'Payment Failed', status: 'f', url: url);
                        }
                      },
                    ),
                    _isLoadingWebView
                        ? Center(
                            child: AppDialogs.screenAppShowDiloag(context),
                          )
                        : const SizedBox(),
                  ],
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomeColor.main_bg,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: Image(
              image: AssetImage(
                'assets/images/ic_launcher.png',
              ),
              fit: BoxFit.fill,
            ),
          ),
          elevation: 2.0,
          onPressed: () {
            Get.offAll(() => DashboardAppScreen(defaultScreen: 4));
          },
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          height: 65,
          backgroundColor: CustomeColor.main_bg,
          splashColor: Colors.red,
          activeColor: Colors.white,
          inactiveColor: Colors.grey,
          icons: iconList,
          activeIndex: 4,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 20,
          rightCornerRadius: 20,
          onTap: (index) {
            Get.offAll(() => DashboardAppScreen(defaultScreen: index));
          },
        ),
      ),
    );
  }

  Future<void> showDialogDynamic(
      {required String msg, required String status, required String url}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(50),
        child: Container(
          margin: const EdgeInsets.all(20),
          height: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Wrap(
                children: [
                  Text(
                    msg,
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  if (status == 's') {
                    //Navigator.of(context).pop();
                    String odIsStr = url.split('?')[1];
                    String orderId = odIsStr.split('=')[1];

                    Get.off(() => TicketDetailScreen(
                        fromCityname: "fromCityname",
                        toCityname: "toCityname",
                        pickupTime: "pickupTime",
                        dropTime: "dropTime",
                        journeyTime: "journeyTime",
                        bustourName: "bustourName",
                        seatNumber: "seatNumber",
                        passengerName: "passengerName",
                        ticketNo: "ticketNo",
                        PNR: "PNR",
                        fare: "fare",
                        OrderId: orderId));
                    setState(() {
                      checkTktStatus = true;
                    });
                  } else if (status == 'f') {
                    Get.offAllNamed(DashboardAppScreen.routeName);
                  }
                  // Navigator.of(context)
                  //     .pushReplacementNamed(DashboardAppScreen.routeName);
                },
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(10)),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
