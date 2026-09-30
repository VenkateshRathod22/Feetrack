import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.isLoading,
    required this.child,
    this.isDarkMode = false,
  });

  final Widget child;
  final bool isLoading;
  final bool isDarkMode;

  static const Color shimmerLightBase =
      Color(0xFFEBEBF4);

  static const Color shimmerLightHighlight =
      Color(0xFFF4F4F4);

  static const Color shimmerDarkBase =
      Color(0xFF2A2A2A);

  static const Color shimmerDarkHighlight =
      Color(0xFF3A3A3A);

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return child;
    }

    return Shimmer.fromColors(
      baseColor: isDarkMode
          ? shimmerDarkBase
          : shimmerLightBase,
      highlightColor: isDarkMode
          ? shimmerDarkHighlight
          : shimmerLightHighlight,
      child: child,
    );
  }
}