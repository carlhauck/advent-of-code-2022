def rope_bridge(puzzle_input)
  @tail_positions = {
    '0,0' => true
  }

  @head = { x: 0, y: 0 }
  @tails = {
    1 => { x: 0, y: 0 },
    2 => { x: 0, y: 0 },
    3 => { x: 0, y: 0 },
    4 => { x: 0, y: 0 },
    5 => { x: 0, y: 0 },
    6 => { x: 0, y: 0 },
    7 => { x: 0, y: 0 },
    8 => { x: 0, y: 0 },
    9 => { x: 0, y: 0 }
  }

  puzzle_input.map { |line| line.split(' ') }.each do |line|
    direction = line[0]
    distance = line[1].to_i
    distance.times do
      move_head(direction)
      (1..9).to_a.each do |num|
        @leader = num == 1 ? @head : @tails[num - 1]
        @tail = @tails[num]
        move_tail(num)
        record_tail_position if num == 9
      end
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

def move_tail(num)
  return if leader_and_tail_touching?

  if same_row_different_col?
    move_horizontally(num)
  elsif same_col_different_row?
    move_vertically(num)
  else
    move_horizontally(num)
    move_vertically(num)
  end
end

def leader_and_tail_touching?
  (@leader[:x] - @tail[:x]).abs <= 1 && (@leader[:y] - @tail[:y]).abs <= 1
end

def same_row_different_col?
  @leader[:y] == @tail[:y] && @leader[:x] != @tail[:x]
end

def same_col_different_row?
  @leader[:y] != @tail[:y] && @leader[:x] == @tail[:x]
end

def move_horizontally(num)
  if @leader[:x] > @tail[:x]
    @tails[num][:x] += 1
  else
    @tails[num][:x] -= 1
  end
end

def move_vertically(num)
  if @leader[:y] > @tail[:y]
    @tails[num][:y] += 1
  else
    @tails[num][:y] -= 1
  end
end

def record_tail_position
  @tail_positions["#{@tails[9][:x]},#{@tails[9][:y]}"] = true
end

puzzle_input = File.open('puzzle_inputs/day_9.txt').readlines(chomp: true)
rope_bridge(puzzle_input)
