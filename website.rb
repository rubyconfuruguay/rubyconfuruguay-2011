# encoding: utf-8

require "bundler/setup"
require "sinatra/base"
require "haml"
require "sinatra/ghetto_i18n"

module RubyConf
  class Website < Sinatra::Application
    register Sinatra::GhettoI18n

    set :public,    File.expand_path("../public", __FILE__)
    set :haml,      :format => :html5
    set :languages, "en" => "English", "es" => "Español"
    set :i18n_view_format do |view, lang|
      :"#{view}_#{lang}"
    end

    home do
      haml :home
    end

    get "sponsors" do
      haml :sponsors
    end

    get "speakers" do
      haml :speakers
    end

    get "agenda" do
      haml :agenda
    end

    get "where" do
      haml :where
    end

    get "events" do
      haml :events
    end

    def speaker_twitter(user)
      "Twitter: " + link_to("@#{user}", "http://twitter.com/#{user}")
    end

    def twitter(text="sígannos en twitter", user="rubyconfuruguay")
      link_to text, "http://twitter.com/#{user}", :class => "twitter"
    end

    def email(text="envíennos un email", address="info@rubyconfuruguay.org")
      link_to text, "mailto:#{address}", :class => "email"
    end

    def link_to(text, url=nil, options={}, &block)
      url, text = text, capture_haml(&block) if url.nil?
      capture_haml do
        haml_tag :a, text, options.merge(:href => url)
      end
    end
  end
end
