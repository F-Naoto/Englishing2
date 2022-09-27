import consumer from './consumer'

$(function() {
  const chatChannel = consumer.subscriptions.create("RoomChannel", {
    connected() {
    },

    disconnected() {
    },

    // received: function(data) {
    //   return $('#messages').append(data['content']);
    // },
    received: function(data) {
      return alert(data['content']);
    },

    speak: function(content) {
      return this.perform('speak', {
        content: content
      });
    }
  });

  $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
    if (event.keyCode === 13) {
      chatChannel.speak(event.target.value);
      event.target.value = '';
      return event.preventDefault();
    }
  });
});
