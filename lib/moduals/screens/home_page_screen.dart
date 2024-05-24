import 'dart:convert';
import 'dart:math';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/constants/navigation_constance.dart';
import 'package:royalcruiser/constants/preferences_costances.dart';
import 'package:royalcruiser/model/recent_search_model.dart';
import 'package:royalcruiser/moduals/screens/avilable_route_screen.dart';
import 'package:royalcruiser/moduals/screens/from_city_screen.dart';
import 'package:royalcruiser/moduals/screens/to_city_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:royalcruiser/utils/ui/ui_utils.dart';
import 'package:royalcruiser/widgets/custome_image_slider.dart';
import 'package:royalcruiser/widgets/recent_search_widget.dart';
import 'package:royalcruiser/widgets/textinput_field_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageFragmnet extends StatefulWidget {
  static const routeName = '/home_page_frg';

  const HomePageFragmnet({Key? key}) : super(key: key);

  @override
  State<HomePageFragmnet> createState() => _HomePageFragmnetState();
}

class _HomePageFragmnetState extends State<HomePageFragmnet> {
  SharedPreferences? _sharedPreferences;
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  TextEditingController toCitytextEditingController = TextEditingController();
  TextEditingController fromCitytextEditingController = TextEditingController();

  DateFormat formatter_only_date = DateFormat('dd');
  DateFormat formatter_week_name = DateFormat('EEEE');
  DateFormat formatter_month_with_year = DateFormat('MMMM yyyy');
  DateFormat formatter_api_call = DateFormat('dd-MM-yyyy');
  DateTime now = DateTime.now();

  String? onward_only_date;
  String? onward_only_week;
  String? onward_only_month_with_year;

  String? return_only_date;
  String? return_only_week;
  String? return_only_month_with_year;

  RxString return_date = "".obs;
  RxString onward_date = "".obs;

  bool _visibility = false;
  RxBool _isrecentSearchLoad = false.obs;

  List<RecentSeaechModel> recentSearchList = [];
  List<RecentSeaechModel> recentSearchListfinal = [];

  List<String> sliderImagesList = [];
  String? popup_visible;

  //RxBool _isLoading = false.obs;

  void removeData() {
    NavigatorConstants.SELECTED_SEAT_LIST_ONWARD = '';
    NavigatorConstants.SELECTED_SEAT_LIST_RETURN = '';

    NavigatorConstants.ALL_ROUTE_LIST_ONWARD = '';
    NavigatorConstants.ALL_ROUTE_LIST_RETURN = '';

    NavigatorConstants.BOARDING_POINT_ONWARD_ARRAY = '';
    NavigatorConstants.DROPPING_POINT_ONWARD_ARRAY = '';
    NavigatorConstants.BOARDING_POINT_RETURN_ARRAY = '';
    NavigatorConstants.DROPPING_POINT_RETURN_ARRAY = '';

    NavigatorConstants.SelectedBoardingPointOnwordID = '';
    NavigatorConstants.SelectedDroppingPointOnwordID = '';
    NavigatorConstants.SelectedBoardingPointReturnID = '';
    NavigatorConstants.SelectedDroppingPointReturnID = '';

    NavigatorConstants.SelectedBoardingPointNameForPage = '';
    NavigatorConstants.SelectedDroppingPointNameForPage = '';

    NavigatorConstants.SelectedBoardingPointOnwordName = '';
    NavigatorConstants.SelectedDroppingPointOnwordName = '';
    NavigatorConstants.SelectedBoardingPointReturnName = '';
    NavigatorConstants.SelectedDroppingPointReturnName = '';

    NavigatorConstants.SelectedBoardingPointOnwordTime = '';
    NavigatorConstants.SelectedDroppingPointOnwordTime = '';
    NavigatorConstants.SelectedBoardingPointReturnTime = '';
    NavigatorConstants.SelectedDroppingPointReturnTime = '';
  }

