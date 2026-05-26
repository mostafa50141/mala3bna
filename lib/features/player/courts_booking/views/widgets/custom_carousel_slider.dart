import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCarouselSlider extends StatefulWidget {
  final String imageUrl;
  const CustomCarouselSlider({super.key, required this.imageUrl});

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  late final List<String> imgList;
  final CarouselSliderController carouselController =
      CarouselSliderController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    imgList = [
      widget.imageUrl,
      widget.imageUrl,
      widget.imageUrl,
      widget.imageUrl,
      widget.imageUrl,
    ];
  }

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
            height: 220.0, // Matches expandedHeight of SliverAppBar
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
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

  Widget buildimage(String imageUrl, int index) {
    return SizedBox(
      width: double.infinity,
      child: Image(
        image: AssetImage(imageUrl),
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
}
