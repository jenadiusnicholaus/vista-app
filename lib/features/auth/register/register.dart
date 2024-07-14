
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:vista/features/auth/register/bloc/registration_bloc.dart';
import '../../../constants/custom_form_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RestorationMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _comfirmPasswordController = TextEditingController();

  var _completePhoneNumber = "";
  final FocusNode _focusNode = FocusNode();
  var _obscureText = true;
  DateTime? selectedDate;
  var isLoading = false;
  var checked = false;
  bool _isSubmitting = false;

  RegistrationBloc? registrationBloc;

  @override
  String? get restorationId => 'register_page';

  @override
  void initState() {
    registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    super.initState();
  }

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
      // Calculate age
      final currentDate = DateTime.now();
      int age = currentDate.year - newSelectedDate.year;
      if (newSelectedDate.month > currentDate.month ||
          (newSelectedDate.month == currentDate.month &&
              newSelectedDate.day > currentDate.day)) {
        age--;
      }
      final isAdult = age >= 18;

      if (isAdult) {
        setState(() {
          _selectedDate.value = newSelectedDate;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'You much be 18 years or older to use Vista. Please select a valid date.',
            style: TextStyle(color: Colors.red),
          ),
        ));
      }
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'Date is null';
    return DateFormat('y-M-d')
        .format(date); // Formats date to '1993-2-3' format
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _focusNode.dispose();
    _selectedDate.dispose();
    _restorableDatePickerRouteFuture.dispose();
    registrationBloc!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationLoading) {
          setState(() {
            _isSubmitting = true;
          });
        } else if (state is RegistrationSuccess) {
          setState(() {
            _isSubmitting = false;
          });
          // Get.to(() => const AgrreOrDeclineTerms());
        } else if (state is RegistrationFailure) {
          setState(() {
            _isSubmitting = false;
          });
          Get.snackbar('Error', state.message);
        }
      },
      child: SafeArea(
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
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
                            languageCode: "en",
                            onChanged: (phone) {
                              setState(() {
                                _completePhoneNumber = phone.completeNumber;
                              });
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
                              CustomTextFormField(
                                controller: _firstNameController,
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
                              CustomTextFormField(
                                controller: _lastNameController,
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
                              const SizedBox(
                                height: 8,
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
                              // CustomTextFormField(
                              //   labelText: 'eg: 01/01/1990',
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Please enter your birthday';
                              //     }
                              //     return null;
                              //   },
                              // ),
                              const Text(
                                  'You must be 18 or older to use Vista.',
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
                              CustomTextFormField(
                                controller: _emailController,
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
                              CustomTextFormField(
                                controller: _passwordController,
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
                                'Your password can’t be too similar to your other personal information.\n Your password must contain at least 8 characters.\nYour password can’t be a commonly used password.\n Your password can’t be entirely numeric.',
                                style: TextStyle(fontSize: 11),
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
                                "Confirm Password",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              CustomTextFormField(
                                controller: _comfirmPasswordController,
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
                            ],
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
                                value: checked,
                                onChanged: (value) {
                                  setState(() {
                                    checked = value!;
                                  });
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
              onPressed: _isSubmitting
                  ? null
                  : () {
                      if (!checked) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Please agree to the terms and conditions',
                            style: TextStyle(color: Colors.red),
                          ),
                        ));
                      }
                      if (_formKey.currentState!.validate() && checked) {
                        BlocProvider.of<RegistrationBloc>(context)
                            .add(RegistrationEventInitial(
                          phoneNumber: _completePhoneNumber,
                          firstName: _firstNameController.text,
                          lastName: _lastNameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          dateOfBirth: formatDate(_selectedDate.value),
                          password2: _comfirmPasswordController.text,
                          agreedToTerms: checked,
                        ));
                      }

                      // Get.to(() => const AgrreOrDeclineTerms());
                    },
              child: BlocBuilder<RegistrationBloc, RegistrationState>(
                builder: (context, state) {
                  if (state is RegistrationLoading) {
                    return const SpinKitWave(
                      color: Colors.white,
                      size: 20.0,
                    );
                  }
                  return const Text('Agree and Continue');
                },
              ),
            ),
          ],
        ),
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
