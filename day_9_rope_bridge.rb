def rope_bridge(puzzle_input)
  @tail_positions = {
    '0,0' => true
  }

  @head = { x: 0, y: 0 }
  @tail = { x: 0, y: 0 }

  puzzle_input.map { |line| line.split(' ') }.each do |line|
    direction = line[0]
    distance = line[1].to_i
    distance.times do
      move_head(direction)
      move_tail
      record_tail_position
    end
  end

  p @tail_positions.length
end

def move_head(direction)
  case direction
  when 'R' then @head[:x] += 1
  when 'L' then @head[:x] -= 1
  when 'U' then @head[:y] += 1
  when 'D' then @head[:y] -= 1
  end
end

def move_tail
  return if head_and_tail_touching?

  if same_row_different_col?
    move_horizontally
  elsif same_col_different_row?
    move_vertically
  else
    move_diagonally
  end
end

def head_and_tail_touching?
  (@head[:x] - @tail[:x]).abs <= 1 && (@head[:y] - @tail[:y]).abs <= 1
end

def same_row_different_col?
  @head[:y] == @tail[:y] && @head[:x] != @tail[:x]
end

def same_col_different_row?
  @head[:y] != @tail[:y] && @head[:x] == @tail[:x]
end

def move_horizontally
  if @head[:x] > @tail[:x]
    @tail[:x] += 1
  else
    @tail[:x] -= 1
  end
end

def move_vertically
  if @head[:y] > @tail[:y]
    @tail[:y] += 1
  else
    @tail[:y] -= 1
  end
end

def move_diagonally
  move_horizontally
  move_vertically
end

def record_tail_position
  @tail_positions["#{@tail[:x]},#{@tail[:y]}"] = true
end

puzzle_input = File.open('puzzle_inputs/day_9.txt').readlines(chomp: true)
rope_bridge(puzzle_input)
