require 'rubygems'
require 'bundler'

Bundler.require

require 'sinatra/reloader'
require 'sinatra/config_file'
require 'sinatra/json'
require 'sinatra/multi_route'
require 'sinatra/namespace'
require 'sinatra/respond_with'

Mongoid.load!("mongoid.yml")

Rabl.register!

require './app'

%w{initializers uploaders models routes}.each {|dir| Dir.glob(File.dirname(__FILE__) + "/#{dir}/*", &method(:require)) }

run App