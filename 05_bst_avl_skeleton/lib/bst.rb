class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize

  end

  def insert(value)

  end

  def find(value)

  end

  def inorder

  end

  def postorder

  end

  def preorder

  end

  def height

  end

  def min

  end

  def max

  end

  def delete(value)

  end

  def self.insert!(node, value)
    return BSTNode.new(value) if node.nil?

    case value <=> node.value
    when -1, 0
      left = self.insert!(node.left, value)
      node.left ||= left
    else
      right = self.insert!(node.right, value)
      node.right ||= right
    end

    node
  end

  def self.find!(node, value)

  end

  def self.preorder!(node)

  end

  def self.inorder!(node)

  end

  def self.postorder!(node)

  end

  def self.height!(node)

  end

  def self.max(node)
    return nil unless node

    self.max(node.right) || node
  end

  def self.min(node)
    return nil unless node

    self.min(node.left) || node
  end

  def self.delete_min!(node)

  end

  def self.delete!(node, value)

  end
end
