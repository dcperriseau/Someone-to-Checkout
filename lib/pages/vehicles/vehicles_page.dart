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
    final isLoading = vehicleList.isEmpty;

    double width = MediaQuery.of(context).size.width;

    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            if (isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (vehicleList.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid.extent(
                  maxCrossAxisExtent: width / 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 20,
                  children: [
                    for (final listing in vehicleList)
                      VehicleListingWidget(vehicleListing: listing),
                  ],
                ),
              )
            else
              const SliverFillRemaining(
                child: Center(child: Text('Error loading listings')),
              ),
          ],
        ),
      ),
    );
  }
}