require 'pry'
def cathode_ray_tube(puzzle_input)
  @crt_pixels = []
  @crt_line = []
  x = 1
  cycle = 1
  index = 0

  puzzle_input.each do |line|
    if line == "noop"
      draw_pixel(x)
      cycle += 1
    else
      draw_pixel(x)
      cycle += 1
      draw_pixel(x)
      x += line.split(" ")[1].to_i
      cycle += 1
    end
  end

  @crt_pixels.each do |line|
    puts line.join
  end
end

def draw_pixel(x)
  position = @crt_line.length
  pixel = (position <= (x + 1) && position >= (x - 1)) ? "#" : "."
  @crt_line << pixel
  if position == 39
    @crt_pixels << @crt_line
    @crt_line = []
  end
end

puzzle_input = File.open("puzzle_inputs/day_10.txt").readlines(chomp: true)
cathode_ray_tube(puzzle_input)