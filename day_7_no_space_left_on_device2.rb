class TreeNode
  attr_accessor :value, :children, :parent, :dir, :file, :size

  def initialize(value, children: [], parent: nil, dir: false, file: false, size: nil)
    @value = value
    @children = children
    @parent = parent
    @dir = dir
    @file = file
    @size = size
  end

  def root?
    @parent.nil?
  end

  def find_child(value)
    @children.select { |child| child.value == value }.first
  end

  def sibling_dirs
    @parent.children.select(&:dir)
  end

  def root
    return self if root?

    @parent.root
  end

  def dir_size
    total = @children.select(&:file).map(&:size).sum
    total += @children.select(&:dir).map(&:dir_size).sum
    total
  end
end

class Tree
  attr_accessor :directory_sizes

  def initialize
    @directory_sizes = {}
  end
end

def no_space_left_on_device(puzzle_input)
  current = nil

  puzzle_input.each_with_index do |line, _index|
    if line.start_with?('$')
      command = line.split(' ')
      if command[1] == 'cd'
        current = if command[2] == '..'
                    current.parent
                  elsif current.nil?
                    TreeNode.new(command[2])
                  else
                    current.find_child(command[2])
                  end
      end
    else
      item = line.split(' ')
      current.children << if item[0] == 'dir'
                            TreeNode.new(item[1], parent: current, dir: true)
                          else
                            TreeNode.new(item[1], parent: current, file: true, size: item[0].to_i)
                          end
    end
  end

  directory_sizes = Tree.new.directory_sizes
  find_directory_sizes(current.root, directory_sizes)

  total_disk_space = 70_000_000
  used_space = current.root.dir_size
  free_space = total_disk_space - used_space
  wanted_free_space = 30_000_000
  target = wanted_free_space - free_space

  p directory_sizes.select { |_k, v| v >= target }.values.sort.first
end

def find_directory_sizes(node, directory_sizes)
  # ridiculous key name to prevent overwriting when multiple directories have same name
  directory_sizes["#{node.value}#{node.parent}#{node.children.length}#{node.dir_size}"] = node.dir_size
  return if node.children.empty?

  node.children.select(&:dir).each do |child|
    find_directory_sizes(child, directory_sizes)
  end
end

puzzle_input = File.open('puzzle_inputs/day_7.txt').readlines(chomp: true)
no_space_left_on_device(puzzle_input)
