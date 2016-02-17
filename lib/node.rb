require 'pry'

class Node
  attr_accessor :word
  attr_reader   :children

  def initialize(word = false)
    @word     = word
    @children = nil
  end

end

if __FILE__ == $0
  node = Node.new(true)
  puts node.word
end
