import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../auth/user_profile/add_my_bank_infos_page.dart';
import '../auth/user_profile/add_my_mw_infos.dart';
import '../auth/user_profile/update_my_bank_infos.dart';
import '../auth/user_profile/update_my_mw_infos.dart';
import 'add_booking_infos_page.dart';
import 'bloc/booking_bloc.dart';
import 'edit_booking_infos_page.dart';

final today = DateUtils.dateOnly(DateTime.now());

class BookingPage extends StatefulWidget {
  final dynamic property;
  const BookingPage({super.key, required this.property});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String _selectedPaymentMethod = '';
  bool isCardSelected = false;
  bool isMobileMoneySelected = false;

  @override
  initState() {
    BlocProvider.of<BookingBloc>(context).add(GetMyBooking());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _updateTeSelectedPaymentMethodOnInitState(GetBookingLoaded state) {
    if (state.booking.myMwPayment!.mobileNumber != '') {
      setState(() {
        isMobileMoneySelected = true;
        _selectedPaymentMethod = state.booking.myMwPayment?.mobileNetwork ?? '';
      });
    } else if (state.booking.myPaymentCard!.accountNumber != null) {
      setState(() {
        isCardSelected = true;
        _selectedPaymentMethod = state.booking.myPaymentCard?.bankName ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is GetBookingLoaded) {
          _updateTeSelectedPaymentMethodOnInitState(state);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Request Booking"),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(children: [
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
                        Text(widget.property.description,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        RatingBar.builder(
                          initialRating: widget.property.rating,
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
              // card to show trip schedule details

              Card(
                child: ListTile(
                  title: const Text("Trip Schedule"),
                  subtitle: BlocBuilder<BookingBloc, BookingState>(
                    builder: (context, state) {
                      if (state is GetBookingLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is GetBookingFailed) {
                        return Text(
                          state.error,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        );
                      }

                      if (state is GetBookingLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: const Text("Schedule",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  "${state.booking.checkIn} - ${state.booking.checkOut}"),
                              contentPadding: EdgeInsets.zero,
                            ),
                            ListTile(
                              title: const Text("Gests",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.zero,
                              subtitle: Text(
                                  "${state.booking.adult} Adults, ${state.booking.children} Child"),
                            ),
                          ],
                        );
                      }

                      return const Text("No booking details found");
                    },
                  ),
                  trailing: BlocBuilder<BookingBloc, BookingState>(
                    builder: (context, state) {
                      if (state is GetBookingLoaded) {
                        return IconButton(
                            icon: const Icon(Icons.edit_calendar),
                            onPressed: () {
                              Get.off(() => EditBookingInfos(
                                    property: widget.property,
                                    booking: state.booking,
                                  ));
                            });
                      }
                      return IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          // _addBookingDialog();
                          Get.off(
                              () => AddBookingPage(property: widget.property));
                        },
                      );
                    },
                  ),
                ),
              ),

              // card to show price details

              Card(
                child: ListTile(
                  title: const Text("Price Details"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: const Text("Price",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            "${widget.property.currency} ${widget.property.price}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        contentPadding: EdgeInsets.zero,
                      ),
                      ListTile(
                        title: const Text("Total",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        contentPadding: EdgeInsets.zero,
                        subtitle: RichText(
                            text: TextSpan(
                          text:
                              "${widget.property.currency} ${widget.property.price}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: const [
                            TextSpan(
                              text: "(including all taxes and fees)",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ),

              // card to show payment details and button to book
              _buildBankCardPaymentMethod(),
              _buildMobileMoneyPaymentMethod(),
              // required  for trip
              Card(
                child: ListTile(
                  title: const Text("Required for Trip"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          title: const Text("Send Message to Host",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: const Text(
                              "Share why you're traveling, who's coming with you, and what you love about the space"),
                          contentPadding: EdgeInsets.zero,
                          trailing:
                              // for going to send sms
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.sms_outlined))),
                      const ListTile(
                        title: Text("Profile photo",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        contentPadding: EdgeInsets.zero,
                        subtitle: Text("Add a clear photo of yourself"),
                        trailing: Icon(Icons.edit),
                      ),

                      // Phone number
                      const ListTile(
                        title: Text("Phone Number",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        contentPadding: EdgeInsets.zero,
                        subtitle: Text("Add or confirm a phone number"),
                        trailing: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),

              // Cancellation policy

              const Card(
                child: ListTile(
                  title: Text("Cancellation Policy"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text("Cancell before check-in",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            "This is a general cancelation policy for all booking. If you cancel your booking 24 hours before check-in, you will get a full refund. If you cancel your booking 12 hours before check-in, you will get a 50% refund. If you cancel your booking less than 12 hours before check-in, you will not get a refund."),
                        contentPadding: EdgeInsets.zero,
                      )
                    ],
                  ),
                ),
              ),

              // Ground rules
              const Card(
                child: ListTile(
                  title: Text(
                    "Ground rules",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          "We ask every guest to remember a few simple things about what makes a great guest. Please review the host's rules before you book.",
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      ListTile(
                        title: Text(
                          ". Follow the house rulesTreat your Host’s home like your own",
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      ListTile(
                        title: Text(
                          ". Treat your Host’s home like your own",
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),

              const Card(
                child: ListTile(
                  title: Text(
                    "Note for Host",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                            "The Host has 24 hours to confirm your reservation. You’ll be charged when the request is accepted.",
                            style: TextStyle(fontStyle: FontStyle.normal)),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                  'By selecting the button, I agree to the booking terms.',
                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
            ]),
          ),
        ),
        persistentFooterButtons: [
          ElevatedButton(
            onPressed: () {},
            child: const Text("Book"),
          ),
        ],
      ),
    );
  }

  _buildMobileMoneyPaymentMethod() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: isMobileMoneySelected ? Colors.green : Colors.grey,
              width: 2,
            ),
          ),
          selected: isMobileMoneySelected,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mobile Money Payment',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Icon(
                Icons.phone_android,
              ),
            ],
          ),
          subtitle:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: BlocBuilder<BookingBloc, BookingState>(
                builder: (context, state) {
                  if (state is GetBookingLoaded) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              state.booking.myMwPayment!.mobileNetwork != ""
                                  ? state.booking.myMwPayment!.mobileNetwork!
                                  : "No mobile network found",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              state.booking.myMwPayment!.mobileNumber != ""
                                  ? state.booking.myMwPayment!.mobileNumber!
                                  : "No phone number found",
                            ),
                          ],
                        ),
                        state.booking.myMwPayment!.mobileNumber != ""
                            ? IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Get.off(() => UpdateMyMwInfosPage(
                                        property: widget.property,
                                        booking: state.booking,
                                      ));
                                },
                              )
                            : IconButton(
                                onPressed: () {
                                  Get.off(() => AddMyMwInfosPage(
                                      property: widget.property));
                                },
                                icon: const Icon(Icons.add),
                              ),
                      ],
                    );
                  }
                  if (state is GetBookingFailed) {
                    return Text(
                      state.error,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    );
                  }

                  return const Text('');
                },
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = 'Mpesa';
                        isMobileMoneySelected = true;
                        isCardSelected = false;
                      });
                    },
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
                          isMobileMoneySelected = true;

                          isCardSelected = false;
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
                        onChanged: (value) => {
                          setState(() {
                            _selectedPaymentMethod = value!;
                            isMobileMoneySelected = true;
                            isCardSelected = false;
                          })
                        },
                      ),
                    ]),
                  ),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _selectedPaymentMethod = 'Tigo'),
                    child: Column(children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/tigopesa.png'),
                        backgroundColor: Colors.grey,
                      ),
                      Radio(
                        value: 'Tigo',
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) => {
                          setState(() {
                            _selectedPaymentMethod = value!;
                            isMobileMoneySelected = true;
                            isCardSelected = false;
                          })
                        },
                      ),
                    ]),
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  _buildBankCardPaymentMethod() {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) {
        if (state is GetBookingLoading) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        }
        if (state is GetBookingFailed) {
          return Text(
            state.error,
            style: const TextStyle(
              color: Colors.red,
            ),
          );
        }
        if (state is GetBookingLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isCardSelected = !isCardSelected;
                      isMobileMoneySelected = false;
                      _selectedPaymentMethod =
                          state.booking.myPaymentCard!.bankName!;
                    });
                  },
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: isCardSelected ? Colors.green : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: ListTile(
                        selected: isCardSelected,
                        leadingAndTrailingTextStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        title: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Bank Payment Method",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Icon(Icons.credit_card),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: const Text("Card Holder Name",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                state.booking.myPaymentCard!.cardHolderName !=
                                        ""
                                    ? state
                                        .booking.myPaymentCard!.cardHolderName!
                                    : "No card holder name found",
                              ),

                              // trailing: Icon(Icons.edit),
                              contentPadding: EdgeInsets.zero,
                            ),
                            ListTile(
                              title: const Text("Card Number",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.zero,
                              subtitle: Text(state.booking.myPaymentCard!
                                          .accountNumber !=
                                      null
                                  ? "**** **** **** ${state.booking.myPaymentCard?.accountNumber?.substring(12)}"
                                  : "No card number found"),
                              trailing:
                                  state.booking.myPaymentCard!.accountNumber !=
                                          null
                                      ? IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            Get.to(() => UpdateMyBankInfospage(
                                                  property: widget.property,
                                                  booking: state.booking,
                                                ));
                                          },
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            Get.to(() => MyBankInforsPage(
                                                property: widget.property));
                                          },
                                          icon: const Icon(Icons.add)),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          );
        }
        return const Text("No booking details found");
      },
    );
  }
}
