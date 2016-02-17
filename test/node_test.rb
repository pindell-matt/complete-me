require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/node'

class NodeTest < Minitest::Test

  def setup
    @node = Node.new
  end

  def test_node_initializes_with_value_as_nil
    submitted = @node.value
    assert_nil submitted
  end

  def test_node_initializes_with_children_array
    submitted = @node.children
    expected  = 26

    assert_equal expected, submitted.count
    assert_kind_of Array, submitted
  end

end
