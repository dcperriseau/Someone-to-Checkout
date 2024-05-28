// Setting up payment intent
const functions = require("firebase-functions");
const admin = require("firebase-admin");
const stripe = require("stripe")(functions.config().stripe.secret); // Add your Stripe secret key to Firebase config

admin.initializeApp();

exports.createPaymentIntent = functions.https.onCall(async (data, context) => {
  const {amount, currency} = data;

  try {
    const paymentIntent = await stripe.paymentIntents.create({
      amount,
      currency,
    });

    return {
      clientSecret: paymentIntent.client_secret,
    };
  } catch (error) {
    return {
      error: error.message,
    };
  }
});

// Ensure there is a newline at the end of this file
