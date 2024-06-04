import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:someonetoview/generators.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/pages/property/property_listing_widget.dart';
import 'package:someonetoview/providers/property_provider.dart';

class PropertyPage extends ConsumerStatefulWidget {
  const PropertyPage({super.key});

  @override
  ConsumerState createState() => _PropertyPageState();
}

class _PropertyPageState extends ConsumerState<PropertyPage> {
  @override
  Widget build(BuildContext context) {
    final propertyList = ref.watch(propertyProvider);

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
                  child: propertyList.isEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('No Property Listings'),
                            TextButton(
                              onPressed: () async {
                                final generatedListings =
                                    Generator.generatePropertyListings();
                                for (final listing in generatedListings) {
                                  ref.read(propertyProvider).add(listing);
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
                            for (final listing in propertyList)
                              PropertyListingWidget(propertyListing: listing)
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
