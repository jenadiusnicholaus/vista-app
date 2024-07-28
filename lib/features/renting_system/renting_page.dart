import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as intl;
import 'package:vista/shared/widgets/error_snack_bar.dart';

import '../../constants/consts.dart';
import '../../shared/widgets/confirm_booking_dialog.dart';
import '../auth/user_profile/add_my_bank_infos_page.dart';
import '../auth/user_profile/add_my_mw_infos.dart';
import '../auth/user_profile/update_my_bank_infos.dart';
import '../auth/user_profile/update_my_mw_infos.dart';
import '../booking_system/booking_page.dart';
import '../home_pages/explore/models.dart';
import '../home_pages/propert_details/bloc/property_details_bloc.dart';
import 'add_my_renting_page.dart';
import 'bloc/my_renting_bloc.dart';
import 'confirm_renting/bloc/confirm_renting_bloc.dart';
import 'update_my_renting_page.dart';

class RentingPage extends StatefulWidget {
  final dynamic property;
  const RentingPage({super.key, required this.property});

  @override
  State<RentingPage> createState() => _RentingPageState();
}

class _RentingPageState extends State<RentingPage> {
  double totalPrice = 0;
  int? _value = 0;
  Rdos? rdos;
  String _selectedPaymentMethod = '';
  bool isMoneyTransferSelected = false;
  bool isBankTransferSelected = false;
  dynamic _selectedAcconntNumber;
  int? _rentingId;
  bool isConfirming = false;
  bool isAvailable = true;

  String? message;

