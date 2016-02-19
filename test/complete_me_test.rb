require 'simplecov'
SimpleCov.start
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
    one_char_word = 'i'
    @trie.insert(one_char_word)
    submitted = @trie.is_word?(one_char_word)

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

  def test_insert_can_sets_properly_flags_one_char_word
    @trie.insert('i')
    submitted = @trie.root.children.values.first.is_word
    expected  = true

    assert_equal expected, submitted
  end

  def test_insert_can_insert_two_char_word
    word = 'hi'
    @trie.insert(word)
    submitted = @trie.is_word?(word)

    assert submitted
  end

  def test_insert_flags_second_char_as_word
    word = 'hi'
    @trie.insert(word)
    first_char  = @trie.root.children.values.first.is_word
    second_char = @trie.root.children.values.first.children.values.first.is_word

    refute first_char
    assert second_char
  end

  def test_insert_can_insert_two_words_with_same_starting_char
    @trie.insert("hi")
    @trie.insert("ho")
    submitted = @trie.root.children.values_at("h").first.children.count
    expected  = 2

    assert_equal expected, submitted
  end

  def test_insert_larger_words_with_same_starting_char
    @trie.insert("house")
    @trie.insert("hope")
    submitted = @trie.root.children.values_at("h").first.children.values_at("o").first.children.count
    expected  = 2

    assert_equal expected, submitted
  end

  def test_trie_count_returns_tries_total_word_count
    @trie.insert("i")
    submitted = @trie.count
    expected  = 1

    assert_equal expected, submitted
  end

  def test_trie_with_two_word_has_count_of_two
    @trie.insert("i")
    @trie.insert("hi")
    submitted = @trie.count
    expected  = 2

    assert_equal expected, submitted
  end

  def test_trie_with_three_words_has_count_of_three
    @trie.insert("i")
    @trie.insert("hi")
    @trie.insert("hey")
    submitted = @trie.count
    expected  = 3

    assert_equal expected, submitted
  end

  def test_trie_with_multiple_words
    @trie.insert("hi")
    @trie.insert("hey")
    @trie.insert("hello")
    @trie.insert("helter")
    @trie.insert("helsinki")
    submitted = @trie.count
    expected  = 5

    assert_equal expected, submitted
  end

  def test_trie_does_not_count_duplicate_entries
    @trie.insert("i")
    @trie.insert("hi")
    @trie.insert("hey")
    @trie.insert("hey")
    @trie.insert("hi")
    submitted = @trie.count
    expected  = 3

    assert_equal expected, submitted
  end

  def test_trie_can_confirm_words_with_is_word?
    @trie.insert("hey")
    @trie.insert("hello")
    included_word     = @trie.is_word?("hello")
    not_included_word = @trie.is_word?("nope")

    assert included_word
    refute not_included_word
  end

  def test_trie_can_be_populated_with_words
    dictionary = "A a aa aal aalii aam Aani aardvark aardwolf Aaron"
    dictionary.split.each do |word|
      @trie.insert(word)
    end
    submitted = @trie.count
    expected  = 10

    assert_equal expected, submitted
  end

  def test_trie_can_be_populated_with_dicionary
    dictionary = File.read("/usr/share/dict/words")
    @trie.populate(dictionary)
    submitted = @trie.count
    expected  = 235886

    assert_equal expected, submitted
  end

  def test_trie_suggest_final_char
    @trie.insert("skelter")
    submitted = @trie.suggest("skelte")
    expected  = ["skelter"]

    assert_equal expected, submitted
  end

  def test_trie_suggest_final_two_chars
    @trie.insert("hello")
    @trie.insert("helter")
    submitted = @trie.suggest("helt")
    expected  = ["helter"]

    assert_equal expected, submitted
  end

  def test_trie_suggest_chars
    @trie.insert("hello")
    @trie.insert("helter")
    @trie.insert("skelter")
    submitted = @trie.suggest("hel")
    expected  = ["hello", "helter"]

    assert_equal expected, submitted
  end

  def test_trie_suggest_three_words
    @trie.insert("hello")
    @trie.insert("helter")
    @trie.insert("skelter")
    @trie.insert("helsinki")
    submitted = @trie.suggest("hel")
    expected  = ["hello", "helter", "helsinki"]

    assert_equal expected, submitted
  end

  def test_trie_suggest_two_suggestions
    @trie.insert("hello")
    @trie.insert("helter")
    @trie.insert("skelter")
    @trie.insert("helsinki")
    @trie.insert("skeleton")
    first_suggest  = @trie.suggest("hel")
    first_result   = ["hello", "helter", "helsinki"]

    second_suggest = @trie.suggest("skel")
    second_result  = ["skelter", "skeleton"]

    assert_equal first_result, first_suggest
    assert_equal second_result, second_suggest
  end

  def test_trie_dictionary_suggestions
    dictionary = File.read("/usr/share/dict/words")
    @trie.populate(dictionary)
    submitted = @trie.suggest('piz')
    expected  = ["pize", "pizza", "pizzeria", "pizzicato", "pizzle"]

    assert_equal expected, submitted
  end

  def test_trie_select_orders_suggestions_by_weight
    @trie.insert("hello")
    @trie.insert("helter")
    @trie.insert("skelter")
    @trie.insert("helsinki")
    @trie.insert("skeleton")
    @trie.select("hel", "helsinki")
    @trie.select("hel", "hello")
    @trie.select("hel", "helsinki")
    submitted = @trie.suggest("hel")
    expected  = ["helsinki", "hello", "helter"]

    assert_equal expected, submitted
  end

  def test_trie_weight_is_dependant_on_fragment
    @trie.insert("hello")
    @trie.insert("helter")
    @trie.insert("helsinki")
    @trie.select("hel", "helsinki")
    @trie.select("hel", "helsinki")
    @trie.select("hel", "helsinki")

    @trie.select("he", "hello")
    @trie.select("he", "hello")
    @trie.select("he", "helsinki")

    submitted = @trie.suggest("hel")
    expected  = ["helsinki", "hello", "helter"]

    assert_equal expected, submitted

    submitted = @trie.suggest("he")
    expected  = ["hello", "helsinki", "helter"]

    assert_equal expected, submitted
  end

end
