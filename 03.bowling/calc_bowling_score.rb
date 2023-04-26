# frozen_string_literal: true

class Result
  @@score = 0
  @@is_strike = false
  @@is_spare = false

  def self.is_strike
    @@is_strike
  end

  def self.is_spare
    @@is_spare
  end

  def self.score
    @@score
  end

  def self.add_score(frame)
    if frame[0] == 10
      @@score += frame[0]
      @@is_strike = true
    elsif frame.sum == 10
      @@score += frame.sum
      @@is_spare = true
    else
      @@score += frame.sum
    end
  end

  def self.plus_next_two_shots(frame)
    if frame.size >= 2
      @@score += frame[0] + frame[1]
    else
      @@score += frame[0]
      @@is_spare = true
    end
    @@is_strike = false
  end

  def self.plus_next_shot(frame)
    @@score += frame[0]
    @@is_spare = false
  end
end

input_array = ARGV[0].split(',')
shots = []
input_array.each do |score|
  if score == 'X'
    shots << 10 << nil
  else
    shots << score.to_i
  end
end

frames = []
shots.each_slice(2) do |score|
  frames << score.compact
end

frames.each_with_index do |_, index|
  frames[9].concat(frames[index]) if index >= 10
end
frames.slice!(10..frames.size)

frames.each_with_index do |frame, index|
  if Result.is_spare == true
    Result.plus_next_shot(frame)
  end

  if index == 9
    Result.plus_next_two_shots(frame) if Result.is_strike == true
    Result.add_score(frame)
    break
  end

  if Result.is_strike == true
    Result.plus_next_two_shots(frame)
  end

  Result.add_score(frame)
end

puts Result.score
