import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vista/constants/custom_form_field.dart';
import 'package:vista/features/auth/forget_password/bloc/forget_password_bloc.dart';

import 'bloc/confirm_reset_password_bloc.dart';

class ConfirmResetPasswordPage extends StatefulWidget {
  const ConfirmResetPasswordPage({super.key});

  @override
  State<ConfirmResetPasswordPage> createState() =>
      _ConfirmResetPasswordPageState();
}

class _ConfirmResetPasswordPageState extends State<ConfirmResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _comfirmPasswordController =
      TextEditingController();
  final TextEditingController _confirmTokenController = TextEditingController();
  bool absecureTxt = false;
  String _message = '';
  bool _isConfirming = false;

  ForgetPasswordBloc forgetPasswordBloc = ForgetPasswordBloc();

  @override
  void initState() {
    forgetPasswordBloc = BlocProvider.of<ForgetPasswordBloc>(context);

    var state = forgetPasswordBloc.state;
    if (state is ForgetPasswordSuccess) {
      _message = state.message;
      _emailController.text = state.email;
    }

    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmTokenController.dispose();
    forgetPasswordBloc.close();
    // This is not used
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Reset Password'),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _message.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Email'),
                const SizedBox(
                  height: 3,
                ),
                CustomTextFormField(
                  labelText: 'eg: example@gmail.com',
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('New Password'),
                const SizedBox(
                  height: 3,
                ),
                CustomTextFormField(
                    labelText: 'Enter new password',
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter new password';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          absecureTxt = !absecureTxt;
                        });
                      },
                      icon: Icon(
                        absecureTxt ? Icons.visibility_off : Icons.visibility,
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                const Text('Confirm Password'),
                const SizedBox(
                  height: 3,
                ),
                CustomTextFormField(
                  labelText: 'Confirm new password',
                  controller: _comfirmPasswordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter confirm password';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        absecureTxt = !absecureTxt;
                      });
                    },
                    icon: Icon(
                      absecureTxt ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Token'),
                const SizedBox(
                  height: 3,
                ),
                CustomTextFormField(
                  labelText: 'Enter token',
                  controller: _confirmTokenController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter token';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _isConfirming
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<ConfirmResetPasswordBloc>(context)
                                .add(
                              OnConfirmResetPasswordBtnPressed(
                                email: _emailController.text,
                                newPassword: _passwordController.text,
                                confirmPassword:
                                    _comfirmPasswordController.text,
                                token: _confirmTokenController.text,
                              ),
                            );
                          }
                        },
                  child: BlocConsumer<ConfirmResetPasswordBloc,
                      ConfirmResetPasswordState>(
                    listener: (context, state) {
                      if (state is ConfirmResetPasswordLoading) {
                        setState(() {
                          _isConfirming = true;
                        });
                      }
                      if (state is ConfirmResetPasswordSuccess) {
                        setState(() {
                          _isConfirming = false;
                        });
                      }

                      if (state is ConfirmResetPasswordFailure) {
                        setState(() {
                          _isConfirming = false;
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is ConfirmResetPasswordLoading) {
                        return const SpinKitWave(
                          color: Colors.white,
                          size: 20,
                        );
                      }
                      return const Text('Confirm Reset Password');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // }
}
