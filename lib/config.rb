# frozen_string_literal: true

require "konfiguracja"

class Config < Konfiguracja::Config
  attribute :test, Dry.Types::String
  # attribute :nested do
  #   attribute :bar, Dry.Types::Boolean
  # end
end
