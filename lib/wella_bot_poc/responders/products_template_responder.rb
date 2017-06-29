class ProductsTemplateResponder
  def respond
    BotDeliverer.new(recipient_id, message).deliver
  end

  private

  attr_reader :recipient_id, :user_input

  def initialize(recipient_id, user_input)
    @recipient_id = recipient_id
    @user_input = user_input
  end

  def message
    get_matching_products.any? ? matching_products_message : nothing_found_message
  end

  def nothing_found_message
    { text: I18n.t('messages.nothing_found') }
  end

  def matching_products_message
    { text: I18n.t('messages.found_products') }
    { attachment: GenericTemplate.new(get_matching_products).to_hash }
  end

  def get_matching_products
    I18n.t('products').select do |product|
      product['name'].downcase.include?(user_input.downcase)
    end
  end
end
