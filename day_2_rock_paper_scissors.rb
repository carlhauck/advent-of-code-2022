TOOL_USE_POINTS = {
  X: 1, # rock
  Y: 2, # paper
  Z: 3, # scissors
}

OUTCOMES = {
  X: { # rock
    A: 3, # rock => draw
    B: 0, # paper => loss
    C: 6, # scissors => win
  },
  Y: { # paper
    A: 6, # rock => win
    B: 3, # paper => draw
    C: 0, # scissors => loss
  },
  Z: { # scissors
    A: 0, # rock => loss
    B: 6, # paper => win
    C: 3, # scissors => draw
  }
}

def rock_paper_scissors(puzzle_input)
  total = 0

  puzzle_input.each do |line|
    tools = line.split(" ")
    opponent_tool = tools[0].to_sym
    our_tool = tools[1].to_sym
    total += TOOL_USE_POINTS[our_tool]
    total += OUTCOMES[our_tool][opponent_tool]
  end
  p total
end

puzzle_input = File.open("puzzle_inputs/day_2.txt").readlines(chomp: true)
rock_paper_scissors(puzzle_input)