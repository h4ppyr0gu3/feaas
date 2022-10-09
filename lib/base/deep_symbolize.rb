# frozen_string_literal: true

module DeepSymbolizable
  def deep_symbolize(&)
    method = self.class.to_s.downcase.to_sym
    syms = DeepSymbolizable::Symbolizers
    syms.respond_to?(method) ? syms.send(method, self, &) : self
  end

  module Symbolizers
    module_function

    def hash(hash, &)
      hash.each_with_object({}) do |(key, value), result|
        value = _recurse_(value, &)
        key = yield key if block_given?
        sym_key = begin
          key.to_sym
        rescue StandardError
          key
        end
        result[sym_key] = value
      end
    end

    def array(ary, &)
      ary.map { |v| _recurse_(v, &) }
    end

    def _recurse_(value, &)
      if value.is_a?(Enumerable) && !value.is_a?(String)
        value.extend DeepSymbolizable unless value.class.include?(DeepSymbolizable)
        value = value.deep_symbolize(&)
      end
      value
    end
  end
end
