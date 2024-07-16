import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vista/features/auth/activate_account/bloc/activate_account_bloc.dart';
import 'package:vista/features/auth/register/models.dart';
import 'package:vista/shared/widgets/custom_pin_put.dart';

import '../register/bloc/registration_bloc.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  RegistrationBloc? registrationBloc;
  ActivateAccountBloc? activateAccountBloc;
  final _formKey = GlobalKey<FormState>();
  RegistrationModel? registrationModel;

  late final TextEditingController pinController;
  late final FocusNode focusNode;

  bool isSubmiting = false;
  bool isResending = false;

  @override
  void initState() {
    registrationBloc = BlocProvider.of<RegistrationBloc>(context);
    activateAccountBloc = BlocProvider.of<ActivateAccountBloc>(context);
    var state = registrationBloc!.state;
    if (state is RegistrationSuccess) {
      registrationModel = state.registrationModel;
    }

    pinController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    registrationBloc!.close();
    activateAccountBloc!.close();
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activate Your Account'),
      ),
      body: BlocListener<ActivateAccountBloc, ActivateAccountState>(
        listener: (context, state) {
          if (state is ActivateAccountLoading) {
            setState(() {
              isSubmiting = true;
            });
          } else if (state is ActivateAccountSuccess) {
            setState(() {
              isSubmiting = false;
            });
            Get.snackbar('Success', state.message);
          } else if (state is ActivateAccountFailure) {
            setState(() {
              isSubmiting = false;
            });
            Get.snackbar('Error', state.message!);
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
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      registrationModel?.message ?? '',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.green),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'OTP Code',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 10),
                    CustomPinPutField(
                      pinController: pinController,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: isSubmiting
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<ActivateAccountBloc>(context)
                                      .add(VerifyEmailEvent(
                                          email:
                                              registrationModel!.data?.email ??
                                                  '',
                                          code: pinController.text));
                                }
                              },
                        child: BlocBuilder<ActivateAccountBloc,
                            ActivateAccountState>(
                          builder: (context, state) {
                            if (state is ActivateAccountLoading) {
                              return const SpinKitWave(
                                color: Colors.white,
                                size: 20.0,
                              );
                            }

                            return const Text('Verify');
                          },
                        )),
                    BlocListener<ActivateAccountBloc, ActivateAccountState>(
                      listener: (context, state) {
                        if (state is ActivateAccountLoading) {
                          setState(() {
                            isResending = true;
                          });
                        } else {
                          setState(() {
                            isResending = false;
                          });
                        }
                      },
                      child: TextButton(
                        onPressed: isResending
                            ? null
                            : () {
                                BlocProvider.of<ActivateAccountBloc>(context)
                                    .add(ResendCodeEvent(
                                        email: registrationModel!.data!.email
                                            .toString()));
                              },
                        child: BlocBuilder<ActivateAccountBloc,
                            ActivateAccountState>(
                          builder: (context, state) {
                            if (state is ActivateAccountLoading) {
                              return const SpinKitWave(
                                color: Colors.white,
                                size: 20.0,
                              );
                            }
                            return const Text('Resend Code',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal));
                          },
                        ),
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
