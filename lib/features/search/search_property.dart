import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:vista/features/search/rentals_search.dart';
import '../../data/sample_data.dart';
import 'bussines_search.dart';

final today = DateUtils.dateOnly(DateTime.now());

class SearchProperty extends StatefulWidget {
  const SearchProperty({super.key});

  @override
  State<SearchProperty> createState() => _SearchPropertyState();
}

class _SearchPropertyState extends State<SearchProperty>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  List<DateTime>? dateTime;

  String _location = '';
  int numberOfAdults = 1;
  int numberOfKids = 0;

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

  static const List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  void _search() {
    // Implement your search logic here
    // Use the state variables: location, numberOfAdults, numberOfKids
    print(
        'Searching for $_location with $numberOfAdults adults and $numberOfKids kids stays at $dateTime');
    Get.toNamed('/searched_results');
  }

  final _scrollController = ScrollController();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _scrollController.addListener(() {
      if (_scrollController.offset > 1000) {
        // ignore: avoid_print
        print('scrolling distance: ${_scrollController.offset}');
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Search Property'),
          bottom: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Stays',
                icon: Icon(Icons.home_outlined),
              ),
              Tab(
                text: 'Buy property',
                icon: Icon(Icons.business_outlined),
              ),
              Tab(
                text: 'Experiences',
                icon: Icon(Icons.explore_outlined),
              ),
              Tab(
                text: 'Rentals',
                icon: Icon(Icons.directions_car_outlined),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.filter),
            ),
          ]),
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
                    

                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return _kOptions.where((String option) {
                          return option
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        debugPrint('You just selected $selection');
                      },
                      fieldViewBuilder: (
                        BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted,
                      ) {
                        return TextField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            labelText: 'I am flexible',
                            hintText: 'Type to search options',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          onSubmitted: (String value) {
                            onFieldSubmitted();
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Where are you going ?"),
                    SizedBox(
                      height: 300,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, // Number of columns
                          crossAxisSpacing: 8, // Horizontal space between cards
                          mainAxisSpacing: 8, // Vertical space between cards
                        ),
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          final location = locations[index];
                          return GestureDetector(
                            onTap: () async {
                              dateTime = await showOmniDateTimeRangePicker(
                                  context: context);

                              // Use dateTime here
                              debugPrint('dateTime: $dateTime');
                              print('Selected: ${location.title}');
                              setState(() {
                                _selectedIndex = index;
                                _location = location.title;
                              });
                            },
                            child: Card(
                              color: _selectedIndex == index
                                  ? Colors.green
                                  : Theme.of(context).cardColor,
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Image.asset(
                                      location.imageUrl,
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      location.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: _selectedIndex == index
                                            ? Colors.white
                                            : Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .color,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Text(
                                      location.subtitle,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _selectedIndex == index
                                            ? Colors.white
                                            : Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Who is coming ?"),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text('Adults'),
                            Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: _decreaseAdults),
                                Text('$numberOfAdults'),
                                IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: _increaseAdults),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text('Kids'),
                            Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: _decreaseKids),
                                Text('$numberOfKids'),
                                IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: _increaseKids),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const BusinessesSearchPage(),
          const Icon(Icons.directions_transit),
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
                width: 150,
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
}

/// My app class to display the date range picker
/// 
// /// class AutocompleteBasicExample extends StatelessWidget {
//   const AutocompleteBasicExample({super.key});

//   static const List<String> _kOptions = <String>[
//     'aardvark',
//     'bobcat',
//     'chameleon',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Autocomplete<String>(
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text == '') {
//           return const Iterable<String>.empty();
//         }
//         return _kOptions.where((String option) {
//           return option.contains(textEditingValue.text.toLowerCase());
//         });
//       },
//       onSelected: (String selection) {
//         debugPrint('You just selected $selection');
//       },
//     );
//   }
// }
