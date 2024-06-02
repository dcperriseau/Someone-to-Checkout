import 'package:flutter/material.dart';
import 'package:someonetoview/constants.dart';
import 'package:someonetoview/models/furniture_listing.dart';
import 'package:intl/intl.dart';

class FurnitureListingWidget extends StatelessWidget {
  final FurnitureListing furnitureListing;

  const FurnitureListingWidget({super.key, required this.furnitureListing});

  String priceFormat(int price) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    return formatter.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          furnitureDetailRoute,
          arguments: furnitureListing,
        );
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
                    furnitureListing.mainImageUrl,
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
              priceFormat(furnitureListing.price),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Text(
              furnitureListing.title,
            ),
            Text(
              'Condition: ${furnitureListing.condition}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              '${furnitureListing.location.city}, ${furnitureListing.location.stateCode}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
