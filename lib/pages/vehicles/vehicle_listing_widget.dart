import 'package:flutter/material.dart';
import 'package:someonetoview/constants.dart';
import 'package:someonetoview/models/vehicle_listing.dart';

String priceFormat(int price) {
  String priceString = price.toString();
  int len = priceString.length;

  // Start from the end of the string and add commas every three digits
  for (int i = len - 3; i > 0; i -= 3) {
    priceString = '${priceString.substring(0, i)},${priceString.substring(i)}';
  }

  return priceString;
}

String formatNumber(int number) {
  if (number >= 1000) {
    return '${(number / 1000).toStringAsFixed(0)}k';
  } else {
    return number.toString();
  }
}

class VehicleListingWidget extends StatelessWidget {
  final VehicleListing vehicleListing;

  const VehicleListingWidget({super.key, required this.vehicleListing});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        double imageHeight = isMobile ? 200 : 300;
        double imageWidth = isMobile
            ? constraints.maxWidth - 32 // full width for mobile
            : 300;

        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              vehicleDetailRoute,
              arguments: vehicleListing,
            );
          },
          child: SizedBox(
            width: double.infinity,
            height: isMobile ? 300 : 400,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SizedBox(
                    width: imageWidth,
                    height: imageHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        vehicleListing.mainImageUrl,
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
                  '\$${priceFormat(vehicleListing.price)}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Text(
                  vehicleListing.title,
                ),
                Text(
                  '${formatNumber(vehicleListing.mileage)} Miles',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  '${vehicleListing.location.city}, ${vehicleListing.location.stateCode}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
