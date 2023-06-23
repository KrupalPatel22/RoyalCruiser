import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/constants/common_constance.dart';

class PNRhtmlScreen extends StatefulWidget {
  static const routeName = '/pnr_html_widget_screen';

  const PNRhtmlScreen({Key? key}) : super(key: key);

  @override
  State<PNRhtmlScreen> createState() => _PNRhtmlScreenState();
}

class _PNRhtmlScreenState extends State<PNRhtmlScreen> {
  String htmlWidget = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final rcvData = ModalRoute.of(context)!.settings.arguments;
    htmlWidget = rcvData as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: false,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: new Text(
          'PNR Details ',
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
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HtmlWidget(
                  htmlWidget,
                  textStyle: TextStyle(
                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                    fontSize: 16,
                  ),
                ),
              ],
            ).paddingAll(10),
          )),
        ],
      ),
    );
  }
}
