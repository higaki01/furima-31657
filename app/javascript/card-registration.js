if (document.URL.match(/card/)) {
  document.addEventListener('DOMContentLoaded', function() {
    Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
    const form = document.getElementById("card-registration");
    form.addEventListener("submit", (e) => {
      e.preventDefault();
      const formData = new FormData(form);
    
      const card = {
        number: formData.get("card[card_number]"),
        cvc: formData.get("card[card_cvc]"),
        exp_month: formData.get("card[card_exp_month]"),
        exp_year: `20${formData.get("card[card_exp_year]")}`,
      };
    
      Payjp.createToken(card, (status, response) => {
        if (status === 200) {
          const token = response.id;
          const renderDom = document.getElementById("card-registration");
          const tokenObj = `<input value=${token} type="hidden" name='card_token'>`;
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
        }

        document.getElementById("card-number").removeAttribute("name");
        document.getElementById("card-cvc").removeAttribute("name");
        document.getElementById("card-exp-month").removeAttribute("name");
        document.getElementById("card-exp-year").removeAttribute("name");

        form.submit();
        form.reset();
      });
    });
  });
};