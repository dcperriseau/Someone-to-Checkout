import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:someonetoview/about_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:someonetoview/contact_page.dart';
import 'package:someonetoview/furniture_page.dart';
import 'package:someonetoview/post_listing_page.dart';
import 'package:someonetoview/property_page.dart';
import 'package:someonetoview/routes.dart';
import 'package:someonetoview/vehicles_page.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: kIsWeb
              ? {
                  for (final platform in TargetPlatform.values)
                    platform: const NoTransitionsBuilder(),
                }
              : {},
        ),
      ),
      themeMode: ThemeMode.system,
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
