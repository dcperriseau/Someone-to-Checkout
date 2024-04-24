import 'package:flutter/material.dart';
import 'package:someonetoview/routes.dart';

const selectedStyle = TextStyle(
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,
);

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String route;

  const MainAppBar({super.key, required this.route});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('someonetoview'),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
