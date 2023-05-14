# frozen_string_literal: true

class Result
  attr_accessor :score

  def initialize
    @score = 0
    @is_strike = false
    @is_spare = false
  end

  def strike?
    @is_strike
  end

  def spare?
    @is_spare
  end

  def check_is_bonus_and_add_score(frame)
    check_strike_and_spare(frame)
    add_score(frame)
  end

  def check_strike_and_spare(frame)
    if frame[0] == 10
      @is_strike = true
    elsif frame.sum == 10
      @is_spare = true
    end
  end

  def add_score(frame)
    @score += frame.sum
  end

  def plus_next_two_shots(frame)
    if frame.size >= 2
      @score += frame[0] + frame[1]
    else
      @score += frame[0]
      @is_spare = true
    end
    @is_strike = false
  end

  def plus_next_shot(frame)
    @score += frame[0]
    @is_spare = false
  end
end

input_array = ARGV[0].split(',')

shots = input_array.map { |score| score == 'X' ? [10, nil] : score.to_i }.flatten

frames = shots.each_slice(2).map(&:compact).to_a

frames[9].concat(frames[10..].flatten)

frames.pop(frames.size - 10)

result = Result.new
frames.each_with_index do |frame, index|
  result.plus_next_shot(frame) if result.spare?

  if index == 9
    result.plus_next_two_shots(frame) if result.strike?
    result.check_is_bonus_and_add_score(frame)
    break
  end

  result.plus_next_two_shots(frame) if result.strike?

  result.check_is_bonus_and_add_score(frame)
end

puts result.score
