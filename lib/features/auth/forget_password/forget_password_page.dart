import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vista/constants/custom_form_field.dart';

import 'bloc/forget_password_bloc.dart';

class FogetPasswordPage extends StatefulWidget {
  const FogetPasswordPage({super.key});

  @override
  State<FogetPasswordPage> createState() => _FogetPasswordPageState();
}

class _FogetPasswordPageState extends State<FogetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSending = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Enter your email to reset password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: _emailController,
                labelText: 'eg: example@gmail.com',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: isSending
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<ForgetPasswordBloc>(context).add(
                              OnForgetPasswordBtnPressed(
                                  email: _emailController.text),
                            );
                          }
                        },
                  child: BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
                    listener: (context, state) {
                      if (state is ForgetPasswordLoading) {
                        setState(() {
                          isSending = true;
                        });
                      }
                      if (state is ForgetPasswordSuccess) {
                        setState(() {
                          isSending = false;
                        });
                      }

                      if (state is ForgetPasswordFailure) {
                        setState(() {
                          isSending = false;
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is ForgetPasswordLoading) {
                        return const SpinKitWave(
                          color: Colors.white,
                          size: 20,
                        );
                      }
                      return const Text("Send");
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
