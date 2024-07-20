import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vista/constants/custom_form_field.dart';
import 'package:vista/features/my_fav_property/bloc/my_fav_properies_bloc.dart';
import '../../../shared/utils/custom_spinkit_loaders.dart';
import '../../../shared/utils/present_money_format.dart';
import '../../../shared/widgets/error_snack_bar.dart';
import '../../Buying_system/Buying_page.dart';
import '../../booking_system/booking_page.dart';
import 'bloc/property_details_bloc.dart';
import 'package:intl/intl.dart';
import 'models.dart';
import 'property_reviews/bloc/property_reviews_bloc.dart'; // Make sure to add the intl package to your pubspec.yaml

class PropertyDetailsPage extends StatefulWidget {
  final dynamic property;
  const PropertyDetailsPage({super.key, required this.property});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  final bool _pinned = false;
  final bool _snap = false;
  final bool _floating = false;
  bool isSubmittingReviews = false;
  int idToAdd = 0;
  bool isAddingToFav = false;
  bool isAdded = false;

  @override
  initState() {
    super.initState();
    BlocProvider.of<PropertyDetailsBloc>(context)
        .add((GetPropertyDetailsEvent(propertyId: widget.property.id!)));
  }

  String calculateDurationOnVista() {
    if (widget.property.host?.user?.dateJoined == null) {
      return "Unknown duration on Vista";
    }
    DateTime dateJoined =
        DateFormat('yyyy-MM-dd').parse(widget.property.host!.user!.dateJoined!);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateJoined);

    // Calculate years, months, days, and hours
    int years = difference.inDays ~/ 365;
    int months = (difference.inDays % 365) ~/ 30; // Approximation
    int days = difference.inDays - (years * 365) - (months * 30);
    int hours = difference.inHours % 24;

