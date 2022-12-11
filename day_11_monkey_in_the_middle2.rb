MONKEYS = {}

class Monkey
  attr_accessor :starting_items, :operator, :operation_number, :test, :true_destination, :false_destination, :inspection_count
  def initialize(starting_items, operation, test, true_destination, false_destination)
    @starting_items = starting_items
    @operator = operation[0]
    @operation_number = operation[1].to_i
    @test = test
    @true_destination = true_destination
    @false_destination = false_destination
    @inspection_count = 0
  end

  def inspect_items(tests_product)
    return if starting_items.empty?
    @inspection_count += starting_items.length
    starting_items.each do |item|
      item = calculate_new_worry_level(item)
      destination = (item % test == 0) ? true_destination : false_destination
      # congruence to a fixed modulus is preserved by addition and multiplication,
      # hence the multiplication of the "divisible_by" test numbers
      MONKEYS[destination].starting_items << item % tests_product
    end
    @starting_items = []
  end

  def calculate_new_worry_level(item)
    @cache ||= {}
    @cache[item] ||= begin
      operation_number = @operation_number == 0 ? item : @operation_number
      operator == "+" ? item + operation_number : item * operation_number
    end
  end
end

def monkey_in_the_middle(puzzle_input)
  tests = []
  monkey_arrays = puzzle_input.map(&:strip).reject(&:empty?).each_slice(6).to_a
  monkey_arrays.each_with_index do |m, index|
    starting_items = m[1][16..-1].split(", ").map(&:to_i)
    operation = m[2][21..-1].split(" ")
    test = m[3].split(" ")[-1].to_i
    tests << test
    true_destination = m[4].split(" ")[-1].to_i
    false_destination = m[5].split(" ")[-1].to_i
    MONKEYS[index] = Monkey.new(starting_items, operation, test, true_destination, false_destination)
  end
  tests_product = tests.reduce(&:*)
  
  10000.times do
    MONKEYS.each { |k,v| v.inspect_items(tests_product) }
  end
  p MONKEYS.map {|k,v| v.inspection_count}.sort[-2..-1].reduce(&:*)
end

puzzle_input = File.open("puzzle_inputs/day_11.txt").readlines(chomp: true)
monkey_in_the_middle(puzzle_input)