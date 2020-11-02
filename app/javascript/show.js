function show(){
  document.querySelectorAll('.img-preview').forEach((imgPreview) => {
    if (imgPreview.getAttribute("data-load") != null) {
      return null;
    }
    imgPreview.setAttribute("data-load", "true");
    imgPreview.addEventListener('click', () => {
      document.querySelector('.item-box-img').setAttribute('src', imgPreview.getAttribute('src'));
    });
  });
};

window.addEventListener('DOMContentLoaded', show);