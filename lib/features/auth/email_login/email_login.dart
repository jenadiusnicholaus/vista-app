import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:vista/constants/custom_form_field.dart';
import 'package:vista/features/auth/register/register.dart';
import '../phone_number/phone_number_login.dart';
import 'bloc/email_login_bloc.dart';
import '../forget_password/forget_password_page.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;
  var _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<EmailLoginBloc, EmailLoginState>(
      listener: (context, state) {
        if (state is EmailLoginLoading) {
          setState(() {
            _isSubmitting = true;
          });
        } else if (state is EmailLoginSuccess) {
          setState(() {
            _isSubmitting = false;
          });
          // Get.to(() => const HomePage());
        } else if (state is EmailLoginFailure) {
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        'Sign In',
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
                                controller: _phoneNumberController,
                                labelText: 'eg: axample@gmail.com',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                            ],
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
                            ],
                          ),

                          // button

                          const SizedBox(
                            height: 30,
                          ),

                          ElevatedButton(
                            onPressed: _isSubmitting
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<EmailLoginBloc>(context)
                                          .add(
                                        EmailLoginButtonPressed(
                                          email: _phoneNumberController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                    }
                                  },
                            child: BlocBuilder<EmailLoginBloc, EmailLoginState>(
                              builder: (context, state) {
                                if (state is EmailLoginLoading) {
                                  return const SpinKitWave(
                                    color: Colors.white,
                                    size: 20.0,
                                  );
                                }
                                return const Text('login');
                              },
                            ),
                          ),

                          TextButton(
                              onPressed: () {
                                Get.to(() => const RegisterPage());
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("I don't have an account"),
                                  Text("Sign Up")
                                ],
                              )),

                          TextButton(
                              onPressed: () {
                                Get.to(() => const FogetPasswordPage());
                              },
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Forgot Password"),
                                  Text("Reset")
                                ],
                              )),

                          const SizedBox(
                            height: 1,
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
                            height: 10,
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
                              text: ' Continue with Phone',
                              textColor: Colors.black,
                              borderRadius: 5,
                              buttonType: SocialLoginButtonType.generalLogin,
                              imagePath: "assets/images/phone.jpg",
                              imageURL: "URL",
                              onPressed: () {
                                Get.to(() => PhoneNumnerLogin());
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
                              text: 'Continue with google',
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
