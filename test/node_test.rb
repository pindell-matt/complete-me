require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/node'

class NodeTest < Minitest::Test

  def setup
    @node = Node.new
  end

  def test_node_initializes_with_word_as_false
    submitted = @node.word
    
    assert_equal false, submitted
  end

  def test_node_initializes_with_children_as_nil
    submitted = @node.children

    assert_equal nil, submitted
  end

end
