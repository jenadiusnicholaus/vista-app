import 'package:flutter/material.dart';

Widget buildAvatar(String? imageUrl, {radius}) {
  return Builder(builder: (context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: imageUrl != null
          ? NetworkImage(imageUrl)
          : const AssetImage("assets/images/placeholder_for_profile.jpeg")
              as ImageProvider,
      backgroundColor: Theme.of(context).primaryColor,
      child: imageUrl == null
          ? const Icon(
              Icons.person,
              color: Colors.white,
              size: 40,
            )
          : null,
    );
  });
}
