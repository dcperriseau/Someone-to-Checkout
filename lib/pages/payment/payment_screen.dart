import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:cloud_functions/cloud_functions.dart';

class PaymentScreen extends StatefulWidget {
  final int amount; // Amount in cents
  final String currency;
  final String description;

  const PaymentScreen({
    Key? key,
    required this.amount,
    required this.currency,
    required this.description,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isLoading = false;

  Future<void> _processPayment() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get client secret from the backend
      final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('createPaymentIntent');
      final response = await callable.call(<String, dynamic>{
        'amount': widget.amount,
        'currency': widget.currency,
      });

      final clientSecret = response.data['clientSecret'];

      // Create a payment method and confirm the payment
      final paymentIntent = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: PaymentMethodParams.card(
          paymentMethodData: const PaymentMethodData(
            billingDetails: BillingDetails(
              email: 'email@example.com',
              phone: '+48888000888',
              address: Address(
                city: 'Houston',
                country: 'US',
                line1: '1459 Circle Drive',
                line2: '',
                postalCode: '77063',
                state: 'TX',
              ),
            ),
          ),
        ),
      );

      // Handle successful payment
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment successful, your booking is confirmed. You will receive an email confirmation shortly.')),
      );

      // Navigate or perform further actions
      Navigator.of(context).pop(); // Go back to the previous screen or home

    } catch (e) {
      // Handle payment error
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double padding = constraints.maxWidth < 600 ? 16.0 : constraints.maxWidth * 0.2;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              children: [
                CardField(
                  onCardChanged: (card) {
                    // Handle card changes
                  },
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _processPayment,
                        child: const Text('Pay Now'),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
