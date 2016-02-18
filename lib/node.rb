require 'pry'

class Node
  attr_accessor :is_word, :children, :weight

  def initialize(is_word = false)
    @is_word  = is_word
    @children = {}
    @weight   = 0
  end

end

if __FILE__ == $0
  node = Node.new(true)
  puts node.is_word
end
