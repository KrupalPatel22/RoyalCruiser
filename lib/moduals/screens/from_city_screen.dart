import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/preferences_costances.dart';
import 'package:royalcruiser/model/source_city_model.dart';
import 'package:royalcruiser/widgets/dynamic_appbar_search_widget.dart';
import 'package:royalcruiser/widgets/no_data_found_widget.dart';

import 'package:shared_preferences/shared_preferences.dart';

class FromCitySearchApplicationScreen extends StatefulWidget {
  static const routeName = '/form_city_screen';

  const FromCitySearchApplicationScreen({Key? key}) : super(key: key);

  @override
  State<FromCitySearchApplicationScreen> createState() =>
      _FromCitySearchApplicationScreenState();
}

class _FromCitySearchApplicationScreenState
    extends State<FromCitySearchApplicationScreen> {
  final RxBool _isLoading = false.obs;
  SharedPreferences? _sharedPreferences;
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final RxList<ITSSources> _sourceCity1 = RxList<ITSSources>([]);

  late final RxList<ITSSources> _sourceCity = RxList<ITSSources>([]);


  @override
  void initState() {
    _pref.then((SharedPreferences sharedPreferences) {
      _sharedPreferences = sharedPreferences;
      var source = json.decode(
          _sharedPreferences!.getString(NavigatorConstants.SOURCE_CITY).toString());
      if (source != null){
        for (var search in source) {
          _sourceCity.add(ITSSources.from(search));
        }
      }
    }).then((value) {
      _isLoading.value = true;
    });
    super.initState();
  }
  void onClear() {
    _sourceCity.value = _sourceCity1.value;
  }

  void onTextSearching(String searchText) {
    if (searchText.isNotEmpty) {
      _sourceCity.value = _sourceCity.where((element) => element.CM_CityName.toString()
          .trim()
          .toLowerCase()
          .contains(searchText.trim().toLowerCase()))
          .toList();
    } else if (searchText.isEmpty) {
      _sourceCity.value =
          _sourceCity1.value;
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
          labelName: 'From City',
        ),
      ),
      body: Obx(
        () => _isLoading.value
            ? SizedBox(
              height: size.height,
              width: size.width,
              child: _sourceCity.length > 0
                  ? ListView.builder(
                      itemCount: _sourceCity.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(8),
                          elevation: 2.0,
                          color: Colors.white,
                          child: ListTile(
                            onTap: () {
                              getPrefRemove();
                              onTapEvent(index: index);
                            },
                            leading: Container(
                              child: const Icon(Icons.location_on_outlined),
                            ),
                            title: Text(
                              _sourceCity[index].CM_CityName.toString(),
                            ),
                          ),
                        );
                      },
                    )
                  : const NoDataFoundWidget(),
            )
            : Container(),
      ),
    );
  }

  void getPrefRemove() {
    NavigatorConstants.DESTINATION_CITY_NAME = '';
    NavigatorConstants.DESTINATION_CITY_ID = '';
  }

  void onTapEvent({required int index}) {
    NavigatorConstants.SOURCE_CITY_NAME = _sourceCity[index].CM_CityName.toString();
    NavigatorConstants.SOURCE_CITY_ID = _sourceCity[index].CM_CityID.toString();
    Navigator.of(context).pop('${_sourceCity[index].CM_CityName.toString()}');

  }
}
