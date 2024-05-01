import 'package:flutter/material.dart';
import 'package:someonetoview/pages/vehicles/vehicle_listing_widget.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/models/furniture_listing.dart';

class FurnitureDetailsPage extends StatelessWidget {
  final FurnitureListing furnitureListing;

  const FurnitureDetailsPage({super.key, required this.furnitureListing});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      furnitureListing.title,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Image.network(
                      furnitureListing.mainImageUrl,
                    ),
                    Text(furnitureListing.id),
                    Text('Price: ${priceFormat(furnitureListing.price)}'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
