import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:someonetoview/constants.dart';
import 'package:someonetoview/main.dart';

final customTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  fontFamily: openSansFont,
  pageTransitionsTheme: PageTransitionsTheme(
    builders: kIsWeb
        ? {
            for (final platform in TargetPlatform.values)
              platform: const NoTransitionsBuilder(),
          }
        : {},
  ),
);
