import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';
import 'package:royalcruiser/widgets/rounded_textInput_field_widget.dart';

class BusFilterApplicationScreen extends StatefulWidget {
  static const routeName = '/filter_screen';

  const BusFilterApplicationScreen({Key? key}) : super(key: key);

  @override
  _BusFilterApplicationScreenState createState() =>
      _BusFilterApplicationScreenState();
}

class _BusFilterApplicationScreenState
    extends State<BusFilterApplicationScreen> {
  bool ischeckBox1 = false;
  bool ischeckBox2 = false;
  bool ischeckBox3 = false;
  bool ischeckBox4 = false;
  List<int> departureList = [];
  RangeValues _currentRangeValues = const RangeValues(0, 0);
  bool AcBusBool = false;
  bool NonAcBusBool = false;
  TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Filter Screen'),
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                _firstWidget(),
                const SizedBox(
                  height: 15,
                ),
                _departureWidget(),
                const SizedBox(
                  height: 8,
                ),
                _busTypeWidget(),
                const SizedBox(
                  height: 8,
                ),
                _boardingPointWidget(),
                const SizedBox(
                  height: 8,
                ),
                _dropingPointWidget(),
                const SizedBox(
                  height: 8,
                ),
                _priceRangeWidget(),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _firstWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 10,
          ),
          const Image(
            image: AssetImage('assets/images/ic_action_exit.png'),
            height: 25,
          ),
          const Spacer(),
          const Text(
            'Filter',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _dropingPointWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.zero,
      color: CustomeColor.sub_bg,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        childrenPadding: EdgeInsets.zero,
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        title: const Text(
          'Dropping Point',
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        children: [
          Container(
            width: size.width,
            color: Colors.white,
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: RoundedTextInputFieldWidget(
              hintText: 'Dropping Point',
              prefixIcon: const Icon(Icons.bus_alert_rounded),
              textEditingController: textEditingController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _boardingPointWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.zero,
      color: CustomeColor.sub_bg,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        childrenPadding: EdgeInsets.zero,
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        title: const Text(
          'Boarding Point',
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        children: [
          Container(
            width: size.width,
            color: Colors.white,
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: RoundedTextInputFieldWidget(
              hintText: 'Boarding Point',
              prefixIcon: const Icon(Icons.bus_alert_rounded),
              textEditingController: textEditingController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _busTypeWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.zero,
      color: CustomeColor.sub_bg,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        childrenPadding: EdgeInsets.zero,
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        title: const Text(
          'Bus Type',
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        children: [
          Container(
            width: size.width,
            color: Colors.white,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Checkbox(
                      value: AcBusBool,
                      onChanged: (bool? value) {
                        setState(() {
                          AcBusBool = value!;
                        });
                      },
                    ),
                    const Text(
                      "Ac",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: NonAcBusBool,
                      onChanged: (bool? value) {
                        setState(() {
                          NonAcBusBool = value!;
                        });
                      },
                    ),
                    const Text(
                      "Non-Ac",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRangeWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.zero,
      color: CustomeColor.sub_bg,
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        childrenPadding: EdgeInsets.zero,
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        title: const Text(
          'Price Range',
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        children: [
          Container(
            width: size.width,
            color: Colors.white,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: RangeSlider(
              values: _currentRangeValues,
              onChanged: (RangeValues value) {
                setState(() {
                  _currentRangeValues = value;
                });
              },
              max: 100,
              divisions: 20,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _departureWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      padding: EdgeInsets.zero,
      color: CustomeColor.sub_bg,
      child: ExpansionTile(
        initiallyExpanded: true,
        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
        childrenPadding: EdgeInsets.zero,
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        title: const Text(
          'Departure',
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        children: [
          Container(
            width: size.width,
            color: Colors.white,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      ischeckBox1 = !ischeckBox1;
                      int a = 1;
                      ischeckBox1
                          ? departureList.add(a)
                          : departureList.remove(a);
                      departureList.forEach((element) {
                        element.compareTo(1) == 0 ? print("aa") : null;
                      });
                    });
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(5),
                    child: Container(
                      width: size.width / 5,
                      padding: const EdgeInsets.all(5),
                      color: ischeckBox1 ? CustomeColor.sub_bg : Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: const AssetImage(
                                'assets/images/ic_before_six_pm_normal.png'),
                            height: size.width * 0.07,
                            color: ischeckBox1 ? Colors.white : Colors.black,
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Before \n6am',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    ischeckBox1 ? Colors.white : Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      ischeckBox2 = !ischeckBox2;
                      int a = 2;
                      ischeckBox2
                          ? departureList.add(a)
                          : departureList.remove(a);
                      departureList.forEach((element) {
                        element.compareTo(2) == 0 ? print("aa") : null;
                      });
                    });
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(5),
                    child: Container(
                      width: size.width / 5,
                      padding: const EdgeInsets.all(5),
                      color: ischeckBox2 ? CustomeColor.sub_bg : Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: const AssetImage(
                                'assets/images/ic_twelve_pm_to_six_pm_normal.png'),
                            height: size.width * 0.07,
                            color: ischeckBox2 ? Colors.white : Colors.black,
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            '06:00 \n-12:00',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    ischeckBox2 ? Colors.white : Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      ischeckBox3 = !ischeckBox3;
                      int a = 3;
                      ischeckBox3
                          ? departureList.add(a)
                          : departureList.remove(a);
                      departureList.forEach((element) {
                        element.compareTo(3) == 0 ? print("aa") : null;
                      });
                    });
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(5),
                    child: Container(
                      width: size.width / 5,
                      padding: const EdgeInsets.all(5),
                      color: ischeckBox3 ? CustomeColor.sub_bg : Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: const AssetImage(
                                'assets/images/ic_six_am_to_twelve_pm_normal.png'),
                            height: size.width * 0.07,
                            color: ischeckBox3 ? Colors.white : Colors.black,
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            '12:00  \n-18:00',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    ischeckBox3 ? Colors.white : Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      ischeckBox4 = !ischeckBox4;
                      int a = 4;
                      ischeckBox4
                          ? departureList.add(a)
                          : departureList.remove(a);
                      departureList.forEach((element) {
                        element.compareTo(4) == 0 ? print("aa") : null;
                      });
                    });
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(5),
                    child: Container(
                      width: size.width / 5,
                      padding: const EdgeInsets.all(5),
                      color: ischeckBox4 ? CustomeColor.sub_bg : Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image: const AssetImage(
                                'assets/images/after_six_pm_normal.png'),
                            height: size.width * 0.07,
                            color: ischeckBox4 ? Colors.white : Colors.black,
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            'After \n18:00',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color:
                                    ischeckBox4 ? Colors.white : Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
