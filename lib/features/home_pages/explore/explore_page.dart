import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vista/data/sample_data.dart';
import 'package:vista/features/home_pages/explore/models.dart'
    as explore_models;
import 'package:vista/features/home_pages/explore/repository.dart';
import 'package:vista/shared/api_call/api.dart';
import 'package:vista/shared/environment.dart';
import 'package:vista/shared/utils/present_money_format.dart';

import '../../../constants/responsiveness.dart';
import '../../booking_system/bloc/booking_bloc.dart';
import '../../my_fav_property/bloc/my_fav_properies_bloc.dart';
import '../../../shared/error_handler.dart';
import '../../../shared/utils/present_image.dart';
import '../category/models.dart';
import '../propert_details/property_details.dart'; // Import intl package at the top of your Dart file
// import '../property_details.dart' as property_details;

class ExplorePage extends StatefulWidget {
  final List<CResults> categories;
  const ExplorePage({super.key, required this.categories});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  // List<CResults>? categories;
  final List<Property> properties = sampleProperties;
  late TabController _tabController;

  bool isLoadingCategory = false;

  static const _propertiesPageSize = 5;

  final PagingController<int, explore_models.Results>
      _propertiesPagingController = PagingController(firstPageKey: 1);

  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _propertiesPagingController.addPageRequestListener((pageKey) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fetchPage(pageKey);
      });
    });
    selectedCategory = widget.categories[0].id.toString();
    _tabController =
        TabController(length: widget.categories.length, vsync: this);

    _propertiesPagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        log(status.name);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () =>
                  _propertiesPagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });

    _tabController.addListener(() {
      setState(() {
        selectedCategory =
            widget.categories[_tabController.index].id.toString();
        _propertiesPagingController.itemList?.clear();
        _propertiesPagingController.refresh();
        // _fetchPage(1);
      });
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      PropertyRepository properRepository = PropertyRepository(
          apiCall: DioApiCall(), environment: Environment.instance);

      final newItems = await properRepository.fetchProperties(
        pageNumber: pageKey,
        pageSize: _propertiesPageSize,
        category: selectedCategory,
      );

      final items = newItems.results ?? [];

      // Create a set to ensure all items are unique based on their 'id'
      var uniqueItems = items.toSet().toList();

      final isLastPage = newItems.results!.length < _propertiesPageSize;

      if (isLastPage) {
        _propertiesPagingController.appendLastPage(uniqueItems);
      } else {
        final nextPageKey = pageKey + 1; // Increment pageKey correctly
        log('Next Page Key: $nextPageKey');
        _propertiesPagingController.appendPage(uniqueItems, nextPageKey);
      }
    } catch (error) {
      log("===================x===================");
      log('Error: $error');
      String errorMessage = ExceptionHandler.handleError(error);

      _propertiesPagingController.error = errorMessage;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _propertiesPagingController.dispose();
    

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _tabController = TabController(
    //     length: categoryController.categories.length, vsync: this);
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
                    await showSearch(
                      context: context,
                      delegate: PropertySearchDelegate(
                        pagingController: _propertiesPagingController,
                      ),
                    );
                    // Get.toNamed('/search');
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
              onTap: (index) {
                setState(() {
                  selectedCategory = widget.categories[index].id.toString();
                  _propertiesPagingController.refresh();
                });
              },
              isScrollable: true,
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.h),
              tabs: [
                ...widget.categories.map((category) {
                  // log('Category cay wed: ${category.name}');
                  return Tab(
                    child: Text(
                      category.name ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList()
              ],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => Future.sync(_propertiesPagingController.refresh),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 2.0.h),
              child: PagedGridView<int, explore_models.Results>(
                pagingController: _propertiesPagingController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .9,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  crossAxisCount: crossAxisCount(),
                ),
                builderDelegate:
                    PagedChildBuilderDelegate<explore_models.Results>(
                  itemBuilder: (context, item, index) =>
                      PropertyItems(property: item),
                ),
              ),
            ),
          )),

      //    RefreshIndicator(
    );
  }
}

class Pages extends StatelessWidget {
  final dynamic category;
  final PagingController<int, explore_models.Results> pagingController;

  const Pages({
    Key? key,
    required this.category,
    required this.pagingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(pagingController.refresh),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 2.0.h),
        child: PagedGridView<int, explore_models.Results>(
          pagingController: pagingController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .9,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            crossAxisCount: crossAxisCount(),
          ),
          builderDelegate: PagedChildBuilderDelegate<explore_models.Results>(
            itemBuilder: (context, item, index) =>
                PropertyItems(property: item),
          ),
        ),
      ),
    );
  }
}

class PropertyItems extends StatefulWidget {
  final dynamic property;

  const PropertyItems({super.key, required this.property});

  @override
  State<PropertyItems> createState() => _PropertyItemsState();
}

class _PropertyItemsState extends State<PropertyItems> {
  bool isAddingToFav = false;
  bool isAdded = false;
  int? idToAdd;

