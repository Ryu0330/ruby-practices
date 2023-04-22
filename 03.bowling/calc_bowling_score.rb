# frozen_string_literal: true

def plus_next_two_shots(frame)
  if frame.size >= 2
    frame[0] + frame[1]
  else
    $is_spare = true
    frame[0]
  end
end

def plus_next_shot(frame)
  $is_spare = false
  frame[0]
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

point = 0
is_strike = false
$is_spare = false

frames.each_with_index do |frame, index|
  if $is_spare == true
    point += plus_next_shot(frame)
  end

  if index == 9
    point += plus_next_two_shots(frame) if is_strike == true
    point += frame.sum
    break
  end

  if is_strike == true
    point += plus_next_two_shots(frame)
    is_strike = false
  end

  if frame[0] == 10
    point += frame[0]
    is_strike = true
  elsif frame.sum == 10
    point += frame.sum
    $is_spare = true
  else
    point += frame.sum
  end
end

puts point
