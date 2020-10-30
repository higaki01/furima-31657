const pay = () => {
  // Payjp.setPublicKey('pk_test_a8da30208a4ab8ac3b3ae447');
  // Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);

  const form = document.getElementById('charge-form');
  form.addEventListener('submit', (e) => {
    e.preventDefault();
    Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
    console.log(process.env.PAYJP_PUBLIC_KEY);
    const formResult = document.getElementById('charge-form');
    const formData = new FormData(formResult);
    const card = {
      number: formData.get('form[card_number]'),
      cvc: formData.get('form[card_cvc]'),
      exp_month: formData.get('form[card_exp_month]'),
      exp_year: `20${formData.get('form[card_exp_year]')}`
    };

    Payjp.createToken(card, (status, response) => {
      if ( status == 200 ) {
        const token = response.id;
        const renderDom = document.getElementById('charge-form');
        const tokenObj = `<input value=${token} name='token' type = 'hidden'> `;
        renderDom.insertAdjacentHTML('beforeend', tokenObj);
      }
      document.getElementById('card-number').removeAttribute('name');
      document.getElementById('card-cvc').removeAttribute('name');
      document.getElementById('card-exp-month').removeAttribute('name');
      document.getElementById('card-exp-year').removeAttribute('name');

      document.getElementById("charge-form").submit();
    })
  });
};

window.addEventListener('load', pay);