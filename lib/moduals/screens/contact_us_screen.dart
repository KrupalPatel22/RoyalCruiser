import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:royalcruiser/utils/ui/ui_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';

class ContactUsScreen extends StatefulWidget {
  static const routeName = '/new_contct_us_frg';

  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  RxBool _isLoading = false.obs;
  String? droupDownId;
  List<ContactUsData> contactdata = [];
  List<ContactUsData> contactdataListWithMap = [];
  ContactUsData? _contactUsDataIsHearOffice;

  @override
  void initState() {
    getData().then((value) => contactApiCall());
    super.initState();
  }

  Future<void> getData() async {
    // CommonConstants.SOURCE_CITY_NAME
  }

  void contactApiCall() {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.getContactDetailsListApiImplementer()
        .then((XmlDocument document) {
      Get.back();
      _isLoading.value = true;
      bool xmlElement = document.findAllElements('NewDataSet').isNotEmpty;
      if (xmlElement) {
        List<XmlElement> element =
            document.findAllElements('ContactDetailsList').toList();
        for (int i = 0; i < element.length; i++) {
          if (element[i].getElement('IsHoOffice')!.text == "1") {
            _contactUsDataIsHearOffice = ContactUsData(
              element[i].getElement('id')!.text ?? "",
              element[i].getElement('CityName')?.text.toString() ?? "",
              element[i].getElement('CityAreaName')?.text.toString() ?? "",
              element[i].getElement('StateName')?.text.toString() ?? "",
              element[i].getElement('Address')?.text.toString() ?? "",
              element[i].getElement('ContactNumber')?.text.toString() ?? "",
              element[i].getElement('EmailID')?.text.toString() ?? "",
              element[i].getElement('longitude')?.text.toString() ?? "",
              element[i].getElement('latitude')?.text.toString() ?? "",
              element[i].getElement('OrderBy')?.text.toString() ?? "",
              element[i].getElement('IsActive')?.text.toString() ?? "",
              element[i].getElement('IsHoOffice')?.text.toString() ?? "",
              element[i].getElement('pincode')?.text.toString() ?? "",
              element[i].getElement('ContactNumbers')?.text.toString() ?? "",
            );
          } else {
            ContactUsData contactUsData = ContactUsData(
              element[i].getElement('id')!.text.toString() ?? "",
              element[i].getElement('CityName')?.text.toString() ?? "",
              element[i].getElement('CityAreaName')?.text.toString() ?? "",
              element[i].getElement('StateName')?.text.toString() ?? "",
              element[i].getElement('Address')?.text.toString() ?? "",
              element[i].getElement('ContactNumber')?.text.toString() ?? "",
              element[i].getElement('EmailID')?.text.toString() ?? "",
              // "22.2504971930328",
              // "70.80188363661982",
              element[i].getElement('longitude')?.text.toString() ?? "",
              element[i].getElement('latitude')?.text.toString() ?? "",
              element[i].getElement('OrderBy')?.text.toString() ?? "",
              element[i].getElement('IsActive')?.text.toString() ?? "",
              element[i].getElement('IsHoOffice')?.text.toString() ?? "",
              element[i].getElement('pincode')?.text.toString() ?? "",
              element[i].getElement('ContactNumbers')?.text.toString() ?? "",
            );
            contactdata.add(contactUsData);
          }
        }
        var contactusMap = Set<String>();
        contactdataListWithMap = contactdata.where((country) {
          return contactusMap.add(country.CityName);
        }).toList();
      }
    }).catchError((onError) {
      print('  onError:::getDestinationsBasedOnSource===>$onError');
      Get.back();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: const Text(
          'Contact Us ',
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
                child: Column(
                  children: [
                    if (_contactUsDataIsHearOffice != null) ...[
                      Card(
                        elevation: 1.5,
                        margin: const EdgeInsets.all(8),
                        color: CustomeColor.sub_bg,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Head Office ',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: CommonConstants
                                      .FONT_FAMILY_OPEN_SANS_BOLD,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
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
                                _contactUsDataIsHearOffice!.CityAreaName,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: CommonConstants
                                      .FONT_FAMILY_OPEN_SANS_BOLD,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                _contactUsDataIsHearOffice!.Address,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: CommonConstants
                                      .FONT_FAMILY_OPEN_SANS_REGULAR,
                                ),
                              ),

                              Visibility(
                                visible: getMyVisiblity(),
                                child: InkWell(
                                  onTap: () async {
                                    final String googleMapsUrl =
                                        "https://www.google.com/maps/search/?api=1&query=${_contactUsDataIsHearOffice!.latitude},${_contactUsDataIsHearOffice!.longitude}";
                                    final String appleMapsUrl =
                                        "https://maps.apple.com/?q=${_contactUsDataIsHearOffice!.latitude},${_contactUsDataIsHearOffice!.longitude}";

                                    if (await canLaunch(googleMapsUrl)) {
                                      await launch(googleMapsUrl);
                                    } else if (await canLaunch(appleMapsUrl)) {
                                      await launch(appleMapsUrl);
                                    } else {
                                      throw 'Could not launch map URL';
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "Open In Map",
                                        style: TextStyle(
                                            color: CustomeColor.main_bg),
                                      ),
                                      Icon(
                                        Icons.location_pin,
                                        color: CustomeColor.main_bg,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 2),
                              Text(
                                _contactUsDataIsHearOffice!.StateName,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: CommonConstants
                                      .FONT_FAMILY_OPEN_SANS_REGULAR,
                                ),
                              ),
                              const SizedBox(height: 5),

                              //Old MG code
                              // HtmlWidget(
                              //   _contactUsDataIsHearOffice!.ContactNumber,
                              // ),

                              //new Krupal code (27 march 24)
                              InkWell(
                                  onTap: () {
                                    getPhonenumberForCall(
                                        _contactUsDataIsHearOffice!
                                            .ContactNumbers);
                                  },
                                  child: Text(_contactUsDataIsHearOffice!
                                      .ContactNumber))
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
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
                            hint: const Text("-Select-"),
                            icon: const Image(
                              image:
                                  AssetImage('assets/images/ic_dropdown.png'),
                            ),
                            isExpanded: true,
                            value: droupDownId,
                            items: [
                              ...contactdataListWithMap
                                  .map(
                                    (e) => DropdownMenuItem(
                                      child: Text(e.CityName),
                                      value:
                                          e.CityName.toLowerCase().toString(),
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (droupDownId != null)
                              for (int i = 0; i < contactdata.length; i++)
                                if (droupDownId ==
                                    contactdata[i]
                                        .CityName
                                        .toLowerCase()
                                        .toString()) ...{
                                  Card(
                                    elevation: 2.0,
                                    margin: const EdgeInsets.all(5),
                                    child: Container(
                                      width: size.width,
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            contactdata[i].CityAreaName,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: CommonConstants
                                                  .FONT_FAMILY_OPEN_SANS_BOLD,
                                              wordSpacing: 2.0,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            contactdata[i].Address,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: CommonConstants
                                                  .FONT_FAMILY_OPEN_SANS_REGULAR,
                                            ),
                                          ),
                                          TrackAddressinGoogleMap(i),
                                          const SizedBox(height: 10),
                                          Text(
                                            contactdata[i].StateName,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontFamily: CommonConstants
                                                  .FONT_FAMILY_OPEN_SANS_REGULAR,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          //Old Code MG
                                          // HtmlWidget(
                                          //   contactdata[i].ContactNumber,
                                          // )

                                          //New Code Krupal
                                          InkWell(
                                            onTap: () {
                                              getPhonenumberForCall(
                                                  contactdata[i]
                                                      .ContactNumbers);
                                            },
                                            child: Text(
                                                contactdata[i].ContactNumber),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                }
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10)
                  ],
                ),
              )
            : Container(),
      ),
    );
  }

  _makePhoneCall(String phoneNumber) async {
    final url = 'tel://$phoneNumber';
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      UiUtils.errorSnackBar(title: "Error", message: "Unable to make call")
          .show();
      throw 'Could not launch $url';
    }
  }

  void getPhonenumberForCall(String contactNumbers) {
    List<String> moNoList = contactNumbers.split(",");
    print(moNoList);
    print("My Length : ${moNoList.length}");

    if (moNoList.length > 1) {
      showDialog(
          context: context,
          barrierLabel: "Text",
          builder: (ctx) {
            return Dialog(
                backgroundColor: Colors.white,
                shadowColor: CustomeColor.main_bg,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      "Select Number",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomeColor.main_bg),
                    ),
                    SizedBox(height: 10),
                    ...List.generate(
                        moNoList.length,
                        (index) => Container(
                              margin:
                                  EdgeInsets.only(right: 10, left: 10, top: 10),
                              child: InkWell(
                                  onTap: () {
                                    _makePhoneCall(moNoList[index]);
                                  },
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${moNoList[index]}",
                                          style: TextStyle(fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Icon(Icons.call,
                                          color: CustomeColor.main_bg)
                                    ],
                                  )),
                            )),
                  ]),
                ));
          });
    } else {
      _makePhoneCall(moNoList.first);
    }
  }

  Widget TrackAddressinGoogleMap(int i) {
    if (contactdata[i].latitude != null &&
        contactdata[i].latitude.isNotEmpty &&
        contactdata[i].latitude != "0" &&
        contactdata[i].longitude != null &&
        contactdata[i].longitude.isNotEmpty &&
        contactdata[i].longitude != "0") {
      return Column(
        children: [
          SizedBox(height: 5),
          InkWell(
            onTap: () async {
              final String googleMapsUrl =
                  "https://www.google.com/maps/search/?api=1&query=${contactdata[i].latitude},${contactdata[i].longitude}";
              final String appleMapsUrl =
                  "https://maps.apple.com/?q=${contactdata[i].latitude},${contactdata[i].longitude}";

              if (await canLaunch(googleMapsUrl)) {
                await launch(googleMapsUrl);
              } else if (await canLaunch(appleMapsUrl)) {
                await launch(appleMapsUrl);
              } else {
                throw 'Could not launch map URL';
              }
            },
            child: Row(
              children: [
                Text(
                  "Open In Map",
                  style: TextStyle(color: CustomeColor.main_bg),
                ),
                Icon(
                  Icons.location_pin,
                  color: CustomeColor.main_bg,
                  size: 20,
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  getMyVisiblity() {
    if (_contactUsDataIsHearOffice!.latitude != null &&
        _contactUsDataIsHearOffice!.latitude.isNotEmpty &&
        _contactUsDataIsHearOffice!.latitude != "0" &&
        _contactUsDataIsHearOffice!.longitude != null &&
        _contactUsDataIsHearOffice!.longitude.isNotEmpty &&
        _contactUsDataIsHearOffice!.longitude != "0") {
      return true;
    } else {
      return false;
    }
  }
}

class ContactUsData {
  String id = '';
  String CityName = '';
  String CityAreaName = '';
  String StateName = '';
  String Address = '';
  String ContactNumber = '';
  String EmailID = '';
  String longitude = '';
  String latitude = '';
  String OrderBy = '';
  String IsActive = '';
  String IsHoOffice = '';
  String pincode = '';
  String ContactNumbers = '';

  ContactUsData(
    this.id,
    this.CityName,
    this.CityAreaName,
    this.StateName,
    this.Address,
    this.ContactNumber,
    this.EmailID,
    this.longitude,
    this.latitude,
    this.OrderBy,
    this.IsActive,
    this.IsHoOffice,
    this.pincode,
    this.ContactNumbers,
  );
}
