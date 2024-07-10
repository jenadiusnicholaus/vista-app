import 'package:flutter/material.dart';

class RentalsSearch extends StatefulWidget {
  const RentalsSearch({super.key});

  @override
  State<RentalsSearch> createState() => _RentalsSearchState();
}

class _RentalsSearchState extends State<RentalsSearch> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Rentals Search'),
      ),
    );
  }
}