  String getMessage(String? businessType) {
    switch (businessType) {
      case "rent":
        return "FOR RENT";
      case "sale":
        return "FOR SALE";
      case "booking":
        return "FOR BOOKING";

      default:
        return "Unavailable";
    }
  }

  Color getColor(String? businessType) {
    switch (businessType) {
      case "rent":
        return Colors.green;
      case "sale":
        return Colors.red;
      case "booking":
        return Colors.blue;

      default:
        return Colors.grey; // Default color if none of the conditions match
    }
  }

  Widget _wrapWithBanner({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Banner(
        location: BannerLocation.topStart,
        message: getMessage(widget.property.businessType),
        // message: 'BETA',
        color: getColor(widget.property.businessType),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 10.0,
        ),
        // textDirection: TextDirection.ltr,

        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyFavProperiesBloc, MyFavProperiesState>(
      listener: (context, state) {
        if (state is MyFavProperiesAddedLoading) {
          setState(() {
            isAddingToFav = true;
          });
        } else if (state is MyFavProperiesAdded) {
          setState(() {
            isAddingToFav = false;
            isAdded = true;
          });
        } else if (state is MyFavProperiesAddError) {
          setState(() {
            isAddingToFav = false;
          });
        }
      },
      child: Stack(
        children: [
          _wrapWithBanner(
            child: Card(
              child: GestureDetector(
                onTap: () {
                  Get.to(() => PropertyDetailsPage(property: widget.property));
                  BlocProvider.of<BookingBloc>(context).add(GetMyBooking(
                    propertyId: widget.property.id,
                  ));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),
                        child: loadImageWithProgress(
                            widget.property.image?.toString()),
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
                              SizedBox(
                                width: 200.w,
                                child: Text(
                                  widget.property.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  RatingBar(
                                    ignoreGestures: true,
                                    initialRating:
                                        widget.property.rating ?? 0.0,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 1,
                                    ratingWidget: RatingWidget(
                                      full: const Icon(Icons.star,
                                          color: Colors.amber),
                                      half: const Icon(Icons.star_half,
                                          color: Colors.amber),
                                      empty: const Icon(Icons.star_border,
                                          color: Colors.amber),
                                    ),
                                    itemSize: 20,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  Text("${widget.property.rating ?? 0.0}")
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Hosted By ${widget.property.host!.user?.firstName ?? ''} ${widget.property.host!.user?.lastName ?? ''}",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              widget.property.host!.isVerified!
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
                            widget.property.description ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Text(
                            widget.property.availabilityStatus!
                                ? 'Available'
                                : 'sold out',
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.property.availabilityStatus!
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          Text(
                            moneyFormater(widget.property),
                            style: const TextStyle(
                              fontSize:
                                  18, // Increased font size for more prominence
                              fontWeight: FontWeight.w900, // Maximum boldness
                              color: Colors.grey,
                              shadows: [
                                // Adding a shadow for a "tomey" effect
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 1.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: widget.property.isMyFavorite ||
                      isAdded ||
                      idToAdd == widget.property.id
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border, color: Colors.grey),
              onPressed: isAddingToFav
                  ? null
                  : () {
                      setState(() {
                        idToAdd = widget.property.id;
                      });
                      BlocProvider.of<MyFavProperiesBloc>(context).add(
                        AddMyFavPropertyEvent(propertyId: widget.property.id),
                      );
                    },
            ),
          )
        ],
      ),
    );
  }
}

class PropertySearchDelegate extends SearchDelegate<explore_models.Results> {
  final PagingController<int, explore_models.Results> pagingController;

  PropertySearchDelegate({
    required this.pagingController,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, explore_models.Results());
      },
    );
  }

  @override
  @override
  Widget buildResults(BuildContext context) {
    final results = pagingController.itemList
        ?.where((property) =>
            property.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results != null && results.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () => Future.sync(pagingController.refresh),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0.w, vertical: 2.0.h),
          child: PagedGridView<int, explore_models.Results>(
            pagingController: pagingController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .9,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              crossAxisCount: crossAxisCount(),
            ),
            builderDelegate: PagedChildBuilderDelegate<explore_models.Results>(
              itemBuilder: (context, item, index) =>
                  PropertyItems(property: item),
            ),
          ),
        ),
      );
    } else {
      return const Center(child: Text('No results found'));
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = pagingController.itemList
        ?.where((property) =>
            property.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    log('Suggestions: $suggestions');

    if (suggestions != null && suggestions.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: const Text(''),
          flexibleSpace: Container(
            decoration: const BoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Near By locations search",
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                  IconButton(
                      onPressed: () {},
                      color: Colors.grey,
                      icon: const Icon(Icons.map_outlined, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: RefreshIndicator(
                      onRefresh: () => Future.sync(pagingController.refresh),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.0.w, vertical: 2.0.h),
                        child: PagedGridView<int, explore_models.Results>(
                          pagingController: pagingController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: .9,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            crossAxisCount: crossAxisCount(),
                          ),
                          builderDelegate:
                              PagedChildBuilderDelegate<explore_models.Results>(
                            itemBuilder: (context, item, index) =>
                                PropertyItems(property: item),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Center(child: Text('No suggestions'));
    }
  }
}
