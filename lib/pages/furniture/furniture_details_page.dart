// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:someonetoview/models/furniture_listing.dart';

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
        height: 12,
      ));
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 500,
          width: (MediaQuery.of(context).size.width / 2) - 150,
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
          height: 500,
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

  Widget timesToViewWidget() {
    return Text('Available Times');
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.furnitureListing.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 12),
                          imageSection(),
                          SizedBox(height: 12),
                          Text(
                            widget.furnitureListing.description,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 4,
                            width: MediaQuery.of(context).size.width / 4,
                            child: FlutterMap(
                              options: MapOptions(
                                initialCenter: getCoords(),
                                initialZoom: 13,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.app',
                                ),
                                CircleLayer(
                                  circles: [
                                    CircleMarker(
                                      point: getCoords(),
                                      radius: 1500,
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
                                      onTap:
                                          () {}, // launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Condition: ${widget.furnitureListing.condition}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(height: 12),
                          FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Send Someone To View This',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          FilledButton(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Have Someone Keep You Company',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          timesToViewWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
