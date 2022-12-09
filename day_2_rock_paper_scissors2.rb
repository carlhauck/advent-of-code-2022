OUTCOMES = {
  A: { # rock
    X: 3, # loss w/ scissors (0 + 3)
    Y: 4, # draw w/ rock (3 + 1)
    Z: 8, # win w/ paper (6 + 2)
  },
  B: { # paper
    X: 1, # loss w/ rock (0 + 1)
    Y: 5, # draw w/ paper (3 + 2)
    Z: 9, # win w/ scissors (6 + 3)
  },
  C: { # scissors
    X: 2, # loss w/ paper (0 + 2)
    Y: 6, # draw w/ scissors (3 + 3)
    Z: 7, # win w/ rock (6 + 1)
  }
}

def rock_paper_scissors(puzzle_input)
  total = 0

  puzzle_input.each do |line|
    letters = line.split(" ")
    opponent_tool = letters[0].to_sym
    needed_outcome = letters[1].to_sym
    total += OUTCOMES[opponent_tool][needed_outcome]
  end
  p total
end

puzzle_input = File.open("puzzle_inputs/day_2.txt").readlines(chomp: true)
rock_paper_scissors(puzzle_input)