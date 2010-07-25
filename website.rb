require "sinatra/base"
require "haml"

module RubyConf
  class Website < Sinatra::Application
    set :public, File.expand_path("../public", __FILE__)
    set :haml,   :format => :html5

    before do
      @lang = "es"
    end

    get "/" do
      haml :home
    end

    get "/website.css" do
      content_type "text/css"
      sass :website
    end

    def haml(template_or_code, options={}, &block)
      layout = options.delete(:layout) || :layout
      options[:layout] = :"#{layout}_#{@lang}"
      if Symbol === template_or_code
        super(:"#{template_or_code}_#{@lang}", options, &block)
      else
        super
      end
    end

    def twitter(text = "sígannos en twitter", user = "rubyconfuruguay")
      link_to text, "http://twitter.com/#{user}", :rel => "twitter", :class => "twitter"
    end

    def email(text = "envíennos un email", address = "info@rubyconfuruguay.org")
      link_to text, "mailto:#{address}", :class => "email", :rel => "email"
    end

    def link_to(text, url, options={})
      capture_haml do
        haml_tag :a, text, options.merge(:href => url)
      end
    end
  end
end
