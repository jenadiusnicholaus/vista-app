import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vista/features/auth/user_profile/bloc/user_profile_bloc.dart';

import '../../../shared/utils/build_avatar.dart';
import '../../host_guest_chat/my_rosters/bloc/add_roster_bloc.dart';

class HostProfilePage extends StatelessWidget {
  final dynamic user;
  const HostProfilePage({super.key, required this.user}); // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Host'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: buildAvatar(user.userProfilePic, radius: 60.0),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                user.firstName.toString(),
                // ignore: prefer_const_constructors
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                user.email,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'About',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'I am veri nice host. I will make sure you have a great time at my place.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                var myPhoneNumber = state is UserProfileLoaded
                    ? state.userProfileModel.phoneNumber
                    : "";

                return Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      BlocProvider.of<AddRosterBloc>(context).add(AddRoster(
                          localuser: myPhoneNumber.toString(),
                          localhost: "192.168.1.181",
                          user: user.phoneNumber.toString(),
                          host: "192.168.1.181",
                          nick: user.firstName.toString()));
                    },
                    icon: const Icon(Icons.message),
                    label: state is AddRosterLoading
                        ? const SpinKitWave(
                            color: Colors.white,
                            size: 20,
                          )
                        : const Text('Message Host'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
