import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'bloc/user_profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context).add(GetUserProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(
              child: SpinKitWave(
                color: Theme.of(context).primaryColor,
                size: 20.0,
              ),
            );
          } else if (state is UserProfileError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is UserProfileLoaded) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Step 3: Design the Profile UI
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: state.userProfileModel.userProfilePic !=
                            null
                        ? NetworkImage(
                            state.userProfileModel.userProfilePic.toString(),
                          )
                        : const AssetImage('assets/images/profile.webp')
                            as ImageProvider,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    state.userProfileModel.firstName.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    state.userProfileModel.lastName.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      state.userProfileModel.email.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // Add more widgets as needed
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        },
      ),
    );
  }
}
