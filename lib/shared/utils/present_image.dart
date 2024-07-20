import 'package:flutter/material.dart';

Widget loadImageWithProgress(String? imageUrl) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(8.0),
      topRight: Radius.circular(8.0),
    ),
    child: Image.network(
      imageUrl ?? "https://via.placeholder.com/150x150",
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child; // Image is fully loaded
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      height: 150,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  );
}