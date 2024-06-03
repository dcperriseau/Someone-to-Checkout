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
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildMobileLayout(context);
        } else {
          return _buildDesktopLayout(context);
        }
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          furnitureDetailRoute,
          arguments: furnitureListing,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                furnitureListing.mainImageUrl,
                fit: BoxFit.cover,
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
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          furnitureDetailRoute,
          arguments: furnitureListing,
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                furnitureListing.mainImageUrl,
                fit: BoxFit.cover,
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
          const SizedBox(width: 16.0),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  priceFormat(furnitureListing.price),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  furnitureListing.title,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  'Condition: ${furnitureListing.condition}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16.0),
                ),
                Text(
                  '${furnitureListing.location.city}, ${furnitureListing.location.stateCode}',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
