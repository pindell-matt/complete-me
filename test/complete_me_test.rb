require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test

  def setup
    @trie = CompleteMe.new
  end

  def test_trie_initializes_with_root_node_as_false
    submitted = @trie.root

    assert_equal false, submitted.is_word
  end

  def test_root_node_initially_has_no_children
    submitted = @trie.root.children.count
    expected = 0

    assert_equal expected, submitted
  end

  def test_insert_can_insert_one_char_word
    # skip
    @trie.insert("i")
    submitted = @trie.root.children.count
    expected  = 1

    assert_equal expected, submitted
  end

  def test_insert_can_sets_complete_word_to_true
    # skip
    @trie.insert("i")
    submitted = @trie.root.children.values.first.is_word
    expected  = true

    assert_equal expected, submitted
  end

  def test_insert_can_insert_two_char_word
    # skip
    @trie.insert("hi")
    submitted = @trie.root.children.count
    expected  = 1

    assert_equal expected, submitted
  end

  def test_insert_sets_first_char_as_false_second_char_as_true
    # skip
    @trie.insert("hi")
    first_char  = @trie.root.children.values.first.is_word
    second_char = @trie.root.children.values.first.children.values.first.is_word

    refute first_char
    assert second_char
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
    # skip
    @trie.insert("house")
    @trie.insert("hope")
    submitted = @trie.root.children.values.first.children.values.first.children.count
    expected  = 2

    assert_equal expected, submitted
  end

  def test_trie_with_one_word_has_count_of_one
    # skip
    @trie.insert("i")
    submitted = @trie.count
    expected  = 1

    assert_equal expected, submitted
  end

  def test_trie_with_two_word_has_count_of_two
    # skip
    @trie.insert("i")
    @trie.insert("hi")
    submitted = @trie.count
    expected  = 2

    assert_equal expected, submitted
  end

  def test_trie_with_two_word_has_count_of_three
    # skip
    @trie.insert("i")
    @trie.insert("hi")
    @trie.insert("hey")
    submitted = @trie.count
    expected  = 3

    assert_equal expected, submitted
  end

  def test_trie_traversal
    # skip
    @trie.insert("hey")
    @trie.insert("hello")
    @trie.find("hey")
    binding.pry
    @trie.traverse_to_fragment("he")
    submitted = @trie.count
    expected  = 3

    assert_equal expected, submitted
  end

end
