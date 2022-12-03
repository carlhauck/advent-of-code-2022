def rucksack_reorganization(puzzle_input)
  priority_hash = {}
  lower_range = "a".."z"
  upper_range = "A".."Z"
  lower_range.each_with_index {|letter, index| priority_hash[letter] = index + 1}
  upper_range.each_with_index {|letter, index| priority_hash[letter] = index + 27}

  priority_sum = 0

  puzzle_input.each do |rucksack|
    size = rucksack.length
    half = size / 2
    compartment_1 = rucksack[0, half]
    compartment_2 = rucksack[half, size]
    
    compartment_1_hash = compartment_1.chars.tally
    compartment_2.each_char do |letter|
      if compartment_1_hash[letter]
        priority_sum += priority_hash[letter]
        break
      end
    end
  end
  p priority_sum
end

puzzle_input = File.open("puzzle_inputs/day-3.txt").readlines(chomp: true)
rucksack_reorganization(puzzle_input)