function addressSelect() {
  if (document.getElementById('addresschk').checked) document.querySelector('.address-hidden').setAttribute('style', 'display: none;');
  
  document.getElementById('addresschk').addEventListener('change', () => {
    if (document.getElementById('addresschk').checked) {
      document.querySelector('.address-hidden').setAttribute('style', 'display: none;');
    } else {
      document.querySelector('.address-hidden').setAttribute('style', 'display: block;');
    };

    addressChk();
  }, false);

  const addressChk = () => {
    document.getElementById('addresschk').addEventListener('change', () => {
      if (document.getElementById('addresschk').checked) {
        document.querySelector('.address-hidden').setAttribute('style', 'display: none;');
      } else {
        document.querySelector('.address-hidden').setAttribute('style', 'display: block;');
      };
    }, false);
  };
};

window.addEventListener('load', addressSelect);