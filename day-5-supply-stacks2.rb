STACK_RANGE = (1..9).to_a
HORIZONTAL_INDICES =
  STACK_RANGE.zip(STACK_RANGE.map.with_index { |num, index| 1 + (index * 4)}).to_h
STACKS = STACK_RANGE.zip(STACK_RANGE.map { |num| [] }).to_h

def supply_stacks(puzzle_input)
  puzzle_stacks = puzzle_input[0..7]
  puzzle_instructions = puzzle_input[10..-1]

  puzzle_stacks.reverse.each do |vert_level|
    HORIZONTAL_INDICES.each do |stack_num, horiz_index|
      STACKS[stack_num].push(vert_level[horiz_index]) if !vert_level[horiz_index].strip.empty?
    end
  end

  puzzle_instructions.each do |instruction|
    instruction = instruction.split(" ")
    STACKS[instruction[5].to_i] << STACKS[instruction[3].to_i].pop(instruction[1].to_i)
    STACKS[instruction[5].to_i].flatten!
  end

  p STACKS.values.map { |stack| stack[-1] }.join
end

puzzle_input = File.open("puzzle_inputs/day-5.txt").readlines(chomp: true)
supply_stacks(puzzle_input)