require_relative 'node'
require 'pry'

class CompleteMe
  attr_reader :root, :count

  def initialize
    @root = create_node
    @count = 0
  end

  def create_node
    Node.new
  end

  def invalid_submission(word)
    word == '' || word == " "
  end

  def insert(word)
    raise ArgumentError if word.class != String || invalid_submission(word)
    chars = word.downcase.chars
    input_characters(chars)
  end

  def input_characters(chars, current = root)
    if chars.empty?
      current.is_word = true
      @count += 1
    else
      char = chars.shift
      if current.children.has_key?(char)
        current = current.children.values_at(char).first
        input_characters(chars, current)
      else
        current.children[char] = create_node
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

  def is_word?(word)
    search_trie_for_string(word).is_word
  end

  def search_trie_for_string(string, current = root)
    string.chars.each do |char|
      if current.children.has_key?(char)
        current = current.children.values_at(char).first
      end
    end
    current
  end

  def suggest(frag, current = root)
    path_to = search_trie_for_string(frag)

    matches = []
    build = ''

    next_char = char_key_and_word_status_pairs(path_to)
    if next_char.count > 1
      next_char.each do |pair|
        compile_suggestions(frag, matches, build, pair, path_to)
      end
    end
    matches.select { |match| is_word?(match) }
  end

  def compile_suggestions(frag, matches, build, pair, current)
    unless pair[1] == true
      build += pair[0]
      current = current.children.values_at(pair[0]).first
      next_pair = char_key_and_word_status_pairs(current).first
      compile_suggestions(frag, matches, build, next_pair, current)
    end
    matches << frag + build + pair[0]
  end

  def char_key_and_word_status_pairs(current = root)
    pair = []
    current.children.keys.each do |key|
      pair << [key, current.children.values_at(key).first.is_word]
    end
    pair
  end

end
