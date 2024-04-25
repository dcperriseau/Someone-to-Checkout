import 'package:flutter/material.dart';
import 'package:someonetoview/main_app_bar.dart';

class PropertyPage extends StatelessWidget {
  const PropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            const SliverFillRemaining(
              fillOverscroll: true,
              hasScrollBody: false,
              child: Center(
                child: Text('Property Page'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
