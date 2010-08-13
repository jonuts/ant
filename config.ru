require ::File.expand_path('init', ::File.dirname(__FILE__))

ENV['RACK_ENV'] ||= 'development'

use Rack::ShowExceptions

run Sinatra::Application

# vim:ft=ruby

