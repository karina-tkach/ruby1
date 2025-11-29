require_relative 'lib/tree'

# Create tree with 15 random numbers
array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)

puts "Initial tree:"
tree.pretty_print
puts "Balanced? #{tree.balanced?}"

puts "Level-order: #{tree.level_order.inspect}"
puts "In-order: #{tree.inorder.inspect}"
puts "Pre-order: #{tree.preorder.inspect}"
puts "Post-order: #{tree.postorder.inspect}"

# Unbalance the tree by adding large numbers
[101, 102, 103, 104, 105].each { |num| tree.insert(num) }

puts "\nTree after inserting high values:"
tree.pretty_print
puts "Balanced? #{tree.balanced?}"

# Rebalance the tree
tree.rebalance
puts "\nTree after rebalancing:"
tree.pretty_print
puts "Balanced? #{tree.balanced?}"

puts "Level-order: #{tree.level_order.inspect}"
puts "In-order: #{tree.inorder.inspect}"
puts "Pre-order: #{tree.preorder.inspect}"
puts "Post-order: #{tree.postorder.inspect}"
