class MessageAction
  def set
    quick_reply ? run_postback : handle_text_message
  end

  private

  attr_reader :recipient_id, :user_input

  def initialize(recipient_id, user_input)
    @recipient_id = recipient_id
    @user_input = user_input
  end

  def run_postback
    PostbackResponder.new(user_input, postback_messages).send
  end

  def postback_messages
    ProductDetailsResponse.new(quick_reply, user_input.sender['id']).messages
  end

  def handle_text_message
    HandleTextMessage.new(recipient_id, user_input.text).send
  end

  def quick_reply
    @quick_reply ||= user_input.quick_reply
  end
end
