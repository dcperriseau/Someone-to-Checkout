import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:someonetoview/main_app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            SliverFillRemaining(
              fillOverscroll: true,
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 4,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome to Someone To View!\n',
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                Text(
                                  'At Someone To View, we believe that finding your perfect space or dream vehicle should be effortless and stress-free. That\'s why we\'ve revolutionized the way you explore properties, vehicles, and furniture.\n',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  'Gone are the days of relying solely on online listings and secondhand descriptions. We understand the importance of experiencing your potential investment firsthand. With our innovative platform, you can now hire trusted individuals to personally visit properties, test drive vehicles, and inspect furniture on your behalf.\n',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  'Our network of experienced gig workers is dedicated to providing comprehensive insights into each listing, ensuring you make informed decisions. Whether you\'re searching for your next apartment, dream car, or the perfect piece of furniture, we\'re here to bring your vision to life.\n',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  'At Someone To View, we\'re committed to delivering convenience, transparency, and peace of mind throughout your search journey. Say goodbye to uncertainty and hello to confidence with our personalized viewing service.\n',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  'Discover the difference with Someone To View today. Your perfect space is just a click away.\n',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          const Flexible(flex: 1, child: SizedBox.expand()),
                          Flexible(
                            flex: 5,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 300,
                                  width: double.infinity,
                                  child: FittedBox(
                                    clipBehavior: Clip.hardEdge,
                                    fit: BoxFit.fitWidth,
                                    child: Image.network(
                                      'https://i.imgur.com/QA6FLxV.jpeg',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 300,
                                  width: double.infinity,
                                  child: FittedBox(
                                    clipBehavior: Clip.hardEdge,
                                    fit: BoxFit.fitWidth,
                                    child: Image.network(
                                      'https://images.pexels.com/photos/35967/mini-cooper-auto-model-vehicle.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
