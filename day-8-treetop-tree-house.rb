require 'pry'
def treetop_tree_house(puzzle_input)
  visible_count = 0
  @rows = puzzle_input.map { |row| row.chars.map(&:to_i) }
  @last_row_idx = @rows.length - 1
  @last_col_idx = @rows.first.length - 1
  @rows.each_with_index do |row, row_index|
    row.each_with_index do |tree_height, col_index|
      if outside_row_or_column?(row_index, col_index)
        visible_count += 1 
        next
      end
      if visible_from_any_direction?(tree_height, row_index, col_index)
        visible_count += 1
      end
    end
  end
  p visible_count
end

def outside_row_or_column?(row_index, col_index)
  [row_index == 0, row_index == @last_row_idx, col_index == 0, col_index == @last_col_idx].any?
end

def visible_from_any_direction?(tree_height, row_index, col_index)
  [visible_from_left?(tree_height, row_index, col_index),
   visible_from_right?(tree_height, row_index, col_index),
   visible_from_top?(tree_height, row_index, col_index),
   visible_from_bottom?(tree_height, row_index, col_index),
  ].any?
end

def visible_from_left?(tree_height, row_index, col_index)
  @rows[row_index][0..(col_index - 1)].all? { |other_tree| other_tree < tree_height }
end

def visible_from_right?(tree_height, row_index, col_index)
  @rows[row_index][(col_index + 1)..@last_col_idx].all? { |other_tree| other_tree < tree_height }
end

def visible_from_top?(tree_height, row_index, col_index)
  @rows[0..(row_index - 1)].map { |row| row[col_index] }.all? { |other_tree| other_tree < tree_height }
end

def visible_from_bottom?(tree_height, row_index, col_index)
  @rows[(row_index + 1)..@last_row_idx].map { |row| row[col_index] }.all? { |other_tree| other_tree < tree_height }
end

puzzle_input = File.open("puzzle_inputs/day-8.txt").readlines(chomp: true)
treetop_tree_house(puzzle_input)
