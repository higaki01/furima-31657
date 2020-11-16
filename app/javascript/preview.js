if (document.URL.match(/items/) && document.URL.match(/new|edit/)) {
  document.addEventListener('DOMContentLoaded', function() {
    // 編集時用に画像登録を取得
    const initialImgCounter = document.getElementById('img-counter-js').getAttribute('data-id');
    const initialImgId = document.getElementById('img-id-js').getAttribute('data-id');

    // 登録・削除呼び出し
    setImg(initialImgCounter, initialImgId);
    deleteImg(initialImgCounter, initialImgId);
    setModal()

    // 画像登録
    function setImg(imgCounter,imgId){
      currentImgCounter = imgCounter
      currentImgId  = imgId
      const imgInputs = document.querySelectorAll('.image-input')
      for (var i = 0; i < imgInputs.length; i++) {
        if (imgInputs[i].getAttribute('data-load') != null) {continue;};
        imgInputs[i].setAttribute("data-load", "true");
        imgInputs[i].addEventListener('change', (e) => {
          const blob = window.URL.createObjectURL(e.target.files[0]);
          const imageContainer = e.target.parentNode.parentNode;
          const imageItem = imageContainer.querySelector('.image-item')

          imageContainer.classList.add('show-width');
          imageItem.setAttribute('src', blob);
          imageItem.classList.remove('hidden');
          imageContainer.querySelector('.delete-btn').classList.remove('hidden');
 
          if (currentImgCounter == 5 || currentImgId != imageContainer.getAttribute('id')) {
            setImg(currentImgCounter,currentImgId);
          } else if (currentImgCounter == 4 && currentImgId == imageContainer.getAttribute('id')) {
            currentImgCounter++;
            setImg(currentImgCounter,currentImgId);
          } else {
            currentImgCounter++;
            currentImgId++;
            createImageHTML(currentImgCounter,currentImgId);
          };
          deleteImg(currentImgCounter,currentImgId);
          setModal()
        });
      };
    };
    // 画像登録

    // 画像フィールド作成
    function createImageHTML(imgCounter, imgId){
      const imageContainer = document.createElement('div');
      const imageArea = document.createElement('div');
      const imageAreaText = document.createElement('span')
      const imageItem = document.createElement('img');
      const imageInput = document.createElement('input');
      const deleteBtn = document.createElement('div');
      imageContainer.classList.add('image-container');
      imageContainer.setAttribute('id', `${imgId}`);
      imageArea.classList.add('image-area');
      imageAreaText.classList.add('image-area-text');
      imageAreaText.innerHTML = `あと${5 - imgCounter}枚追加できます`;
      imageItem.classList.add('image-item', 'hidden');
      imageInput.classList.add('image-input');
      imageInput.setAttribute('type', 'file');
      imageInput.setAttribute('name', 'item_form[images][]');
      deleteBtn.classList.add('delete-btn', 'hidden');
      deleteBtn.innerHTML = '削除';

      document.querySelector('.image-drop-container').appendChild(imageContainer);
      imageContainer.appendChild(imageArea);
      imageArea.appendChild(imageAreaText);
      imageArea.appendChild(imageItem);
      imageArea.appendChild(imageInput);
      imageContainer.appendChild(deleteBtn);

      setImg(imgCounter,imgId);
      deleteImg(imgCounter, imgId);
    };
    // 画像フィールド作成

    // 画像削除
    function deleteImg(imgCounter,imgId){
      currentImgCounter = imgCounter
      currentImgId  = imgId
      const deleteBtn = document.querySelectorAll('.delete-btn')
      for (var i = 0; i < deleteBtn.length; i++) {
        if (deleteBtn[i].getAttribute('data-load') != null) {continue;};
        deleteBtn[i].setAttribute("data-load", "true");
        deleteBtn[i].addEventListener('click', (e) => {
          e.target.parentNode.remove();
          
          currentImgCounter--;
          if (currentImgCounter == 4) {
            currentImgId++;
            createImageHTML(currentImgCounter, currentImgId);
          }
          console.log(currentImgId)
          const imageContainer = document.getElementById(`${currentImgId}`)
          const imageAreaText = imageContainer.querySelector('.image-area-text')

          if (currentImgCounter == 0) {
            imageAreaText.innerHTML = `クリックして選択 or ドラッグ&ドロップ`;
          } else {
            imageAreaText.innerHTML = `あと${5 - currentImgCounter}枚追加できます`;
          };
          setImg(currentImgCounter,currentImgId)
        });
      };
    };
    // 画像削除

    // モーダル
    function setModal(){
      const imgItems = document.querySelectorAll('.image-item')
      for (var i = 0; i < imgItems.length; i++) {
        if (imgItems[i].getAttribute('data-load') != null) {continue;};
        imgItems[i].setAttribute("data-load", "true");
        imgItems[i].addEventListener('click', (e) => {
          document.querySelector('body').classList.add('scroll_stop');
          document.getElementById('modal-cover-js').classList.remove('hidden');
          const imageUrl = e.target.getAttribute('src');
          document.getElementById('modal-image-js').setAttribute('src', imageUrl);
          document.getElementById('modal-main-js').animate([{opacity: 0},{opacity: 1}], 500)
        });

        const modalDeleteBtn = document.getElementById('modal-delete-btn-js')
        if (modalDeleteBtn.getAttribute('data-load') != null) {continue;};
        modalDeleteBtn.setAttribute("data-load", "true");
        modalDeleteBtn.addEventListener('click', () => {
          document.querySelector('body').classList.remove('scroll_stop');
          document.getElementById('modal-cover-js').classList.add('hidden');
        });
        setModal();
      };
    // モーダル

    };
  });
};
