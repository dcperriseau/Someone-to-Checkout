import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                sliver: SliverToBoxAdapter(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 600;
                      final crossAxisCount = isMobile ? 2 : 4;
                      final itemHeight = isMobile ? 250 : 400;
                      final itemWidth = (constraints.maxWidth - (crossAxisCount - 1) * 12) / crossAxisCount;

                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: vehicleList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 20,
                          childAspectRatio: itemWidth / itemHeight,
                        ),
                        itemBuilder: (context, index) {
                          return VehicleListingWidget(vehicleListing: vehicleList[index]);
                        },
                      );
                    },
                  ),
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
