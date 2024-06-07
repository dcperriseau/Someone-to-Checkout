// lib/widgets/property_listing_widget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:someonetoview/models/property_listing.dart';
import 'package:someonetoview/constants.dart';

class PropertyListingWidget extends StatelessWidget {
  final PropertyListing propertyListing;

  const PropertyListingWidget({super.key, required this.propertyListing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          propertyDetailRoute,
          arguments: propertyListing,
        );
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          double imageSize = constraints.maxWidth < 600 ? 150 : 300;
          double height = constraints.maxWidth < 600 ? 250 : 400;
          double fontSize = constraints.maxWidth < 600 ? 14 : 16;

          return SizedBox(
            width: double.infinity,
            height: height,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SizedBox(
                    width: imageSize,
                    height: imageSize,
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                  ),
                ),
                Text(
                  propertyListing.title,
                  style: TextStyle(fontSize: fontSize),
                ),
                Text(
                  '${propertyListing.bedroomCount}BR, ${propertyListing.bathroomCount}B',
                  style: TextStyle(color: Colors.grey[600], fontSize: fontSize),
                ),
                Text(
                  '${propertyListing.location.city}, ${propertyListing.location.stateCode}',
                  style: TextStyle(color: Colors.grey[600], fontSize: fontSize),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String priceFormat(int price) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    return formatter.format(price);
  }
}
