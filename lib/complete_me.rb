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

  def populate(words_string)
    words_string.split.each do |word|
      insert(word)
    end
  end

  def traverse(current = @root)
    # binding.pry
    collected = []
    until current.children == {}
      collected << current.children.keys
      current = current.children.flatten.last
    end
    collected
  end

  # fragment.shift - look for that element
  # chop
  # recursively go down - whenever you get to a true
  # add to possible word

  def traverse_to_fragment(frag, current = @root)
    # binding.pry
    until current.children.keys.include?(frag[-1])
      current = current.children.flatten.last
    end
    #current
    # current.children.values
    current.children.values.first.children
    # current.children.values.first.children.keys

    # if final_char's node.is_word == true, recommend
    # if final_char has children, for each child
    # => if child.is_word == true, recommend
    # else, store char and look at children.

  end

end
