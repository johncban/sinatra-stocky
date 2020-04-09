ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'
require 'bundler'
require 'yard-ghpages'

Yard::GHPages::Tasks.install_tasks

Bundler.require

task :console do
    Pry.start
end
