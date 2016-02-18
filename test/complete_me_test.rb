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
    one_char_word = 'i'
    @trie.insert(one_char_word)
    submitted = @trie.find(one_char_word)

    assert submitted
  end

  def test_insert_rejects_empty_string
    assert_raises ArgumentError do
      @trie.insert('')
    end
  end

  def test_insert_rejects_space_only_string
    assert_raises ArgumentError do
      @trie.insert(' ')
    end
  end

  def test_insert_rejects_non_string
    assert_raises ArgumentError do
      @trie.insert([/[d+]/])
    end
  end

  def test_insert_can_sets_properly_flags_one_char_word
    # skip
    @trie.insert('i')
    submitted = @trie.root.children.values.first.is_word
    expected  = true

    assert_equal expected, submitted
  end

  def test_insert_can_insert_two_char_word
    # skip
    word = 'hi'
    @trie.insert(word)
    submitted = @trie.find(word)

    assert submitted
  end

  def test_insert_flags_second_char_as_word
    # # skip
    word = 'hi'
    @trie.insert(word)
    first_char  = @trie.root.children.values.first.is_word
    second_char = @trie.root.children.values.first.children.values.first.is_word

    refute first_char
    assert second_char
  end

  def test_insert_can_insert_two_words_with_same_starting_char
    # skip
    @trie.insert("hi")
    @trie.insert("ho")
    submitted = @trie.root.children.values_at("h").first.children.count
    expected  = 2

    assert_equal expected, submitted
  end

  def test_insert_larger_words_with_same_starting_char
    # skip
    @trie.insert("house")
    @trie.insert("hope")
    submitted = @trie.root.children.values_at("h").first.children.values_at("o").first.children.count
    expected  = 2

    assert_equal expected, submitted
  end

  def test_trie_count_returns_tries_total_word_count
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

  def test_trie_can_confirm_words_with_find
    # skip
    @trie.insert("hey")
    @trie.insert("hello")
    included_word     = @trie.find("hello")
    not_included_word = @trie.find("nope")

    assert included_word
    refute not_included_word
  end

  def test_trie_can_be_populated_with_dicionary
    skip
    dictionary = File.read("/usr/share/dict/words")
    @trie.populate(dictionary)
    submitted = @trie.count
    expected  = 235886

    assert_equal expected, submitted
  end

  def test_trie_suggest
    # skip
    @trie.insert("skelter")
    submitted = @trie.suggest("skelte")
    expected  = ["skelter"]

    assert_equal expected, submitted
  end

  def test_trie_can_recieve_fragment
    skip
    @trie.insert("hello")
    @trie.insert("helter")
    @trie.insert("skelter")
    submitted = @trie.traverse_to_frag("hel")
    expected  = ["hello", "helter"]

    assert_equal expected, submitted
  end

end
