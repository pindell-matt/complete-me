require_relative 'node'
require 'pry'

class CompleteMe
  attr_reader :root, :word_count

  def initialize
    @root = Node.new
    @word_count = 0
  end

  def insert(word, count = 0, current = @root)
    i = 0
    while i < (word.length)
      if current.children.has_key?(word[i])
        current = current.children.values_at(word[i]).first
        i += 1
      else
        break
      end
    end

    while i < (word.length)
      current.children[word[i]] = Node.new
      current = current.children.values_at(word[i]).first
      i += 1
    end
    current.is_word = true
    @word_count += 1
  end

  def count
    @word_count
  end

  def populate(words_string)
    words_string.split.each do |word|
      insert(word)
    end
  end

  def find(word, current = @root)
    word.chars.each do |char|
      if current.children.has_key?(char)
        current = current.children.values_at(char).first
      else
        "nope"
      end
    end
    current.is_word
  end

  def traverse(current = @root)
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
    until current.children.keys.include?(frag[-1])
      current = current.children.flatten.last
    end
    #current
    # current.children.values
    current.children.values.first.children

    # if final_char's node.is_word == true, recommend
    # if final_char has children, for each child
    # => if child.is_word == true, recommend
    # else, store char and look at children.

  end

end
