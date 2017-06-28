class PostbackResponder
  def send
    messages.each do |message|
      postback.reply(text: message)
    end
  end

  private

  attr_reader :postback, :messages

  def initialize(postback, messages)
    @postback = postback
    @messages = Array(messages)
  end
end