  void onTapSearch(String? recentDate) {
    if(recentDate != ""){
      NavigatorConstants.ONWARD_DATE = recentDate!;
    }else{
      NavigatorConstants.ONWARD_DATE = onward_date.value;
    }
    NavigatorConstants.SelectedDroppingPointOnwordID = '0';
    NavigatorConstants.SelectedDroppingPointReturnID = '0';
    if (_visibility == true) {
      if (return_date.value.isEmpty) {
        //ToastMsg(message: 'please select return date');
        UiUtils.errorSnackBar(message: 'please select return date').show();
      } else {
        NavigatorConstants.RETURN_DATE = return_date.value;
        NavigatorConstants.TRIP_TYPE = "1";
        Navigator.of(context).pushNamed(AvailableRoutesAppScreen.routeName);
      }
    }
    else if (_visibility == false) {
      NavigatorConstants.TRIP_TYPE = "0";
      NavigatorConstants.RETURN_DATE = '';
      Navigator.of(context).pushNamed(AvailableRoutesAppScreen.routeName);
    }
  }

  bool _isValid() {
    if (fromCitytextEditingController.text.isEmpty) {
      // ToastMsg(message: 'please select source city');
      UiUtils.errorSnackBar(message: 'please select source city').show();
      return false;
    } else if (toCitytextEditingController.text.isEmpty) {
      // ToastMsg(message: 'please select destination city');
      UiUtils.errorSnackBar(message: 'please select destination city').show();
      return false;
    } else if (onward_date == null) {
      // ToastMsg(message: 'Please select your journey date');
      UiUtils.errorSnackBar(message: 'Please select your journey date').show();
      return false;
    }
    return true;
  }

  @override
  void initState() {
    popup_visible = NavigatorConstants.POP_UP_BANNER_BOOL;
    _pref.then((SharedPreferences sharedPreferences) {
      _sharedPreferences = sharedPreferences;
      print("My banner :- ${NavigatorConstants.POP_UP_BANNER}");
      var pop = json.decode(NavigatorConstants.POP_UP_BANNER);
      if (pop != null) {
        for (var banner in pop) {
          print('banner============>$banner');
          sliderImagesList.add(banner);
        }
      }

      var resent = json.decode(_sharedPreferences!.getString(Preferences.RECENT_SEARCH).toString());
      if (resent != null)
        for (var search in resent) {
          recentSearchList.add(RecentSeaechModel.fromJson(search));
        }
      recentSearchListfinal = recentSearchList.reversed.toList();
    }).then((value) {
      if (sliderImagesList.length > 0 && popup_visible!.compareTo("0") == 0) {
        NavigatorConstants.POP_UP_BANNER_BOOL = '1';
        dialogBoxBanner();
      }
      _isrecentSearchLoad.value = true;
    });
    removeData();
    NavigatorConstants.ONWARD_DATE = '';
    NavigatorConstants.RETURN_DATE = '';
    dateformandtoBydefault();
    super.initState();
  }

