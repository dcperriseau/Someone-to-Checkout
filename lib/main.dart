import 'package:flutter/material.dart';
import 'package:someonetoview/models/furniture_listing.dart';
import 'package:someonetoview/pages/about_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:someonetoview/pages/contact/contact_page.dart';
import 'package:someonetoview/pages/furniture/furniture_details_page.dart';
import 'package:someonetoview/pages/furniture/furniture_page.dart';
import 'package:someonetoview/pages/post_listing/post_listing_page.dart';
import 'package:someonetoview/pages/property/property_page.dart';
import 'package:someonetoview/constants.dart';
import 'package:someonetoview/pages/vehicles/vehicles_page.dart';
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
        propertyRoute: (context) => const PropertyPage(),
        vehiclesRoute: (context) => const VehiclesPage(),
        furnitureRoute: (context) => const FurniturePage(),
        // furnitureDetailRoute: (context) => const FurnitureDetailsPage(),
        aboutRoute: (context) => const AboutPage(),
        postListingRoute: (context) => const PostListingPage(),
        contactRoute: (context) => const ContactPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name!.contains(furnitureDetailRoute)) {
          final args = settings.arguments as FurnitureListing;
          return MaterialPageRoute(
            builder: (context) => FurnitureDetailsPage(furnitureListing: args),
          );
        }

        switch (settings.name) {
          case propertyRoute:
            return MaterialPageRoute(
              builder: (context) => const PropertyPage(),
            );
          case vehiclesRoute:
            return MaterialPageRoute(
              builder: (context) => const VehiclesPage(),
            );
          case furnitureRoute:
            return MaterialPageRoute(
              builder: (context) => const FurniturePage(),
            );
          case aboutRoute:
            return MaterialPageRoute(
              builder: (context) => const AboutPage(),
            );
          case contactRoute:
            return MaterialPageRoute(
              builder: (context) => const ContactPage(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const PropertyPage(),
            );
        }
      },
      title: 'someonetoview',
    );
  }
}
