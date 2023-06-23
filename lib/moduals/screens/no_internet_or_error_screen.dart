import 'package:connectivity/connectivity.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInterNetOrErrorScreen extends StatefulWidget {
  static const String routeName = '/no_internet_or_error_screen';

  const NoInterNetOrErrorScreen({Key? key}) : super(key: key);

  @override
  State<NoInterNetOrErrorScreen> createState() =>
      _NoInterNetOrErrorScreenState();
}

class _NoInterNetOrErrorScreenState extends State<NoInterNetOrErrorScreen> {
  RxBool _isLoading = false.obs;
  RxBool _isInterNet = true.obs;
  RxString _appBar = ''.obs;

  @override
  void initState() {
    _connectivity().then((value) => _isLoading.value = true);
    super.initState();
  }

  Future<void> _connectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _isInterNet.value = false;
      _appBar.value = 'No Internet Conncection';
    } else {
      _appBar.value = 'Error';
      _isInterNet.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 24,
        ),
        leading: SizedBox(),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: Obx(
          () => Text(
            '${_appBar.value}',
            style: TextStyle(
              fontSize: 18,
              letterSpacing: 0.5,
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
            ),
          ),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Obx(
          () => !_isLoading.value
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Obx(
                      () => Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16),
                        child: !_isInterNet.value
                            ? Text(
                                'You are not connected to Active Network Connection.Please Try Again',
                                style: TextStyle(
                                  fontFamily: CommonConstants
                                      .FONT_FAMILY_OPEN_SANS_REGULAR,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                'Please try again',
                                style: TextStyle(
                                  fontFamily: CommonConstants
                                      .FONT_FAMILY_OPEN_SANS_REGULAR,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily:
                              CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget callWebServices() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 20,
                  width: 50,
                  child: SizedBox(width: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
