import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart' as intl;

import '../home_pages/explore/models.dart';

class RentingPage extends StatefulWidget {
  final dynamic property;
  const RentingPage({super.key, required this.property});

  @override
  State<RentingPage> createState() => _RentingPageState();
}

class _RentingPageState extends State<RentingPage> {
  final Uri _url = Uri.parse('https://flutter.dev');
  int? _value = 0;
  Rdos? rdos;
  String _selectedPaymentMethod = '';

  Future<void> _launchUrl() async {
    var launch = await launchUrl(_url);
    if (!launch) {
      log('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rent Property'),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
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
                                  selected: _value == index,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      _value = selected ? index : null;
                                      rdos = widget.property.rdos[index];
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
                    title: const Text('Price per Duration explainations',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black), // Default text style
                            children: [
                              const TextSpan(text: 'Price per month: '),
                              TextSpan(
                                text:
                                    '${widget.property.currency} ${intl.NumberFormat('#,##0.00', widget.property.currency == "Tsh" ? "sw_TZ" : "en_US").format(double.parse(widget.property.price.toString()))}',
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
                              const TextSpan(text: 'Price per 3 months: '),
                              TextSpan(
                                text:
                                    '${widget.property.currency} ${intl.NumberFormat('#,##0.00', widget.property.currency == "Tsh" ? "sw_TZ" : "en_US").format((double.parse(widget.property.price) * 3).round())}',

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
                              const TextSpan(text: 'Price per 6 months: '),
                              TextSpan(
                                text:
                                    // '${(double.parse(widget.property.price) * 6).round()}',
                                    '${widget.property.currency} ${intl.NumberFormat('#,##0.00', widget.property.currency == "Tsh" ? "sw_TZ" : "en_US").format((double.parse(widget.property.price) * 6).round())}',
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
                              const TextSpan(text: 'Price per year: '),
                              TextSpan(
                                text:
                                    // '${(double.parse(widget.property.price) * 12).round()}',
                                    '${widget.property.currency} ${intl.NumberFormat('#,##0.00', widget.property.currency == "Tsh" ? "sw_TZ" : "en_US").format((double.parse(widget.property.price) * 12).round())}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),

              // Total Price based on selected duration
              const Card(
                child: ListTile(
                  title: Text('Total Price',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Total Price: \$1000'),
                ),
              ),

              // Payment
              Card(
                child: ListTile(
                  title: const Text('Payment Method',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Money Transfer'),
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
                      ),

                      // Bank Transfer
                      const ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('Bank Transfer'),
                          subtitle: Column(children: [
                            ListTile(
                              title: Text("Card Number",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              contentPadding: EdgeInsets.zero,
                              subtitle: Text("**** **** **** 1234"),
                              trailing: Icon(Icons.edit),
                            ),
                          ])),
                    ],
                  ),
                ),
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
                  subtitle:
                      const Text('Please read the contract before proceeding'),
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
          onPressed: () {
            // Add your onPressed code here!
          },
          child: const Text('Rent Now'),
        ),
      ],
    );
  }
}
