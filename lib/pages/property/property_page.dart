import 'package:flutter/material.dart';
import 'package:someonetoview/generators.dart';
import 'package:someonetoview/models/property_listing.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/pages/property/property_listing_widget.dart';

class PropertyPage extends StatefulWidget {
  const PropertyPage({super.key});

  @override
  State<PropertyPage> createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
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
                  future: Generator.generatePropertyListings(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final listings = snapshot.data as List<PropertyListing>;
                      return Center(
                        child: GridView.extent(
                          maxCrossAxisExtent: width / 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 20,
                          children: [
                            for (final listing in listings)
                              PropertyListingWidget(propertyListing: listing)
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
