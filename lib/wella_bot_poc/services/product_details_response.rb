class ProductDetailsResponse
  def messages
    case details_kind
      when 'mixingratio'
        [mixing_ratio_message, product.mixing, product.ratio].flatten
      when 'mixing'
        [mixing_message, product.mixing].flatten
      when 'ratio'
        [ratio_message, product.ratio].flatten
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

  def mixing_ratio_message
    I18n.t('messages.mixing_ratio', name: product_name, sub_name: product_sub_name)
  end

  def mixing_message
    I18n.t('messages.mixing', name: product_name, sub_name: product_sub_name)
  end

  def ratio_message
    I18n.t('messages.ratio', name: product_name, sub_name: product_sub_name)
  end

  def application_message
    I18n.t('messages.application', name: product_name, sub_name: product_sub_name)
  end

  def product_name
    @product_name ||= product.name.upcase
  end

  def product_sub_name
    @product_sub_name ||= product.sub_name.downcase
  end
end
