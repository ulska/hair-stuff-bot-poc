include Facebook::Messenger

Bot.on :message do |message|
  recipient_id = message.sender['id']

  SenderActionsResponder.new.respond(recipient_id)
  FoundProductsResponder.new(recipient_id, message.text).respond
end

Bot.on :postback do |postback|
  PostbackResponder.new(postback, ProductDetailsResponse.new(postback.payload, postback.sender['id']).messages).send
end
