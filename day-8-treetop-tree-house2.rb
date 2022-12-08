require 'pry'
def treetop_tree_house(puzzle_input)
  max_scenic_score = 0
  @rows = puzzle_input.map { |row| row.chars.map(&:to_i) }
  @last_row_idx = @rows.length - 1
  @last_col_idx = @rows.first.length - 1
  @rows.each_with_index do |row, row_index|
    row.each_with_index do |tree_height, col_index|
      next if outside_row_or_column?(row_index, col_index)
      scenic_score = 
        [visible_to_left(tree_height, row_index, col_index),
        visible_to_right(tree_height, row_index, col_index),
        visible_to_top(tree_height, row_index, col_index),
        visible_to_bottom(tree_height, row_index, col_index)].reduce(:*)
      max_scenic_score = scenic_score if scenic_score > max_scenic_score
    end
  end
  p max_scenic_score
end

def outside_row_or_column?(row_index, col_index)
  [row_index == 0, row_index == @last_row_idx, col_index == 0, col_index == @last_col_idx].any?
end

def visible_to_left(tree_height, row_index, col_index)
  count = 0
  col_index -= 1
  while col_index >= 0
    count += 1
    break if @rows[row_index][col_index] >= tree_height
    col_index -= 1
  end
  count
end

def visible_to_right(tree_height, row_index, col_index)
  count = 0
  col_index += 1
  while col_index <= @last_col_idx
    count += 1
    break if @rows[row_index][col_index] >= tree_height
    col_index += 1
  end
  count
end

def visible_to_top(tree_height, row_index, col_index)
  count = 0
  row_index -= 1
  while row_index >= 0
    count += 1
    break if @rows[row_index][col_index] >= tree_height
    row_index -= 1
  end
  count
end

def visible_to_bottom(tree_height, row_index, col_index)
  count = 0
  row_index += 1
  while row_index <= @last_col_idx
    count += 1
    break if @rows[row_index][col_index] >= tree_height
    row_index += 1
  end
  count
end

puzzle_input = File.open("puzzle_inputs/day-8.txt").readlines(chomp: true)
treetop_tree_house(puzzle_input)
