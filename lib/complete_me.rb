require_relative 'node'
require 'pry'

class CompleteMe
  attr_reader :root, :word_count

  def initialize
    @root = Node.new
    @word_count = 0
  end

  def insert(word, count = 0, current = @root)
    unless current.children.keys.include?(word[count])
      if word[count] == word[-1]
        @word_count += 1
        current.children[word[count]] = Node.new(true)
      else
        current.children[word[count]] = Node.new
      end
    end
    count += 1
    if word[count] != nil
      insert(word, count, current.children.fetch(word[count - 1]))
    end
  end

  def count
    @word_count
  end

  def traverse(current = @root)
    # binding.pry
    until current.children == {}
      current = current.children.flatten.last
    end
    current
  end

  def traverse_to_fragment(frag, current = @root)
    # binding.pry
    until current.children.keys.include?(frag[-1])
      current = current.children.flatten.last
    end
    current
  end

end
