import 'package:flutter/material.dart';

class BusinessesSearchPage extends StatefulWidget {
  const BusinessesSearchPage({super.key});

  @override
  State<BusinessesSearchPage> createState() => _BusinessesSearchPageState();
}

class _BusinessesSearchPageState extends State<BusinessesSearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Businesses Search'),
      ),
    );
  }
}
