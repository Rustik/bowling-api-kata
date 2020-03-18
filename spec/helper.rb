ENV['RACK_ENV'] = 'test'

require './app'
require 'rack/test'

def app
  App
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
