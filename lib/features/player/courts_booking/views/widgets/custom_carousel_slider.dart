import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCarouselSlider extends StatefulWidget {
  final String imageUrl;
  final List<String> images;

  const CustomCarouselSlider({
    super.key,
    required this.imageUrl,
    this.images = const [],
  });

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
    if (widget.images.isNotEmpty) {
      imgList = widget.images;
    } else {
      imgList = [
        widget.imageUrl,
        widget.imageUrl,
        widget.imageUrl,
        widget.imageUrl,
        widget.imageUrl,
      ];
    }
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
      child: imageUrl.startsWith('http')
          ? CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/Court.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            )
          : Image(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
    );
  }
}
