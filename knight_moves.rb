def knight_moves(start_pos, end_pos)
  # All possible knight moves
  moves = [
    [2, 1], [1, 2], [-1, 2], [-2, 1],
    [-2, -1], [-1, -2], [1, -2], [2, -1]
  ]

  # Check if position is on the board
  valid = ->(x, y) { x.between?(0, 7) && y.between?(0, 7) }

  # BFS setup
  queue = [[start_pos]] # queue of paths
  visited = Array.new(8) { Array.new(8, false) }
  visited[start_pos[0]][start_pos[1]] = true

  while !queue.empty?
    path = queue.shift
    current = path[-1]

    return path if current == end_pos

    moves.each do |dx, dy|
      next_pos = [current[0] + dx, current[1] + dy]
      next unless valid.call(*next_pos)
      next if visited[next_pos[0]][next_pos[1]]

      visited[next_pos[0]][next_pos[1]] = true
      queue << path + [next_pos]
    end
  end
end

# Print nicely
def display_knight_moves(start_pos, end_pos)
  path = knight_moves(start_pos, end_pos)
  puts "You made it in #{path.length - 1} moves! Here's your path:"
  path.each { |pos| p pos }
end


display_knight_moves([0,0],[1,2])

display_knight_moves([0,0],[3,3])

display_knight_moves([3,3],[0,0])

display_knight_moves([0,0],[7,7])

display_knight_moves([3,3],[4,3])