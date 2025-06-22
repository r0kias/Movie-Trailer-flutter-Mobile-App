// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:secondd_ui/pages/detail_page.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final double ids;
  // final String title;
  // final String subtitle;
  // final double rating;

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.ids,
    // required this.title,
    // required this.subtitle,
    // required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(ids: ids)),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          imageUrl,
          alignment: Alignment.center,
          height: 380,
          width: 180,
          fit:
              BoxFit
                  .cover, // This will make the image cover the available space
        ),
      ),
    );
  }
}
