import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../shared/utils/present_money_format.dart';

class BuyPropertyPage extends StatefulWidget {
  final dynamic property;
  const BuyPropertyPage({super.key, required this.property});

  @override
  State<BuyPropertyPage> createState() => _BuyPropertyPageState();
}

class _BuyPropertyPageState extends State<BuyPropertyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Property'),
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
                    title: Text(widget.property.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
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

              // Quntity
              Card(
                child: ListTile(
                  title: const Text('Quantity',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('2'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),

              // Price

              Card(
                child: ListTile(
                  title: const Text('Price',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Per Unit'),
                        subtitle: Text(
                          moneyFormater(widget.property),
                        ),
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Total'),
                          subtitle: Text(
                            moneyFormater(widget.property), // * quantity
                          )),
                    ],
                  ),
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

              // Required for Delivery
              const Card(
                child: ListTile(
                  title: Text('Address and Contact',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('Address'),
                        subtitle: Text('Dar es Salaam, Tanzania'),
                        trailing: Icon(Icons.edit),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text('Phone Number'),
                        subtitle: Text('+255788811189'),
                        trailing: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),

              // Button
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Buy'),
        ),
      ],
    );
  }
}
