class GenericTemplateElement
  def to_hash
    {
      title: product['name'],
      image_url: product['image_url'],
      subtitle: product['sub_name'],
      default_action: default_action,
      buttons: buttons
    }
  end

  private

  attr_reader :product

  def initialize(product)
    @product = product
  end

  def buttons
    [{ type: 'postback', title: 'Mixing instructions', payload: "mixing|#{product_id}" },
     { type: 'postback', title: 'Application info', payload: "application|#{product_id}" },
     { type: 'web_url', title: 'Show PDF', url: product['pdf_url'] }]
  end

  def default_action
    { type: 'web_url', url: product['product_url'] }
  end

  def product_id
    @product_id ||= product['id']
  end
end
