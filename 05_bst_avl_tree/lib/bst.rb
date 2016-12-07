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
    @root = nil
  end

  def insert(value)
    if @root
      BinarySearchTree.insert!(@root, value)
    else
      @root = BSTNode.new(value)
    end
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    BinarySearchTree.delete!(@root, value)
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
    return [] unless node

    left = self.preorder!(node.left)
    right = self.preorder!(node.right)

    [node.value] + left + right
  end

  def self.inorder!(node)
    return [] unless node

    left = self.inorder!(node.left)
    right = self.inorder!(node.right)

    left + [node.value] + right
  end

  def self.postorder!(node)
    return [] unless node

    left = self.postorder!(node.left)
    right = self.postorder!(node.right)

    left + right + [node.value]
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
