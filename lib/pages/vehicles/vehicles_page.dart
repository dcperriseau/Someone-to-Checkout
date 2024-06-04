import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:someonetoview/generators.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/pages/vehicles/vehicle_listing_widget.dart';
import 'package:someonetoview/providers/vehicles_provider.dart';

class VehiclesPage extends ConsumerStatefulWidget {
  const VehiclesPage({super.key});

  @override
  ConsumerState createState() => _VehiclesPageState();
}

class _VehiclesPageState extends ConsumerState<VehiclesPage> {
  @override
  Widget build(BuildContext context) {
    final vehicleList = ref.watch(vehiclesProvider);

    double width = MediaQuery.of(context).size.width;

    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: vehicleList.isEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('No Vehicles Listings'),
                            TextButton(
                              onPressed: () async {
                                final generatedListings =
                                    Generator.generateVehicleListings();
                                for (final listing in generatedListings) {
                                  ref.read(vehiclesProvider).add(listing);
                                }
                                setState(() {});
                              },
                              child: const Text('Generate Sample Listings'),
                            ),
                          ],
                        )
                      : GridView.extent(
                          maxCrossAxisExtent: width / 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 20,
                          children: [
                            for (final listing in vehicleList)
                              VehicleListingWidget(vehicleListing: listing)
                          ],
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
