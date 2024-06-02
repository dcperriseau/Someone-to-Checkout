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
    final isLoading = propertyList.isEmpty;

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
            else if (propertyList.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid.extent(
                  maxCrossAxisExtent: width / 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 20,
                  children: [
                    for (final listing in propertyList)
                      PropertyListingWidget(propertyListing: listing),
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