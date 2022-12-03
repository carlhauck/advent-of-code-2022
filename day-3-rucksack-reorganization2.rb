require 'set'
def rucksack_reorganization(puzzle_input)
  priority_hash = {}
  lower_range = "a".."z"
  upper_range = "A".."Z"
  lower_range.each_with_index {|letter, index| priority_hash[letter] = index + 1}
  upper_range.each_with_index {|letter, index| priority_hash[letter] = index + 27}

  priority_sum = 0

  puzzle_input.each_slice(3) do |group|
    common_char = Set.new(group[0].chars).intersection(Set.new(group[1].chars)).intersection(Set.new(group[2].chars)).first
    priority_sum += priority_hash[common_char]
  end
  p priority_sum
end

puzzle_input = File.open("puzzle_inputs/day-3.txt").readlines(chomp: true)
rucksack_reorganization(puzzle_input)