require 'pry'

class Node
  attr_accessor :value
  attr_reader   :children

  def initialize(value = nil)
    @value = value
    @children = ('a'..'z').to_a
  end

end

if __FILE__ == $0
  node = Node.new(true)
  puts node.value
end
