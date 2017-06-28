class ProductParser
  def initialize(product_id)
    @product_id = product_id
  end

  def name
    product['name']
  end

  def sub_name
    product['sub_name']
  end

  def image_url
    product['image_url']
  end

  def image_url
    product['product_url']
  end

  def pdf_url
    product['pdf_url']
  end

  def mixing
    product['mixing']
  end

  def ratio
    product['ratio']
  end

  def application
    product['application']
  end

  private

  attr_reader :product_id

  def product
    products_seeds.detect { |product| product['id'] == product_id }
  end

  def products_seeds
    I18n.t('products')
  end
end
