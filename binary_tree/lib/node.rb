class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    return nil unless other.is_a?(Node)
    @data <=> other.data
  end
end
