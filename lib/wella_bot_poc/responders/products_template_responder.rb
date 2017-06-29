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
    products_from_input.any? ? matching_products_message : nothing_found_message
  end

  def nothing_found_message
    { text: I18n.t('messages.nothing_found') }
  end

  def matching_products_message
    { text: I18n.t('messages.found_products') }
    { attachment: GenericTemplate.new(products_from_input).to_hash }
  end

  def input
    @input ||= user_input.downcase
  end

  def products_from_input
    input.split(' ').map { |in_part| get_matching_products(in_part) }.flatten
  end

  def get_matching_products(input)
    I18n.t('products').select do |product|
      product['name'].downcase.include?(input.downcase)
    end
  end
end
