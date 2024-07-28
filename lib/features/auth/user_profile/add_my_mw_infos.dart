import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vista/constants/consts.dart';
import 'package:vista/shared/widgets/error_snack_bar.dart';

import '../../../constants/custom_form_field.dart';
import 'bloc/user_profile_bloc.dart';

class AddMyMwInfosPage extends StatefulWidget {
  final dynamic property;
  final RequestContext requestContext;
  const AddMyMwInfosPage(
      {super.key, required this.property, required this.requestContext});

  @override
  State<AddMyMwInfosPage> createState() => _AddMyMwInfosPageState();
}

class _AddMyMwInfosPageState extends State<AddMyMwInfosPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedMobileNetwork = 'Mpesa';
  final TextEditingController _mobileNumberController = TextEditingController();
  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Mobile Money'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text('Mobile Money Network'),
                  const SizedBox(height: 10),
                  // CREATE DROP DOWN FOR Mpesa, Tigo, TIGO, Airtel.
                  DropdownButtonFormField<String>(
                    value: _selectedMobileNetwork,
                    items: ['Mpesa', 'Tigo', 'Airtel'].map((String network) {
                      return DropdownMenuItem<String>(
                        value: network,
                        child: Text(network),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedMobileNetwork = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "Select Mobile Network",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a mobile network';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Mobile Money Number'),
                  const SizedBox(height: 10),
                  // CREATE TEXT FIELD FOR MOBILE MONEY NUMBER.
                  CustomTextFormField(
                    labelText: "eg. +254712345678 or 0712345678",
                    controller: _mobileNumberController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter mobile money number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // CREATE BUTTON FOR ADDING MOBILE MONEY.
                  ElevatedButton(
                    onPressed: isSaving
                        ? null
                        : () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            // ADD MOBILE MONEY TO USER PROFILE.
                            BlocProvider.of<UserProfileBloc>(context).add(
                              AddMobileMoneyPaymentInfos(
                                  mobileNetwork: _selectedMobileNetwork!,
                                  mobileNumber: _mobileNumberController.text,
                                  property: widget.property,
                                  requestContext: widget.requestContext),
                            );
                          },
                    child: BlocConsumer<UserProfileBloc, UserProfileState>(
                      listener: (context, state) {
                        // isSaving = state is UserProfileLoading;
                        if (state is AddMobileMoneyPaymentInfosLoading) {
                          setState(() {
                            isSaving = true;
                          });
                        }
                        if (state is AddMobileMoneyPaymentInfosSuccess) {
                          setState(() {
                            isSaving = false;
                          });
                        }
                        if (state is AddMobileMoneyPaymentInfosFailed) {
                          setState(() {
                            isSaving = false;
                          });
                          showMessage(
                            message: "Failed to add",
                            isAnError: true,
                            title: "Error",
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AddMobileMoneyPaymentInfosLoading) {
                          return const SpinKitWave(
                            color: Colors.white,
                            size: 20.0,
                          );
                        }
                        return const Text('save');
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