    // Determine the most appropriate unit to display
    if (years > 0) {
      return "$years years on Vista";
    } else if (months > 0) {
      return "$months months on Vista";
    } else if (days > 0) {
      return "$days days on Vista";
    } else {
      return "$hours hours on Vista";
    }
  }

  Widget buildReviewList(state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: state.propertyDetailsModel.reviews!.length == 0
              ? 10
              : 140.h, // Adjust height as needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.propertyDetailsModel.reviews!.length,
            itemBuilder: (context, index) {
              return ReviewCard(
                  review: state.propertyDetailsModel.reviews![index]);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyFavProperiesBloc, MyFavProperiesState>(
      listener: (context, state) {
        if (state is AddPropertyReviewsLoading) {
          setState(() {
            isAddingToFav = true;
          });
        } else if (state is AddPropertyReviewsSuccess) {
          setState(() {
            isAddingToFav = false;
            isAdded = true;
          });
        } else if (state is AddPropertyReviewsFailure) {
          setState(() {
            isAddingToFav = false;
          });
        }
      },
      child: Scaffold(
        body: BlocBuilder<PropertyDetailsBloc, PropertyDetailsState>(
          builder: (context, state) {
            if (state is PropertyDetailsLoaded) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: _pinned,
                    snap: _snap,
                    floating: _floating,
                    expandedHeight: 200.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: state.propertyDetailsModel.images!.isEmpty
                          ? Image.network(
                              widget.property.image!,
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Text('Error loading image');
                              },
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 225.0, // Adjust height as needed
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state
                                        .propertyDetailsModel.images!.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          Image.network(
                                            state.propertyDetailsModel
                                                .images![index].image!,
                                            fit: BoxFit.cover,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Text(
                                                  'Error loading image');
                                            },
                                          ),
                                          Positioned(
                                            bottom: 20,
                                            right: 20,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                "${index + 1} / ${state.propertyDetailsModel.images!.length}", // Adjust index to start from 1
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
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
                              // like property
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: IconButton(
                            icon: widget.property.isMyFavorite ||
                                    isAdded ||
                                    idToAdd == widget.property.id
                                ? const Icon(Icons.favorite, color: Colors.red)
                                : const Icon(Icons.favorite_border,
                                    color: Colors.grey),
                            onPressed: isAddingToFav
                                ? null
                                : () {
                                    setState(() {
                                      idToAdd = widget.property.id;
                                    });
                                    BlocProvider.of<MyFavProperiesBloc>(context)
                                        .add(
                                      AddMyFavPropertyEvent(
                                          propertyId: widget.property.id),
                                    );
                                  },
                          ),
                        ),
                      ),

                      // like button
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.property.name ?? '',
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                              (state.propertyDetailsModel.facilities!.isEmpty)
                                  ? SizedBox(
                                      height: 20.h,
                                      width: MediaQuery.of(context).size.width,
                                      child: const Text(' No facilities yet.',
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.red)),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 20.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: state
                                                .propertyDetailsModel
                                                .facilities!
                                                .length,
                                            itemBuilder: (context, index) {
                                              return Text(
                                                  " . ${state.propertyDetailsModel.facilities![index].facility}" ??
                                                      '',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey));
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.location_on),
                                  Text(
                                      "${widget.property.city}, ${widget.property.country}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          const Divider(),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(widget
                                        .property.host?.user?.userProfilePic ??
                                    ''),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        " Hosted By - ${widget.property.host?.user?.firstName ?? ''}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    Row(
                                      children: [
                                        Icon(
                                            widget.property.host!.isVerified!
                                                ? Icons.verified
                                                : Icons.cancel_outlined,
                                            color: widget
                                                    .property.host!.isVerified!
                                                ? Colors.green
                                                : Colors.red,
                                            size: 30),
                                        Text(
                                            widget.property.host!.isVerified!
                                                ? "Verified"
                                                : "Not Verified",
                                            style: TextStyle(
                                              color: widget.property.host!
                                                      .isVerified!
                                                  ? Colors.green
                                                  : Colors.red,
                                            )),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(calculateDurationOnVista(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                          const SizedBox(width: 10),
                                          Text(".",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                          const SizedBox(width: 10),
                                          Text("4.8 Rating",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                          const SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Divider(),
                          if (state.propertyDetailsModel.facilities!.isEmpty)
                            SizedBox(
                              height: 100.h,
                              width: MediaQuery.of(context).size.width,
                              child: const Center(
                                child: Text(' No facilities yet.',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red)),
                              ),
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text("Facilities",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state
                                      .propertyDetailsModel.facilities!.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: const Icon(
                                            Icons.check_circle_outline,
                                            size: 35,
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              left: 6.w, right: 6.w),
                                          title: Text(
                                              state
                                                      .propertyDetailsModel
                                                      .facilities![index]
                                                      .facility ??
                                                  '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                          subtitle: Text(
                                              state
                                                      .propertyDetailsModel
                                                      .facilities![index]
                                                      .description ??
                                                  '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          const SizedBox(height: 10),
                          const Divider(),
                          if (state.propertyDetailsModel.amenities!.isEmpty)
                            SizedBox(
                              height: 100.h,
                              width: MediaQuery.of(context).size.width,
                              child: const Center(
                                child: Text(' No amenities yet.',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red)),
                              ),
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Text("Amenities",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state
                                      .propertyDetailsModel.amenities!.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: Icon(
                                            state
                                                        .propertyDetailsModel
                                                        .amenities![index]
                                                        .isAvailable ??
                                                    false
                                                ? Icons.check_circle_outline
                                                : Icons.verified,
                                            size: 35,
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              left: 6.w, right: 6.w),
                                          title: Text(
                                              state.propertyDetailsModel
                                                      .amenities![index].name ??
                                                  '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall),
                                          subtitle: Text(
                                              state
                                                      .propertyDetailsModel
                                                      .amenities![index]
                                                      .description ??
                                                  '',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          const SizedBox(height: 3),
                          const Divider(),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                "Reviews  ",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 10),
                              ReviewsForm(
                                propertyId: widget.property.id!,
                              ),
                              const SizedBox(height: 10),
                              buildReviewList(state)
                            ],
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                "Description",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                state.propertyDetailsModel.description ?? '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  wordSpacing: 1.5,
                                  leadingDistribution:
                                      TextLeadingDistribution.even,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is PropertyDetailsLoading) {
              return loader();
            } else if (state is PropertyDetailsError) {
              return Center(
                child: Text(state.error),
              );
            }
            return const Text("");
          },
        ),

        // persistentFooterAlignment: AlignmentDirectional.
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    moneyFormater(widget.property),
                    style: const TextStyle(
                      fontSize: 18, // Increased font size for more prominence
                      fontWeight: FontWeight.w900, // Maximum boldness
                      color: Colors.grey,
                      shadows: [
                        // Adding a shadow for a "tomey" effect
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 1.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 0.5.sw, // 50% of screen width
                child: Column(
                  children: [
                    if ((widget.property.businessType == "sale"))
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => BuyPropertyPage(
                                property: widget.property,
                              ));
                        },
                        child: const Text('Buy Now'),
                      )
                    else if ((widget.property.businessType == "rent"))
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Rent Now'),
                      )
                    else if ((widget.property.businessType == "booking"))
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => BookingPage(
                                property: widget.property,
                              ));
                        },
                        child: const Text('Reserve Now'),
                      )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Step 2: Create the ReviewCard Widget
class ReviewCard extends StatelessWidget {
  final Reviews review;

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
              review.user!.firstName.toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            RatingBar.builder(
              initialRating: review.rating!,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            const SizedBox(height: 8),
            Text(review.comment!,
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 16,
                  wordSpacing: 1.5,
                  leadingDistribution: TextLeadingDistribution.even,
                  overflow: TextOverflow.ellipsis,
                ),
                softWrap: true),
          ],
        ),
      ),
    );
  }
}

