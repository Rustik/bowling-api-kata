class Bowling

  attr_reader :game_id, :rolls

  def initialize(game_id)
    @game_id = game_id
    @rolls = load_rolls
  end

  def roll!(pins)
    @rolls << pins
    save_roll(pins)
  end

  # Recursively iterate over rolls and calculates frame score.
  # Returns array of scores.
  def frames_score(roll_index=0, frame_index=1, memo=[])
    return memo if frame_index > 10

    if strike?(roll_index)
      memo << 10 + strike_bonus(roll_index)
      frames_score(roll_index + 1, frame_index + 1, memo)
    elsif spare?(roll_index)
      memo << 10 + spare_bonus(roll_index)
      frames_score(roll_index + 2, frame_index + 1, memo)
    else
      memo << sum_rolls(roll_index, roll_index + 1)
      frames_score(roll_index + 2, frame_index + 1, memo)
    end
    memo
  end

  def total_score
    frames_score.sum
  end

  def strike?(roll_index)
    roll_at(roll_index) == 10
  end

  def spare?(roll_index)
    sum_rolls(roll_index, roll_index + 1) == 10
  end

  def strike_bonus(roll_index)
    sum_rolls(roll_index + 1, roll_index + 2)
  end

  def spare_bonus(roll_index)
    roll_at(roll_index + 2)
  end

  def sum_rolls(*indices)
    indices.map { |roll_index| roll_at(roll_index) }.sum
  end

  def roll_at(roll_index)
    rolls[roll_index].to_i
  end

  def load_rolls
    REDIS.lrange(game_id, 0, 11)
  end

  def save_roll(value)
    REDIS.rpush(game_id, value)
  end
end
