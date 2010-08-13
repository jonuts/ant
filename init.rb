require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra'
require 'sinatra/namespace'
require 'haml'

module Ant
  @mods = []

  class << self
    attr_reader :mods

    def register(name)
      @mods << name
      yield if block_given?
    end
  end
end

get "/" do
  haml :index
end

get "/styles.css" do
  content_type "text/css", :charset => "utf-8"
  sass :stylesheet
end

Dir["#{File.dirname(__FILE__)}/modules/*_ant.rb"].each {|mod| load mod}

__END__
@@ layout
!!!
%html
  %head
    %meta{ :content=>"yes", :name=>"apple-mobile-web-app-capable"}
    %meta{ :content=>"text/html; charset=iso-8859-1", 'http-equiv'=>"Content-Type"}
    %meta{ :content=>"minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no", :name=>"viewport" }
    %link{ :rel => "stylesheet", :href => "/styles.css", :type => "text/css" }

  %body
    #container
      %header== Ant
      %hr
      = yield
