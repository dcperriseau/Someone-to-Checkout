import 'dart:math';

import 'package:flutter/material.dart';
import 'package:someonetoview/listing_widgets/vehicle_listing_widget.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/models/vehicle_listing.dart';
import 'package:someonetoview/models/location.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({super.key});

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  Future<List<VehicleListing>> generateSampleData() async {
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
    List<VehicleListing> listings = [];

    for (int i = 0; i < 100; i++) {
      int imageIndex = i + Random().nextInt(500);
      VehicleListing listing = VehicleListing(
        mainImageUrl: 'https://picsum.photos/id/$imageIndex/300',
        title: 'Vehicle $i',
        price: Random().nextInt(50000) + 10000,
        location: location,
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        mileage: Random().nextInt(300000) + 10000,
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
                      final listings = snapshot.data as List<VehicleListing>;
                      return Center(
                        child: GridView.extent(
                          maxCrossAxisExtent: width / 5,
                          children: [
                            for (final listing in listings)
                              VehicleListingWidget(vehicleListing: listing)
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
