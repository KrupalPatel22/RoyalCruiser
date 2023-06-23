import 'package:royalcruiser/constants/common_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class NoDataFoundWidget extends StatefulWidget {
  final String? msg;

  const NoDataFoundWidget({Key? key, this.msg = 'No Data Found!'})
      : super(key: key);

  @override
  State<NoDataFoundWidget> createState() => _NoDataFoundWidgetState();
}

class _NoDataFoundWidgetState extends State<NoDataFoundWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/no_data_found.svg',
            height: 70,
            width: 70,

          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${widget.msg}',
            style: TextStyle(

              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
