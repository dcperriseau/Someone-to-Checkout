import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/models/vehicle_listing.dart';
import 'package:someonetoview/pages/booking/booking_details_page.dart';


class VehicleDetailsPage extends ConsumerStatefulWidget {
  final VehicleListing vehicleListing;

  const VehicleDetailsPage({super.key, required this.vehicleListing});

  @override
  ConsumerState createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends ConsumerState<VehicleDetailsPage> {
  int selectedImage = 0;

  LatLng getCoords() {
    return LatLng(
      widget.vehicleListing.location.latitude,
      widget.vehicleListing.location.longitude,
    );
  }

  Widget mapWidget(double mapSize) {
    return SizedBox(
      height: mapSize,
      width: mapSize,
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
  }

  Widget imageSection(double imageHeight, double imageWidth) {
    List<Widget> images = [];

    int imageUrlLen = widget.vehicleListing.imageUrls.length;

    for (int i = 0; i < imageUrlLen; i++) {
      String url = widget.vehicleListing.imageUrls[i];

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

      images.add(const SizedBox(
        height: 8,
      ));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: imageHeight,
          width: imageWidth,
          child: Image.network(
            selectedImage == 0
                ? widget.vehicleListing.mainImageUrl
                : widget.vehicleListing.imageUrls[selectedImage],
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 100,
          height: imageHeight,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: images,
            ),
          ),
        ),
      ],
    );
  }

  String priceFormat(int price) {
    final formatter = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    return formatter.format(price);
  }

  String formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(0)}k';
    } else {
      return number.toString();
    }
  }

  Widget detailsSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Price: ${priceFormat(widget.vehicleListing.price)}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          '${formatNumber(widget.vehicleListing.mileage)} Miles',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'Listed by: ${widget.vehicleListing.username}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'Listed On: ${DateFormat.yMMMd('en_US').format(widget.vehicleListing.dateCreated)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          'Last Updated: ${DateFormat.yMMMd('en_US').format(widget.vehicleListing.lastUpdated)}',
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
                  availableTimes: widget.vehicleListing.availableTimes!,
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
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BookingDetailsPage(
                  amount: 2000,
                  description: 'Have Someone Keep You Company',
                  availableTimes: widget.vehicleListing.availableTimes!,
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
            child: Center(
              child: Text(
                'Have Someone Keep You Company',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget timesToViewWidget() {
    final times = widget.vehicleListing.availableTimes!;

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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isMobile = constraints.maxWidth < 600;
                  double imageHeight = isMobile ? 300 : 600;
                  double imageWidth = isMobile
                      ? constraints.maxWidth - 32 // full width for mobile
                      : (constraints.maxWidth / 2) - 150;

                  double mapSize = isMobile
                      ? constraints.maxWidth - 32 // full width for mobile
                      : constraints.maxWidth / 5;

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.vehicleListing.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          isMobile
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    imageSection(imageHeight, imageWidth),
                                    const SizedBox(height: 12),
                                    Text(
                                      widget.vehicleListing.description,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    const SizedBox(height: 12),
                                    detailsSection(),
                                    const SizedBox(height: 12),
                                    mapWidget(mapSize),
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
                                          imageSection(
                                              imageHeight, imageWidth),
                                          const SizedBox(height: 12),
                                          Text(
                                            widget.vehicleListing.description,
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
                                              mapWidget(mapSize),
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
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}