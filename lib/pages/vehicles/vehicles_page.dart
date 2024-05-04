import 'package:flutter/material.dart';
import 'package:someonetoview/generators.dart';
import 'package:someonetoview/models/vehicle_listing.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/pages/vehicles/vehicle_listing_widget.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({super.key});

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
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
                  future: Generator.generateVehicleListings(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final listings = snapshot.data as List<VehicleListing>;
                      return Center(
                        child: GridView.extent(
                          maxCrossAxisExtent: width / 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 20,
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