class ReviewsForm extends StatefulWidget {
  final int propertyId;
  const ReviewsForm({
    super.key,
    required this.propertyId,
  });

  @override
  State<ReviewsForm> createState() => _ReviewsFormState();
}

class _ReviewsFormState extends State<ReviewsForm> {
  final TextEditingController commentController = TextEditingController();
  double rationg = 1.0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isSubmiting = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<PropertyReviewsBloc, PropertyReviewsState>(
      listener: (context, state) {
        if (state is AddPropertyReviewsLoading) {
          setState(() {
            isSubmiting = true;
          });
        } else if (state is AddPropertyReviewsSuccess) {
          setState(() {
            isSubmiting = false;
          });
          showMessage(
              title: "Success", message: state.message, isAnError: false);
        } else if (state is AddPropertyReviewsFailure) {
          setState(() {
            isSubmiting = false;
          });
          showMessage(
              title: "Error", message: state.errorMessage, isAnError: true);
        }
      },
      child: Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            RatingBar.builder(
                initialRating: 1,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                onRatingUpdate: (rating) {
                  setState(() {
                    rationg = rating;
                  });
                }),
            const Text("Add your comment"),
            const SizedBox(height: 10),
            CustomTextFormField(
              controller: commentController,
              labelText: 'Comment',
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a review';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: isSubmiting
                  ? null
                  : () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<PropertyReviewsBloc>(context).add(
                            AddPropertyReviewEvent(
                                propertyId: widget.propertyId.toString(),
                                comment: commentController.text,
                                rating: rationg));
                      }
                    },
              child: BlocBuilder<PropertyReviewsBloc, PropertyReviewsState>(
                builder: (context, state) {
                  if (state is AddPropertyReviewsLoading) {
                    return loader();
                  }
                  return const Text('Submit');
                },
              ),
            ),
          ])),
    );
  }
}
