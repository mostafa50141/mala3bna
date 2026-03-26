import 'package:flutter/material.dart';
import 'stars_widget.dart';

class ReviewItem extends StatelessWidget {
  final Map<String, dynamic> review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Avatar
        const CircleAvatar(radius: 18),

        const SizedBox(width: 10),

        /// Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Name + Time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    review["name"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    review["time"],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              /// Stars
              StarsWidget(rating: review["rating"]),

              const SizedBox(height: 6),

              /// Comment
              Text(
                review["comment"],
                style: const TextStyle(color: Colors.grey, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
