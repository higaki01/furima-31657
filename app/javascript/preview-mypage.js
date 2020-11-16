if (document.URL.match(/mypages/)) {
  document.addEventListener('DOMContentLoaded', function() {
    // 登録・削除呼び出し
    setImg();

    // 画像登録
    function setImg(){
      const imgInput = document.querySelector('.image-input')
      imgInput.addEventListener('change', (e) => {
        const blob = window.URL.createObjectURL(e.target.files[0]);
        const imageItem = document.querySelector('.avatar-image-item');
        imgInput.setAttribute('src', '');
        imageItem.setAttribute('src', blob);
        setImg()
      });
    // 画像登録
    };
  });
};
