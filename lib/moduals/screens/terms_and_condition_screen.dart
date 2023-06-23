import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:xml/xml.dart';

class TermsAndConditionScreen extends StatefulWidget {
  static const String routeName = '/terms_and_condition_screen';

  const TermsAndConditionScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: new Text(
          'Terms And Conditions',
          style: TextStyle(
              fontSize: 18,
              letterSpacing: 0.5,
              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD),
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
          SafeArea(
            child: Container(
              height: size.height,
              width: size.width,
              child: FutureBuilder<XmlDocument>(
                  future: ApiImplementer.getTermsAndConditionApiImplementer(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        child: Text('${snapshot.error}'),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return AppDialogs.screenAppShowDiloag(context);
                    }
                    XmlElement xmlElement =
                        snapshot.data!.findAllElements('NewDataSet').first;
                    return SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          HtmlWidget(
                              '${xmlElement.getElement('TermsAndConditions')!.text}')
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
