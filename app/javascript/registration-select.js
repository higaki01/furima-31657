if (document.URL.match(/users/) && document.URL.match(/addresses|cards/)){
  document.addEventListener('DOMContentLoaded', function() {
    const selectRegistration = document.getElementById('select_registration')
    const onRegistration = document.querySelectorAll('.on-registration-js')
    const offRegistration = document.querySelector('.off-registration-js')

    selectRegistration.addEventListener('change', (e) => {
      if (e.target.checked) {
        onRegistration.forEach((e) => {e.setAttribute('style', 'display: block;');});
        offRegistration.setAttribute('style', 'display: none;');
      } else {
        onRegistration.forEach((e) => {e.setAttribute('style', 'display: none;');});
        offRegistration.setAttribute('style', 'display: block;');
      };

      selectRegistration.addEventListener('change', (e) => {
        if (e.target.checked) {
          onRegistration.forEach((e) => {e.setAttribute('style', 'display: block;');});
          offRegistration.setAttribute('style', 'display: none;');
        } else {
          onRegistration.forEach((e) => {e.setAttribute('style', 'display: none;');});
          offRegistration.setAttribute('style', 'display: block;');
        };
      }, false);
    }, false);
  });
};