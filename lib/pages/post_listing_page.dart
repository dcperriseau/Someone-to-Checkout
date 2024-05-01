import 'package:flutter/material.dart';
import 'package:someonetoview/main_app_bar.dart';

class PostListingPage extends StatefulWidget {
  const PostListingPage({super.key});

  @override
  State<PostListingPage> createState() => _PostListingPageState();
}

class _PostListingPageState extends State<PostListingPage> {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            SliverFillRemaining(
              child: ListView(
                children: [
                  SizedBox(
                    height: 600,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 600,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/background.jpg',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        Center(
                          child: Text(
                            'We allow shoppers to send our trusted partners to view listings for them.',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: DefaultTabController(
                      length: 3,
                      child: SizedBox(
                        width: screenWidth / 4,
                        child: Column(
                          children: [
                            const TabBar(
                              tabs: [
                                Tab(text: 'Property'),
                                Tab(text: 'Vehicle'),
                                Tab(text: 'Furniture'),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 900,
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Center(
                                    child: Form(
                                      key: _formKey1,
                                      child: SizedBox(
                                        width: screenWidth / 4,
                                        child: Column(
                                          children: [
                                            DropdownButtonFormField(
                                              items: const [
                                                DropdownMenuItem(
                                                  value: 'Option 1',
                                                  child: Text('Option 1'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Option 2',
                                                  child: Text('Option 2'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Option 3',
                                                  child: Text('Option 3'),
                                                ),
                                              ],
                                              onChanged: (_) {},
                                            ),
                                            DropdownButtonFormField(
                                              items: const [
                                                DropdownMenuItem(
                                                  value: 'Option 1',
                                                  child: Text('Option 1'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Option 2',
                                                  child: Text('Option 2'),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'Option 3',
                                                  child: Text('Option 3'),
                                                ),
                                              ],
                                              onChanged: (_) {},
                                            ),
                                            TextFormField(),
                                            TextFormField(),
                                            TextFormField(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Center(
                                    child: Text('Content of Tab 2'),
                                  ),
                                  const Center(
                                    child: Text('Content of Tab 3'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
