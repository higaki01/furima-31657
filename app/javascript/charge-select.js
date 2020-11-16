if (document.URL.match(/purchases/)){
  document.addEventListener('DOMContentLoaded', function() {
    const checkCard = document.getElementById('check_card')
    const checkAddress = document.getElementById('check_address')
    const cardForm = document.getElementById('card-form-js')
    const addressForm = document.getElementById('address-form-js')

    if (checkCard.checked) cardForm.setAttribute('style', 'display: none;');
    if (checkAddress.checked) addressForm.setAttribute('style', 'display: none;');

    checkCard.addEventListener('change', () => {
      if (checkCard.checked) {
        cardForm.setAttribute('style', 'display: none;');
      } else {
        cardForm.setAttribute('style', 'display: block;');
      };
      selectCard()
    });

    checkAddress.addEventListener('change', () => {
      if (checkAddress.checked) {
        addressForm.setAttribute('style', 'display: none;');
      } else {
        addressForm.setAttribute('style', 'display: block;');
      };
      selectAddress()
    });

    const selectCard = () => {
      checkCard.addEventListener('change', () => {
        if (checkCard.checked) {
          cardForm.setAttribute('style', 'display: none;');
        } else {
          cardForm.setAttribute('style', 'display: block;');
        };
        selectCard();
      });
    }

    const selectAddress = () => {
      checkAddress.addEventListener('change', () => {
        if (checkAddress.checked) {
          addressForm.setAttribute('style', 'display: none;');
        } else {
          addressForm.setAttribute('style', 'display: block;');
        };
        selectAddress();
      });
    };

  });
};
