require_relative 'node'
require 'pry'

class CompleteMe
  attr_reader :root

  def initialize
    @root = create_node
  end

  def create_node
    Node.new
  end

  def invalid_submission(word)
    word.class != String || word.empty?
  end

  def insert(word)
    word.strip!
    raise ArgumentError if invalid_submission(word)
    chars = word.chars
    root.insert(chars)
  end

  def count
    root.count
  end

  def populate(words_string)
    words_string.split.each do |word|
      insert(word)
    end
  end

  def is_word?(word)
    search_trie(word).is_word
  end

  def search_trie(string)
    chars = string.chars
    root.search(chars)
  end

  def suggest(frag)
    matches = []
    matches << frag if is_word?(frag)
    build = ''
    path_to = search_trie(frag)
    stage_one(frag, matches, build, path_to)
    matches_cleanup(matches)
  end

  def matches_cleanup(matches)
    qualified = matches.select { |match| is_word?(match.first) }.uniq
    if qualified.any? { |match| match.last > 0 }
      weighted = qualified.sort_by { |match| -match.last }
      weighted.flatten.delete_if { |word| word.class != String }
    else
      qualified.flatten.delete_if { |word| word.class != String }
    end
  end

  def stage_one(frag, matches, build, current)
    next_char = char_key_and_word_status_pairs(frag, current)
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

  def char_key_and_word_status_pairs(frag, current = root)
    pair = []
    current.children.keys.each do |key|
      path = current.children.values_at(key).first
      pair << [key, path.is_word, path.weights[frag]]
    end
    pair
  end

  def select(frag, selected)
    search_trie(selected).weights[frag] += 1
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
  pp completion.suggest("piz")
end
