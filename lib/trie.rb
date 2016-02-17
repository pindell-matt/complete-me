require 'pry'

class Trie
  attr_accessor :word
  attr_reader   :children

  def initialize(word = nil)
    @word = word
    @children = ('a'..'z').to_a
  end

end

if __FILE__ == $0
  trie = Trie.new(true)
  puts trie.word
end
