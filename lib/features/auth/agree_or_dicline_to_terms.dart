import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../home.dart';

class AgrreOrDeclineTerms extends StatefulWidget {
  const AgrreOrDeclineTerms({super.key});

  @override
  State<AgrreOrDeclineTerms> createState() => _AgrreOrDeclineTermsState();
}

class _AgrreOrDeclineTermsState extends State<AgrreOrDeclineTerms> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "VistaStay is a community where anyone can belong",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'To ensure this, we’re asking you to commit to respecting everyone on Airbnb. '
                  'I agree to treat everyone in the Airbnb community – regardless of their race, religion, '
                  'national origin, ethnicity, skin color, disability, sex, gender identity, sexual orientation, '
                  'or age – with respect, and without judgement or bias.',
                ),
                TextButton(
                    onPressed: () => {},
                    child: const Text("Learn more",
                        style: TextStyle(color: Colors.blue))),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, // This will space out the buttons evenly in the row.
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0), // Add some spacing between the buttons
                  child: ElevatedButton(
                    onPressed: () {
                      // if (_formKey.currentState!.validate()) {
                      // }

                      Get.to(() => const HomePage(title: 'Vista'));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      // primary: Colors
                      // .green, // Optional: Style the button with a specific color
                    ),
                    child: const Text('Agree and Join',
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4.0), // Add some spacing between the buttons
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle the decline action, e.g., navigate back or close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      // primary: Colors
                      // .red, // Optional: Style the button with a specific color
                    ),
                    child: const Text(
                      'Decline',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
