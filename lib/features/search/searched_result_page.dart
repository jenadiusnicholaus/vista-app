// import 'package:flutter/material.dart';
// import 'package:vista/home_pages/explore/explore_page.dart';

// class SearchedResults extends StatefulWidget {
//   final String title;
//   const SearchedResults({super.key, required this.title});

//   @override
//   _SearchedResultsState createState() => _SearchedResultsState();
// }

// class _SearchedResultsState extends State<SearchedResults> {
//   int _selectedIndex = 0;

//   static const List<Widget> _widgetOptions = <Widget>[
//     ExplorePage(
    
//     ),
//     WishlistsPage(),
//     TripsPage(),
//     InboxPage(),
//     ProfilePage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 2,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search_outlined),
//             label: 'Explore',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_border),
//             label: 'Wishlists',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.airplane_ticket_outlined),
//             label: 'Trips',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.mail_outline),
//             label: 'Inbox',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// class WishlistsPage extends StatelessWidget {
//   const WishlistsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Text('Wishlists Page');
//   }
// }

// class TripsPage extends StatelessWidget {
//   const TripsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Text('Trips Page');
//   }
// }

// class InboxPage extends StatelessWidget {
//   const InboxPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Text('Inbox Page');
//   }
// }

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Text('Profile Page');
//   }
// }
