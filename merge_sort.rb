def merge_sort(arr)
  # Base cases:
  return arr if arr.length <= 1

  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..-1])

  merge(left, right)
end

def merge(left, right)
  sorted = []

  until left.empty? || right.empty?
    if left.first <= right.first
      sorted << left.shift
    else
      sorted << right.shift
    end
  end

  sorted + left + right
end


# Test Examples:
puts "merge_sort([]): #{merge_sort([]).inspect}"
puts "merge_sort([73]): #{merge_sort([73]).inspect}"
puts "merge_sort([1,2,3,4,5]): #{merge_sort([1,2,3,4,5]).inspect}"
puts "merge_sort([3, 2, 1, 13, 8, 5, 0, 1]): #{merge_sort([3,2,1,13,8,5,0,1]).inspect}"
puts "merge_sort([105, 79, 100, 110]): #{merge_sort([105,79,100,110]).inspect}"
