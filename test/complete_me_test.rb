require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test

  def setup
    @trie = CompleteMe.new
  end

  def test_trie_initializes_with_root_node
    submitted = @trie.root

    assert_equal false, submitted.is_word
  end

  def test_insert_can_insert_one_char_word
    skip
    @trie.insert("i")
    submitted = @trie.root.children.count
    expected  = 1

    assert_equal expected, submitted
  end

  def test_insert_can_set_is_word_to_true
    # skip
    @trie.insert("i")
    submitted = @trie.root.children.values.first.is_word
    expected  = true

    assert_equal expected, submitted
  end

  def test_insert_can_insert_one_word
    skip
    @trie.insert("hi")
    submitted = @trie.root.children.count
    expected  = 1

    assert_equal expected, submitted
  end

  def test_insert_can_insert_two_words_with_same_starting_char
    # skip
    @trie.insert("hi")
    @trie.insert("ho")
    submitted = @trie.root.children.values.first.children.count
    expected  = 2

    assert_equal expected, submitted
  end

  def test_insert_larger_words_with_same_starting_char
    skip
    @trie.insert("house")
    @trie.insert("hope")
    submitted = @trie.root.children.values.first.children.count
    expected  = 2

    assert_equal expected, submitted
  end

end
