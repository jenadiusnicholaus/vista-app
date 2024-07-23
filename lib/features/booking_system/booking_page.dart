import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

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

  final _scrollController = ScrollController();

  List<DateTime>? dateTime;

  @override
  initState() {
    super.initState();

    BlocProvider.of<BookingBloc>(context).add(GetMyBooking());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(
                                "${state.booking.checkIn} - ${state.booking?.checkOut}"),
                            contentPadding: EdgeInsets.zero,
                          ),
                          ListTile(
                            title: const Text("Gests",
                                style: TextStyle(fontWeight: FontWeight.bold)),
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
                title: Text("Price Details"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: const Text("Price",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          "${widget.property.currency} ${widget.property.price}"),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      title: const Text("Total",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      contentPadding: EdgeInsets.zero,
                      subtitle: Text(
                          "${widget.property.currency} ${widget.property.price} After Taxes"),
                    ),
                  ],
                ),
              ),
            ),

            // card to show payment details and button to book
            const Card(
              child: ListTile(
                title: Text("Payment Details"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text("Payment Method",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("Credit Card"),
                      trailing: Icon(Icons.edit),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      title: Text("Card Number",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      contentPadding: EdgeInsets.zero,
                      subtitle: Text("**** **** **** 1234"),
                      trailing: Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text('Money Transfer',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(''),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => setState(
                                  () => _selectedPaymentMethod = 'mpesa'),
                              child: Column(children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage:
                                      AssetImage('assets/images/mpesa.png'),
                                ),
                                Radio(
                                  value: 'mpesa',
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: (value) => setState(
                                      () => _selectedPaymentMethod = value!),
                                ),
                              ]),
                            ),
                            GestureDetector(
                              onTap: () => setState(
                                  () => _selectedPaymentMethod = 'airtelmoney'),
                              child: Column(children: [
                                const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/airtellmoney.jpeg'),
                                  backgroundColor: Colors.grey,
                                ),
                                Radio(
                                  value: 'airtelmoney',
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: (value) => setState(
                                      () => _selectedPaymentMethod = value!),
                                ),
                              ]),
                            ),
                            GestureDetector(
                              onTap: () => setState(
                                  () => _selectedPaymentMethod = 'tigopesa'),
                              child: Column(children: [
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/tigopesa.png'),
                                  backgroundColor: Colors.grey,
                                ),
                                Radio(
                                  value: 'tigopesa',
                                  groupValue: _selectedPaymentMethod,
                                  onChanged: (value) => setState(
                                      () => _selectedPaymentMethod = value!),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            ),

            // required  for trip
            const Card(
              child: ListTile(
                title: Text("Required for Trip"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text("Send Message to Host",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          "Share why you're traveling, who's coming with you, and what you love about the space"),
                      contentPadding: EdgeInsets.zero,
                      trailing: Icon(Icons.edit),
                    ),
                    ListTile(
                      title: Text("Profile photo",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      contentPadding: EdgeInsets.zero,
                      subtitle: Text("Add a clear photo of yourself"),
                      trailing: Icon(Icons.edit),
                    ),

                    // Phone number
                    ListTile(
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

            Card(
              child: ListTile(
                title: const Text("Cancellation Policy"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.property?.bORpolicy != null
                        ? ListTile(
                            title: Text(widget.property?.bORpolicy?.title ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle:
                                Text(widget.property?.bORpolicy?.policy ?? ""),
                            contentPadding: EdgeInsets.zero,
                          )
                        : const Text(
                            "No policy found",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
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
                title: Text("Note for Host"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                          "The Host has 24 hours to confirm your reservation. You’ll be charged when the request is accepted.",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      contentPadding: EdgeInsets.zero,
                      trailing: Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
            ),
            const Text('By selecting the button, I agree to the booking terms.',
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
    );
  }
}
