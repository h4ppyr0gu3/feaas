# frozen_string_literal: true
module Base
  class Header
    attr_reader :title, :stylesheet, :favicon, :lang, :desc

    def initialize(params: {})
      @title = params[:title]
      @stylesheet = params[:stylesheet]
      @favicon = params[:favicon]
      @lang = params[:lang]
      @desc = params[:desc]
    end

    def call
      "
    <!DOCTYPE html>
    <html lang='#{lang || 'en'}'>
    <head>
      <title>#{title || 'Default Title'}</title>
      <meta charset='UTF-8' />
      <meta name='viewport' content='width=device-width,initial-scale=1' />
      <meta name='description' content='#{desc}' />
      #{selected_stylesheet}
      <link rel='icon' href='img/favicon.png'>
    </head>
    "
    end

    def selected_stylesheet
      stylesheet_provider[stylesheet] || stylesheet_provider["bulma"]
    end

    def stylesheet_provider
      {
        "bulma" => "<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css'>",
        :bootstrap => ""
      }
    end
  end
end
