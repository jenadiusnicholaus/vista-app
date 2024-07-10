import 'package:flutter/material.dart';
import 'package:vista/data/sample_data.dart';

class WishlistsPage extends StatelessWidget {
  const WishlistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlists'),
      ),
      body: ListView.builder(
        itemCount: sampleProperties.length,
        itemBuilder: (context, index) {
          final property = sampleProperties[index];
          return Card(
            child: ListTile(
              leading: Image.asset(property.hostImage!,
                  width: 100, fit: BoxFit.cover),
              title: Text(property.title),
              subtitle: Text(
                  '${property.location}\n\$${property.price.toStringAsFixed(2)}'),
              isThreeLine: true,
              trailing: Icon(property.availability ? Icons.check : Icons.close),
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
