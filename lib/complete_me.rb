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
      end
    end
    current.is_word
  end

  def traverse_to_frag(frag, current = @root)
    possible_matches = []
    frag.chars.each do |char|
      if current.children.has_key?(char)
        current = current.children.values_at(char).first
      end
    end
    if current.children.keys.count == 1
      match = frag + current.children.keys.first
      possible_matches << match
    end
    possible_matches
  end

  def traverse_to_fragment(frag, current = @root)
    until current.children.keys.include?(frag[-1])
      current = current.children.flatten.last
    end
    # current.children.values.first.children
    current.children.values.first
  end

  def find_possible_endings(frag)
    reccommend = []
    start = traverse_to_fragment(frag)
    if start.is_word
      reccommend << start
    elsif start.children
      binding.pry
    else
      binding.pry

    end

  end

end
