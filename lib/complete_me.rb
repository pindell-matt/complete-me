require_relative 'node'
require 'pry'

class CompleteMe
  attr_reader :root, :count

  def initialize
    @root = Node.new
    @count = 0
  end

  def valid_submission(word)
    word == '' || word == " "
  end

  def insert(word)
    raise ArgumentError if word.class != String || valid_submission(word)
    chars = word.downcase.chars
    input_characters(chars)
  end

  def input_characters(chars, current = @root)
    if chars.empty?
      current.is_word = true
      @count += 1
    else
      char = chars.shift
      if current.children.has_key?(char)
        current = current.children.values_at(char).first
        input_characters(chars, current)
      else
        current.children[char] = Node.new
        current = current.children.values_at(char).first
        input_characters(chars, current)
      end
    end
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
    if current.children.keys.count > 1
      tails = follow_to_end(current)
      follow_to_end(current).each do |tail|
        if find(frag + tail)
          possible_matches << frag + tails[0]
        end
      end
    else
      match = frag + current.children.keys.first
      possible_matches << match
    end
    possible_matches
  end

  def follow_to_end(current)
    current.children.map do |child|
      child.first + child.last.children.keys.first
    end
  end

end
