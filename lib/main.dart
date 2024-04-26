import 'package:flutter/material.dart';
import 'package:someonetoview/pages/about_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:someonetoview/pages/contact_page.dart';
import 'package:someonetoview/pages/furniture_page.dart';
import 'package:someonetoview/pages/post_listing_page.dart';
import 'package:someonetoview/pages/property_page.dart';
import 'package:someonetoview/constants.dart';
import 'package:someonetoview/pages/vehicles_page.dart';
import 'package:someonetoview/theme.dart';

void main() {
  usePathUrlStrategy();
  runApp(const App());
}

class NoTransitionsBuilder extends PageTransitionsBuilder {
  const NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    // only return the child without warping it with animations
    return child!;
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: customTheme,
      themeMode: ThemeMode.light,
      initialRoute: propertyRoute,
      routes: {
        vehiclesRoute: (context) => const VehiclesPage(),
        furnitureRoute: (context) => const FurniturePage(),
        aboutRoute: (context) => const AboutPage(),
        postListingRoute: (context) => const PostListingPage(),
        contactRoute: (context) => const ContactPage(),
      },
      title: 'someonetoview',
      home: const PropertyPage(),
    );
  }
}
