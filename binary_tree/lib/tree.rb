require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array)
    array = array.uniq.sort
    @root = build_tree(array)
  end

  # Build balanced BST recursively
  def build_tree(array)
    return nil if array.empty?

    mid = array.length / 2
    node = Node.new(array[mid])
    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[mid + 1..])
    node
  end

  # Insert a value
  def insert(value, node = @root)
    return Node.new(value) if node.nil?
    return node if node.data == value  # avoid duplicates

    if value < node.data
      node.left = insert(value, node.left)
    else
      node.right = insert(value, node.right)
    end
    node
  end

  # Delete a value
  def delete(value, node = @root)
    return nil if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      # Node found
      if node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      else
        # Node with two children: find inorder successor
        min_larger_node = find_min(node.right)
        node.data = min_larger_node.data
        node.right = delete(min_larger_node.data, node.right)
      end
    end
    node
  end

  def find_min(node)
    node = node.left while node.left
    node
  end

  # Find a node by value
  def find(value, node = @root)
    return nil if node.nil?
    return node if node.data == value

    value < node.data ? find(value, node.left) : find(value, node.right)
  end

  # Level-order traversal (BFS)
  def level_order(node = @root, &block)
    return [] if node.nil?
    queue = [node]
    result = []

    until queue.empty?
      current = queue.shift
      if block_given?
        yield current
      else
        result << current.data
      end
      queue << current.left if current.left
      queue << current.right if current.right
    end

    result unless block_given?
  end

  # Depth-first traversals
  def inorder(node = @root, &block)
    return [] if node.nil?
    result = inorder(node.left, &block)
    block_given? ? yield(node) : result << node.data
    result += inorder(node.right, &block)
  end

  def preorder(node = @root, &block)
    return [] if node.nil?
    result = []
    block_given? ? yield(node) : result << node.data
    result += preorder(node.left, &block)
    result += preorder(node.right, &block)
  end

  def postorder(node = @root, &block)
    return [] if node.nil?
    result = postorder(node.left, &block)
    result += postorder(node.right, &block)
    block_given? ? yield(node) : result << node.data
  end

  # Height of a node (edges to deepest leaf)
  def height(value, node = @root)
    node = find(value, node)
    return nil if node.nil?

    compute_height(node)
  end

  def compute_height(node)
    return -1 if node.nil? # leaf nodes height = 0 edges
    1 + [compute_height(node.left), compute_height(node.right)].max
  end

  # Depth of a node (edges from root)
  def depth(value, node = @root, current_depth = 0)
    return nil if node.nil?
    return current_depth if node.data == value

    if value < node.data
      depth(value, node.left, current_depth + 1)
    else
      depth(value, node.right, current_depth + 1)
    end
  end

  # Check if tree is balanced
  def balanced?(node = @root)
    return true if node.nil?

    left_height = compute_height(node.left)
    right_height = compute_height(node.right)

    (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)
  end

  # Rebalance the tree
  def rebalance
    values = inorder
    @root = build_tree(values)
  end

  # Pretty print
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
