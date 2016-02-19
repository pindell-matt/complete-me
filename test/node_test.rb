require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/node'

class NodeTest < Minitest::Test

  def setup
    @node = Node.new
  end

  def test_node_initializes_with_word_as_false
    submitted = @node.is_word?

    assert_equal false, submitted
  end

  def test_node_initializes_with_children_as_empty_hash
    expected = {}
    submitted = @node.children

    assert_equal expected, submitted
  end

  def test_node_initializes_with_weights_as_empty_hash
    expected = {}
    submitted = @node.weights

    assert_equal expected, submitted
  end

end
