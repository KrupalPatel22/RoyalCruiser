import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:royalcruiser/constants/common_constance.dart';

class CustomImageSliderWithIndicator extends StatefulWidget {
  final List<String>? imageSliders;

  CustomImageSliderWithIndicator({required this.imageSliders});

  @override
  _CustomImageSliderWithIndicatorState createState() =>
      _CustomImageSliderWithIndicatorState();
}

class _CustomImageSliderWithIndicatorState
    extends State<CustomImageSliderWithIndicator> {
  double _currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return widget.imageSliders!.length != 1
        ? Column(
            children: [
              CarouselSlider(
                items: widget.imageSliders!
                    .map(
                      (i) => Card(
                        elevation: 0,
                        margin: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0.0),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              i,
                              fit: BoxFit.fill,
                              frameBuilder: (context, child, frame,
                                  wasSynchronouslyLoaded) {
                                return child;
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.red, strokeWidth: 2),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                    initialPage: 0,
                    height: CommonConstants.SCREEN_HEIGHT / 3,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPosition = double.parse(index.toString());
                      });
                    }),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DotsIndicator(
                      dotsCount: widget.imageSliders!.length,
                      position: _currentPosition,
                      reversed: false,
                      decorator: DotsDecorator(
                        activeColor: Colors.blue,
                        color: Colors.black,
                        spacing: EdgeInsets.only(
                          top: 8,
                          left: 4,
                          right: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5)
            ],
          )
        : Column(
            children: [
              ...widget.imageSliders!
                  .map(
                    (i) => Card(
                      elevation: 0,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0.0),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            i,
                            fit: BoxFit.fill,
                            frameBuilder: (context, child, frame,
                                wasSynchronouslyLoaded) {
                              return child;
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.red, strokeWidth: 2),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          );
  }
}
