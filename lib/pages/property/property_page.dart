import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            propertyList.when(
              data: (listings) => SliverFillRemaining(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: listings.isEmpty
                        ? const Center(child: Text('No Property Listings'))
                        : GridView.extent(
                            maxCrossAxisExtent: width / 4,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 20,
                            children: [
                              for (final listing in listings)
                                PropertyListingWidget(
                                    propertyListing: listing)
                            ],
                          ),
                  ),
                ),
              ),
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stackTrace) => SliverFillRemaining(
                child: Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
