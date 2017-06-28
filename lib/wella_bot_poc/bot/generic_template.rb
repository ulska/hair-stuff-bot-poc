class GenericTemplate
  def to_hash
    {
      type: 'template',
      payload: {
        template_type: 'generic',
        image_aspect_ratio: 'square',
        elements: elements
      }
    }
  end

  private

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def elements
    data.map { |job_data| GenericTemplateElement.new(job_data).to_hash }
  end
end
