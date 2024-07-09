import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../constants/custom_form_field.dart';
import '../agree_or_dicline_to_terms.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RestorationMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  var _obscureText = true;
  DateTime? selectedDate;

  @override
  String? get restorationId => 'register_page';

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime.now()); // Use current date as initial date
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(1900), // Set to the earliest possible date
          lastDate: DateTime(2100), // Set to the latest possible date
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _focusNode.dispose();
    _selectedDate.dispose();
    _restorableDatePickerRouteFuture.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          width: double.infinity,
          child: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Text(
                      'Finish Sign Up',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                  ),
                  // phone number

                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Phone Number",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        IntlPhoneField(
                          focusNode: _focusNode,
                          initialCountryCode: "TZ",
                          controller: _phoneNumberController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            labelText: 'eg: 652 123 456',
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: .9,
                                // color: Colors.grey,
                              ),
                            ),
                          ),
                          languageCode: "en",
                          onChanged: (phone) {
                            print(phone.completeNumber);
                            log(phone.countryCode);
                            log(phone.countryISOCode);
                            log(phone.number);
                          },
                          onCountryChanged: (country) {
                            print('Country changed to: ' + country.name);
                          },
                        ),
                        const Text(
                          "We’ll call or text you to confirm your number. Standard message and data rates apply.",
                          style: TextStyle(fontSize: 11),
                        ),

                        // button

                        const SizedBox(
                          height: 20,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "First Name",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFormFied(
                              labelText: 'eg: John',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Last Name",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFormFied(
                              labelText: 'eg: Doe',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                            const Text(
                              "Make sure it matches the name on your government ID.",
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Birthday",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: InputDatePickerFormField(
                                    initialDate: _selectedDate.value,
                                    firstDate: DateTime(
                                        1), // Set to the earliest possible date
                                    lastDate: DateTime(9999),
                                    keyboardType: TextInputType.datetime,
                                    onDateSubmitted: (DateTime date) {
                                      setState(() {
                                        _selectedDate.value = date;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: IconButton(
                                    icon: Icon(Icons.calendar_today),
                                    onPressed: () {
                                      _restorableDatePickerRouteFuture
                                          .present();
                                      // Your logic to show date picker dialog or perform any action
                                    },
                                  ),
                                ),
                              ],
                            ),

                            // DateTimeFormField(
                            //   decoration: const InputDecoration(
                            //     labelText: 'Enter Date',
                            //   ),
                            //   firstDate:
                            //       DateTime.now().add(const Duration(days: 10)),
                            //   lastDate:
                            //       DateTime.now().add(const Duration(days: 40)),
                            //   initialPickerDateTime:
                            //       DateTime.now().add(const Duration(days: 20)),
                            //   onChanged: (DateTime? value) {
                            //     selectedDate = value;
                            //   },
                            // ),
                            // CustomTextFormFied(
                            //   labelText: 'eg: 01/01/1990',
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter your birthday';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            const Text('You must be 18 or older to use Vista.',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFormFied(
                              labelText: 'eg: example@gmail.com',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFormFied(
                              labelText: 'Password',
                              obscureText: _obscureText,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            const Text(
                              "Password strength: strong \nCan't contain your name or email address \nAt least 8 character \nContains a number or symbol",
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        // add check box for terms and conditions

                        const Text(
                          "By selecting Agree and continue below, I agree to Airbnb’s Terms of Service, Payments Terms of Service, Privacy Policy, and Nondiscrimination Policy.",
                          style: TextStyle(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                        Row(
                          children: [
                            Checkbox(
                              value: false,
                              onChanged: (value) {
                                // setState(() {
                                //   value = value!;
                                // });
                              },
                            ),
                            const Expanded(
                              child: Text(
                                "I agree to VistaStay’s Terms of Service, Payments Terms of Service,  Privacy Policy, and Nondiscrimination Policy.",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // social media login
                      ],
                    ),
                  ),

                  // phone number
                ],
              ),
            ),
          ),
        ),
        persistentFooterButtons: [
          ElevatedButton(
            onPressed: () {
              // if (_formKey.currentState!.validate()) {
              // }

              Get.to(() => const AgrreOrDeclineTerms());
            },
            child: const Text('Agree and Continue'),
          ),
        ],
      ),
    );
  }
}

// class DatePickerExample extends StatefulWidget {
//   const DatePickerExample({super.key, this.restorationId});

//   final String? restorationId;

//   @override
//   State<DatePickerExample> createState() => _DatePickerExampleState();
// }

// /// RestorationProperty objects can be used because of RestorationMixin.
// class _DatePickerExampleState extends State<DatePickerExample>
//     with RestorationMixin {
//   // In this example, the restoration ID for the mixin is passed in through
//   // the [StatefulWidget]'s constructor.
//   @override
//   String? get restorationId => widget.restorationId;

//   final RestorableDateTime _selectedDate =
//       RestorableDateTime(DateTime(2021, 7, 25));
//   late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
//       RestorableRouteFuture<DateTime?>(
//     onComplete: _selectDate,
//     onPresent: (NavigatorState navigator, Object? arguments) {
//       return navigator.restorablePush(
//         _datePickerRoute,
//         arguments: _selectedDate.value.millisecondsSinceEpoch,
//       );
//     },
//   );

//   @pragma('vm:entry-point')
//   static Route<DateTime> _datePickerRoute(
//     BuildContext context,
//     Object? arguments,
//   ) {
//     return DialogRoute<DateTime>(
//       context: context,
//       builder: (BuildContext context) {
//         return DatePickerDialog(
//           restorationId: 'date_picker_dialog',
//           initialEntryMode: DatePickerEntryMode.calendarOnly,
//           initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
//           firstDate: DateTime(2021),
//           lastDate: DateTime(2022),
//         );
//       },
//     );
//   }

//   @override
//   void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     registerForRestoration(_selectedDate, 'selected_date');
//     registerForRestoration(
//         _restorableDatePickerRouteFuture, 'date_picker_route_future');
//   }

//   void _selectDate(DateTime? newSelectedDate) {
//     if (newSelectedDate != null) {
//       setState(() {
//         _selectedDate.value = newSelectedDate;
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text(
//               'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
//         ));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: OutlinedButton(
//           onPressed: () {
//             _restorableDatePickerRouteFuture.present();
//           },
//           child: const Text('Open Date Picker'),
//         ),
//       ),
//     );
//   }
// }
