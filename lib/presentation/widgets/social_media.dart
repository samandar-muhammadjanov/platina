
  import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:platina/utils/colors.dart';

Container socialMedias(svg, title) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 100,
      decoration: BoxDecoration(
          color: const Color(0xffF8F8FF),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          SvgPicture.asset(
            svg,
            color: kprimaryColor,
            width: 12,
          ),
          const SizedBox(
            width: 7,
          ),
          Text(
            title,
            style: TextStyle(
              color: kprimaryColor,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }