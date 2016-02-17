require_relative 'node'
require 'pry'

class CompleteMe
  attr_reader :root

  def initialize
    @root = Node.new
  end

  def insert(word, count = 0, current = @root)
    unless current.children.keys.include?(word[count])
      if word[count] == word[-1]
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
    # returns # of nodes w/ is_word == true
  end
end
