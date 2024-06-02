import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:cloud_functions/cloud_function.dart';

class PaymentScreen extends StatefulWidget {
  final int amount; // Amount in cents
  final String currency;
  final String description;

  const PaymentScreen({Key? key, required this.amount, required this.currency, required this.description}) : super(key: key);

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

      // Create a payment method
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
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

      // Confirm the payment
      await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: PaymentMethodParams.cardFromMethodId(
          paymentMethodId: paymentMethod.id,
        ),
      );

      // Handle successful payment
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment successful')),
      );

      // Navigate or perform further actions

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
      ),
    );
  }
}
