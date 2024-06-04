
var stripe;

function initializeStripe(publishableKey) {
  stripe = Stripe(publishableKey);
}

function createPaymentIntent(clientSecret) {
  return stripe.confirmCardPayment(clientSecret, {
    payment_method: {
      card: {
        number: '4242424242424242',
        exp_month: 12,
        exp_year: 2023,
        cvc: '123',
      },
    },
  }).then(function(result) {
    if (result.error) {
      return { error: result.error.message };
    } else {
      return { success: true };
    }
  });
}
