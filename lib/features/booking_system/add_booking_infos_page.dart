
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vista/shared/widgets/error_snack_bar.dart';

import '../../constants/custom_form_field.dart';
// import '../../shared/utils/custom_spinkit_loaders.dart';
import 'bloc/booking_bloc.dart';
import 'package:intl/intl.dart';

class AddBookingPage extends StatefulWidget {
  final dynamic property;

  const AddBookingPage({Key? key, required this.property}) : super(key: key);

  @override
  _AddBookingPageState createState() => _AddBookingPageState();
}

class _AddBookingPageState extends State<AddBookingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _adultsController = TextEditingController();
  final TextEditingController _childrenController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isAdding = false;

  String checkIn = '';
  String checkOut = '';

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 1000) {
        // ignore: avoid_print
        print('scrolling distance: ${_scrollController.offset}');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _adultsController.dispose();
    _childrenController.dispose();
    super.dispose();
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
      // selectableDayPredicate: (day) {
      //   // Disable dates before the start date.
      //   final startDate =
      //       _rangeDatePickerValueWithDefaultValue[0] ?? DateTime.now();
      //   if (day.isBefore(startDate)) {
      //     return false;
      //   }

      //   // Additional logic to disable Wednesdays or other criteria can be added here.
      //   return day.weekday != DateTime.wednesday;
      // },
    );
    return SizedBox(
      width: 375,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Text('Select Date Range for Check-in and Check-out',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is AddingBookinngInforsLoading) {
          setState(() {
            isAdding = true;
          });
          showMessage(
              message: "Booking Info added",
              title: "Success",
              isAnError: false);
        } else if (state is AddBookingSuccess) {
          setState(() {
            isAdding = false;
          });
        } else if (state is AddBookingFailed) {
          setState(() {
            isAdding = false;
          });

          showMessage(
              message: "Failed to add booking info",
              title: "Error",
              isAnError: true);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Add Booking Details"),
          actions: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildScrollRangeDatePickerWithValue(),
                  const SizedBox(height: 10),
                  const Text("Who is coming?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("Adults",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  CustomTextFormField(
                    labelText: "e.g. 1",
                    controller: _adultsController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Adults is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text("Children",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  CustomTextFormField(
                    labelText: "e.g. 1",
                    controller: _childrenController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Children is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final DateFormat formatter = DateFormat('yyyy-MM-dd');

                      final cIn = _rangeDatePickerValueWithDefaultValue[0] !=
                              null
                          ? formatter
                              .format(_rangeDatePickerValueWithDefaultValue[0]!)
                          : 'null';

                      final cOut = _rangeDatePickerValueWithDefaultValue
                                      .length >
                                  1 &&
                              _rangeDatePickerValueWithDefaultValue[1] != null
                          ? formatter
                              .format(_rangeDatePickerValueWithDefaultValue[1]!)
                          : 'null';

                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      if (cIn == 'null' || cOut == 'null') {
                        showMessage(
                            message: "Please select check-in and check-out",
                            title: "Error",
                            isAnError: true);
                        return;
                      }

                      BlocProvider.of<BookingBloc>(context).add(AddBooking(
                        property: widget.property,
                        checkIn: cIn,
                        checkOut: cOut,
                        adults: _adultsController.text,
                        children: _childrenController.text,
                      ));
                    },
                    child: BlocBuilder<BookingBloc, BookingState>(
                      builder: (context, state) {
                        if (state is GetBookingLoading) {
                          return const SpinKitWave(
                            color: Colors.white,
                            size: 20.0,
                          );
                        }
                        return const Text("Save");
                      },
                    ),
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
