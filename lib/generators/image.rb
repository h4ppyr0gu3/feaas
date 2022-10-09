module Generators
  class Image < Base
    def call
      generate_wrapper
    end

    def data
      return unless success?
      @data
    end
    
    private

    def gen
      "<img src='#{object[:image]}' #{alt_text} #{size_params}/>"
    end

    def alt_text
      return if object[:alt].nil?
      "alt='#{object[:alt]}'"
    end

    def size_params
      return if object[:size].nil?
      "height=#{object[:size][:height]} width=#{object[:size][:height]}"
    end
  end
end
