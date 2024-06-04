import 'package:flutter/material.dart';
import 'package:someonetoview/main_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  final String email = 'dylanwain@localviewers.com';
  final String phone = '859-519-8911';

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MainAppBar(route: ModalRoute.of(context)?.settings.name ?? ''),
            SliverFillRemaining(
              hasScrollBody: false,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 96),
                    child: Center(
                      child: constraints.maxWidth < 600
                          ? _buildMobileLayout(context)
                          : _buildDesktopLayout(context),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Contact Us:',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildEmailButton(context),
        const SizedBox(height: 8),
        _buildPhoneButton(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Contact Us:',
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildEmailButton(context),
        const SizedBox(height: 8),
        _buildPhoneButton(context),
      ],
    );
  }

  Widget _buildEmailButton(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            email,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.mail_outlined,
            color: Colors.black87,
          ),
        ],
      ),
      onPressed: () {
        final emailUri = Uri.parse('mailto:$email');
        launchUrl(emailUri);
      },
    );
  }

  Widget _buildPhoneButton(BuildContext context) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            phone,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.call_made,
            color: Colors.black87,
          ),
        ],
      ),
      onPressed: () {
        final phoneUri = Uri.parse('tel:+1-$phone');
        launchUrl(phoneUri);
      },
    );
  }
}