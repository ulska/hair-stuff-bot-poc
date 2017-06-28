include Facebook::Messenger

Bot.on :message do |message|
  recipient_id = message.sender['id']

  SenderActionsResponder.new.respond(recipient_id)
  message.reply(text: 'OK, I am working! <3')
end