  Future<void> dialogBoxBanner() async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Dialog(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomImageSliderWithIndicator(
                        imageSliders: sliderImagesList,
                      ),
                      Positioned(
                        right: -20.0,
                        top: -20.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.close),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // contentPadding: const EdgeInsets.all(0.0),
            ),
          );
        });
  }

  Future<void> dateformandtoBydefault() async {
    //todo onwoard date
    onward_only_date = formatter_only_date.format(now);
    onward_only_week = formatter_week_name.format(now);
    onward_only_month_with_year = formatter_month_with_year.format(now);
    onward_date.value = formatter_api_call.format(now);
    //todo return date
    return_only_date = formatter_only_date.format(now);
    return_only_week = formatter_week_name.format(now);
    return_only_month_with_year = formatter_month_with_year.format(now);
  }

  void ToastMsg({required String message}) {
    SnackBar snackBar = SnackBar(
      content: Text(
        '$message',
        style: TextStyle(
          fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
          fontSize: 14,
        ),
      ),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width * 0.01;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: Container(
          color: CustomeColor.main_bg,
          padding: EdgeInsets.symmetric(vertical: 5),
          child: SafeArea(
            maintainBottomViewPadding: false,
            child: Card(
              elevation: 3.0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: const Image(
                    image: AssetImage(
                      'assets/images/royal_logo.png',
                    ),
                    // fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
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
          Container(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 5),
                      _dynamicTabBar(),
                      SizedBox(height: 15),
                      _citySelection(),
                      SizedBox(height: 10),
                      onwardJourneyWidget(),
                      SizedBox(height: 10),
                      returnJourneyWidget(),
                      SizedBox(height: 10),
                      searchBusesWidget(),
                      SizedBox(height: 15),
                      recentSearchWidget(),
                    ],
                  ).paddingAll(8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dynamicTabBar() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomeColor.main_bg,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _visibility = false;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _visibility == false ? CustomeColor.sub_bg : Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Text(
                  'One-way',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _visibility == false ? Colors.white : Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: _visibility == false ? CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD : CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  _visibility = true;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _visibility == true ? CustomeColor.sub_bg : Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Text(
                  'Round-trip',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _visibility == true ? Colors.white : Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: _visibility == true ? CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD : CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _citySelection() {
    Size size = MediaQuery.of(context).size;
    BorderRadius borderRadiusAll = const BorderRadius.all(Radius.circular(25));
    return Stack(
      children: [
        Column(
          children: [
            InkWell(
              borderRadius: borderRadiusAll,
              highlightColor: Colors.transparent,
              onTap: () => pushNamedFromCityScreen(context),
              child: TextInputFieldWidget(
                textEditingController: fromCitytextEditingController,
                hintText: 'Select From City',
                upperText: 'From',
                prefixIcon: Image(
                  image: const AssetImage('assets/images/06.png'),
                  height: 20,
                  color: CustomeColor.main_bg,
                ),
              ),
            ),
            SizedBox(height: 10),
            InkWell(
              borderRadius: borderRadiusAll,
              highlightColor: Colors.transparent,
              onTap: () {
                if (fromCitytextEditingController.text.isNotEmpty) {
                  pushNamedToCityScreen(context);
                }
              },
              child: TextInputFieldWidget(
                textEditingController: toCitytextEditingController,
                hintText: 'Select To City',
                upperText: 'To',
                prefixIcon: Image(
                  image: const AssetImage('assets/images/01.png'),
                  height: 30,
                  color: CustomeColor.main_bg,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: size.height / 18,
          left: size.width / 1.32,
          child: InkWell(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            onTap: () {
              if (fromCitytextEditingController.text.isNotEmpty && toCitytextEditingController.text.isNotEmpty) {
                changeCityIcon();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                shape: BoxShape.circle,
                color: CustomeColor.sub_bg,
              ),
              child: Icon(
                Icons.swap_vert,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget onwardJourneyWidget() {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2101),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: CustomeColor.sub_bg,
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      // primary: CustomeColor.sub_bg,
                      ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          print('onwardDate:::');
          setState(() {
            onward_only_date = formatter_only_date.format(pickedDate);
            onward_only_week = formatter_week_name.format(pickedDate);
            onward_only_month_with_year = formatter_month_with_year.format(pickedDate);
            onward_date.value = "${formatter_api_call.format(pickedDate)}";
            return_only_date = formatter_only_date.format(pickedDate);
            return_only_week = formatter_week_name.format(pickedDate);
            return_only_month_with_year = formatter_month_with_year.format(pickedDate);
            return_date.value = "";
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          border: Border.all(
            color: CustomeColor.main_bg,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Image(
                image: const AssetImage('assets/images/07.png'),
                height: 30,
                color: CustomeColor.sub_bg,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '$onward_only_date',
                        style: TextStyle(
                          fontSize: 26,
                          fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              '$onward_only_week',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              '$onward_only_month_with_year',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget returnJourneyWidget() {
    return Obx(
      () => Visibility(
        visible: _visibility,
        child: InkWell(
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.parse(DateFormat("dd-MM-yyyy").parse(onward_date.toString()).toString()),
              firstDate: DateTime.parse(DateFormat("dd-MM-yyyy").parse(onward_date.toString()).toString()),
              lastDate: DateTime(2101),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: CustomeColor.sub_bg,
                      onPrimary: Colors.white,
                      onSurface: Colors.black,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                          // primary: CustomeColor.sub_bg,
                          ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (pickedDate != null) {
              print('returnDate:::');
              setState(() {
                return_only_date = formatter_only_date.format(pickedDate);
                return_only_week = formatter_week_name.format(pickedDate);
                return_only_month_with_year = formatter_month_with_year.format(pickedDate);
                return_date.value = "${formatter_api_call.format(pickedDate)}";
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              border: Border.all(
                color: CustomeColor.main_bg,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Image(
                    image: const AssetImage('assets/images/07.png'),
                    height: 30,
                    color: CustomeColor.sub_bg,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            '$return_only_date',
                            style: TextStyle(
                              fontSize: 26,
                              fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                              color: return_date.value.isEmpty ? Colors.grey.shade500 : null,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '$return_only_week',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                                    color: return_date.value.isEmpty ? Colors.grey.shade500 : null,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '$return_only_month_with_year',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                                    color: return_date.value.isEmpty ? Colors.grey.shade500 : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchBusesWidget() {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
          color: CustomeColor.sub_bg,
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Search Buses',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
              ),
            ).paddingSymmetric(horizontal: 10),
            // SizedBox(width: 10),
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: Colors.white,
              size: 25,
            ).paddingSymmetric(horizontal: 5)
          ],
        ),
      ),
      onTap: () {
        if (_isValid()) {
          removeData();
          onTapSearch("");
        }
      },
    );
  }

  Widget recentSearchWidget() {
    return Obx(() => _isrecentSearchLoad.value
          ? recentSearchListfinal.length > 0
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Search',
                        style: TextStyle(fontSize: 18, fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD),
                      ).paddingOnly(left: 8),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...recentSearchListfinal.map((e) => RecentSearchWidget(
                                FormCity: e.S_CityName,
                                ToCity: e.D_CityName,
                                J_Date: e.J_Date,
                                onTapItem: () {
                                  NavigatorConstants.SOURCE_CITY_NAME = e.S_CityName;
                                  NavigatorConstants.SOURCE_CITY_ID = e.S_CityID;
                                  NavigatorConstants.DESTINATION_CITY_NAME = e.D_CityName;
                                  NavigatorConstants.DESTINATION_CITY_ID = e.D_CityID;
                                  fromCitytextEditingController.text = e.S_CityName;
                                  toCitytextEditingController.text = e.D_CityName;
                                  onTapSearch(e.J_Date);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink()
          : const SizedBox.shrink(),
    );
  }

  void changeCityIcon() {
    String formcity = fromCitytextEditingController.text;
    String tocity = toCitytextEditingController.text;

    var sharedformcity = NavigatorConstants.SOURCE_CITY_ID;
    var sharedtocity = NavigatorConstants.DESTINATION_CITY_ID;
    var sharedformcityid = NavigatorConstants.SOURCE_CITY_NAME;
    var sharedtocityid = NavigatorConstants.DESTINATION_CITY_NAME;

    NavigatorConstants.SOURCE_CITY_ID = sharedtocity;
    NavigatorConstants.DESTINATION_CITY_ID = sharedformcity;
    NavigatorConstants.SOURCE_CITY_NAME = sharedtocityid;
    NavigatorConstants.DESTINATION_CITY_NAME = sharedformcityid;

    setState(() {
      fromCitytextEditingController.text = tocity;
      toCitytextEditingController.text = formcity;
    });
  }

  pushNamedFromCityScreen(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(FromCitySearchApplicationScreen.routeName);
    if (result != null) {
      fromCitytextEditingController.text = '$result';
      toCitytextEditingController.clear();
    }
  }

  pushNamedToCityScreen(BuildContext context) async {
    final result1 = await Navigator.of(context).pushNamed(ToCitySearchApplicationScreen.routeName);
    if (result1 != null) {
      toCitytextEditingController.text = '$result1';
    }
  }
}
