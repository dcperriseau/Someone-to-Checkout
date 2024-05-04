import 'package:flutter/material.dart';
import 'package:someonetoview/models/property_listing.dart';
import 'package:someonetoview/pages/vehicles/vehicle_listing_widget.dart';

class PropertyListingWidget extends StatelessWidget {
  final PropertyListing propertyListing;

  const PropertyListingWidget({super.key, required this.propertyListing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // final newRoute = '$PropertyDetailRoute?id=${PropertyListing.id}';
        // Navigator.of(context).pushNamed(
        //   PropertyDetailRoute,
        //   arguments: PropertyListing,
        // );
      },
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SizedBox(
                width: 300,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    propertyListing.mainImageUrl,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text('Image Failed to Load'),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              '\$${priceFormat(propertyListing.price)} / month',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            Text(
              propertyListing.title,
            ),
            Text(
              '${propertyListing.bedroomCount}BR, ${propertyListing.bathroomCount}B',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              '${propertyListing.location.city}, ${propertyListing.location.stateCode}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
