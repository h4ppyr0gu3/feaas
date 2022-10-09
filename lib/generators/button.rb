module Generators
  class Button < Base
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
      <button class='button'>
       #{object[:value]}
      </button>
      "
    end
  end
end

