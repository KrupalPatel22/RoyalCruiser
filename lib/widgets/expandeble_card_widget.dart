import 'package:flutter/material.dart';
import 'package:royalcruiser/constants/color_constance.dart';
import 'package:royalcruiser/constants/common_constance.dart';



class ExpandableCardContainerWidget extends StatefulWidget {
  bool isCardExpandedBool;
  bool onlyNormalWidgetBool;
  double normalWidgetHeight;
  double headerWidth;
  double expandedwidgetHeight;
  double normalWidgetWidth;
  double expandedwidgetWidth;
  double avatarRadius;
  Widget normalWidget;
  Widget expandedwidget;
  String headerText;

  ExpandableCardContainerWidget({
    required this.isCardExpandedBool,
    required this.headerWidth,
    required this.normalWidgetWidth,
    required this.headerText,
    this.normalWidgetHeight = 35,
    required this.normalWidget,
    this.expandedwidgetHeight = 0.0,
    this.expandedwidgetWidth = 0.0,
    this.expandedwidget = const SizedBox.shrink(),
    required this.avatarRadius,
    this.onlyNormalWidgetBool = false,
  });

  @override
  _ExpandableCardContainerWidgetState createState() =>
      _ExpandableCardContainerWidgetState();
}

class _ExpandableCardContainerWidgetState
    extends State<ExpandableCardContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: widget.normalWidgetWidth,
      height: widget.isCardExpandedBool
          ? widget.normalWidgetHeight +
              widget.avatarRadius +
              widget.expandedwidgetHeight +
              35 +
              8 +
              2
          : widget.normalWidgetHeight +
              widget.avatarRadius +
              35 +
              8 +
              2,
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: widget.headerWidth,
                        height: 35,
                        color: CustomeColor.main_bg,
                        child: Text(
                          '${widget.headerText}',
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        width: widget.normalWidgetWidth,
                        height: widget.normalWidgetHeight,
                        color: Colors.white,
                        child: widget.normalWidget,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      if (widget.isCardExpandedBool &&
                          !widget.onlyNormalWidgetBool)
                        Container(
                          width: widget.normalWidgetWidth,
                          height: widget.expandedwidgetHeight,
                          color: Colors.white,
                          child: widget.expandedwidget,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (!widget.onlyNormalWidgetBool)
              new Positioned(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.isCardExpandedBool = !widget.isCardExpandedBool;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        shape: BoxShape.circle),
                    child: CircleAvatar(
                      radius: widget.avatarRadius,
                      backgroundColor: Colors.white,
                      child: Icon(
                        widget.isCardExpandedBool
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: Colors.grey,
                        size: widget.avatarRadius + 10,
                      ),
                    ),
                  ),
                  // left: (MediaQuery.of(context).size.width/2) - avatarRadius,
                ),
                top: !widget.isCardExpandedBool
                    ? widget.normalWidgetHeight -
                        widget.avatarRadius +
                        35 +
                        8 +
                        2
                    : widget.normalWidgetHeight -
                        widget.avatarRadius +
                        widget.expandedwidgetHeight +
                        35 +
                        8 +
                        2,
              )
          ],
        ),
      ),
    );
  }
}
