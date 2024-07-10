import 'package:flutter/material.dart';

class Location {
  final String name;
  final String address;
  final String imageUrl;

  Location({required this.name, required this.address, required this.imageUrl});
}

class Property {
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String host;
  final bool availability;
  final int showHourDriveFrom;
  final bool hostVerified;
  final double? rating;
  final String? location;
  final String? hostImage;

  Property({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.host,
    required this.availability,
    required this.showHourDriveFrom,
    required this.hostVerified,
    required this.rating,
    required this.location,
    required this.hostImage,
  });
}

var images = [
  "assets/images/houses.jpeg",
  "assets/images/images.jpeg",
  "assets/images/villa.jpeg",
  "assets/images/villa2.webp",
  "assets/images/villa3.jpeg",
  "assets/images/images.jpg",
];

final List<Property> sampleProperties = List.generate(20, (index) {
  return Property(
    title: 'Property $index',
    location: 'Bagamoyo, Tanzania $index',
    description: 'Description of Property $index',
    hostImage: 'assets/images/jenadius_m4C5CQQ.jpeg',
    price: 100.0 + index, // Example price
    imageUrl: images[index % images.length], // Example image
    host: 'Host $index', // Example host
    hostVerified: index % 2 == 0, // Example host verification
    rating: 4.5, // Example rating
    availability:
        index % 2 == 0, // Example availability, alternating true/false
    showHourDriveFrom: index, // Example driving hours from a landmark
  );
});

class Category {
  final String name;
  final IconData icon;

  Category({required this.name, required this.icon});
}

final List<Category> scategories = [
  Category(
    name: 'Amazing stays',
    icon: Icons.home_outlined,
  ),
  Category(name: 'Experiences', icon: Icons.explore_outlined),
  Category(name: 'Restaurants', icon: Icons.restaurant_outlined),
  Category(name: 'Adventures', icon: Icons.directions_bike_outlined),
  Category(name: 'Adventures', icon: Icons.directions_bike_outlined),
  Category(name: 'Adventures', icon: Icons.directions_bike_outlined),
  Category(name: 'Adventures', icon: Icons.directions_bike_outlined),
  Category(name: 'Adventures', icon: Icons.directions_bike_outlined),
];

final List<Map<String, dynamic>> ratings = [
  {"rating": 5, "label": "Excellent"},
  {"rating": 4, "label": "Good"},
  {"rating": 3, "label": "Average"},
  {"rating": 2, "label": "Below Average"},
  {"rating": 1, "label": "Poor"},
];

final List<Location> locations = [
  Location(
    name: "Central Park",
    address: "New York, NY, USA",
    imageUrl: "assets/images/hotel_map.jpeg",
  ),
  // Add more locations as needed
];
