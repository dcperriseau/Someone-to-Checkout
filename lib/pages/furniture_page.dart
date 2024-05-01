import 'dart:math';

import 'package:flutter/material.dart';
import 'package:someonetoview/listing_widgets/furniture_listing_widget.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/models/furniture_listing.dart';
import 'package:someonetoview/models/location.dart';
import 'package:uuid/uuid.dart';

class FurniturePage extends StatefulWidget {
  const FurniturePage({super.key});

  @override
  State<FurniturePage> createState() => _FurniturePageState();
}

class _FurniturePageState extends State<FurniturePage> {
  Future<List<FurnitureListing>> generateSampleData() async {
    // Sample data for location
    Location location = Location(
      longitude: -122.4194,
      latitude: 37.7749,
      streetAddress: '123 Main St',
      city: 'Los Angeles',
      stateCode: 'CA',
      stateName: 'California',
      zipCode: 90057,
    );

    // Sample data for image URLs
    List<String> imageUrls = [
      'https://picsum.photos/300',
      'https://picsum.photos/300',
      'https://picsum.photos/300',
    ];

    // Generate random sample data for VehicleListing
    List<FurnitureListing> listings = [];

    for (int i = 0; i < 100; i++) {
      int imageIndex = i + Random().nextInt(500);
      FurnitureListing listing = FurnitureListing(
        id: const Uuid().v4(),
        mainImageUrl: 'https://picsum.photos/id/$imageIndex/300',
        title: 'Furniture $i',
        price: Random().nextInt(500) + 10,
        location: location,
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        condition: 'Used',
        imageUrls: imageUrls,
      );

      listings.add(listing);
    }

    await Future.delayed(const Duration(seconds: 1));

    return listings;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FutureBuilder(
                  future: generateSampleData(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final listings = snapshot.data as List<FurnitureListing>;
                      return Center(
                        child: GridView.extent(
                          maxCrossAxisExtent: width / 4,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 16,
                          children: [
                            for (final listing in listings)
                              FurnitureListingWidget(furnitureListing: listing)
                          ],
                        ),
                      );
                    }
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
