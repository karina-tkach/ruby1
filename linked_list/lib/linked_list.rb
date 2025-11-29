require_relative 'node'

class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  # Add a node at the end
  def append(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
      return
    end

    current = @head
    current = current.next_node while current.next_node
    current.next_node = new_node
  end

  # Add a node at the start
  def prepend(value)
    @head = Node.new(value, @head)
  end

  # Returns the total number of nodes
  def size
    count = 0
    current = @head
    while current
      count += 1
      current = current.next_node
    end
    count
  end

  # Returns the first node
  def head_node
    @head
  end

  # Returns the last node
  def tail
    return nil if @head.nil?
    current = @head
    current = current.next_node while current.next_node
    current
  end

  # Returns node at index
  def at(index)
    current = @head
    i = 0
    while current
      return current if i == index
      current = current.next_node
      i += 1
    end
    nil
  end

  # Removes the last element
  def pop
    return if @head.nil?

    if @head.next_node.nil?
      @head = nil
      return
    end

    current = @head
    current = current.next_node while current.next_node.next_node
    current.next_node = nil
  end

  # Returns true if value exists
  def contains?(value)
    !!find(value)
  end

  # Returns index of value, nil if not found
  def find(value)
    current = @head
    index = 0
    while current
      return index if current.value == value
      current = current.next_node
      index += 1
    end
    nil
  end

  # Returns string representation
  def to_s
    str = ''
    current = @head
    while current
      str += "( #{current.value} ) -> "
      current = current.next_node
    end
    str + 'nil'
  end

  # Extra credit: insert at index
  def insert_at(value, index)
    if index == 0
      prepend(value)
      return
    end

    prev = at(index - 1)
    return unless prev

    new_node = Node.new(value, prev.next_node)
    prev.next_node = new_node
  end

  # Extra credit: remove at index
  def remove_at(index)
    return if @head.nil?

    if index == 0
      @head = @head.next_node
      return
    end

    prev = at(index - 1)
    return unless prev && prev.next_node

    prev.next_node = prev.next_node.next_node
  end
end
