import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vista/features/my_fav_property/models.dart';

import '../../constants/responsiveness.dart';
import '../my_fav_property/repository.dart';
import '../../shared/api_call/api.dart';
import '../../shared/environment.dart';
import '../../shared/error_handler.dart';
import '../../shared/utils/present_money_format.dart';
import 'propert_details/property_details.dart';

class WishlistsPage extends StatefulWidget {
  const WishlistsPage({super.key});

  @override
  State<WishlistsPage> createState() => _WishlistsPageState();
}

class _WishlistsPageState extends State<WishlistsPage> {
  static const _pageSize = 17;

  final PagingController<int, Results> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      MyFavoritePropertyRepository properRepository =
          MyFavoritePropertyRepository(
              apiCall: DioApiCall(), environment: Environment.instance);

      final newItems = await properRepository.getMyFavoriteProperties(
        pageNumber: pageKey,
        pageSize: _pageSize,
      );

      final isLastPage = newItems.results!.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.results!);
      } else {
        final nextPageKey = pageKey + newItems.results!.length;
        _pagingController.appendPage(newItems.results!, nextPageKey);
      }
    } catch (error) {
      String errorMessage = ExceptionHandler.handleError(
        error,
      );

      _pagingController.error = errorMessage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlists'),
        actions: [],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                ResponsiveLayout.isLargeScreen(context) ? 0.05.sw : 0.02.sw,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 0.02.sw, // Adjust the width as needed
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => _pagingController.refresh(),
                  child: PagedListView<int, Results>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Results>(
                      itemBuilder: (context, item, index) {
                        return MyFavPropertyItems(property: item);
                      },
                      firstPageErrorIndicatorBuilder: (context) {
                        return const Center(
                          child: Text('Error'),
                        );
                      },
                      noItemsFoundIndicatorBuilder: (context) {
                        return const Center(
                          child: Text('No items found'),
                        );
                      },
                      newPageErrorIndicatorBuilder: (context) {
                        return const Center(
                          child: Text('Error'),
                        );
                      },
                      firstPageProgressIndicatorBuilder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      newPageProgressIndicatorBuilder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class MyFavPropertyItems extends StatefulWidget {
  final Results property;

  const MyFavPropertyItems({super.key, required this.property});

  @override
  State<MyFavPropertyItems> createState() => _MyFavPropertyItemsState();
}

class _MyFavPropertyItemsState extends State<MyFavPropertyItems> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PropertyDetailsPage(property: widget.property.property));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 0.02.sh),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 0.3.sh,
              width: 1.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image:
                      NetworkImage(widget.property.property!.image.toString()),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 0.01.sh,
            ),
            Text(
              widget.property.property!.name.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.property.property!.description.toString(),
              style: const TextStyle(
                fontSize: 16,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 0.01.sh,
            ),
            Row(
              children: [
                Text(
                  "Hosted By ${widget.property.property!.host!.user!.firstName} ${widget.property.property!.host!.user!.lastName}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                widget.property.property!.host!.isVerified!
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
            SizedBox(
              height: 0.01.sh,
            ),
            Text(
              widget.property.property!.availabilityStatus!
                  ? 'Available'
                  : 'Not Available',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.property.property!.availabilityStatus!
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            SizedBox(
              height: 0.01.sh,
            ),
            Text(
              moneyFormater(widget.property.property!),
              style: const TextStyle(
                fontSize: 18, // Increased font size for more prominence
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
    );
  }
}
