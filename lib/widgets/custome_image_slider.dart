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
        ? Stack(
      children: [
        CarouselSlider(
          items: widget.imageSliders!
              .map(
                (i) => Card(
              elevation: 0,
              margin: const EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(0.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(0.0),
                ),
                child: SizedBox(
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
                        return const Center(
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
              viewportFraction: 1.0,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPosition = double.parse(index.toString());
                });
              }),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            color: Colors.black26,
            child: DotsIndicator(
              dotsCount: widget.imageSliders!.length,
              position: _currentPosition,
              reversed: false,
              decorator: const DotsDecorator(
                activeColor: Colors.blue,
                color: Colors.black,
                spacing: EdgeInsets.only(
                  top: 5,
                  bottom: 5,
                  left: 4,
                  right: 4,
                ),
              ),
            ),
          ),
        ),
      ],
    )
        : Column(
      children: [
        ...widget.imageSliders!
            .map(
              (i) => Card(
            elevation: 0,
            margin: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(0.0),
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  i,
                  //fit: BoxFit.cover,
                  frameBuilder: (context, child, frame,
                      wasSynchronouslyLoaded) {
                    return child;
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(
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
