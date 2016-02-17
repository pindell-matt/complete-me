require_relative 'node'
require 'pry'

class CompleteMe
  attr_reader :root

  def initialize
    @root = Node.new
  end

  def insert(word, count = 0, current = @root)
    unless current.children.nil?
      if word[count] == word[-1]
        current.children = {word[count] => Node.new(true)}
      else
        current.children = {word[count] => Node.new}
      end
    end
    count += 1
    # binding.pry
    if word[count] != nil
      insert(word, count, current.children.values.first)
    end
  end
end
