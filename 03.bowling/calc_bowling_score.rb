# frozen_string_literal: true

require 'debug'

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

point = 0
is_strike = false
is_spare = false

frames.each_with_index do |frame, index|
  if is_spare == true
    point += frame[0]
    is_spare = false
  end

  if index == 9
    if is_strike == true
      point += frame[0] + frame[1]
      is_strike = false
    end
    point += frame.sum
    next
  end

  if is_strike == true
    if frame.size == 2
      point += frame.sum
    else
      point += frame[0]
      is_spare = true
    end
    is_strike = false
  end

  if frame[0] == 10
    point += frame[0]
    is_strike = true
  elsif frame.sum == 10
    point += frame.sum
    is_spare = true
  else
    point += frame.sum
  end
end

puts point
