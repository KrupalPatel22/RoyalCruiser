import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/model/boarding_and_dropping_point_model.dart';
import 'package:royalcruiser/moduals/screens/avilable_route_screen.dart';
import 'package:royalcruiser/moduals/screens/passenger_info_screen.dart';

class DroppingPointWidget extends StatefulWidget {
  final List<BoardingDroppingPointDetails> droppingPointList;
  final VoidCallback onNext;

  DroppingPointWidget({
    Key? key,
    required this.droppingPointList,
    required this.onNext,
  }) : super(key: key);

  @override
  State<DroppingPointWidget> createState() => _DroppingPointWidgetState();
}

class _DroppingPointWidgetState extends State<DroppingPointWidget> {
  RxBool _isLoading = false.obs;
  RxString SelectedValue = "".obs;
  String? tripType;

  @override
  void initState() {
    _isLoading.value = true;
    tripType = NavigatorConstants.TRIP_TYPE;
    if (tripType == "0" || tripType == "1") {
      if (NavigatorConstants.SelectedDroppingPointOnwordID.isNotEmpty) {
        SelectedValue.value = NavigatorConstants.SelectedDroppingPointOnwordID;
        print(SelectedValue.value);
      }
    } else if (tripType == "2") {
      if (NavigatorConstants.SelectedDroppingPointReturnID.isNotEmpty) {
        SelectedValue.value = NavigatorConstants.SelectedDroppingPointReturnID;
        print(SelectedValue.value);
      }
    }
    super.initState();
  }

  void onTapData({required int index}) {
    SelectedValue.value = widget.droppingPointList[index].PickUpID;
    NavigatorConstants.SelectedDroppingPointNameForPage= widget.droppingPointList[index].PickUpName;
    if (tripType == "0" || tripType == "1") {
      setState(() {
       NavigatorConstants.SelectedDroppingPointOnwordID = widget.droppingPointList[index].PickUpID;
       NavigatorConstants.SelectedDroppingPointOnwordName = widget.droppingPointList[index].PickUpName;
       NavigatorConstants.SelectedDroppingPointOnwordTime = widget.droppingPointList[index].PickUpTime;
      });
      widget.onNext();
    } else if (tripType == "2") {
      setState(() {
        NavigatorConstants.SelectedDroppingPointReturnID = widget.droppingPointList[index].PickUpID;
        NavigatorConstants.SelectedDroppingPointReturnName = widget.droppingPointList[index].PickUpName;
        NavigatorConstants.SelectedDroppingPointReturnTime = widget.droppingPointList[index].PickUpTime;
      });
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !_isLoading.value
          ? Container()
          : SingleChildScrollView(
            child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    widget.droppingPointList.length,
                    (e) => InkWell(
                      onTap: () {
                        onTapData(index: e);
                        if(NavigatorConstants.SelectedBoardingPointNameForPage.isNotEmpty)
                          {
                            pageRedirect();
                          }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                                value: widget.droppingPointList[e].PickUpID,
                                groupValue: SelectedValue.value,
                                onChanged: (onChanged) {
                                  onTapData(index: e);
                                  if(NavigatorConstants.SelectedBoardingPointNameForPage.isNotEmpty)
                                  {
                                    pageRedirect();
                                  }
                                }),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${widget.droppingPointList[e].PickUpName}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: CommonConstants
                                            .FONT_FAMILY_OPEN_SANS_BOLD),
                                    textAlign: TextAlign.start,
                                  ),

                                ],
                              ),
                            ),
                            Text('${widget.droppingPointList[e].PickUpTime}')
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ),
    );
  }

  void pageRedirect() {
    tripType = NavigatorConstants.TRIP_TYPE;

      if (tripType == "0") {
        Navigator.of(context).pushNamed(PassengerInfoScreen.routeName);
      } else if (tripType == "1") {
        NavigatorConstants.TRIP_TYPE = "2";
        Navigator.of(context).pushNamed(AvailableRoutesAppScreen.routeName);
      } else if (tripType == "2") {
        Navigator.of(context).pushNamed(PassengerInfoScreen.routeName);
      }
    }

}
