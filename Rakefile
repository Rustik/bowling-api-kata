#!/usr/bin/env rake
#
require 'rake'

namespace :bundler do
  task :setup do
    require 'rubygems'
    require 'bundler/setup'
  end
end

task :environment => 'bundler:setup' do
  ENV["RACK_ENV"] ||= "development"
  require "./app"
end

task :console => :environment do
  Pry.start
end
