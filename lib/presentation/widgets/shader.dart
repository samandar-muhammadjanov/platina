import 'package:flutter/material.dart';
import 'package:platina/utils/colors.dart';

class ShaderContainer extends StatelessWidget {
  const ShaderContainer(
      {super.key, required this.height, this.width = double.infinity});
  final double height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kbackground,
      ),
    );
  }
}
