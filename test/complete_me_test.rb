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

    assert_equal false, submitted.word
  end



end
