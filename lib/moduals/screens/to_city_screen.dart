import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/api/api_imlementer.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/model/destination_city_model.dart';
import 'package:royalcruiser/moduals/screens/no_internet_or_error_screen.dart';
import 'package:royalcruiser/utils/app_dialog.dart';
import 'package:royalcruiser/widgets/dynamic_appbar_search_widget.dart';
import 'package:royalcruiser/widgets/no_data_found_widget.dart';
import 'package:xml/xml.dart';

class ToCitySearchApplicationScreen extends StatefulWidget {
  static const routeName = '/to_city_screen';

  const ToCitySearchApplicationScreen({Key? key}) : super(key: key);

  @override
  State<ToCitySearchApplicationScreen> createState() =>
      _ToCitySearchApplicationScreenState();
}

class _ToCitySearchApplicationScreenState
    extends State<ToCitySearchApplicationScreen> {
  final List<ITSDestinations> _tocityList1 = [];
  late final RxList<ITSDestinations> _tocityList = RxList<ITSDestinations>([]);
  String? sourceId;
  final RxBool _isLoading = false.obs;

  @override
  void initState() {
    getData().then((value) {
      getDestinationsBasedOnSource(sourceCityID: sourceId!);
    });
    super.initState();
  }

  Future<void> getData() async {
    // CommonConstants.SOURCE_CITY_NAME
    sourceId = NavigatorConstants.SOURCE_CITY_ID;
  }

  void onClear() {
    _tocityList.value = _tocityList1;
  }

  void onTextSearching(String searchText) {
    if (searchText.isNotEmpty) {
      _tocityList.value = _tocityList.where((element) => element.CM_CityName.toString()
          .trim()
          .toLowerCase()
          .contains(searchText.trim().toLowerCase()))
          .toList();
    } else if (searchText.isEmpty) {
      _tocityList.value =
          _tocityList1;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(size.height / 14),
        child: DynamicAppbarForSearchingWidget(
          onClear: onClear,
          onTextSearching: onTextSearching,
          labelName: 'To City',
        ),
      ),
      body: Obx(
        () => _isLoading.value
            ? SafeArea(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: _tocityList.length > 0
                      ? ListView.builder(
                          itemCount: _tocityList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.all(8),
                              elevation: 2.0,
                              color: Colors.white,
                              child: ListTile(
                                onTap: () {
                                  onTapEvent(index: index);
                                },
                                leading: const Icon(Icons.location_on_outlined),
                                title: Text(
                                  _tocityList[index].CM_CityName.toString(),
                                ),
                              ),
                            );
                          },
                        )
                      : const NoDataFoundWidget(),
                ),
              )
            : Container(),
      ),
    );
  }


  void onTapEvent({required int index}) {
   NavigatorConstants.DESTINATION_CITY_NAME = _tocityList[index].CM_CityName.toString();
   NavigatorConstants.DESTINATION_CITY_ID = _tocityList[index].CM_CityID.toString();
    Navigator.of(context).pop('${_tocityList[index].CM_CityName.toString()}');
  }

  void getDestinationsBasedOnSource({required String sourceCityID}) {
    AppDialogs.showProgressDialog(context: context);
    ApiImplementer.getDestinationsBasedOnSourceApiImplementer(
            sourceID: sourceCityID)
        .then((XmlDocument document) {
      _isLoading.value = true;
      Get.back();
      bool xmlElement = document.findAllElements('NewDataSet').isNotEmpty;
      if (xmlElement) {
        List<XmlElement> element =
            document.findAllElements('ITSDestinations').toList();
        for (int i = 0; i < element.length; i++) {
          ITSDestinations destinations = ITSDestinations(
              CM_CityID: element[i].getElement('CM_CityID')!.text,
              CM_CityName: element[i].getElement('CM_CityName')!.text);
          _tocityList.add(destinations);
        }
      }
    }).catchError((onError) {
      Get.back();
      Navigator.of(context)
          .pushReplacementNamed(NoInterNetOrErrorScreen.routeName);
      print('  onError:::getDestinationsBasedOnSource===>$onError');
    });
  }
}
