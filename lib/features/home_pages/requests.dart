import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vista/features/renting_system/all_my_rentals/models.dart';
import 'package:vista/shared/error_handler.dart';
import '../../shared/api_call/api.dart';
import '../../shared/environment.dart';
import '../booking_system/all_booking_requests/models.dart' as myBooking;
import '../booking_system/all_booking_requests/repository.dart';
import '../renting_system/all_my_rentals/repository.dart';

class BookingRequestsPage extends StatefulWidget {
  const BookingRequestsPage({super.key});

  @override
  State<BookingRequestsPage> createState() => _BookingRequestsPageState();
}

class _BookingRequestsPageState extends State<BookingRequestsPage> {
  static const _pageSize = 17;

  final PagingController<int, myBooking.MyRequestResults> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Widget showStatus(myBooking.MyBookingStatus myBookingStatus) {
    Color statusColor;
    String statusText;

    if (myBookingStatus.confirmed == true) {
      statusColor = Colors.green;
      statusText = 'Confirmed';
    } else if (myBookingStatus.canceled == true) {
      statusColor = Colors.red;
      statusText = 'Cancelled';
    } else if (myBookingStatus.completed == true) {
      statusColor = Colors.blue;
      statusText = 'Completed';
    } else {
      statusColor = Colors.orange;
      statusText = 'Pending';
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        border: Border.all(color: statusColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      GuestBookingRequestsRepository properRepository =
          GuestBookingRequestsRepository(
              apiCall: DioApiCall(), environment: Environment.instance);

      final newItems = await properRepository.getGuestBookingRequests(
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          child: PagedListView<int, myBooking.MyRequestResults>(
            pagingController: _pagingController,
            builderDelegate:
                PagedChildBuilderDelegate<myBooking.MyRequestResults>(
              itemBuilder: (context, item, index) {
                return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    // elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 150.0, // Set a fixed height for the container
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image section
                              Image.network(
                                item.property?.image ?? '',
                                width: 100.0, // Set a fixed width for the image
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 16.0),
                              // Details section
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.property?.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    _buildCheckInCheckOutDates(item),
                                    Text(
                                      item.property?.address ?? '',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        showStatus(item.myBookingStatus!),
                                        IconButton(
                                          icon: const Icon(Icons.more_vert),
                                          onPressed: () {
                                            // show bottom sheet
                                            // add a drop down menu
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )));
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildCheckInCheckOutDates(myBooking.MyRequestResults item) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Check In: ',
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: item.checkIn ?? '',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          TextSpan(
            text: 'Check Out: ',
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: item.checkOut ?? '',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

//  create page  with tab , for requests, bookings, and rentals
//
class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // Tab Changed
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final _pages = [const BookingRequestsPage(), const RentalRequests()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Requests'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Bookings'),
            Tab(text: 'Rentals'),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController, children: _pages),
    );
  }
}

class RentalRequests extends StatefulWidget {
  const RentalRequests({super.key});

  @override
  State<RentalRequests> createState() => _RentalRequestsState();
}

class _RentalRequestsState extends State<RentalRequests> {
  static const _pageSize = 17;

  final PagingController<int, RentingRequestResults> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      GuestRentalsRequestsRepository properRepository =
          GuestRentalsRequestsRepository(
              apiCall: DioApiCall(), environment: Environment.instance);

      final newItems = await properRepository.getGuestRentalsRequests(
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

  _buildCheckInCheckOutDates(RentingRequestResults item) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Check In: ',
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: item.checkIn ?? '',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          TextSpan(
            text: 'Check Out: ',
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: item.checkOut ?? '',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          child: PagedListView<int, RentingRequestResults>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<RentingRequestResults>(
              itemBuilder: (context, item, index) {
                return Card(

                    // elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height:
                              150.0.h, // Set a fixed height for the container
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image section
                              Image.network(
                                item.property?.image ?? '',
                                width: 120.0, // Set a fixed width for the image
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 16.0),
                              // Details section
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.property?.name ?? '',
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    _buildCheckInCheckOutDates(item),
                                    Text(
                                      item.property?.address ?? '',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                        "Rental Time: ${item.rentingDuration?.timeInNumber} ${item.rentingDuration?.timeInText}"),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        showStatus(item.rentingStatus!),
                                        IconButton(
                                          icon: const Icon(Icons.more_vert),
                                          onPressed: () {
                                            // show bottom sheet
                                            // add a drop down menu
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )));
              },
            ),
          ),
        ),
      ),
    );
  }

  showStatus(RentingStatus myRentingStatus) {
    Color statusColor;
    String statusText;

    if (myRentingStatus.rentingRequestConfirmed == true) {
      statusColor = Colors.green;
      statusText = 'Confirmed';
    } else if (myRentingStatus.rentingStatus == 'cancelled') {
      statusColor = Colors.red;
      statusText = 'Cancelled';
    } else if (myRentingStatus.rentingStatus == 'ongoing') {
      statusColor = Colors.blue;
      statusText = 'Ongoing';
    } else if (myRentingStatus.rentingStatus == 'completed') {
      statusColor = Colors.grey;
      statusText = 'Completed';
    } else {
      statusColor = Colors.orange;
      statusText = 'Pending';
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        border: Border.all(color: statusColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
