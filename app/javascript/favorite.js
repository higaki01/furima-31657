if (document.URL.match(/item/) && !document.URL.match(/new|index/)){
  document.addEventListener('DOMContentLoaded', function() {

    favorite();

    function favorite(){
      const favoriteBtn = document.getElementById('favorite-btn-js');
      if (favoriteBtn.getAttribute('data-load') != null) {
        return null;
      };
      favoriteBtn.setAttribute('data-load', 'true');
      favoriteBtn.addEventListener('click', () => {
        const itemId = favoriteBtn.getAttribute('data-id');
        const XHR = new XMLHttpRequest();

        XHR.open('post',`/items/${itemId}/favorites`, true);
        XHR.responseType = "json";
        XHR.send();
        XHR.onload = () => {
          if (XHR.status != 200) {
            alert(`Error ${XHR.status}: ${XHR.statusText}`);
            return null;          
          }
          const count = XHR.response.count;
          const favoriteCounter = document.getElementById('favorite-counter-js');
          favoriteCounter.innerHTML = `お気に入り ${count}`
          if (count === 0){
            favoriteBtn.classList.remove('favorite');
          } else {
            favoriteBtn.classList.add('favorite');
          };
        };
        favorite();
      });
    };
  });
};

