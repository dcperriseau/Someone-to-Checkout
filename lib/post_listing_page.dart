import 'package:flutter/material.dart';
import 'package:someonetoview/main_app_bar.dart';

class PostListingPage extends StatelessWidget {
  const PostListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
      body: const Center(
        child: Text('Post Listing Page'),
      ),
    );
  }
}
