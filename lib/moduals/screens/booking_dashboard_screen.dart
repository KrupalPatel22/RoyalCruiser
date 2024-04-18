import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/moduals/screens/payment_main_screen_v2.dart';
import 'package:royalcruiser/moduals/screens/ticket_detail_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:royalcruiser/widgets/no_data_found_widget.dart';
import 'package:xml/xml.dart';
import '../../api/api_imlementer.dart';
import '../../constants/color_constance.dart';
import '../../utils/ui/cliper_class.dart';

class MyBookingDashBoardScreen extends StatefulWidget {
  static const routeName = '/booking_dashboard_screen';

  const MyBookingDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingDashBoardScreen> createState() =>
      _MyBookingDashBoardScreenState();
}

class _MyBookingDashBoardScreenState extends State<MyBookingDashBoardScreen> {
  RxBool _isLoading = false.obs;
  String? UserId;
  String? UserEmail;
  String? UserPassword;

  @override
  void initState() {
    getData().then((value) {
      _isLoading.value = true;
    });
    super.initState();
  }

  Future<void> getData() async {
    UserId = NavigatorConstants.USER_ID;
    UserPassword = NavigatorConstants.USER_PASSWORD;
    UserEmail = NavigatorConstants.USER_EMAIL;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    TextStyle titletextStyle = TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD);

    TextStyle textStyle = TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white, size: 24),
        toolbarHeight: MediaQuery.of(context).size.height / 14,
        title: new Text(
          'My Booking',
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 0.5,
            fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
          ),
        ),
        actions: [

          // IconButton(onPressed: (){
          //
          //   Navigator.of(context).pushReplacementNamed(
          //       PaymentMainScreenV2.routeName,
          //       arguments: {
          //         'PGURL': "https://royalcruiser.com/E-Ticket.aspx?OrderID=671705",
          //         'OrderNo':
          //         "671705",
          //       });
          //
          //
          //
          // }, icon: Icon(Icons.add))

        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: FutureBuilder<XmlDocument>(
            future: ApiImplementer.Fetch_MyBookingsApiImplementer(
                EmailID: UserEmail!, Password: UserPassword!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return AppDialogs.screenAppShowDiloag(context);
              }
              else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error.toString()}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              List<XmlElement> MyBookingData =
                  snapshot.data!.findAllElements('MyBookingData').toList();
              Logger().d(MyBookingData);
              return MyBookingData.length > 0
                  ?
              ListView.builder(
                          itemCount: MyBookingData.length,
                          itemBuilder: (context, item) {
                            return InkWell(
                              onTap: () {
                                Get.to(() => TicketDetailScreen(
                                    fromCityname: '${MyBookingData[item].getElement("FromCityName")!.text}',
                                    toCityname: '${MyBookingData[item].getElement("ToCityName")!.text}',
                                    pickupTime: '${MyBookingData[item].getElement("PickupTime")!.text}',
                                    dropTime: '${MyBookingData[item].getElement("DropTime")!.text}',
                                    journeyTime: '${MyBookingData[item].getElement("DisplayJourneyDate")!.text}',
                                    bustourName: '${MyBookingData[item].getElement("PickupName")!.text}',
                                    seatNumber: '${MyBookingData[item].getElement("SeatList")!.text}',
                                    passengerName: "${MyBookingData[item].getElement("CustName")!.text}",
                                    ticketNo: "${MyBookingData[item].getElement("M_OrderID")!.text}",
                                    PNR: "${MyBookingData[item].getElement("PNRNo")!.text}",
                                    fare: "₹${MyBookingData[item].getElement("PNRAmount")!.text}",
                                  OrderId: "${MyBookingData[item].getElement("OrderID")!.text}",
                                  fromMybooking: true,
                                ),
                                );
                              },
                              child: Card(
                                color: CustomeColor.main_bg,
                                elevation: 2.0,
                                shadowColor: Colors.grey.shade800,
                                child: Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'PNR No : ',
                                                  style: titletextStyle,
                                                ),
                                                Text(
                                                  '${MyBookingData[item].getElement('PNRNo')!.text}',
                                                  style: textStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Journey Date : ',
                                                  style: titletextStyle,
                                                ),
                                                Text(
                                                  '${MyBookingData[item].getElement('JourneyDate')!.text}',
                                                  style: textStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Sub Route : ',
                                                  style: titletextStyle,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${MyBookingData[item].getElement('SubRoute')!.text}',
                                                    style: textStyle,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Time : ',
                                                  style: titletextStyle,
                                                ),
                                                Text(
                                                  '${MyBookingData[item].getElement('CityTime')!.text}',
                                                  style: textStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                  : NoDataFoundWidget();
            }),
      ),
    );
  }
}
