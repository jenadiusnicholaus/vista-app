import 'package:flutter/material.dart';
import 'package:vista/home_pages/explore_page.dart';
import 'package:vista/home_pages/inbox.dart';

import '../features/auth/user_profile/user_profile_page.dart';
import 'trips.dart';
import 'wishlist_page.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ExplorePage(),
    WishlistsPage(),
    TripPage(),
    InboxPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket_outlined),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
