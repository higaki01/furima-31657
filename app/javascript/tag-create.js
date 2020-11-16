if (document.URL.match(/items/) && document.URL.match(/new|edit/)) {
  document.addEventListener('DOMContentLoaded', function() {
    const initialTags = document.querySelectorAll('.tag-field-js')
    for (var i = 0; i < initialTags.length; i++) {
      createTag(initialTags[i]);
    };
    
    document.querySelector('.tag-create-btn').addEventListener('click', () => {
      const tag = document.querySelector('.item-tag');
      createTag(tag);
    });

    function createTag(tag){
      const tagContainer = document.createElement('div');
      const tagText = document.createElement('div');
      const tagDelBtn = document.createElement('div');
      tagContainer.classList.add('tag-container');
      tagText.classList.add('tag-name');
      tagText.innerHTML = `${tag.value}`;
      tagDelBtn.classList.add('tag-delete-btn');
      tagDelBtn.innerHTML = '<i class="fas fa-times-circle"></i>';

      document.querySelector('.tags-container').appendChild(tagContainer);
      tagContainer.appendChild(tagText);
      tagContainer.appendChild(tagDelBtn);
      tag.value = '';

      document.querySelectorAll('.tag-delete-btn').forEach((element) => {
        if (element.getAttribute("data-load") != null) {
          return null;
        }
        element.setAttribute("data-load", "true");
        element.addEventListener('click', () => {
          element.parentNode.remove();
        });
      });
    };

    document.querySelector('.sell-form').addEventListener('submit', (event) => {
      event.preventDefault();
      let tag = document.getElementById('item-tag');
      document.querySelectorAll('.tag-name').forEach((element) => {
        tag.value = `${tag.value} ${element.innerHTML}`;
      });
      document.querySelector('.sell-form').submit();
      tag.value = '';
    });

    document.querySelector('.item-tag').addEventListener('keypress', (event) => {
      if (event.key === 'Enter') {
        event.preventDefault();
        document.querySelector('.tag-create-btn').click();
      };
    });

  });
};