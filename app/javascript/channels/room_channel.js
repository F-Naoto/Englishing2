import consumer from './consumer'

$(function() {
  const chatChannel = consumer.subscriptions.create({ channel: 'RoomChannel', room: $('textarea').data('room_id') }, {
    connected() {
    },

    disconnected() {
    },

    received: function(data) {
      const chat_messages = document.getElementById('messages');
      chat_messages.insertAdjacentHTML('beforeend', data['chat_message']);
    },

    speak: function(chat_message, room_id, teacher_id, student_id, poster) {
      return this.perform('speak', { chat_message: chat_message,
                                     room_id: room_id,
                                     teacher_id: teacher_id,
                                     student_id: student_id,
                                     poster: poster});
    }
  });

  $(document).on('click', '#send_btn', function(e) {
      const room_id = $('textarea').data('room_id')
      const teacher_id = $('textarea').data('teacher_id')
      const student_id = $('textarea').data('student_id')
      const poster = $('textarea').data('poster')
      const content = $('textarea').val()
      chatChannel.speak(content, room_id, teacher_id, student_id, poster);
      $('textarea').val("")
      e.preventDefault();
  });
});
