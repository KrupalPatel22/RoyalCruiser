import 'package:flutter/material.dart';
import 'package:royalcruiser/constants/common_constance.dart';

class RecentSearchWidget extends StatelessWidget {
  final String FormCity;
  final String ToCity;
  final String J_Date;
  final Function onTapItem;

  const RecentSearchWidget(
      {Key? key,
      required this.FormCity,
      required this.ToCity,
      required this.onTapItem,
      required this.J_Date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        child: InkWell(
          onTap: () => onTapItem(),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From :',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'To :',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily:
                              CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Date :',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: CommonConstants.FONT_FAMILY_OPEN_SANS_BOLD,
                      ),
                    ),
                    SizedBox(height: 5),

                  ],
                ),
                SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$FormCity',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily:
                              CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR),
                    ),
                    SizedBox(height: 5),

                    Text(
                      '$ToCity',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily:
                            CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '$J_Date',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily:
                        CommonConstants.FONT_FAMILY_OPEN_SANS_REGULAR,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
