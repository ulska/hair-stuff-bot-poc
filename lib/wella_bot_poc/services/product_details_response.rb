class ProductDetailsResponse
  def messages
    case details_kind
      when 'mixing'
        [mixing_message, product.mixing, product.ratio].flatten
      when 'application'
        [application_message, product.application].flatten
    end
  end

  private

  attr_reader :payload, :sender_id

  def initialize(payload, sender_id)
    @payload = payload
    @sender_id = sender_id
  end

  def product
    @product ||= ProductParser.new(product_id)
  end

  def details_kind
    payload.split('|').first
  end

  def product_id
    @job_shortcode ||= payload.split('|').last
  end

  def mixing_message
    I18n.t('messages.mixing', name: product.name.upcase, sub_name: product.sub_name)
  end

  def application_message
    I18n.t('messages.application', name: product.name.upcase, sub_name: product.sub_name)
  end
end
