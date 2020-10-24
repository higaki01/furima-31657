function calc() {
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    const commissionRate = 0.1;
    addTaxPrice.innerHTML = `${itemPrice.value * commissionRate}`;
    profit.innerHTML = `${itemPrice.value * (1 - commissionRate)}`;
  });
};

window.addEventListener('load', calc);

