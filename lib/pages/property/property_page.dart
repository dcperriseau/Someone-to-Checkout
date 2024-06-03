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
              LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;
                  int crossAxisCount = 1;
                  
                  if (width > 600) {
                    crossAxisCount = 2;
                  }
                  if (width > 900) {
                    crossAxisCount = 3;
                  }
                  if (width > 1200) {
                    crossAxisCount = 4;
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid.count(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 20,
                      children: [
                        for (final listing in propertyList)
                          PropertyListingWidget(propertyListing: listing),
                      ],
                    ),
                  );
                },
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
