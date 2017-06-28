class FoundProductsResponder
  def respond
    bot_deliver(message)
  end

  private

  attr_reader :recipient_id, :user_input

  def initialize(recipient_id, user_input)
    @recipient_id = recipient_id
    @user_input = user_input
  end

  def bot_deliver(message)
    Bot.deliver({ recipient: { id: recipient_id }, message: message }, access_token: ENV['ACCESS_TOKEN'])
  end

  def message
    get_matching_products.any? ? matching_products_message : nothing_found_message
  end

  def nothing_found_message
    { text: I18n.t('messages.nothing_found') }
  end

  def matching_products_message
    { attachment: GenericTemplate.new(get_matching_products).to_hash }
  end

  def get_matching_products
    I18n.t('products').select do |product|
      product['name'].downcase.include?(user_input.downcase)
    end
  end
end
