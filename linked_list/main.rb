require_relative './lib/linked_list'

list = LinkedList.new

list.append('dog')
list.append('cat')
list.append('parrot')
list.append('hamster')
list.append('snake')
list.append('turtle')

puts list

# Optional extra tests:
list.prepend('rabbit')
puts list

list.insert_at('fish', 3)
puts list

list.remove_at(2)
puts list

puts "Size: #{list.size}"
puts "Contains 'cat'? #{list.contains?('cat')}"
puts "Index of 'snake': #{list.find('snake')}"
puts "Head: #{list.head_node.value}"
puts "Tail: #{list.tail.value}"

list.pop
puts list
