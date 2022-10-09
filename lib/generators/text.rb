module Generators
  class Text < Base
    def call
      generate_wrapper
    end

    def data
      return unless success?
      @data
    end

    private

    def gen
      "
      <div class='is-size-#{object[:size] || 3} #{object[:class]}'>
       #{object[:value]}
      </div>
      "
    end
  end
end
