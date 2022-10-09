module Generators
  class Cols < Base
    def call(cols, values)
      cols.each do |col|
        col.generate_self
      end
    end

    def data
    end
    
    def generate_self(&block)
      self[:type]
    end
  end
end
