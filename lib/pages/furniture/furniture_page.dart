import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final isLoading = furnitureList.isEmpty;

    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            if (isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (furnitureList.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: LayoutBuilder(
                  builder: (context, constraints) {
                    return SliverGrid.extent(
                      maxCrossAxisExtent: constraints.maxWidth < 600
                          ? constraints.maxWidth / 2
                          : constraints.maxWidth / 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 20,
                      children: [
                        for (final listing in furnitureList)
                          FurnitureListingWidget(furnitureListing: listing),
                      ],
                    );
                  },
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
