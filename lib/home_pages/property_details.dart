import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vista/data/sample_data.dart';

class PropertyDetailsPage extends StatefulWidget {
  final Property property;
  const PropertyDetailsPage({super.key, required this.property});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  bool _pinned = false;
  bool _snap = false;
  bool _floating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background:
                  Image.asset(widget.property.imageUrl, fit: BoxFit.cover),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.background,
                ),
                child: IconButton(
                  iconSize: 20,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            actions: [
              // share button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      // share property
                    },
                  ),
                ),
              ),

              // like button
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.background,
                  ),
                  child: IconButton(
                    iconSize: 20,
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // like property
                    },
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.property.title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("2 gests",
                                style: Theme.of(context).textTheme.titleSmall),
                            SizedBox(width: 10),
                            Text(".",
                                style: Theme.of(context).textTheme.titleSmall),
                            SizedBox(width: 10),
                            Text("2 Bedrooms",
                                style: Theme.of(context).textTheme.titleSmall),
                            SizedBox(width: 10),
                            Text(".",
                                style: Theme.of(context).textTheme.titleSmall),
                            SizedBox(width: 10),
                            Text("1 DHs",
                                style: Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          Text("Bagamoyo, Tanzania",
                              style: Theme.of(context).textTheme.titleSmall),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Divider(),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage(widget.property.hostImage ?? ''),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${widget.property.title} Hosted By ${widget.property.host}",
                                style: Theme.of(context).textTheme.titleSmall),
                            Row(
                              children: [
                                const Icon(Icons.verified_user),
                                Text("Verified",
                                    style:
                                        Theme.of(context).textTheme.titleSmall),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("2 years on Vista",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                  SizedBox(width: 10),
                                  Text(".",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                  SizedBox(width: 10),
                                  Text("4.8 Rating",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.home_outlined,
                      size: 80.sp,
                    ),
                    contentPadding: EdgeInsets.all(0),
                    title: Text("Entire Home",
                        style: Theme.of(context).textTheme.titleSmall),
                    subtitle: Text('You’ll have the guesthouse to yourself.',
                        style: Theme.of(context).textTheme.caption),
                  ),

                  // This host committed to Airbnb's 5-step enhanced cleaning process. Show more
                  SizedBox(height: 3),
                  ListTile(
                    leading: Icon(
                      Icons.cleaning_services_outlined,
                      size: 80.sp,
                    ),
                    contentPadding: EdgeInsets.all(0),
                    title: Text("Enhanced Clean",
                        style: Theme.of(context).textTheme.titleSmall),
                    subtitle: Text(
                        'This host committed to Airbnb\'s 5-step enhanced cleaning process. Show more.',
                        style: Theme.of(context).textTheme.caption),
                  ),

                  // Self check-in
                  SizedBox(height: 3),
                  ListTile(
                    leading: Icon(
                      Icons.lock_clock_outlined,
                      size: 80.sp,
                    ),
                    contentPadding: EdgeInsets.all(0),
                    title: Text("Self Check-in",
                        style: Theme.of(context).textTheme.titleSmall),
                    subtitle: Text(
                        'Check yourself in with the lockbox. Show more.',
                        style: Theme.of(context).textTheme.caption),
                  ),

                  // Wifi
                  SizedBox(height: 3),
                  ListTile(
                    leading: Icon(
                      Icons.wifi_outlined,
                      size: 80.sp,
                    ),
                    contentPadding: EdgeInsets.all(0),
                    title: Text("Wifi",
                        style: Theme.of(context).textTheme.titleSmall),
                    subtitle: Text(
                        'Guests often search for this popular amenity. Show more.',
                        style: Theme.of(context).textTheme.caption),
                  ),
                  SizedBox(height: 3),
                  // Kitchen
                  ListTile(
                    leading: Icon(
                      Icons.kitchen_outlined,
                      size: 80.sp,
                    ),
                    contentPadding: EdgeInsets.all(0),
                    title: Text("Kitchen",
                        style: Theme.of(context).textTheme.titleSmall),
                    subtitle: Text(
                        'Guests often search for this popular amenity. Show more.',
                        style: Theme.of(context).textTheme.caption),
                  ),
                  SizedBox(height: 30),
                  Divider(),

                  // review card

                  Container(
                      height: 250.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: reviews.length,
                        itemBuilder: (context, index) {
                          return ReviewCard(review: reviews[index]);
                        },
                      )),

                  // more description

                  // location card

                  // amenities card
                ],
              ),
            ),
          ),
        ],
      ),

      // persistentFooterAlignment: AlignmentDirectional.
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _snap = !_snap;
              if (_snap) {
                _floating = true;
              }
            });
          },
          child: const Text('Reserve'),
        )
      ],
    );
  }

  final List<Review> reviews = [
    Review(
        reviewerName: "John Doe",
        reviewText: "Great experience, would definitely come back!",
        rating: 5),
    Review(
        reviewerName: "Jane Smith",
        reviewText: "Good service, but the room was a bit dirty.",
        rating: 3),
    // Add more sample reviews as needed
  ];
}

class Review {
  final String reviewerName;
  final String reviewText;
  final double rating;

  Review(
      {required this.reviewerName,
      required this.reviewText,
      required this.rating});
}

// Step 2: Create the ReviewCard Widget
class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({Key? key, required this.review}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.reviewerName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < review.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(review.reviewText),
          ],
        ),
      ),
    );
  }
}
