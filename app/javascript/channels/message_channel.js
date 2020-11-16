import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },
  
  received(data) {
    const commentBox = document.getElementById('message-area-js');
    const commentText = document.getElementById("comment-text-js");
    if (data.message.user_id === data.user.id) {
      var messageBox = 'right'
    } else {
      var messageBox = 'left'
    };

    if (data.avatar == null) {
      var avatar = '/images/s30.png'
    } else {
      var avatar = data.avatar
    }; 

    const date = new Date(data.time)

    const HTML = `
      <div class = 'message-container' id = 'message-container-js'>
        <div class = "message-info ${messageBox}">
          <div class = 'message-nickname'>${data.user.nickname}</div>
          <div class = 'message-time'>${date}</div>
        </div>
        <div class = 'message-main ${messageBox}'>
          <div class = 'user-icon-box'>
            <img src = '${avatar}', class = "img-preview-show">
          </div>
          <div class = 'fukidashi-${messageBox}'></div>
          <div class = message-text>${data.message.text}</div>
        </div>
      </div>`;
    commentBox.insertAdjacentHTML("afterbegin", HTML);
    commentText.value = "";
  }
});
