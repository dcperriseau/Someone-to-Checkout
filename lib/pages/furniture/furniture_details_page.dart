import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/models/furniture_listing.dart';
import 'package:someonetoview/pages/booking/booking_details_page.dart';

class FurnitureDetailsPage extends StatefulWidget {
  final FurnitureListing furnitureListing;

  const FurnitureDetailsPage({super.key, required this.furnitureListing});

  @override
  State<FurnitureDetailsPage> createState() => _FurnitureDetailsPageState();
}

class _FurnitureDetailsPageState extends State<FurnitureDetailsPage> {
  int selectedImage = 0;

  LatLng getCoords() {
    return LatLng(
      widget.furnitureListing.location.latitude,
      widget.furnitureListing.location.longitude,
    );
  }

  Widget mapWidget(double size) {
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
  }

  Widget imageSection() {
    List<Widget> images = [];

    int imageUrlLen = widget.furnitureListing.imageUrls.length;

    for (int i = 0; i < imageUrlLen; i++) {
      String url = widget.furnitureListing.imageUrls[i];

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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.network(
            selectedImage == 0
                ? widget.furnitureListing.mainImageUrl
                : widget.furnitureListing.imageUrls[selectedImage],
            fit: BoxFit.fitWidth,
          ),
        ),
        SizedBox(width: 12),
        SizedBox(
          width: 100,
          height: 600,
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

  Widget detailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Price: ${priceFormat(widget.furnitureListing.price)}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'Condition: ${widget.furnitureListing.condition}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'Listed by: ${widget.furnitureListing.username}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'Listed On: ${DateFormat.yMMMd('en_US').format(widget.furnitureListing.dateCreated)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          'Last Updated: ${DateFormat.yMMMd('en_US').format(widget.furnitureListing.lastUpdated)}',
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
                  availableTimes: widget.furnitureListing.availableTimes!,
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
                  availableTimes: widget.furnitureListing.availableTimes!,
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
    final times = widget.furnitureListing.availableTimes!;

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
                  if (constraints.maxWidth < 600) {
                    return _buildMobileLayout(context);
                  } else {
                    return _buildDesktopLayout(context);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.furnitureListing.title,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 12),
            imageSection(),
            SizedBox(height: 12),
            Text(
              widget.furnitureListing.description,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(height: 12),
            detailsSection(),
            SizedBox(height: 16),
            mapWidget(200),
            SizedBox(height: 16),
            timesToViewWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.furnitureListing.title,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageSection(),
                    SizedBox(height: 12),
                    Text(
                      widget.furnitureListing.description,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        detailsSection(),
                        SizedBox(width: 16),
                        mapWidget(MediaQuery.of(context).size.width / 5),
                      ],
                    ),
                    SizedBox(height: 16),
                    timesToViewWidget(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
