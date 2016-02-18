require 'pry'

class Node
  attr_accessor :is_word, :children, :weight # :frag_weight

  def initialize(is_word = false)
    @is_word  = is_word
    @children = {}
    @weight   = 0
    # @frag_weight = {}
  end

end

if __FILE__ == $0
  node = Node.new(true)
  puts node.is_word
end
