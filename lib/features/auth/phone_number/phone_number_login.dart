import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import 'package:vista/features/auth/email_login/email_login.dart';

import 'bloc/phone_number_auth_bloc.dart';

class PhoneNumnerLogin extends StatefulWidget {
  const PhoneNumnerLogin({super.key});

  @override
  State<PhoneNumnerLogin> createState() => _LoginPageState();
}

class _LoginPageState extends State<PhoneNumnerLogin> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();
  var _completePhoneNumber = "";
  final _phoneNumberController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneNumberAuthBloc, PhoneNumberAuthState>(
      listener: (context, state) {
        if (state is PhoneNumberAuthLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is PhoneNumberAuthSuccess) {
          setState(() {
            isLoading = false;
          });
        } else if (state is PhoneNumberAuthFailure) {
          setState(() {
            isLoading = false;
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 20),
                      child: Text(
                        'Send OTP',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),

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
                              log(phone.completeNumber);
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
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),

                          // button

                          const SizedBox(
                            height: 30,
                          ),

                          ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (_completePhoneNumber.isEmpty) {
                                      Get.snackbar(
                                          "Error", "Please enter phone number");
                                      return;
                                    } else if (_completePhoneNumber.length <
                                        10) {
                                      Get.snackbar("Error",
                                          "Please enter valid phone number");
                                      return;
                                    }

                                    BlocProvider.of<PhoneNumberAuthBloc>(
                                            context)
                                        .add(SendOTPEvent(
                                            phoneNumber: _completePhoneNumber));
                                  },
                            child: BlocBuilder<PhoneNumberAuthBloc,
                                PhoneNumberAuthState>(
                              builder: (context, state) {
                                const spinkit = SpinKitWave(
                                  color: Colors.white,
                                  size: 20.0,
                                );
                                if (state is PhoneNumberAuthLoading) {
                                  // Doted progress bar
                                  return spinkit;
                                } else {
                                  return const Text('Send OTP');
                                }
                              },
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text("or"),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width:
                                    2.0, // Set your desired border width here
                              ),
                              borderRadius: BorderRadius.circular(
                                  8.0), // Optional: if you want rounded corners
                            ),
                            child: SocialLoginButton(
                              backgroundColor: Colors.white,
                              height: 44,
                              text: ' Continue with Email',
                              textColor: Colors.black,
                              borderRadius: 5,
                              buttonType: SocialLoginButtonType.generalLogin,
                              imagePath: "assets/images/email.png",
                              imageURL: "URL",
                              onPressed: () {
                                Get.to(() => const EmailLogin());
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width:
                                    2.0, // Set your desired border width here
                              ),
                              borderRadius: BorderRadius.circular(
                                  8.0), // Optional: if you want rounded corners
                            ),
                            child: SocialLoginButton(
                              // backgroundColor: Colors.amber,
                              height: 44,
                              text: 'Continue with Google',
                              borderRadius: 5,
                              buttonType: SocialLoginButtonType.google,
                              onPressed: () {},
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width:
                                    2.0, // Set your desired border width here
                              ),
                              borderRadius: BorderRadius.circular(
                                  8.0), // Optional: if you want rounded corners
                            ),
                            child: SocialLoginButton(
                              height: 44,
                              text: 'Continue with Apple',
                              buttonType: SocialLoginButtonType.apple,
                              borderRadius: 5,
                              onPressed: () {},
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width:
                                    2.0, // Set your desired border width here
                              ),
                              borderRadius: BorderRadius.circular(
                                  8.0), // Optional: if you want rounded corners
                            ),
                            child: SocialLoginButton(
                              height: 44,
                              text: 'Continue with Facebook',
                              buttonType: SocialLoginButtonType.facebook,
                              borderRadius: 5,
                              onPressed: () {},
                            ),
                          ),

                          // social media login

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
        ),
      ),
    );
  }
}
