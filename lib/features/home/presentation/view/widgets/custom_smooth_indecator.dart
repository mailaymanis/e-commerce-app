import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../layout/presentation/view_model/cubit/layout_cubit.dart';

class CustomSmoothIndecator extends StatelessWidget {
  const CustomSmoothIndecator({super.key , required this.controller , required this.cubit});
  final PageController controller;
  final LayoutCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmoothPageIndicator(
        controller:controller ,
        count:cubit.banners.length,
        axisDirection: Axis.horizontal,
        effect: const SlideEffect(
            spacing: 8.0,
            radius: 25.0,
            dotWidth: 15.0,
            dotHeight: 15.0,
            paintStyle: PaintingStyle.stroke,
            strokeWidth: 1.5,
            dotColor: Colors.black54,
            activeDotColor: Colors.orangeAccent),
      ),
    );
  }
}
