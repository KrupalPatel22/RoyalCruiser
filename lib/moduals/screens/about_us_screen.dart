import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/widgets/no_data_found_widget.dart';
import 'package:xml/xml.dart';

class AboutUsAppScreen extends StatefulWidget {
  static const routeName = '/about_us_frg';

  const AboutUsAppScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsAppScreen> createState() => _AboutUsAppScreenState();
}

class _AboutUsAppScreenState extends State<AboutUsAppScreen> {
  String? webURL;
  RxBool _isLoading = true.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: Text(
          'About Us',
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 0.5,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bannerbg.png"),
                opacity: 80.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Obx(
            () => !_isLoading.value
                ? Container()
                : Container(
                    height: size.height,
                    width: size.width,
                    margin: EdgeInsets.all(10),
                    child: FutureBuilder<XmlDocument>(
                        future: ApiImplementer.getCompanyAboutUsApiImplementer(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return AppDialogs.screenAppShowDiloag(context);
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                snapshot.error.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                          XmlElement data1 = snapshot.data!
                              .findAllElements('AboutUs')
                              .first;
                          return snapshot.data!
                                  .findAllElements('NewDataSet')
                                  .isNotEmpty
                              ? SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      HtmlWidget(
                                        data1.getElement('AboutUs')!.text,
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontFamily: CommonConstants
                                                .FONT_FAMILY_OPEN_SANS_REGULAR),
                                      ),
                                    ],
                                  ),
                                )
                              : const NoDataFoundWidget();
                        }),
                  ),
          ),
        ],
      ),
    );
  }
}
