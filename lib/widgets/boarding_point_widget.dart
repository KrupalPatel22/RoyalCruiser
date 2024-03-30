import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/model/boarding_and_dropping_point_model.dart';
import 'package:royalcruiser/utils/helpers/helper.dart';

class BoardingPointWidget extends StatefulWidget {
  final List<BoardingDroppingPointDetails> boardingPointList;
  final VoidCallback onNext;

  const BoardingPointWidget({
    Key? key,
    required this.onNext,
    required this.boardingPointList,
  }) : super(key: key);

  @override
  State<BoardingPointWidget> createState() => _BoardingPointWidgetState();
}

class _BoardingPointWidgetState extends State<BoardingPointWidget> {
  RxBool _isLoading = false.obs;
  RxString SelectedValue = "".obs;
  String? tripType;

  @override
  void initState() {
    _isLoading.value = true;
    tripType = NavigatorConstants.TRIP_TYPE;
    if (tripType == "0" || tripType == "1") {
      if (NavigatorConstants.SelectedBoardingPointOnwordID.isNotEmpty) {
        SelectedValue.value = NavigatorConstants.SelectedBoardingPointOnwordID;
        print(SelectedValue.value);
      }
    } else if (tripType == "2") {
      if (NavigatorConstants.SelectedBoardingPointReturnID.isNotEmpty) {
        SelectedValue.value = NavigatorConstants.SelectedBoardingPointReturnID;
        print(SelectedValue.value);
      }
    }
    super.initState();
  }

  void onTapData({required int index}) {
    SelectedValue.value = widget.boardingPointList[index].PickUpID ?? "";
    NavigatorConstants.SelectedBoardingPointNameForPage =
        widget.boardingPointList[index].PickUpName ?? "";
    if (tripType == "0" || tripType == "1") {
      setState(() {
        NavigatorConstants.SelectedBoardingPointOnwordID =
            widget.boardingPointList[index].PickUpID ?? "";
        NavigatorConstants.SelectedBoardingPointOnwordName =
            widget.boardingPointList[index].PickUpName ?? "";
        NavigatorConstants.SelectedBoardingPointOnwordTime =
            widget.boardingPointList[index].PickUpTime ?? "";
      });
      widget.onNext();
    } else if (tripType == "2") {
      setState(() {
        NavigatorConstants.SelectedBoardingPointReturnID =
            widget.boardingPointList[index].PickUpID ?? "";
        NavigatorConstants.SelectedBoardingPointReturnName =
            widget.boardingPointList[index].PickUpName ?? "";
        NavigatorConstants.SelectedBoardingPointReturnTime =
            widget.boardingPointList[index].PickUpTime ?? "";
      });
      widget.onNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
      !_isLoading.value
          ? Container()
          : SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              widget.boardingPointList.length,
                  (e) =>
                  InkWell(
                    onTap: () {
                      onTapData(index: e);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                              value: widget.boardingPointList[e].PickUpID,
                              groupValue: SelectedValue.value,
                              onChanged: (onChanged) {
                                onTapData(index: e);
                              }),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${widget.boardingPointList[e].PickUpName}',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: CommonConstants
                                          .FONT_FAMILY_OPEN_SANS_BOLD),
                                  textAlign: TextAlign.start,
                                ),
                                InkWell(
                                  onTap: () {
                                    Helper.openMap(
                                        widget.boardingPointList[e].latitude ??
                                            "",
                                        widget.boardingPointList[e].longitude ??
                                            "");

                                  },
                                  child: Text(
                                    'Locate on Google Maps',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.blue[900],
                                        fontFamily: CommonConstants
                                            .FONT_FAMILY_OPEN_SANS_BOLD),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text('${widget.boardingPointList[e].PickUpTime}')
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
}
