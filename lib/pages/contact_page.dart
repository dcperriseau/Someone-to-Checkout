import 'package:flutter/material.dart';
import 'package:someonetoview/main_app_bar.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            const SliverFillRemaining(
              child: Center(
                child: Text('Contact Page'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
