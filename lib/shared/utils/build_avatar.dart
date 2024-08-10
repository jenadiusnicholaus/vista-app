// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';

Widget buidAvatar(String imageUrl) {
  return Builder(builder: (context) {
    return CircleAvatar(
      backgroundImage: imageUrl != null
          ? NetworkImage(imageUrl)
          : const AssetImage("assestes/images/placeholder_for_profile.jpeg")
              as ImageProvider,
      backgroundColor: Theme.of(context).primaryColor,
    );
  });
}
