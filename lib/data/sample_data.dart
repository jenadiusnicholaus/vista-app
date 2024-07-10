import 'package:flutter/material.dart';

class Location {
  final String title;
  final String subtitle;
  final String imageUrl;

  Location(
      {required this.title, required this.subtitle, required this.imageUrl});
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
  Category(name: 'Order Goods', icon: Icons.shopping_cart_outlined),
  Category(name: 'Retals', icon: Icons.car_rental_outlined),
  Category(name: 'Buy Property', icon: Icons.home_outlined),
];

final List<Map<String, dynamic>> ratings = [
  {"rating": 5, "label": "Excellent"},
  {"rating": 4, "label": "Good"},
  {"rating": 3, "label": "Average"},
  {"rating": 2, "label": "Below Average"},
  {"rating": 1, "label": "Poor"},
];

// final List<Location> locations = [
//   Location(
//     name: "Central Park",
//     address: "New York, NY, USA",
//     imageUrl: "assets/images/hotel_map.jpeg",
//   ),
//   // Add more locations as needed
// ];

final List<Location> locations = [
  Location(
    title: 'Bagamoyo',
    subtitle: 'Historical city',
    imageUrl: 'assets/images/images.jpeg',
  ),
  Location(
    title: 'Zanzibar',
    subtitle: 'Beautiful beaches',
    imageUrl: 'assets/images/images.jpg',
  ),

  Location(
    title: 'Zanzibar',
    subtitle: 'Beautiful beaches',
    imageUrl: 'assets/images/images.jpg',
  ),

  Location(
    title: 'Zanzibar',
    subtitle: 'Beautiful beaches',
    imageUrl: 'assets/images/images.jpg',
  ),

  Location(
    title: 'Zanzibar',
    subtitle: 'Beautiful beaches',
    imageUrl: 'assets/images/images.jpg',
  ),
  // Add more locations here
];

class Trip {
  final String destination, description, imageUrl;
  final DateTime startDate, endDate;

  Trip({
    required this.destination,
    required this.description,
    required this.imageUrl,
    required this.startDate,
    required this.endDate,
  });
}

// Example list of trips
final List<Trip> sampleTrips = List.generate(10, (index) {
  return Trip(
    destination: 'Destination $index',
    description: 'Description of Trip $index',
    imageUrl: images[index % images.length],
    startDate: DateTime.now(),
    endDate: DateTime.now().add(Duration(days: index + 5)),
  );
});

class ChatMessage {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;
  final bool isSender;

  ChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    this.isSender = true,
  });
}

class Message {
  final String sender;
  final String subject;
  final String body;
  final DateTime date;
  bool isRead;

  Message({
    required this.sender,
    required this.subject,
    required this.body,
    required this.date,
    this.isRead = false,
  });
}

final List<Message> messages = List.generate(20, (index) {
  return Message(
    sender: 'Sender $index',
    subject: 'Subject $index',
    body: 'Body of the message $index',
    date: DateTime.now().subtract(Duration(days: index)),
  );
});

// Example message model
class InboxMessage {
  final String id;
  final String body;
  final DateTime date;

  InboxMessage({required this.id, required this.body, required this.date});
}

// Now, you can pass initialMessages to ChatPage
// Static list of inbox messages for testing
List<InboxMessage> inboxMessages = [
  InboxMessage(id: '1', body: 'Hello, how are you?', date: DateTime.now()),
  InboxMessage(
      id: '2',
      body: 'Are we meeting today?',
      date: DateTime.now().subtract(Duration(days: 1))),
  // Add more messages as needed
];

// Step 1: Define a UserProfile model
class UserProfile {
  final String name;
  final String title;
  final String description;
  final String profileImageUrl;

  UserProfile({
    required this.name,
    required this.title,
    required this.description,
    required this.profileImageUrl,
  });
}
