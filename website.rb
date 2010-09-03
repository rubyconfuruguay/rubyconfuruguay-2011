require "sinatra/base"
require "haml"

module RubyConf
  class Website < Sinatra::Application
    LANGUAGES = { "en" => "English", "es" => "Español" }

    def self.check_language!
      condition { LANGUAGES.keys.include?(params[:lang]) }
    end

    set :public, File.expand_path("../public", __FILE__)
    set :haml,   :format => :html5

    get "/" do
      redirect language
    end

    check_language!
    get "/:lang" do |lang|
      haml :home
    end

    def language
      @lang ||= params[:lang] || language_from_http
    end

    def language_from_http
      env["HTTP_ACCEPT_LANGUAGE"].split(",").each do |lang|
        LANGUAGES.each {|code,_| return code if lang =~ /^#{code}/ }
      end
    end

    def twitter(text="sígannos en twitter", user="rubyconfuruguay")
      link_to text, "http://twitter.com/#{user}", :rel => "twitter", :class => "twitter"
    end

    def email(text="envíennos un email", address="info@rubyconfuruguay.org")
      link_to text, "mailto:#{address}", :class => "email", :rel => "email"
    end

    def link_to(text, url, options={})
      capture_haml do
        haml_tag :a, text, options.merge(:href => url)
      end
    end

    def haml(template_or_code, options={}, &block)
      layout = options.has_key?(:layout) ? options.delete(:layout) : :layout
      options[:layout] = :"#{layout}_#{language}" if layout

      if Symbol === template_or_code
        super(:"#{template_or_code}_#{language}", options, &block)
      else
        super
      end
    end
  end
end
