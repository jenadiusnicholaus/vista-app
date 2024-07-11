import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vista/data/sample_data.dart';

import 'property_details.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  final List<Category> categories = scategories;
  final List<Property> properties = sampleProperties;
  late TabController _tabController;

  final _pagingController = PagingController<int, Property>(
    firstPageKey: 0,
  );
  String selectedCategory = 'Homes';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
    _pagingController.appendLastPage(properties);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context, designSize: Size(360, 690));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  90.0.r), // Use ScreenUtil for responsive radius
            ),
            child: GestureDetector(
                onTap: () async {
                  log('Search tapped');
                  Get.toNamed('/search_properties');
                },
                child: const Row(
                  children: [
                    Icon(Icons.search_outlined, color: Colors.grey),
                    Text('Search',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        )),
                  ],
                )),
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.grey),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_alt_outlined, color: Colors.grey),
              onPressed: () async {},
            ),
          ],
          bottom: TabBar(
            tabAlignment: TabAlignment.start,
            controller: _tabController,
            isScrollable: true,
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.h),
            tabs: categories
                .map((Category category) => Tab(
                      icon: Icon(
                        category.icon,
                        color: Colors.grey,
                      ),
                      text: category.name,
                    ))
                .toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: categories
              .map((Category category) => ListView.builder(
                    itemCount: properties.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0.w, vertical: 8.0.h),
                          child: Column(
                            children: [
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: ScreenUtil().screenWidth > 800
                                      ? 4
                                      : ScreenUtil().screenWidth > 600
                                          ? 3
                                          : ScreenUtil().screenWidth > 400
                                              ? 2
                                              : 1,
                                  crossAxisSpacing: 10.w,
                                  mainAxisSpacing: 10.h,
                                ),
                                itemCount: properties.length,
                                itemBuilder: (context, index) {
                                  var property = properties[index];
                                  return PropertyItems(property: property);
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
    );
  }
}

class PropertyItems extends StatelessWidget {
  final Property property;

  const PropertyItems({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: GestureDetector(
            onTap: () {
              Get.to(() => PropertyDetailsPage(property: property));
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    property.imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            property.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 16,
                              ),
                              Text(
                                property.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hosted By ${property.host}",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          property.hostVerified
                              ? const Icon(
                                  Icons.verified,
                                  color: Colors.green,
                                  size: 16,
                                )
                              : const Icon(
                                  Icons.verified_outlined,
                                  color: Colors.red,
                                  size: 16,
                                ),
                        ],
                      ),
                      Text(
                        property.description,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Text(
                        property.availability ? 'Available' : 'Not Available',
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              property.availability ? Colors.green : Colors.red,
                        ),
                      ),
                      Text(
                        'Price: \$${property.price}',
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
              borderRadius: BorderRadius.circular(100.0),
            ),
            label: Text('${property.showHourDriveFrom} hours drive'),
          ),
        ),
      ],
    );
  }
}
