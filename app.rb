# app.rb
require 'sinatra/base'
require 'securerandom'
require_relative './lib/bowling'

ENV['RACK_ENV'] ||= 'development'

Bundler.require(:default, ENV['RACK_ENV'])
require 'sinatra/reloader' if development?

class App < Sinatra::Base
  register Sinatra::Initializers

  helpers do
    def game
      @game ||= Bowling.new(params['game_id'])
    end

    def new_game_id
      SecureRandom.hex(10)
    end
  end

  post '/game' do
    { game_id: new_game_id }.to_json
  end

  get '/score' do
    {
      total_score:  game.total_score,
      frames_score: game.frames_score,
    }.to_json
  end

  post '/roll' do
    game.roll!(params['pins'])
    200
  end
end
