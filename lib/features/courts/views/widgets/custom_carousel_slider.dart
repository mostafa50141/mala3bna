import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: imgList.length,
          itemBuilder: (context, index, realIndex) {
            return buildimage(imgList[index], index);
          },
          options: CarouselOptions(
            viewportFraction: 1.0,
            height: 200.0,
            autoPlay: true,
            // enlargeCenterPage: true,
            autoPlayInterval: Duration(seconds: 2),
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
