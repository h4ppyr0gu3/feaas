# frozen_string_literal: true

# This is to generate a basic frontend as a service


require "pry"
require "json"
require_relative "lib/generators"
require_relative "lib/base"
# require_relative "lib/generators/base"
# require_relative "lib/generators/text"
# require_relative "lib/generators/button"
# require_relative "lib/generators/image"

class Hash; include ::DeepSymbolizable; end


class Component
  class << self
    def call(json:)
      new(json: json).tap(&:call)
    end
  end

  include Generators
  WRAPPERS = %w[card box form].freeze

  attr_reader :title, :cols, :values, :keys, :json

  def initialize(json:)
    @title = json[:title]
    @cols = json[:cols]
    @values = json[:values]
    @keys = json.keys
    @json = json
  end

  def call
    @data = generate_wrapper
  end

  def data
    # return unless success?
    @data
  end

  def wrapper_class
    @wrapper_class ||= (@keys - %i[component title name values]).first
  end

  def inner_type
    case json[wrapper_class].keys.first
    when :cols
      "<div class='columns'>#{generate_columns.join("").gsub("\n", "")}</div>"
    when :component
      Component.new(json: json[wrapper_class][:component])
    end
  end

  def generate_columns
    html = []
    ancestors = [wrapper_class, :cols]
    json[wrapper_class][:cols].each do |col|
      html <<
        case col[:type]
        when "text"
          generate_text_html(ancestors, col, values)
        when "image"
          generate_image_html(ancestors, col, values)
        when "button"
          generate_button_html(ancestors, col, values)
        end
    end
    html
  end

  def generate_wrapper
    case wrapper_class 
    when :card
      "<div class='#{wrapper_class}'>\
        #{inner_type}\
      </div>"
    end

  end
end

class Body
  def call
    Component.call(json: json_file_data[:component]).data
  end

  def json_file_data
    JSON.parse(File.read("./in.json")).deep_symbolize
  end
end

class Doc
  class << self
    def call
      new.tap(&:call)
    end
  end

  def call
    @data = Base::Header.new.call + Body.new.call + Footer.call
  end

  def data
    return unless success?
    @data
  end
end

File.write("test.html", Doc.call.data.gsub("\n", ""))

# File.write("test.html", Body.new.call)


# follow parents 
# card < cols < image
# form < cols < button
# 
