require 'set'
def camp_cleanup(puzzle_input)
  sum = 0

  puzzle_input.each do |pair|
    assignment_ranges =
      pair.split(",")
        .map { |assignment| assignment.split("-").map(&:to_i) }
        .map { |assignment| (assignment[0]..assignment[1]).to_a }
    common_range = Set.new(assignment_ranges[0]).intersection(Set.new(assignment_ranges[1]))
    sum += 1 if common_range.length > 0
  end
  p sum
end

puzzle_input = File.open("puzzle_inputs/day-4.txt").readlines(chomp: true)
camp_cleanup(puzzle_input)