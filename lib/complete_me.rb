require_relative 'node'
require 'pry'

class CompleteMe
  attr_reader :root

  def initialize
    @root = Node.new
  end

  def insert(word, count = 0, current = @root)
    unless current.children.any? { |child| child.keys.include?(word[count]) }
      current.children << { word[count] => Node.new }
      if word[count] == word[-1]
        current.children.select {|child| child.keys.include?( word[count])}.first.values.first.is_word = true
      end
    end
    count += 1
    if word[count] != nil
      insert(word, count, (current.children.select { |child| child.keys.include?( word[count - 1] ) }.first.values.first))
    end
  end
end
