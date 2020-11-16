if (document.URL.match(/items/) && !document.URL.match(/new|edit/)){
  document.addEventListener('DOMContentLoaded', function(){
    const submit = document.getElementById('submit-js');
    submit.addEventListener('click', (e) => {
      e.preventDefault();
      const formData = new FormData(document.getElementById('message-form-js'));
      const XHR = new XMLHttpRequest();
      XHR.open('POST', '/messages', true);
      XHR.responseType = "json";
      XHR.send(formData);
  
    });
  });
};