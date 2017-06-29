class HandleTextMessage
  def send
    if keywords_input && products_from_input.any?
      BotDeliverer.new(recipient_id, set_response).deliver
    elsif input.include?('help')
      BotDeliverer.new(recipient_id, { text: I18n.t('messages.help') }).deliver
    else
      respond_with_template
    end
  end

  private

  attr_reader :recipient_id, :user_input

  def initialize(recipient_id, user_input)
    @recipient_id = recipient_id
    @user_input = user_input
  end

  def input
    @input ||= user_input.downcase
  end

  def set_response
    products_from_input.size == 1 ? one_product_response : show_quick_responses
  end

  def one_product_response
    { text: ProductDetailsResponse.new(payload(products_from_input.first), recipient_id).messages.join(' ') }
  end

  def show_quick_responses
    { text: I18n.t('messages.which_products'), quick_replies: quick_replies }
  end

  def quick_replies
    products_from_input.map do |product|
      { content_type: 'text', title: "#{product['name']}",
        payload: payload(product) }
    end
  end

  def payload(product)
    "#{set_payload}|#{product['id']}"
  end

  def respond_with_template
    ProductsTemplateResponder.new(recipient_id, user_input).respond
  end

  def get_products_ids
    products_from_input.map { |product| product}
  end

  def products_from_input
    input.split(' ').map { |in_part| get_matching_products(in_part) }.flatten
  end

  def keywords_input
    %w(use using usage mixing mix ratio application).select { |w| input =~ /#{w}/ }.first
  end

  def set_payload
    case
      when %w(use using usage).include?(keywords_input)
        'mixingratio'
      when %w(mixing mix).include?(keywords_input)
        'mixing'
      when keywords_input == 'ratio'
        'ratio'
      when keywords_input == 'application'
        'application'
    end
  end

  def get_matching_products(item)
    I18n.t('products').select do |product|
      product['name'].downcase.include?(item)
    end
  end
end
