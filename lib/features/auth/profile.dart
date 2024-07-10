import 'package:flutter/material.dart';

import '../../data/sample_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile userProfile = UserProfile(
    name: 'Jenadius N',
    title: 'Software Engineer',
    description: 'Experienced in mobile and web development.',
    profileImageUrl: 'assets/images/jenadius_m4C5CQQ.jpeg',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Step 3: Design the Profile UI
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(userProfile.profileImageUrl),
            ),
            SizedBox(height: 20),
            Text(
              userProfile.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userProfile.title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                userProfile.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}
