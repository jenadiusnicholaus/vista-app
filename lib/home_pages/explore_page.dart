import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vista/data/sample_data.dart';

import 'property_details.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  // Example categories and properties
  final List<Category> categories = scategories;
  final List<Property> properties = sampleProperties;
  late TabController _tabController;

  String selectedCategory = 'Homes';

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: _pinned,
              snap: _snap,
              floating: _floating,
              title: Padding(
                padding: EdgeInsets.only(right: 5.w, top: 4.h),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.5), // Shadow color with some transparency
                        spreadRadius: 1, // Spread radius
                        blurRadius: 7, // Blur radius
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Where to?',
                      prefixIcon: const Icon(Icons.search_outlined,
                          size: 24, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 10.w),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                    ),
                  ),
                ),
              ),
              expandedHeight: 160.0,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // do something
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // do something
                  },
                ),
              ],
              bottom: TabBar(
                tabAlignment: TabAlignment.start,
                controller: _tabController,
                isScrollable: true, // Enable scrolling
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 10),

                tabs: categories
                    .map((Category category) =>
                        Tab(icon: Icon(category.icon), text: category.name))
                    .toList(),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
                child: Center(
                  child: Text('Live, rent, and relax in new places.',
                      style: TextStyle(fontSize: 34.sp, color: Colors.grey)),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: categories
              .map((Category category) => ListView.builder(
                    itemCount: properties.length,
                    itemBuilder: (BuildContext context, int index) {
                      // final Property property = properties[index];
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8.0),
                          child: Column(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics:
                                    const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: properties.length,
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Card(
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(() => PropertyDetailsPage(
                                                property: properties[index]));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Image.asset(
                                                  properties[index].imageUrl,
                                                  height: 150,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0.0,
                                                        vertical: 4.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          properties[index]
                                                              .title,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        // rating
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.yellow,
                                                              size: 16,
                                                            ),
                                                            Text(
                                                              properties[index]
                                                                  .rating
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        ), // rating
                                                      ],
                                                    ), // host

                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Hosted By ${properties[index].host}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),

                                                        // host verified
                                                        properties[index]
                                                                .hostVerified
                                                            ? const Icon(
                                                                Icons.verified,
                                                                color: Colors
                                                                    .green,
                                                                size: 16,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .verified_outlined,
                                                                color:
                                                                    Colors.red,
                                                                size: 16,
                                                              ),
                                                      ],
                                                    ),

                                                    Text(
                                                      properties[index]
                                                          .description,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),

                                                    // availability
                                                    Text(
                                                      properties[index]
                                                              .availability
                                                          ? 'Available'
                                                          : 'Not Available',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: properties[index]
                                                                .availability
                                                            ? Colors.green
                                                            : Colors.red,
                                                      ),
                                                    ),

                                                    // price

                                                    Text(
                                                      'Price: \$${properties[index].price}',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Chip(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100.0),
                                          ),
                                          label: Text(
                                              '${properties[index].showHourDriveFrom} hours drive'),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ))
              .toList(),
        ),
      ),
    ));
  }
}
