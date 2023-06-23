import 'package:flutter/material.dart';

class DolDurmaClipper extends CustomClipper<Path> {
  final double holeRadius;
  final double bottom;

  DolDurmaClipper({required this.holeRadius, required this.bottom});

  @override
  Path getClip(Size size) {

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0.0, size.height - bottom - holeRadius)
      ..arcToPoint(
        Offset(0, size.height - bottom),
        clockwise: true,
        radius: Radius.circular(1),
      )
      ..lineTo(0.0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height - bottom)
      ..arcToPoint(
        Offset(size.width, size.height - bottom - holeRadius),
        clockwise: true,
        radius: Radius.circular(1),
      );
    path.lineTo(size.width, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}

class TicketClipper extends CustomClipper<Path> {


  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(size.width*3/4, 0.0);

    path.relativeArcToPoint(const Offset(20, 0),
        radius: const Radius.circular(10.0), largeArc: true, clockwise: false);
    path.lineTo(size.width-10, 0);
    path.quadraticBezierTo(size.width, 0.0, size.width, 10.0);
    path.lineTo(size.width, size.height -10 );
    path.quadraticBezierTo(
        size.width, size.height, size.width-10, size.height);
    path.lineTo(size.width*3/4+20, size.height);
    path.arcToPoint(Offset((size.width*3/4), size.height),
        radius: const Radius.circular(10.0), clockwise: false);
    path.lineTo(10.0, size.height);
    path.quadraticBezierTo(0.0, size.height, 0.0, size.height - 10);
    path.lineTo(0.0, 10.0);
    path.quadraticBezierTo(0.0, 0.0, 10.0, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}


class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1.25, this.color = Colors.grey})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 3.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}