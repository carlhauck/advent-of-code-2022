def tuning_trouble(puzzle_input)
  char_hash = {}
  
  index = 0
  while index < puzzle_input.length
    if char_hash[puzzle_input[index]]
      index = index - char_hash.length + 1
      char_hash = {}
    else
      char_hash[puzzle_input[index]] = true
      if char_hash.length == 14
        p index + 1
        return
      end
      index += 1
    end
  end
end

puzzle_input = File.open("puzzle_inputs/day_6.txt").readlines(chomp: true).first
tuning_trouble(puzzle_input)