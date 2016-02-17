require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/trie'

class TrieTest < Minitest::Test

  def setup
    @trie = Trie.new
  end

  def test_trie_initializes_with_word_as_nil
    submitted = @trie.word
    assert_nil submitted
  end

  def test_trie_initializes_with_children_array
    submitted = @trie.children
    expected  = 26

    assert_equal expected, submitted.count
    assert_kind_of Array, submitted 
  end

end