  Future<void> _launchUrl() async {
    Uri? contractUri;
    if (widget.property.contractDraft != null) {
      contractUri = Uri.parse(widget.property.contractDraft);
      var launch = await launchUrl(contractUri);
      if (!launch) {
        log('Could not launch $contractUri');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.property.rdos.isNotEmpty) {
      rdos = widget.property.rdos[0];
      totalPrice = double.parse(widget.property.price) *
          double.parse(widget.property.rdos[0].timeInNumber.toString());
    }
    BlocProvider.of<MyRentingBloc>(context)
        .add(GetMyRenting(widget.property.id));
  }

  _updateTeSelectedPaymentMethodOnInitState(MyRentingSuccess state) {
    setState(() {
      _rentingId = state.myRentingModel.id;
      isAvailable = state.myRentingModel.property!.availabilityStatus!;
      // isBookingConfirmed = state.booking.myBookingStatus!.confirmed;
    });
    if (state.myRentingModel.myMwPayment?.mobileNumber != '') {
      setState(() {
        isMoneyTransferSelected = true;
        _selectedAcconntNumber =
            state.myRentingModel.myMwPayment?.mobileNumber ?? '';
        _selectedPaymentMethod =
            state.myRentingModel.myMwPayment?.mobileNetwork ?? '';
      });
    } else if (state.myRentingModel.myPaymentCard!.accountNumber != null) {
      setState(() {
        isBankTransferSelected = true;

        _selectedPaymentMethod =
            state.myRentingModel.myPaymentCard?.bankName ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyRentingBloc, MyRentingState>(
      listener: (context, state) {
        if (state is MyRentingSuccess) {
          _updateTeSelectedPaymentMethodOnInitState(state);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
              BlocProvider.of<PropertyDetailsBloc>(context).add(
                  (GetPropertyDetailsEvent(propertyId: widget.property.id!)));
            },
          ),
          title: const Text('Rent Property'),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: ListTile(
                      leading: Image.network(
                        widget.property.image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      title: Text(widget.property.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.property.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          RatingBar.builder(
                            initialRating: widget.property.rating,
                            ignoreGestures: true,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          Text("Rating: ${widget.property.rating}"),
                        ],
                      ),
                    ),
                  ),
                ),

                // Renting  Duration
                Card(
                  child: ListTile(
                    title: const Text(' Select Renting Duration you Want',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            'Select the duration you want to rent this property'),
                        if (widget.property.rdos.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Wrap(
                              spacing: 8.0, // gap between adjacent chips
                              runSpacing: 4.0, // gap between lines
                              children: List<Widget>.generate(
                                widget.property.rdos.length,
                                (int index) {
                                  return ChoiceChip(
                                    label: Text(
                                        "${widget.property.rdos[index].timeInNumber} ${widget.property.rdos[index].timeInText}"
                                            .toString()),
                                    selected: (_value == index),
                                    onSelected: (bool selected) {
                                      message = "update the chages";
                                      setState(() {
                                        _value = selected ? index : null;
                                        rdos = widget.property.rdos[index];
                                        if (rdos?.timeInText == "year") {
                                          totalPrice = double.parse(
                                                  widget.property.price) *
                                              12;
                                        } else {
                                          totalPrice = double.parse(
                                                  widget.property.price) *
                                              double.parse(rdos!.timeInNumber
                                                  .toString());
                                        }
                                      });
                                    },
                                  );
                                },
                              ).toList(),
                            ),
                          )
                        else
                          // Return a placeholder or an alternative widget if rdos is empty
                          const Text('No options available'),
                      ],
                    ),
                  ),
                ),

                //  Price per Duration
                Card(
                  child: ListTile(
                      title: BlocBuilder<MyRentingBloc, MyRentingState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('When and Who will be Renting',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          state is MyRentingSuccess
                              ? IconButton(
                                  icon: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.edit),
                                      Text(message ?? "",
                                          style: const TextStyle(
                                              fontSize: 9, color: Colors.red)),
                                      message != null
                                          ? Text("${totalPrice.toString()}",
                                              style: const TextStyle(
                                                  fontSize: 9,
                                                  color: Colors.red))
                                          : Text("")
                                    ],
                                  ),
                                  onPressed: () {
                                    Get.to(() => UpdateRentingPage(
                                        property: widget.property,
                                        selectDuration: rdos!.id!,
                                        totalPrice: totalPrice,
                                        myRentingModel: state.myRentingModel));
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(Icons.add_outlined),
                                  onPressed: () {
                                    if (rdos == null) {
                                      Get.snackbar('Error',
                                          'Please select the duration you want to rent this property');
                                      return;
                                    }
                                    Get.to(() => AddRentingPage(
                                          property: widget.property,
                                          selectDuration: rdos!.id!,
                                          totalPrice: totalPrice,
                                        ));
                                  },
                                )
                        ],
                      );
                    },
                  ), subtitle: BlocBuilder<MyRentingBloc, MyRentingState>(
                    builder: (context, state) {
                      if (state is MyRentingLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is MyRentingFailure) {
                        return Text(state.errorMessage);
                      }
                      if (state is MyRentingSuccess) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black), // Default text style
                                children: [
                                  const TextSpan(text: 'Duration: '),
                                  TextSpan(
                                    text:
                                        '${state.myRentingModel.rentingDuration!.timeInNumber} ${state.myRentingModel.rentingDuration?.timeInText!}',
                                    // '${double.parse(widget.property.price).round()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black), // Default text style
                                children: [
                                  const TextSpan(text: 'Check in/out: '),
                                  TextSpan(
                                    text:
                                        '${state.myRentingModel.checkIn} - ${state.myRentingModel.checkOut}',

                                    // '${(double.parse(widget.property.price) * 3).round()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black), // Default text style
                                children: [
                                  const TextSpan(text: 'Adults: '),
                                  TextSpan(
                                    text: '${state.myRentingModel.adult}',

                                    // '${(double.parse(widget.property.price) * 3).round()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black), // Default text style
                                children: [
                                  const TextSpan(text: 'children: '),
                                  TextSpan(
                                    text: '${state.myRentingModel.children}',

                                    // '${(double.parse(widget.property.price) * 3).round()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black), // Default text style
                                children: [
                                  const TextSpan(
                                      text: 'Total Family Members: '),
                                  TextSpan(
                                    text:
                                        '${state.myRentingModel.totalFamilyMember}',

                                    // '${(double.parse(widget.property.price) * 3).round()}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: const Text('Total Price',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                widget.property.price == null
                                    ? '${widget.property.currency} ${intl.NumberFormat('#,##0.00', widget.property.currency == "Tsh" ? "sw_TZ" : "en_US").format(totalPrice)}'
                                    : '${widget.property.currency} ${intl.NumberFormat('#,##0.00', widget.property.currency == "Tsh" ? "sw_TZ" : "en_US").format(double.parse(state.myRentingModel.totalPrice))}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        );
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('No Renting infos'),
                          IconButton(
                            icon: const Icon(Icons.refresh_sharp),
                            onPressed: () {
                              BlocProvider.of<MyRentingBloc>(context)
                                  .add(GetMyRenting(widget.property.id));
                            },
                          ),
                        ],
                      );
                    },
                  )),
                ),

                // Payment
                _buildMyMobilePaymentInfosCard(),

                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListTile(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: isBankTransferSelected
                                  ? Colors.green
                                  : Colors.grey,
                              width: 2,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10)),
                      onTap: () {
                        setState(() {
                          _selectedPaymentMethod = 'Bank Transfer';
                          isMoneyTransferSelected = false;
                          isBankTransferSelected = !isBankTransferSelected;
                        });
                      },
                      selected: isBankTransferSelected,
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Bank Transfer',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Icon(Icons.credit_card)
                        ],
                      ),
                      subtitle: BlocBuilder<MyRentingBloc, MyRentingState>(
                        builder: (context, state) {
                          return Column(children: [
                            ListTile(
                              selected: isBankTransferSelected,
                              title: const Text("Account Name"),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              subtitle: (state is MyRentingSuccess)
                                  ? state.myRentingModel.myPaymentCard
                                              ?.cardHolderName !=
                                          ""
                                      ? Text(state.myRentingModel.myPaymentCard
                                          ?.cardHolderName)
                                      : const Text("No Account")
                                  : const Text(" No Account"),
                            ),
                            ListTile(
                              selected: isBankTransferSelected,
                              title: const Text("Card Number"),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              subtitle: (state is MyRentingSuccess)
                                  ? state.myRentingModel.myPaymentCard
                                              ?.cardHolderName !=
                                          ""
                                      ? Text(
                                          "**** **** **** ${state.myRentingModel.myPaymentCard!.accountNumber!.substring(state.myRentingModel.myPaymentCard!.accountNumber!.length - 3)}",
                                        )
                                      : const Text(" No Account Number")
                                  : const Text(" No Account Number"),
                              trailing: (state is MyRentingSuccess)
                                  ? state.myRentingModel.myPaymentCard
                                              ?.cardHolderName !=
                                          ""
                                      ? IconButton(
                                          onPressed: () {
                                            Get.to(() => UpdateMyBankInfospage(
                                                  property: widget.property,
                                                  requestContext:
                                                      RequestContext.renting,
                                                  requestData:
                                                      state.myRentingModel,
                                                ));
                                          },
                                          icon: const Icon(Icons.edit))
                                      : IconButton(
                                          onPressed: () {
                                            Get.to(
                                              () => MyBankInforsPage(
                                                  requestContext:
                                                      RequestContext.renting,
                                                  property: widget.property),
                                            );
                                          },
                                          icon: const Icon(Icons.add))
                                  : IconButton(
                                      onPressed: () {
                                        //
                                      },
                                      icon: const Icon(Icons.refresh),
                                    ),
                            ),
                          ]);
                        },
                      )),
                ),

