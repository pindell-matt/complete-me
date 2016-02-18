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
    @count += 1
    raise ArgumentError if word.class != String || invalid_submission(word)
    chars = word.downcase.chars
    input_characters(chars)
  end

  def input_characters(chars, current = root)
    if chars.empty?
      current.is_word = true
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
    matches = []
    if is_word?(frag)
      matches << frag
    end
    build = ''
    path_to = search_trie_for_string(frag)
    stage_one(frag, matches, build, path_to)

    qualified = matches.select { |match| is_word?(match.first) }.uniq

    if qualified.any? { |match| match.last > 0 }
      weighted = qualified.uniq.sort_by { |match| match.last }.reverse
      weighted.flatten.delete_if { |word| word.class != String }
    else
      qualified.flatten.delete_if { |word| word.class != String }
    end
  end

  def stage_one(frag, matches, build, current)
    next_char = char_key_and_word_status_pairs(current)
    next_char.each do |pair|
      compile_suggestions(frag, matches, build, pair, current)
    end
  end

  def compile_suggestions(frag, matches, build, pair, current)
    if pair[1] == true
      matches << [frag + pair[0], pair.last]
    else
      build += pair[0]
      current = current.children.values_at(pair[0]).first
      stage_one(frag, matches, build, current)
    end
    matches << [frag + build + pair[0], pair.last]
  end

  def char_key_and_word_status_pairs(current = root)
    pair = []
    current.children.keys.each do |key|
      path = current.children.values_at(key).first
      pair << [key, path.is_word, path.weight]
    end
    pair
  end

  def select(frag, selected)
    search_trie_for_string(selected).weight += 1
    # hash and increment?
  end

end

if __FILE__ == $0
  # Breakdown Example of Basic Interaction Model
  completion = CompleteMe.new
  completion.insert("pizza")
  puts completion.count
  # => 1
  pp completion.suggest("piz")
  # => ["pizza"]
  dictionary = File.read("/usr/share/dict/words")
  completion.populate(dictionary)
  puts completion.count
  # => 235886
  # => currently: 235887
  # => currently: 228069
  pp completion.suggest("piz")
  # => ["pizza", "pizzeria", "pizzicato"]
  # => currently: ["pizza", "pize"]
end
