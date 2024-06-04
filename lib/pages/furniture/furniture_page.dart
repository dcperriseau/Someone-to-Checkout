import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:someonetoview/generators.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/pages/furniture/furniture_listing_widget.dart';
import 'package:someonetoview/providers/furniture_provider.dart';

class FurniturePage extends ConsumerStatefulWidget {
  const FurniturePage({super.key});

  @override
  ConsumerState createState() => _FurniturePageState();
}

class _FurniturePageState extends ConsumerState<FurniturePage> {
  @override
  Widget build(BuildContext context) {
    final furnitureList = ref.watch(furnitureProvider);

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
                  child: furnitureList.isEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('No Furniture Listings'),
                            TextButton(
                              onPressed: () async {
                                final generatedListings =
                                    Generator.generateFurnitureListings();
                                for (final listing in generatedListings) {
                                  ref.read(furnitureProvider).add(listing);
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
                            for (final listing in furnitureList)
                              FurnitureListingWidget(furnitureListing: listing)
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
