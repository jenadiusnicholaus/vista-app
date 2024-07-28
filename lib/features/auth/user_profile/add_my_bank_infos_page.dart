import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vista/constants/custom_form_field.dart';
import 'package:vista/shared/widgets/error_snack_bar.dart';

import '../../../constants/consts.dart';
import 'bloc/user_profile_bloc.dart';

class MyBankInforsPage extends StatefulWidget {
  final dynamic property;
  final RequestContext requestContext;
  const MyBankInforsPage({
    super.key,
    required this.property,
    required this.requestContext,
  });

  @override
  State<MyBankInforsPage> createState() => _MyBankInforsPageState();
}

class _MyBankInforsPageState extends State<MyBankInforsPage> {
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedBankName = 'CRDB';
  bool isAdding = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('My Bank Infors'),
      ),
      body: SingleChildScrollView(
        // reverse: true,
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
                  // const Text('Add Bank Account', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  const Text('Bank Name'),
                  const SizedBox(height: 10),
                  //  CREATE DROP DOWN FOR BANK NAME, CRDB, NMB.
                  DropdownButtonFormField<String>(
                    value: _selectedBankName,
                    items: ['CRDB', 'NMB'].map((String bank) {
                      return DropdownMenuItem<String>(
                        value: bank,
                        child: Text(bank),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedBankName = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: "Select Bank",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a bank name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  const Text('Account Number'),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    labelText: "eg. 123456789",
                    controller: _accountNumberController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter account number';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),
                  const Text('Account Name'),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    labelText: "eg. John Doe",
                    controller: _accountNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter account name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: isAdding
                        ? null
                        : () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            BlocProvider.of<UserProfileBloc>(context).add(
                              AddBankAccountInfos(
                                bankName: _selectedBankName,
                                accountNumber: _accountNumberController.text,
                                accountName: _accountNameController.text,
                                property: widget.property,
                                requestContext: widget.requestContext,
                              ),
                            );
                            // Process data.
                          },
                    child: BlocConsumer<UserProfileBloc, UserProfileState>(
                      listener: (context, state) {
                        if (state is AddBankAccountInfosLoading) {
                          setState(() {
                            isAdding = true;
                          });
                        }
                        if (state is AddBankAccountInfosSuccess) {
                          setState(() {
                            isAdding = false;
                          });
                        }
                        if (state is AddBankAccountInfosFailed) {
                          setState(() {
                            isAdding = false;
                          });
                          showMessage(
                              message: state.error,
                              title: "Error",
                              isAnError: true);
                        }
                      },
                      builder: (context, state) {
                        if (state is AddBankAccountInfosLoading) {
                          return const SpinKitWave(
                            color: Colors.white,
                            size: 20.0,
                          );
                        }
                        return const Text('Save');
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
