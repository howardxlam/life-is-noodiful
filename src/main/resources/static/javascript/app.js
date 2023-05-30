  const paymentForm = document.getElementById('payment-form');
  const cardNumberInput = document.getElementById('card-number');
  const cardNumberError = document.getElementById('card-number-error');

  paymentForm.addEventListener('submit', (event) => {
    event.preventDefault();
    const cardNumber = cardNumberInput.value;
    const expirationDate = document.getElementById('expiration-date').value;
    const cvc = document.getElementById('cvc').value;

    if (!cardNumber || !expirationDate || !cvc) {
      alert('Please fill in all the credit card details.');
      return;
    }

    if (!validateCardNumber(cardNumber)) {
      cardNumberError.textContent = 'Invalid card number';
      return;
    }

    alert('Payment successful!');
    paymentForm.reset();
  });

  cardNumberInput.addEventListener('input', () => {
    cardNumberError.textContent = '';
  });

  function validateCardNumber(cardNumber) {
    let sum = 0;
    let isSecondDigit = false;

    for (let i = cardNumber.length - 1; i >= 0; i--) {
      let digit = parseInt(cardNumber.charAt(i), 10);
      if (isSecondDigit) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }
      sum += digit;
      isSecondDigit = !isSecondDigit;
    }

    return sum % 10 === 0;
  }