                // Reqired for renting
                Card(
                  child: ListTile(
                    title: const Text('Required for Renting',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.property?.prrs?.isNotEmpty
                            ? SizedBox(
                                height: 200.h,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemCount: widget.property.prrs.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      leading: const Icon(
                                          Icons.check_circle_outline_rounded),
                                      title: Text(widget
                                          .property.prrs[index].requirement),
                                      subtitle: Text(widget
                                          .property.prrs[index].description),
                                      // trailing: IconButton(
                                      //   icon: const Icon(Icons.upload_file),
                                      //   onPressed: () {},
                                      // ),
                                    );
                                  },
                                ),
                              )
                            : const Text('No requirements',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal))
                      ],
                    ),
                  ),
                ),

                // Host Confirmation  Notice
                const Card(
                  child: ListTile(
                    title: Text('Host Confirmation',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Host has 24 hours to confirm your request'),
                  ),
                ),

                // Read Contract Notice
                Card(
                  child: ListTile(
                    title: const Text('Read Contract',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text(
                        'Please read the contract before proceeding'),
                    trailing: IconButton(
                      icon: const Icon(Icons.open_in_new),
                      onPressed: () async => _launchUrl(),
                    ),
                  ),
                ),

                // Terms and Conditions
                const Card(
                  child: ListTile(
                    title: Text('Terms and Conditions',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle:

                        /// make italics
                        Text(
                            'By clicking Rent Now, you agree to the terms and conditions',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.normal)),
                  ),
                ),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [
          ElevatedButton(
            onPressed: isConfirming
                ? null
                : isAvailable
                    ? () {
                        dynamic amount;
                        var state =
                            BlocProvider.of<MyRentingBloc>(context).state;
                        if (state is MyRentingSuccess) {
                          amount = state.myRentingModel.totalPrice;
                        }

                        if (_selectedPaymentMethod == '') {
                          Get.snackbar("Error", "Please select payment method");

                          return;
                        }
                        if (_selectedAcconntNumber == '' ||
                            _selectedAcconntNumber == null) {
                          Get.snackbar("Error", "Phone number is missing");
                          return;
                        }
                        if (_rentingId == null) {
                          Get.snackbar("Error", "No booking found");
                          return;
                        }

                        showDialog(
                          context: context,
                          builder: (context) => ConfirmDialog(
                              isMobileMoneySelected: isMoneyTransferSelected,
                              id: _rentingId,
                              selectedPaymentMethod: _selectedPaymentMethod,
                              selectedAcconntNumber: _selectedAcconntNumber,
                              amount: amount,
                              onPressed: () {
                                BlocProvider.of<ConfirmRentingBloc>(context)
                                    .add(ConfirmRenting(
                                  rentingId: _rentingId,
                                  paymentMethod: _selectedPaymentMethod,
                                  accountNumber: _selectedAcconntNumber,
                                  amount: amount,
                                ));
                                Navigator.of(context).pop();
                              }),
                        );
                      }
                    : null,
            child: BlocConsumer<ConfirmRentingBloc, ConfirmRentingState>(
              listener: (context, state) {
                if (state is ConfirmRentingLoading) {
                  setState(() {
                    isConfirming = true;
                  });
                }
                if (state is ConfirmRentingSuccess) {
                  setState(() {
                    isConfirming = false;
                  });
                  showMessage(
                      message: state.message,
                      title: "success",
                      isAnError: false);
                  BlocProvider.of<MyRentingBloc>(context)
                      .add(GetMyRenting(widget.property.id));
                }

                if (state is ConfirmRentingFailed) {
                  setState(() {
                    isConfirming = false;
                  });

                  BlocProvider.of<MyRentingBloc>(context)
                      .add(GetMyRenting(widget.property.id));

                  showMessage(
                      message: state.message, title: "Error", isAnError: true);
                }
              },
              builder: (context, state) {
                if (state is ConfirmRentingLoading) {
                  return const SpinKitCircle(
                    color: Colors.white,
                    size: 20,
                  );
                }
                return Text(isAvailable ? 'Request for Renting ' : "Sold Out");
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildMyMobilePaymentInfosCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: isMoneyTransferSelected ? Colors.green : Colors.grey,
                width: 2,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
        onTap: () {
          setState(() {
            isMoneyTransferSelected = !isMoneyTransferSelected;
            isBankTransferSelected = false;
          });
        },
        selected: isMoneyTransferSelected,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Mobile Transfer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(
              Icons.phone_android_outlined,
              color: Colors.grey,
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              selected: isMoneyTransferSelected,
              contentPadding: EdgeInsets.zero,
              title: BlocBuilder<MyRentingBloc, MyRentingState>(
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (state is MyRentingSuccess)
                          ? Row(
                              children: [
                                Text(
                                  state.myRentingModel.myMwPayment!
                                              .mobileNetwork !=
                                          ""
                                      ? state.myRentingModel.myMwPayment!
                                          .mobileNetwork!
                                      : "No mobile network found",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  state.myRentingModel.myMwPayment!
                                              .mobileNumber !=
                                          ""
                                      ? state.myRentingModel.myMwPayment!
                                          .mobileNumber!
                                      : "",
                                ),
                              ],
                            )
                          : const Text('No Mobile Phone Number'),
                      (state is MyRentingSuccess)
                          ? state.myRentingModel.myMwPayment?.mobileNumber != ''
                              ? IconButton(
                                  visualDensity: VisualDensity.compact,
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Get.off(() => UpdateMyMwInfosPage(
                                          property: widget.property,
                                          requestData: state.myRentingModel,
                                          requestContext:
                                              RequestContext.renting,
                                        ));
                                  },
                                )
                              : IconButton(
                                  visualDensity: VisualDensity.compact,
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.add_outlined),
                                  onPressed: () {
                                    Get.to(() => AddMyMwInfosPage(
                                          property: widget.property,
                                          requestContext:
                                              RequestContext.renting,
                                        ));
                                  },
                                )
                          : IconButton(
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.refresh),
                              onPressed: () {
                                // Get.to(() => AddMyMwInfosPage(
                                //       property: widget.property,
                                //       requestContext: RequestContext.renting,
                                //     ));
                              },
                            ),
                    ],
                  );
                },
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () =>
                        setState(() => _selectedPaymentMethod = 'Mpesa'),
                    child: Column(children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage('assets/images/mpesa.png'),
                      ),
                      Radio(
                        value: 'Mpesa',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) => setState(() {
                          _selectedPaymentMethod = value!;
                          isMoneyTransferSelected = true;
                          isBankTransferSelected = false;
                        }),
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _selectedPaymentMethod = 'Airtel'),
                    child: Column(children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/airtellmoney.jpeg'),
                        backgroundColor: Colors.grey,
                      ),
                      Radio(
                        value: 'Airtel',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) => setState(() {
                          _selectedPaymentMethod = value!;
                          isMoneyTransferSelected = true;
                          isBankTransferSelected = false;
                        }),
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _selectedPaymentMethod = 'Tigo';
                      isMoneyTransferSelected = true;
                      isBankTransferSelected = false;
                    }),
                    child: Column(children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/tigopesa.png'),
                        backgroundColor: Colors.grey,
                      ),
                      Radio(
                        value: 'Tigo',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) => setState(() {
                          _selectedPaymentMethod = value!;
                          isMoneyTransferSelected = true;
                          isBankTransferSelected = false;
                        }),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
