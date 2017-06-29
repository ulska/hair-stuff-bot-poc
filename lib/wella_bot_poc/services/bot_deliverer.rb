class BotDeliverer
  def deliver
    messages.each do |message|
      Bot.deliver({recipient: {id: recipient_id}, message: message}, access_token: ENV['ACCESS_TOKEN'])
    end
  end

  private

  attr_reader :recipient_id, :messages

  def initialize(recipient_id, messages)
    @recipient_id = recipient_id
    @messages = Array[messages]
  end
end
