import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomepageLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SvgPicture.asset(
          "assets/fp.svg",
          height: 118,
          width: 126,
        ),
        const SizedBox(height: 16),
        Text(
          "FRESH PLUS",
          style: TextStyle(
            fontSize: 21,
            color: Color(0xff2C7B0C),
            letterSpacing: 2.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 13),
        Container(
          width: 224,
          height: 3,
          color: Color(0xff2C7B0C),
        ),
        const SizedBox(height: 12),
        Text(
          "Military Refrigerator Management System",
          style: TextStyle(
            fontSize: 13,
            color: Color(0xff2C7B0C),
            letterSpacing: 1.8,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ));
  }
}
