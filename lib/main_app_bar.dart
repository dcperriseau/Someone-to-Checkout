import 'package:flutter/material.dart';
import 'package:someonetoview/constants.dart';

const defaultStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 16,
  fontFamily: robotoFont,
  color: Colors.black87,
);

class MainAppBar extends StatelessWidget {
  final String route;

  const MainAppBar({super.key, required this.route});

  Widget customLine(BuildContext context, double textWidth) {
    return Container(
      color: Colors.black87,
      height: 2,
      width: textWidth / 2.2,
    );
  }

  Widget headerButton(
    BuildContext context, {
    required String title,
    required String currentRoute,
  }) {
    return TextButton(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Text(
            title,
            style: defaultStyle,
          ),
          if (route == currentRoute)
            customLine(context, (title.length * defaultStyle.fontSize!))
        ],
      ),
      onPressed: () {
        Navigator.pushNamed(context, currentRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      title: Text(
        'Someone To View',
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      pinned: true,
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      actions: [
        headerButton(context, title: 'Property', currentRoute: propertyRoute),
        headerButton(context, title: 'Vehicles', currentRoute: vehiclesRoute),
        headerButton(context, title: 'Furniture', currentRoute: furnitureRoute),
        headerButton(context, title: 'About', currentRoute: aboutRoute),
        headerButton(context,
            title: 'Post Listing', currentRoute: postListingRoute),
        headerButton(context, title: 'Contact', currentRoute: contactRoute),
      ],
    );
  }
}
