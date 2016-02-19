require 'pry'

class Node
  attr_accessor :is_word, :children, :weights

  def initialize(is_word = false)
    @is_word  = is_word
    @children = Hash.new {|hash, key| hash[key] = Node.new}
    @weights  = Hash.new(0)
  end

  def insert(chars)
    char = chars.shift
    if chars.empty?
      children[char] = Node.new(true)
    else
      children[char].insert(chars)
    end
  end

  def count
    sum = 0
    children.each do |letter, node|
      sum += node.count
    end
    sum += 1 if is_word?
    sum
  end

  def is_word?
    is_word
  end

  def search(chars)
    char = chars.shift
    if chars.empty?
      children[char]
    else
      children[char].search(chars)
    end
  end

end

if __FILE__ == $0
  node = Node.new(true)
  puts node.is_word
end
