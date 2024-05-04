// import 'package:flutter/material.dart';

// initialRoute: propertyRoute,
//       routes: {
//         vehiclesRoute: (context) => const VehiclesPage(),
//         furnitureRoute: (context) => const FurniturePage(),
//         // furnitureDetailRoute: (context) => const FurnitureDetailsPage(),
//         aboutRoute: (context) => const AboutPage(),
//         postListingRoute: (context) => const PostListingPage(),
//         contactRoute: (context) => const ContactPage(),
//       },
//       onGenerateRoute: (settings) {
//         if (settings.name!.contains(furnitureDetailRoute)) {
//           final args = settings.arguments as FurnitureListing;
//           return MaterialPageRoute(
//             builder: (context) => FurnitureDetailsPage(furnitureListing: args),
//           );
//         }

//         switch (settings.name) {
//           case propertyRoute:
//             return MaterialPageRoute(
//               builder: (context) => const PropertyPage(),
//             );
//           case vehiclesRoute:
//             return MaterialPageRoute(
//               builder: (context) => const VehiclesPage(),
//             );
//           case furnitureRoute:
//             return MaterialPageRoute(
//               builder: (context) => const FurniturePage(),
//             );
//           case aboutRoute:
//             return MaterialPageRoute(
//               builder: (context) => const AboutPage(),
//             );
//           case contactRoute:
//             return MaterialPageRoute(
//               builder: (context) => const ContactPage(),
//             );
//           default:
//             return MaterialPageRoute(
//               builder: (context) => const PropertyPage(),
//             );
//         }
//       },

// class CustomRouterDelegate extends RouterDelegate<CustomRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin<CustomRoutePath> {
//   @override
//   GlobalKey<NavigatorState> navigatorKey;

//   CustomRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       pages: [

//       ],
//       onPopPage: (route, result) {
//         // Handle popping pages
//         return route.didPop(result);
//       },
//     );
//   }

//   @override
//   Future<void> setNewRoutePath(CustomRoutePath configuration) async {
//     // Handle updating the route based on configuration
//   }
// }

// class MyRouteInformationParser extends RouteInformationParser<CustomRoutePath> {
//   @override
//   Future<CustomRoutePath> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     // Parse route information and return corresponding MyRoutePath
//     return CustomRoutePath();
//   }

//   @override
//   RouteInformation restoreRouteInformation(CustomRoutePath path) {
//     // Convert MyRoutePath back to RouteInformation
//     return RouteInformation(uri: Uri.parse('/'));
//   }
// }

// class CustomRoutePath {
//   // Define properties that represent the route
// }