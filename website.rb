require "sinatra/base"
require "haml"

module RubyConf
  class Website < Sinatra::Application
    set :public, File.expand_path("../public", __FILE__)
    set :haml,   :format => :html5

    get "/" do
      haml :home
    end

    get "/website.css" do
      content_type "text/css"
      sass :website
    end

    def twitter(text="sígannos en twitter")
      link_to text, "http://twitter.com/rubyconfuruguay",
        :rel => "twitter", :class => "twitter"
    end

    def email(text, address=text)
      link_to text, "mailto:#{address}", :class => "email", :rel => "email"
    end

    def link_to(text, url, options={})
      capture_haml do
        haml_tag :a, text, options.merge(:href => url)
      end
    end
  end
end
