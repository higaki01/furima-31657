if (document.URL.match(/items/) && document.URL.match(/new/)) {
  document.addEventListener('DOMContentLoaded', function() {
    const itemPrice = document.getElementById("item-price");
    itemPrice.addEventListener("keyup", () => {
      const addTaxPrice = document.getElementById("add-tax-price");
      const profit = document.getElementById("profit");
      const commissionRate = 0.1;
      const profitValue = Math.floor(itemPrice.value * (1 - commissionRate));
      const addTaxPriceValue = Math.floor(itemPrice.value * commissionRate);
      addTaxPrice.innerHTML = `${addTaxPriceValue}`;
      profit.innerHTML = `${profitValue}`;
    });
  });
};
