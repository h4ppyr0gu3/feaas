require_relative "generators/base"
require_relative "generators/text"
require_relative "generators/button"
require_relative "generators/image"

module Generators
  def generate_text_html(ancestors, object, values)
    ::Generators::Text.call(ancestors, object, values).data
  end

  def generate_image_html(ancestors, object, values)
    ::Generators::Image.call(ancestors, object, values).data
  end

  def generate_button_html(ancestors, object, values)
    ::Generators::Button.call(ancestors, object, values).data
  end
end
