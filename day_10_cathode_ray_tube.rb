def cathode_ray_tube(puzzle_input)
  x = 1
  cycle = 1
  index = 0
  @signal_strengths = {}
  puzzle_input.each do |line|
    if line == "noop"
      cycle += 1
    else
      cycle += 1
      add_signal_strength(cycle, x)
      cycle += 1
      x += line.split(" ")[1].to_i
    end
    add_signal_strength(cycle, x)
  end
  p @signal_strengths.values.sum
end

def add_signal_strength(cycle, x)
  return unless [20, 60, 100, 140, 180, 220].include?(cycle)
  @signal_strengths[cycle] = cycle * x
end

puzzle_input = File.open("puzzle_inputs/day_10.txt").readlines(chomp: true)
cathode_ray_tube(puzzle_input)