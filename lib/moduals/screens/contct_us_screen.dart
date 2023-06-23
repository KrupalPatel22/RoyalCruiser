import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:royalcruiser/widgets/no_data_found_widget.dart';
import 'package:xml/xml.dart';

class ContactUsAppScreen extends StatefulWidget {
  static const routeName = '/contct_us_frg';

  const ContactUsAppScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsAppScreen> createState() => _ContactUsAppScreenState();
}

class _ContactUsAppScreenState extends State<ContactUsAppScreen> {
  String? droupDownId;

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
          'Contact Us ',
          style: const TextStyle(
            fontSize: 18,
            letterSpacing: 0.5,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
          ),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: FutureBuilder<XmlDocument>(
            future: ApiImplementer.getContactDetailsListApiImplementer(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return AppDialogs.screenAppShowDiloag(context);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error.toString()}'),
                );
              }

              List<String> droupDownValue = [];
              List<XmlElement> xmlElement =
                  snapshot.data!.findAllElements('ContactDetailsList').toList();
              XmlElement? xmlElementIsHoOffice;
              for (int i = 0; i < xmlElement.length; i++) {
                if (xmlElement[i].getElement('IsHoOffice')!.text == "1") {
                  xmlElementIsHoOffice = xmlElement[i];
                }
                droupDownValue.add(xmlElement[i].getElement('CityName')!.text);
              }
              return xmlElement.isNotEmpty
                  ? Container(
                      height: size.height,
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (xmlElementIsHoOffice != null) ...[
                            Card(
                              elevation: 2.0,
                              margin: const EdgeInsets.all(5),
                              child: Container(
                                width: size.width,
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${xmlElementIsHoOffice.getElement('CityAreaName')!.text}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: CommonConstants
                                            .FONT_FAMILY_OPEN_SANS_BOLD,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${xmlElementIsHoOffice.getElement('Address')!.text}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: CommonConstants
                                            .FONT_FAMILY_OPEN_SANS_REGULAR,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${xmlElementIsHoOffice.getElement('StateName')!.text}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: CommonConstants
                                            .FONT_FAMILY_OPEN_SANS_REGULAR,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    HtmlWidget(
                                      '${xmlElementIsHoOffice.getElement('ContactNumber')!.text}',
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                          const SizedBox(height: 20),
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
                                  onChanged: (state) {
                                    setState(() {
                                      droupDownId = state as String;
                                    });
                                  },
                                  hint: new Text("-Select-"),
                                  icon: const Image(
                                    image: AssetImage(
                                        'assets/images/ic_dropdown.png'),
                                  ),
                                  isExpanded: true,
                                  value: droupDownId,
                                  items: [
                                    ...droupDownValue
                                        .map(
                                          (e) => DropdownMenuItem(
                                            child: Text('$e'),
                                            value: e,
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (droupDownId != null)
                                for (int i = 0; i < xmlElement.length; i++)
                                  if (droupDownId ==
                                      xmlElement[i]
                                          .getElement('CityName')!
                                          .text)
                                    Card(
                                      elevation: 2.0,
                                      margin: const EdgeInsets.all(
                                          5),
                                      child: Container(
                                        width: size.width,
                                        padding: const EdgeInsets.all(
                                            15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${xmlElement[i].getElement('CityAreaName')!.text}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: CommonConstants
                                                    .FONT_FAMILY_OPEN_SANS_BOLD,
                                                wordSpacing: 2.0,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                            const SizedBox(
                                                height:
                                                    10),
                                            Text(
                                              '${xmlElement[i].getElement('Address')!.text}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: CommonConstants
                                                    .FONT_FAMILY_OPEN_SANS_REGULAR,
                                              ),
                                            ),
                                            const SizedBox(
                                                height:
                                                    10),
                                            Text(
                                              '${xmlElement[i].getElement('StateName')!.text}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontFamily: CommonConstants
                                                    .FONT_FAMILY_OPEN_SANS_REGULAR,
                                              ),
                                            ),
                                            const SizedBox(
                                                height:
                                                    10),
                                            HtmlWidget(
                                              '${xmlElement[i].getElement('ContactNumber')!.text}',
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  else
                                    Container(
                                      alignment: Alignment.center,
                                      child: const Text('Select City'),
                                      padding: const EdgeInsets.all(
                                        10,
                                      ),
                                    )
                              else
                                const Text('')
                            ],
                          )
                        ],
                      ),
                    )
                  : const NoDataFoundWidget();
            }),
      ),
    );
  }
}
