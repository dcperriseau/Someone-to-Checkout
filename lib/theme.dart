import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:someonetoview/constants.dart';
import 'main.dart';

final customTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: robotoFont,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  textTheme: Typography().black.apply(fontFamily: openSansFont),
  pageTransitionsTheme: PageTransitionsTheme(
    builders: kIsWeb
        ? {
            for (final platform in TargetPlatform.values)
              platform: const NoTransitionsBuilder(),
          }
        : {},
  ),
);
