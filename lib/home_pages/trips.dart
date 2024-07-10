import 'package:flutter/material.dart';

import '../data/sample_data.dart';

class TripPage extends StatelessWidget {
  const TripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trips'),
      ),
      body: ListView.builder(
        itemCount: sampleTrips.length,
        itemBuilder: (context, index) {
          final trip = sampleTrips[index];
          return Card(
            child: ListTile(
              leading:
                  Image.asset(trip.imageUrl, width: 100, fit: BoxFit.cover),
              title: Text(trip.destination),
              subtitle: Text(
                '${trip.description}\nFrom: ${trip.startDate.toLocal()} To: ${trip.endDate.toLocal()}',
              ),
              isThreeLine: true,
              onTap: () {
                // Handle tap if necessary
              },
            ),
          );
        },
      ),
    );
  }
}
