import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/models/property_listing.dart';
import 'package:someonetoview/pages/booking/booking_details_page.dart';

class PropertyDetailsPage extends ConsumerStatefulWidget {
  final PropertyListing propertyListing;

  const PropertyDetailsPage({super.key, required this.propertyListing});

  @override
  ConsumerState createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends ConsumerState<PropertyDetailsPage> {
  int selectedImage = 0;

  LatLng getCoords() {
    return LatLng(
      widget.propertyListing.location.latitude,
      widget.propertyListing.location.longitude,
    );
  }

  Widget mapWidget() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = constraints.maxWidth < 600 ? 300 : 500;
        return SizedBox(
          height: size,
          width: size,
          child: FlutterMap(
            options: MapOptions(
              center: getCoords(),
              zoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: getCoords(),
                    radius: 1750,
                    color: Colors.black38,
                    borderColor: Colors.black,
                    useRadiusInMeter: true,
                  ),
                ],
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution(
                    'OpenStreetMap contributors',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget imageSection() {
    List<Widget> images = [];

    int imageUrlLen = widget.propertyListing.imageUrls.length;

    for (int i = 0; i < imageUrlLen; i++) {
      String url = widget.propertyListing.imageUrls[i];

      images.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedImage = i;
            });
          },
          child: Image.network(url),
        ),
      );

      if (imageUrlLen - 1 == i) continue;

      images.add(SizedBox(
        height: 8,
      ));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxWidth < 600 ? 300 : 600;
        double width = constraints.maxWidth < 600
            ? constraints.maxWidth - 50
            : (constraints.maxWidth / 2) - 150;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Image.network(
                selectedImage == 0
                    ? widget.propertyListing.mainImageUrl
                    : widget.propertyListing.imageUrls[selectedImage],
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 100,
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: images,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String priceFormat(int price) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    return formatter.format(price);
  }

  Widget detailsSection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Price: ${priceFormat(widget.propertyListing.price)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Bedrooms: ${widget.propertyListing.bedroomCount}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Bathrooms: ${widget.propertyListing.bathroomCount}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Listed by: ${widget.propertyListing.username}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Listed On: ${DateFormat.yMMMd('en_US').format(widget.propertyListing.dateCreated)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Last Updated: ${DateFormat.yMMMd('en_US').format(widget.propertyListing.lastUpdated)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookingDetailsPage(
                      amount: 2000,
                      description: 'Send Someone To View This',
                      availableTimes: widget.propertyListing.availableTimes!,
                    ),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black87,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Send Someone To View This',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BookingDetailsPage(
                      amount: 2000,
                      description: 'Have Someone Keep You Company',
                      availableTimes: widget.propertyListing.availableTimes!,
                    ),
                  ),
                );
              },
              style: FilledButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black87,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Have Someone Keep You Company',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timesToViewWidget() {
    final times = widget.propertyListing.availableTimes!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Available Times:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'Sunday: ${times.dayText(times.sunday)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          'Monday: ${times.dayText(times.monday)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          'Tuesday: ${times.dayText(times.tuesday)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          'Wednesday: ${times.dayText(times.wednesday)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          'Thursday: ${times.dayText(times.thursday)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          'Friday: ${times.dayText(times.friday)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          'Saturday: ${times.dayText(times.saturday)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            SliverFillRemaining(
              hasScrollBody: false,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.propertyListing.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 12),
                          constraints.maxWidth < 600
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    imageSection(),
                                    SizedBox(height: 12),
                                    Text(
                                      widget.propertyListing.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(height: 12),
                                    detailsSection(),
                                    const SizedBox(height: 12),
                                    mapWidget(),
                                    const SizedBox(height: 16),
                                    timesToViewWidget(),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          imageSection(),
                                          SizedBox(height: 12),
                                          Text(
                                            widget.propertyListing.description,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              detailsSection(),
                                              const SizedBox(width: 16),
                                              mapWidget(),
                                            ],
                                          ),
                                          const SizedBox(height: 16),
                                          timesToViewWidget(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}