import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/custom_pin_put.dart';
import 'bloc/phone_number_auth_bloc.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({super.key});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  PhoneNumberAuthBloc? phoneNumberAuthBloc;
  String phoneNumber = '';
  String? otp;
  var verifyOtpController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  bool _isResending = false;
  bool _isVerifying = false;

  @override
  initState() {
    super.initState();
    phoneNumberAuthBloc = BlocProvider.of<PhoneNumberAuthBloc>(context);
    var state = phoneNumberAuthBloc!.state;
    if (state is PhoneNumberAuthSuccess) {
      otp = state.sentTokenModel?.alternativeOtps.toString();
      phoneNumber = state.phoneNumber!;
      pinController.text = otp!;
    }
  }

  String formatPhoneNumber(String phoneNumber) {
    // Assuming the phone number format is always valid and follows the pattern +234XXXXXXXXXX
    String countryCode = phoneNumber.substring(0, 4); // +234
    String lastTwoDigits =
        phoneNumber.substring(phoneNumber.length - 3); // Last two digits
    return "$countryCode XXX $lastTwoDigits";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Phone Number'),
      ),
      body: BlocListener<PhoneNumberAuthBloc, PhoneNumberAuthState>(
        listener: (context, state) {
          if (state is PhoneNumberAuthVerifyLoading) {
            setState(() {
              _isVerifying = true;
            });
          }

          if (state is PhoneNumberAuthVerifySuccess) {
            setState(() {
              _isVerifying = false;
            });
          } else if (state is PhoneNumberAuthVerifyFailure) {
            setState(() {
              _isVerifying = false;
            });
          }
        },
        child: Container(
          margin:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          width: double.infinity,
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //  show only few digits of the phone number in  format like +234 80X XXX XXXX
                    Text(
                      'Enter the code sent to this number $phoneNumber',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'OTP',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomPinPutField(
                      pinController: pinController,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: _isVerifying
                            ? null
                            : () {
                                if (_formkey.currentState!.validate()) {
                                  phoneNumberAuthBloc!.add(
                                    VerifyOTPEvent(
                                      phoneNumber: phoneNumber,
                                      otpCode: pinController.text,
                                    ),
                                  );
                                }
                              },
                        child: BlocBuilder<PhoneNumberAuthBloc,
                            PhoneNumberAuthState>(
                          builder: (context, state) {
                            if (_isVerifying) {
                              return const SpinKitWave(
                                color: Colors.white,
                                size: 20.0,
                              );
                            }
                            return const Text('Verify',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal));
                          },
                        )),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<PhoneNumberAuthBloc>(context)
                            .add(SendOTPEvent(phoneNumber: phoneNumber));
                      },
                      child: BlocConsumer<PhoneNumberAuthBloc,
                          PhoneNumberAuthState>(
                        listener: (context, state) {
                          if (state is PhoneNumberAuthLoading) {
                            setState(() {
                              _isResending = true;
                            });
                          }
                          if (state is PhoneNumberAuthSuccess) {
                            setState(() {
                              _isResending = false;
                            });
                            Get.snackbar('OTP Resent',
                                'OTP has been resent to $phoneNumber',
                                icon: const Icon(
                                  Icons.check_circle_outline,
                                ));
                          }

                          if (state is PhoneNumberAuthFailure) {
                            setState(() {
                              _isResending = false;
                            });
                          }
                        },
                        builder: (context, state) {
                          if (_isResending) {
                            return const SpinKitWave(
                              color: Colors.green,
                              size: 20.0,
                            );
                          }

                          return const Text('Resent OTP');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
