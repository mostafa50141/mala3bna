import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({super.key});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final List<String> imgList = [
    'assets/images/Court.png',
    'assets/images/Court.png',
    'assets/images/Court.png',
    'assets/images/Court.png',
    'assets/images/Court.png',
  ];
  final CarouselSliderController carouselController =
      CarouselSliderController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: carouselController,
          itemCount: imgList.length,
          itemBuilder: (context, index, realIndex) {
            return buildimage(imgList[index], index);
          },
          options: CarouselOptions(
            viewportFraction: 1.0,
            height: 200.0,
            autoPlay: true,
            // enlargeCenterPage: true,
            autoPlayInterval: Duration(seconds: 3),
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),
        Positioned(
          bottom: 16,
          left: 0,
          right: 0,
          child: Center(
            child: AnimatedSmoothIndicator(
              activeIndex: _currentIndex,
              count: imgList.length,
              effect: const ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                activeDotColor: Colors.white,
                dotColor: Colors.white54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildimage(String imgList, int index) {
    return SizedBox(
      // margin: EdgeInsets.symmetric(horizontal: 5),
      width: double.infinity,
      child: Image.asset(imgList, fit: BoxFit.cover, width: double.infinity),
    );
  }
}
