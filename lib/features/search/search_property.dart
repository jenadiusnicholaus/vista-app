import 'dart:developer';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vista/features/search/models.dart';
import 'package:vista/features/search/rentals_search.dart';

import '../../shared/api_call/api.dart';
import '../../shared/environment.dart';
import '../../shared/error_handler.dart';
import 'repository.dart';

final today = DateUtils.dateOnly(DateTime.now());

class SearchProperty extends StatefulWidget {
  const SearchProperty({super.key});

  @override
  State<SearchProperty> createState() => _SearchPropertyState();
}

class _SearchPropertyState extends State<SearchProperty>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<DateTime>? dateTime;

  String _location = '';
  int _selectedLocationIndex = 0;
  int numberOfAdults = 1;
  int numberOfKids = 0;

  static const _propertiesPageSize = 5;

  final PagingController<int, Results> _pagingController =
      PagingController(firstPageKey: 1);

  void _increaseAdults() {
    setState(() {
      numberOfAdults++;
    });
  }

  void _decreaseAdults() {
    setState(() {
      if (numberOfAdults > 0) numberOfAdults--;
    });
  }

  void _increaseKids() {
    setState(() {
      numberOfKids++;
    });
  }

  void _decreaseKids() {
    setState(() {
      if (numberOfKids > 0) numberOfKids--;
    });
  }

  void _search() {
    print(
        'Searching for $_selectedLocationIndex with $numberOfAdults adults and $numberOfKids kids stays at $dateTime');
    // Get.toNamed('/searched_results');
  }

  final _scrollController = ScrollController();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.offset > 1000) {
        print('Scrolled to the bottom');
      }
    });

    _pagingController.addPageRequestListener((pageKey) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fetchPage(pageKey);
      });
    });
    super.initState();
  }

  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime.now(),
    null,
  ];

  Widget _buildScrollRangeDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      centerAlignModePicker: true,
      calendarType: CalendarDatePicker2Type.range,
      calendarViewMode: CalendarDatePicker2Mode.scroll,
      rangeBidirectional: true,
      selectedDayHighlightColor: Colors.teal[800],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dynamicCalendarRows: true,
      weekdayLabelBuilder: ({required weekday, isScrollViewTopHeader}) {
        if (weekday == DateTime.wednesday && isScrollViewTopHeader != true) {
          return const Center(
            child: Text(
              'W',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return null;
      },
      modePickerTextHandler: ({required monthDate, isMonthPicker}) {
        if (isMonthPicker ?? false) {
          return '${getLocaleShortMonthFormat(const Locale('en')).format(monthDate)} New';
        }

        return null;
      },
      disabledDayTextStyle:
          const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
      selectableDayPredicate: (day) {
        // No dates are disabled.
        return true;
      },
    );
    return SizedBox(
      width: 375,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text('Select Date Range for Check-in and Check-out',
              style: TextStyle(fontSize: 16, color: Colors.grey)),
          SizedBox(
            height: 400,
            child: CalendarDatePicker2(
              config: config,
              value: _rangeDatePickerValueWithDefaultValue,
              onValueChanged: (dates) =>
                  setState(() => _rangeDatePickerValueWithDefaultValue = dates),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Check in and Out:  '),
              const SizedBox(width: 10),
              Text(
                _getValueText(
                  config.calendarType,
                  _rangeDatePickerValueWithDefaultValue,
                ),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      SupportedRepository properRepository = SupportedRepository(
          apiCall: DioApiCall(), environment: Environment.instance);

      final newItems = await properRepository.fetchRegions(
        pageNumber: pageKey,
        pageSize: _propertiesPageSize,
      );

      final items = newItems.results ?? [];

      // Create a set to ensure all items are unique based on their 'id'
      var uniqueItems = items.toSet().toList();

      final isLastPage = newItems.results!.length < _propertiesPageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(uniqueItems);
      } else {
        final nextPageKey = pageKey + 1; // Increment pageKey correctly
        log('Next Page Key: $nextPageKey');
        _pagingController.appendPage(uniqueItems, nextPageKey);
      }
    } catch (error) {
      log("===================x===================");
      log('Error: $error');
      String errorMessage = ExceptionHandler.handleError(error);

      _pagingController.error = errorMessage;
    }
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';

        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  _buildSupportedRegions() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Popular Destinations",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100, // Adjust the height as needed
            child: PagedListView<int, Results>(
              scrollDirection: Axis.horizontal,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Results>(
                itemBuilder: (context, item, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLocationIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _selectedLocationIndex == index
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        _buildLocationCard(item.regionName ?? '',
                            item.image ?? '', item.totalProperties),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Icon(
                            _selectedLocationIndex == index
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: _selectedLocationIndex == index
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  _buildWhoIsCommingCard() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Who is coming?",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    "Adults",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: _decreaseAdults,
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    '$numberOfAdults',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: _increaseAdults,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Kids",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: _decreaseKids,
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    '$numberOfKids',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: _increaseKids,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Where are to?',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey)),
        bottom: TabBar(
          tabAlignment: TabAlignment.center,
          isScrollable: true,
          dividerHeight: 2,
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Experiences',
            ),
            Tab(
              text: 'I am flexible',
            ),
            Tab(
              text: 'Rentals',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SizedBox(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildSupportedRegions(),
                    _buildWhoIsCommingCard(),
                    _buildScrollRangeDatePickerWithValue(),
                  ],
                ),
              ),
            ),
          ),
          const RentalsSearch(),
          const RentalsSearch()
        ],
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: () {}, child: const Text("Skip")),
              SizedBox(
                width: 140,
                child: ElevatedButton(
                  onPressed: _search,
                  child: const Text('Search'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationCard(
      String location, String imagePath, totalProperties) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imagePath == ""
                  ? 'https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png'
                  : imagePath,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$totalProperties properties",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
