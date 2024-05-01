import 'package:flutter/material.dart';
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

class VehicleListingWidget extends StatelessWidget {
  final VehicleListing vehicleListing;

  const VehicleListingWidget({super.key, required this.vehicleListing});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 400,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              vehicleListing.mainImageUrl,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.blue,
                  child: const Icon(Icons.error_outline),
                );
              },
            ),
          ),
          Text(vehicleListing.title),
          Text('\$${priceFormat(vehicleListing.price)}'),
          Text('${(vehicleListing.mileage / 1000).round()}k miles'),
          Text(
            '${vehicleListing.location.city}, ${vehicleListing.location.stateCode}',
          ),
        ],
      ),
    );
  }
}
