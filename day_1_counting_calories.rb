def count_calories(puzzle_input)
  elf_sum = 0
  elf_max = 0
  
  puzzle_input.each do |num|
    if num == 0
      if elf_sum > elf_max
        elf_max = elf_sum
      end
      elf_sum = 0
    else
      elf_sum += num
    end
  end
  p elf_max
end

puzzle_input = File.open("puzzle_inputs/day_1.txt").readlines.map(&:to_i)
count_calories(puzzle_input)