if (document.URL.match(/items/) && document.URL.match(/new|edit/)){
  document.addEventListener('DOMContentLoaded', function(){
    const inputTag = document.querySelector('.item-tag')
    inputTag.addEventListener('keyup', () => {
      const keyword = inputTag.value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/items/search_tag/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        const tagName = XHR.response.keyword;
        if (document.querySelector('.results')) {
          document.querySelector('.results').remove();
        };
        const results = document.createElement('div');
        document.querySelector('.tag-input').insertAdjacentElement('afterend', results)
        results.setAttribute('class', 'results');
        results.setAttribute('style',
          `
          position: absolute;
          top: ${results.parentNode.style.height}; 
          left: 0; 
          background: white;
          font-size: 1.5vw;
          `
        );
        tagName.forEach((tag) => {
          const result = document.createElement('div');
          result.setAttribute('class', `result result-id${tag.id}`);
          result.innerHTML = tag.name;
          results.appendChild(result);
          result.addEventListener('click', () => {
            inputTag.value = tag.name;
            results.remove();
          });
        }); 
      };
    });
  });
};