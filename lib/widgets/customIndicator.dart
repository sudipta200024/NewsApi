import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomIndicator extends StatelessWidget {
  final int activeIndex;
  final int count;

  const CustomIndicator({
    super.key,
    required this.activeIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
      effect: const WormEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: Colors.green,
      ),
    );
  }
}
