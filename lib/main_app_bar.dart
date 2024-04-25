import 'package:flutter/material.dart';
import 'package:someonetoview/constants.dart';

const selectedStyle = TextStyle(
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,
);

class MainAppBar extends StatelessWidget {
  final String route;

  const MainAppBar({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      title: const Text('someonetoview'),
      pinned: true,
      scrolledUnderElevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      actions: [
        TextButton(
          child: Text(
            'Property',
            style: route == propertyRoute ? selectedStyle : null,
          ),
          onPressed: () {
            Navigator.pushNamed(context, propertyRoute);
          },
        ),
        TextButton(
          child: Text(
            'Vehicles',
            style: route == vehiclesRoute ? selectedStyle : null,
          ),
          onPressed: () {
            Navigator.pushNamed(context, vehiclesRoute);
          },
        ),
        TextButton(
          child: Text(
            'Furniture',
            style: route == furnitureRoute ? selectedStyle : null,
          ),
          onPressed: () {
            Navigator.pushNamed(context, furnitureRoute);
          },
        ),
        TextButton(
          child: Text(
            'About',
            style: route == aboutRoute ? selectedStyle : null,
          ),
          onPressed: () {
            Navigator.pushNamed(context, aboutRoute);
          },
        ),
        TextButton(
          child: Text(
            'Post Listing',
            style: route == postListingRoute ? selectedStyle : null,
          ),
          onPressed: () {
            Navigator.pushNamed(context, postListingRoute);
          },
        ),
        TextButton(
          child: Text(
            'Contact',
            style: route == contactRoute ? selectedStyle : null,
          ),
          onPressed: () {
            Navigator.pushNamed(context, contactRoute);
          },
        ),
      ],
    );
  }
}
