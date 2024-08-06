import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vista/features/home_pages/explore/explore_page.dart';
import 'package:vista/features/host_guest_chat/inbox.dart';
import 'package:vista/shared/utils/local_storage.dart';
import '../../auth/user_profile/user_profile_page.dart';
import '../../fcm/firebase_push_notification.dart';
import '../../location/device_current_location.dart';
import '../category/bloc/property_category_bloc.dart';
import '../requests.dart';
import '../wishlist_page.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  // final String title;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String username = '';
  String vzx = '';

  @override
  void initState() {
    LocalStorage.read(key: 'phone_number').then((value) {
      setState(() {
        username = value.toString();
      });
    });

    LocalStorage.read(key: 'vc').then((value) {
      setState(() {
        vzx = value.toString();
      });
    });
    super.initState();
    BlocProvider.of<PropertyCategoryBloc>(context)
        .add(GetPropertyCategoryEvent());
    _getUserCurrentLocation();
    super.initState();
  }

  _getUserCurrentLocation() async {
    try {
      final position = await determinePosition();
      log('Current Position: $position');
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  _getPages(ct) {
    final List<Widget> widgetOptions = <Widget>[
      ExplorePage(categories: ct),
      const WishlistsPage(),
      const MyRequests(),
      InboxPage(u: username, v: vzx),
      const ProfilePage(),
    ];

    return widgetOptions.elementAt(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    log(message.toString());
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocBuilder<PropertyCategoryBloc, PropertyCategoryState>(
          builder: (context, state) {
            if (state is PropertyCategoryLoading) {
              return const Center(
                child: ShimmerLoader(),
              );
            } else if (state is PropertyCategoryLoaded) {
              var cat = state.propertyCategoryList.results;
              return Center(
                child: _getPages(cat),
              );
            } else if (state is PropertyCategoryError) {
              return Center(
                child: Text(state.error),
              );
            }
            return const Center(
              child: Text("unexceptedError"),
            );
          },
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
              label: 'Requests',
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
      ),
    );
  }
}

class ShimmerLoader extends StatefulWidget {
  const ShimmerLoader({super.key});

  @override
  State<ShimmerLoader> createState() => _ShimmerLoaderState();
}

class _ShimmerLoaderState extends State<ShimmerLoader> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(kToolbarHeight), // Standard AppBar height
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: AppBar(
              title: Container(
                height: 20.0,
                color: Colors.white,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications),
                ),
              ],
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: Container(
                  color: Colors.grey[300],
                  height: 1.0,
                ),
              ),
            ),
          ),
        ),
        body: Shimmer.fromColors(
          baseColor: Theme.of(context).scaffoldBackgroundColor,
          highlightColor: Theme.of(context).highlightColor,
          child: GridView.builder(
            itemCount: 6, // Number of shimmer items
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .9,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 2.h,
              crossAxisCount: 1, // Number of columns
            ),
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 400.0.h,
                      color: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  Container(
                    width: double.infinity,
                    height: 8.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: double.infinity,
                    height: 8.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: double.infinity,
                    height: 8.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: double.infinity,
                    height: 8.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: 100.0,
                    height: 8.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: double.infinity,
                    height: 8.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: 50.0,
                    height: 10.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
