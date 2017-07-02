class HandleTextMessage
  def send
    respond_with_message || respond_with_template
  end

  private

  attr_reader :recipient_id, :user_input

  def initialize(recipient_id, user_input)
    @recipient_id = recipient_id
    @user_input = user_input
  end

  def respond_with_message
    case
      when keywords_input && products_from_input.any?
        deliver(set_response)
      when keywords_input
        deliver(all_products_response)
      when input_includes_any?(I18n.t('help', locale: :key_words))
        deliver({ text: I18n.t('messages.help') })
      when input_includes_any?(I18n.t('greetings', locale: :key_words))
        deliver({ text: I18n.t('messages.welcome_message', name: user_name) })
    end
  end

  def input
    @input ||= user_input.downcase.gsub(/[^a-z0-9\s]/i, '')
  end

  def set_response
    products_from_input.size == 1 ? one_product_response : show_quick_responses
  end

  def one_product_response
    { text: ProductDetailsResponse.new(payload(products_from_input.first), recipient_id).messages[0..1].join('') }
  end

  def show_quick_responses
    { text: I18n.t('messages.which_products'),
      quick_replies: build_quick_replies(products_from_input) }
  end

  def all_products_response
    { text: I18n.t('messages.all_products'),
      quick_replies: build_quick_replies(I18n.t('products')) }
  end

  def build_quick_replies(products)
    products.map do |product|
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
    input.split(' ').map { |in_part| get_matching_products(in_part) }.flatten.uniq
  end

  def keywords_input
    I18n.t('info_kind', locale: :key_words).select { |w| input =~ /#{w}/ }.first
  end

  def set_payload
    I18n.t('predefined_input', locale: :key_words).select do |key, hash|
      hash.include?(keywords_input)
    end.keys.first.to_s
  end

  def get_matching_products(item)
    I18n.t('products').select do |product|
      product['name'].downcase.include?(item)
    end
  end

  def deliver(message)
    BotDeliverer.new(recipient_id, message).deliver
  end

  def user_name
    GetUserData.new(recipient_id).name
  end

  def input_includes_any?(key_words)
    input.split(' ').map { |word| key_words.include?(word) }.include?(true)
  end
end
