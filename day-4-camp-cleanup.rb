require 'set'
def camp_cleanup(puzzle_input)
  sum = 0

  puzzle_input.each do |pair|
    assignment_ranges =
      pair.split(",")
        .map { |assignment| assignment.split("-").map(&:to_i) }
        .map { |assignment| (assignment[0]..assignment[1]).to_a }
    assignment_1 = assignment_ranges[0]
    assignment_2 = assignment_ranges[1]
    common_range = Set.new(assignment_1).intersection(Set.new(assignment_2))
    sum += 1 if common_range.length == assignment_1.length || common_range.length == assignment_2.length
  end

  p sum
end

puzzle_input = File.open("puzzle_inputs/day-4.txt").readlines(chomp: true)
camp_cleanup(puzzle_input)