import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:vista/features/auth/register/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode = FocusNode();
  final _phoneNumberController = TextEditingController();
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
                    padding: EdgeInsets.only(top: 60, bottom: 20),
                    child: Text(
                      'Sign or Sign Up',
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
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),

                        // button

                        const SizedBox(
                          height: 30,
                        ),

                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(
                              //     content: Text('Processing Data'),
                              //   ),
                              // );
                              // RegisterPage();
                              Get.to(() => const RegisterPage());
                            }
                          },
                          child: const Text('Continue'),
                        ),

                        const SizedBox(
                          height: 30,
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
                              width: 2.0, // Set your desired border width here
                            ),
                            borderRadius: BorderRadius.circular(
                                8.0), // Optional: if you want rounded corners
                          ),
                          child: SocialLoginButton(
                            backgroundColor: Colors.white,
                            height: 44,
                            text: ' Continue with email',
                            textColor: Colors.black,
                            borderRadius: 5,
                            buttonType: SocialLoginButtonType.generalLogin,
                            imagePath: "assets/images/email.png",
                            imageURL: "URL",
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
                              width: 2.0, // Set your desired border width here
                            ),
                            borderRadius: BorderRadius.circular(
                                8.0), // Optional: if you want rounded corners
                          ),
                          child: SocialLoginButton(
                            // backgroundColor: Colors.amber,
                            height: 44,
                            text: 'Continue with google',
                            borderRadius: 5,
                            buttonType: SocialLoginButtonType.google,
                            // imageURL: "URL",
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
                              width: 2.0, // Set your desired border width here
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
                              width: 2.0, // Set your desired border width here
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
    );
  }
}
