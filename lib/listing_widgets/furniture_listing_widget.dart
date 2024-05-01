import 'package:flutter/material.dart';
import 'package:someonetoview/constants.dart';
import 'package:someonetoview/models/furniture_listing.dart';

class FurnitureListingWidget extends StatelessWidget {
  final FurnitureListing furnitureListing;

  const FurnitureListingWidget({super.key, required this.furnitureListing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // final newRoute = '$furnitureDetailRoute?id=${furnitureListing.id}';
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
            Text(furnitureListing.title),
            Text('\$${furnitureListing.price}'),
            Text('Condition: ${furnitureListing.condition}'),
            Text(furnitureListing.location.city),
          ],
        ),
      ),
    );
  }
}
