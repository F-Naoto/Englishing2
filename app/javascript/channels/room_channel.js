import consumer from './consumer'

$(function() {
  const chatChannel = consumer.subscriptions.create("RoomChannel", {
    connected() {
    },

    disconnected() {
    },

    received: function(data) {
      const chat_messages = document.getElementById('messages');
      chat_messages.insertAdjacentHTML('beforeend', "data['chat_message']");
    },

    speak: function(chat_message, room_id, teacher_id, student_id) {
      return this.perform('speak', { chat_message: chat_message,
                                     room_id: room_id,
                                     teacher_id: teacher_id,
                                     student_id: student_id });
    }
  });

  $(document).on('keypress', '[data-behavior~=room_speaker]', function(e) {
    if (e.keyCode === 13) {
      const room_id = $('textarea').data('room_id')
      const teacher_id = $('textarea').data('teacher_id')
      const student_id = $('textarea').data('student_id')
      chatChannel.speak(e.target.value, room_id, teacher_id, student_id);
      e.target.value = '';
      e.preventDefault();
    }
  });
});
