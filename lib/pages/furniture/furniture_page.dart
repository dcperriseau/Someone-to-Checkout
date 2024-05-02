import 'dart:math';

import 'package:flutter/material.dart';
import 'package:someonetoview/pages/furniture/furniture_listing_widget.dart';
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
      longitude: -118.264854,
      latitude: 34.077164,
      streetAddress: '123 Main St',
      city: 'Los Angeles',
      stateCode: 'CA',
      stateName: 'California',
      zipCode: 90057,
    );

    // Sample data for image URLs
    List<String> imageUrls = [
      'https://picsum.photos/id/10/300/300',
      'https://picsum.photos/id/11/300/300',
      'https://picsum.photos/id/12/300/300',
      'https://picsum.photos/id/13/300/300',
      'https://picsum.photos/id/14/300/300',
    ];

    // Generate random sample data for VehicleListing
    List<FurnitureListing> listings = [];

    String description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
    String finalDesc = '';

    for (int i = 0; i < 4; i++) {
      finalDesc += ' $description';
    }

    for (int i = 0; i < 100; i++) {
      int imageIndex = Random().nextInt(15);
      FurnitureListing listing = FurnitureListing(
        id: const Uuid().v4(),
        mainImageUrl: 'https://picsum.photos/id/$imageIndex/300',
        title: 'Furniture Listing Here ${i + 1}',
        price: Random().nextInt(500) + 10,
        location: location,
        description: finalDesc,
        condition: 'Used',
        imageUrls: ['https://picsum.photos/id/$imageIndex/300', ...imageUrls],
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
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 20,
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
