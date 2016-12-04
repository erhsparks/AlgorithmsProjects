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
    return nil unless node
    return node if node.value == value

    case value <=> node.value
    when -1, 0
      self.find!(node.left, value)
    else
      self.find!(node.right, value)
    end
  end

  def self.preorder!(node)

  end

  def self.inorder!(node)

  end

  def self.postorder!(node)

  end

  def self.height!(node)
    return -1 unless node
    return 0 unless node.left || node.right

    left = self.height!(node.left) + 1
    right = self.height!(node.right) + 1

    left >= right ? left : right
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
    return nil unless node

    if node.left
      node.left = self.delete_min!(node.left)

      node
    else
      node.right
    end
  end

  def self.delete!(node, value)
    return nil unless node

    case value <=> node.value
    when -1
      node.left = self.delete!(node.left, value)

      node
    when 0
      node.right
    when 1
      node.right = self.delete!(node.right, value)

      node
    end
  end
end
