if (document.URL.match(/items/) && document.URL.match(/new|edit/)) {
  document.addEventListener('DOMContentLoaded', function() {
    let imgCounter = document.getElementById('img-counter-js').value;
    let imgId = document.getElementById('img-counter-js').value;
    
    document.querySelector('.image-input.main').addEventListener('change', (event) => {
      const file = event.target.files[0];
      const blob = window.URL.createObjectURL(file);

      document.querySelector('.image-container.main').setAttribute('style', 'width: 20%;');
      document.querySelector('.image-item.main').setAttribute('src', blob);
      document.querySelector('.image-item.main').setAttribute('style', 'display: block;');
      document.querySelector('.delete-btn.main').setAttribute('style', 'display: block;');

      if (imgCounter == 0) {
        imgId = 1;
        imgCounter = 1;
        createImageHTML();
      };
    });

    document.querySelector('.delete-btn.main').addEventListener('click', () => {
      document.querySelectorAll('.image-container').forEach( (element) => {
        if (!element.className.match(/main/)){
          element.remove()
        };
      });
      document.querySelector('.image-item.main').setAttribute('src', '');
      document.querySelector('.image-item.main').setAttribute('style', 'display: none;');
      document.querySelector('.delete-btn.main').setAttribute('style', 'display: none;');
      document.querySelector('.image-container.main').setAttribute('style', 'width: 100%;');
      elementCounter = 0;
      elementId = 0;
      document.querySelector('.image-input.main').value = null;
    });

  const createImageHTML = () => {
    const imageContainer = document.createElement('div');
    const imageTitle = document.createElement('div');
    const imageArea = document.createElement('div');
    const imageItem = document.createElement('img');
    const imageInput = document.createElement('input');
    const deleteBtn = document.createElement('div');
    imageContainer.classList.add('image-container', `element${elementId}`);
    imageContainer.setAttribute('style', 'width: 20%;');
    imageTitle.classList.add('image-title', `element${elementId}`);
    imageTitle.innerHTML = '＜追加画像＞';
    imageArea.classList.add('image-area', `element${elementId}`);
    imageArea.innerHTML = `追加できます`
    imageItem.classList.add('image-item', `element${elementId}`);
    imageInput.classList.add('image-input', `element${elementId}`);
    imageInput.setAttribute('type', 'file')
    imageInput.setAttribute('name', 'item_form[images][]')
    deleteBtn.classList.add('delete-btn', `element${elementId}`);
    deleteBtn.innerHTML = '削除';

    document.querySelector('.image-drop-container').appendChild(imageContainer);
    imageContainer.appendChild(imageTitle);
    imageContainer.appendChild(imageArea);
    imageArea.appendChild(imageItem);
    imageArea.appendChild(imageInput);
    imageContainer.appendChild(deleteBtn);

  
    document.querySelector(`.image-input.element${elementId}`).addEventListener('change', (event) => {
      const file = event.target.files[0];
      const blob = window.URL.createObjectURL(file);

      document.querySelector(`.image-container.element${elementId}`).setAttribute('style', 'width: 20%;');
      document.querySelector(`.image-item.element${elementId}`).setAttribute('src', blob);
      document.querySelector(`.image-item.element${elementId}`).setAttribute('style', 'display: block;');
      document.querySelector(`.delete-btn.element${elementId}`).setAttribute('style', 'display: block;');

      elementId++;
      elementCounter++;

      if (!(elementCounter === 5)) {
        createImageHTML();
      };
    });

    document.querySelectorAll('.delete-btn').forEach((element) => {
      if (element.getAttribute("data-load") != null) {
        return null;
      }
      element.setAttribute("data-load", "true");
      element.addEventListener('click', () => {
        if (!element.className.match(/main/)){
          element.parentNode.remove();
          if (elementCounter == 5) {
            elementId++;
            elementCounter--;
            createImageHTML();
          } else { 
            elementCounter--;
          };
        };
      });
    });
  };

// 編集ページ初期ロード用
  if (!(elementCounter == 0)) {
    document.querySelectorAll('.delete-btn').forEach((element) => {
      if (element.getAttribute("data-load") != null) {
        return null;
      }
      element.setAttribute("data-load", "true");
      element.addEventListener('click', () => {
        if (!element.className.match(/main/)){
          element.parentNode.remove();
          if (elementCounter == 5) {
            elementId++;
            elementCounter--;
            createImageHTML();
          } else { 
            elementCounter--;
          };
        };
      });
    });

    document.querySelector(`.image-input.element${elementId}`).addEventListener('change', (event) => {
      const file = event.target.files[0];
      const blob = window.URL.createObjectURL(file);

      document.querySelector(`.image-container.element${elementId}`).setAttribute('style', 'width: 20%;');
      document.querySelector(`.image-item.element${elementId}`).setAttribute('src', blob);
      document.querySelector(`.image-item.element${elementId}`).setAttribute('style', 'display: block;');
      document.querySelector(`.delete-btn.element${elementId}`).setAttribute('style', 'display: block;');

      elementId++;
      elementCounter++;

      if (!(elementCounter === 5)) {
        createImageHTML();
      };
    });
  }
// 編集ページ初期ロード用

});
};

window.addEventListener('DOMContentLoaded', preview);