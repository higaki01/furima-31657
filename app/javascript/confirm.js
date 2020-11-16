if (document.URL.match(/mypages/) && document.URL.match(/card|address|info/)) {
  document.addEventListener('DOMContentLoaded', function(){
    document.getElementById('mypage-delete-btn').addEventListener('click', (event) => {
      if (document.URL.match(/info/)) {
        if (!confirm('本当に退会しますか？')) {
          event.preventDefault();
          return false;
        } else {
          alert('退会しました');
        };
      } else if (document.URL.match(/card/)) {
        if (!confirm('本当に削除しますか？')) {
          event.preventDefault();
          return false;
        } else {
          alert('削除しました');
        };
      } else if (document.URL.match(/address/)) {
        if (confirm('本当に削除しますか？')) {
          alert('削除しました');
          document.getElementById('mypage-delete-btn-hidden').click()
        };
      };
    }, false);
  });
};