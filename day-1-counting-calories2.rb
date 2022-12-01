def count_calories(puzzle_input)
  max_three = []
  new_sum = 0
  threshold = 0
  
  puzzle_input.each do |num|
    if num == 0
      if new_sum >= threshold
        if max_three.length < 3
          max_three << new_sum
          max_three.sort!.reverse!
        else
          max_three.each_with_index do |old_sum, index|
            if new_sum >= old_sum
              max_three.insert(index, new_sum)
              max_three.pop if max_three.length > 3
              break
            end
          end
        end
      end
      new_sum = 0
    else
      new_sum += num
    end
  end
  p max_three.sum
end

puzzle_input = File.open("puzzle_inputs/day-1.txt").readlines.map(&:to_i)
count_calories(puzzle_input)