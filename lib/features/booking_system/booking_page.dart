import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookingPage extends StatefulWidget {
  final dynamic property;
  const BookingPage({super.key, required this.property});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
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
                      Text(widget.property.description),
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

            const Card(
              child: ListTile(
                title: Text("Trip Schedule"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text("Schedule",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("April 2022 - June 2022"),
                      trailing: Icon(Icons.edit),
                      contentPadding: EdgeInsets.zero,
                    ),
                    ListTile(
                      title: Text("Gests",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      contentPadding: EdgeInsets.zero,
                      subtitle: Text("2 Adults, 1 Child"),
                      trailing: Icon(Icons.edit),
                    ),
                  ],
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
                            Column(children: [
                              const CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage:
                                    AssetImage('assets/images/mpesa.png'),
                              ),
                              Radio(
                                value: 'mpesa',
                                groupValue: 'MobileMoney',
                                onChanged: (value) {},
                              ),
                            ]),
                            Column(children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/airtellmoney.jpeg'),
                                backgroundColor: Colors.grey,
                                // child: const Icon(Icons.money),
                              ),
                              Radio(
                                value: 'airtelmoney ',
                                groupValue: 'MobileMoney',
                                onChanged: (value) {},
                              ),
                            ]),
                            Column(children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/tigopesa.png'),
                                backgroundColor: Colors.grey,
                                // child: const Icon(Icons.money),
                              ),
                              Radio(
                                value: 'tigopesa',
                                groupValue: 'MobileMoney',
                                onChanged: (value) {},
                              ),
                            ]),
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

            const Card(
              child: ListTile(
                title: Text("Cancellation Policy"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                          "Free cancellation until 5:00 PM on 1st April",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          "Cancel before Jul 23 for a partial refund. After that, this reservation is non-refundable. Learn more"),
                      contentPadding: EdgeInsets.zero,
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
                      ])),
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

            // Button to book
            // make italic
            const Text('By selecting the button, I agree to the booking terms.',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
          ]),
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            // cancel the booking
          },
          child: const Text("Book"),
        ),
      ],
    );
  }
}
