# The bowling game api

This is my implementation of [Uncle Bob’s bowling game kata](http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata) written with Ruby and Sinatra

## Actions

Api provides the following actions:
- post `/game` - Starts a new game, returns `game_id`.
- post `/roll` - Input the number of `pins` knocked down by ball in current game and returns `200`.
- get `/score` - Output the current game score (which consists of the score for each frame and total score).

Params: use `game_id` to specify current game, `pins` to specify number of pins knocked.

## Setup
- clone this repo
- `gem install bunlder`
- `bundle install`
- `bundle exec rspec`
- `heroku local`to run api locally, or `bundle exec puma -C config/puma.rb`

## Notes

For simplicity, api does not validate input values and store games in Redis. Also, I think game logic can be re-implemented in functional style and perhaps its code could be more neat, probably I'll return to it later.
