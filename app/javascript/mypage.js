if (document.URL.match(/mypages|users/)) {
  document.addEventListener('DOMContentLoaded', function() {
    if (document.URL.match(/sale/)) document.querySelector('.sale').setAttribute('style', 'background: #ccc;')
    if (document.URL.match(/sold/)) document.querySelector('.sold').setAttribute('style', 'background: #ccc;')
    if (document.URL.match(/buy/)) document.querySelector('.buy').setAttribute('style', 'background: #ccc;')
    if (document.URL.match(/address/)) document.querySelector('.address').setAttribute('style', 'background: #ccc;')
    if (document.URL.match(/card/)) document.querySelector('.card').setAttribute('style', 'background: #ccc;')
    if (document.URL.match(/edit/)) document.querySelector('.edit').setAttribute('style', 'background: #ccc;')
    if (document.URL.match(/info/)) document.querySelector('.info').setAttribute('style', 'background: #ccc;')
  });
};