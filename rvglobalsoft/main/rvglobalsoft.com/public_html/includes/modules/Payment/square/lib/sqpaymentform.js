function requestCardNonce(event) {
  event.preventDefault();
  paymentForm.requestCardNonce();
}

var paymentForm = new SqPaymentForm({
  applicationId: applicationId,
  locationId: locationId,
  inputClass: 'sq-input',
  inputStyles: [{
      fontSize: '.9em'
  }],
  applePay: {
    elementId: 'sq-apple-pay'
  },
  masterpass: {
    elementId: 'sq-masterpass'
  },
  cardNumber: {
    elementId: 'sq-card-number',
    placeholder: '•••• •••• •••• ••••'
  },
  cvv: {
    elementId: 'sq-cvv',
    placeholder: 'CVV'
  },
  expirationDate: {
    elementId: 'sq-expiration-date',
    placeholder: 'MM/YY'
  },
  postalCode: {
    elementId: 'sq-postal-code'
  },
  callbacks: {
    methodsSupported: function (methods) {

      var applePayBtn = document.getElementById('sq-apple-pay');
      var applePayLabel = document.getElementById('sq-apple-pay-label');
      var masterpassBtn = document.getElementById('sq-masterpass');
      var masterpassLabel = document.getElementById('sq-masterpass-label');
      if (methods.applePay === true) {
        applePayBtn.style.display = 'inline-block';
        applePayLabel.style.display = 'none' ;
      }
      if (methods.masterpass === true) {
        masterpassBtn.style.display = 'inline-block';
        masterpassLabel.style.display = 'none';
      }
    },
    createPaymentRequest: function () {
      return {
        requestShippingAddress: false,
        currencyCode: "USD",
        countryCode: "US",

        total: {
          label: "Merchant Name",
          amount: "1.01",
          pending: false,
        },

        lineItems: [
          {
            label: "Subtotal",
            amount: "1.00",
            pending: false,
          },
          {
            label: "Tax",
            amount: "0.01",
            pending: false,
          }
        ]
      };
    },
    cardNonceResponseReceived: function(errors, nonce, cardData) {
      if (errors) {
        console.log("Encountered errors:");
        errors.forEach(function(error) {
          alert('  ' + error.message);
          console.log('  ' + error.message);
        });

        return;
      }

      alert('Transaction is successful. Take note of your transaction ID for reference: ' + nonce);
      document.getElementById('card-nonce').value = nonce;
      document.getElementById('nonce-form').submit();
    },
    unsupportedBrowserDetected: function() {
      //
    },
    inputEventReceived: function(inputEvent) {
      switch (inputEvent.eventType) {
        case 'focusClassAdded':
          break;
        case 'focusClassRemoved':
          break;
        case 'errorClassAdded':
          break;
        case 'errorClassRemoved':
          break;
        case 'cardBrandChanged':
          break;
        case 'postalCodeChanged':
          break;
      }
    },
    paymentFormLoaded: function() {
      //
    }
  }
});
