import 'package:flutter/material.dart';
import 'package:platina/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class ShaderContainer extends StatelessWidget {
  const ShaderContainer(
      {super.key, required this.height, this.width = double.infinity});
  final double height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: kbackground,
        ),
      ),
    );
  }
}
