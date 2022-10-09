module Generators
  class Base
    class << self
      def call(ancestors, object, values)
        new(ancestors, object, values).tap(&:call)
      end
    end

    attr_reader :ancestors, :values, :object, :data, :errors

    def initialize(ancestors, object, values)
      @ancestors = ancestors
      @object = object
      @values = values
      @errors = []
    end

    def generate_wrapper
      ancestors.each do |ancestor|
        case ancestor
        when :cols
          @data = "<div class='column'> #{gen} </div>"
        end
      end
    end

    def success?
      errors.empty?
    end
  end
end
