require_relative './helper'

RSpec.describe App do
  let(:game_id) { 1 }
  let(:game) { Bowling.new(game_id) }
  let(:parsed_response) { JSON.parse(last_response.body) }
  let(:game_id) { 'xdxdxd' }

  describe 'Bowling game api' do
    it 'post to "/game" returns new game id' do
      allow_any_instance_of(App).to receive(:new_game_id).and_return(game_id)
      post '/game'
      expect(parsed_response).to eq({ 'game_id' => game_id})
    end

    it 'post to "/roll" record pins and return 200' do
      post '/roll', { game_id: game_id, pins: 4 }
      post '/roll', { game_id: game_id, pins: 6 }
      post '/roll', { game_id: game_id, pins: 7 }
      expect(last_response.status).to eq(200)
    end

    it 'get to "/score" return frames score and total score' do
      get '/score', { game_id: game_id }
      expect(parsed_response).to eq({ 'frames_score' => [17, 7, 0, 0, 0, 0, 0, 0, 0, 0], 'total_score' => 24 })
    end
  end

end
