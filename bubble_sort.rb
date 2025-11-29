def bubble_sort(array)
  n = array.length

  loop do
    swapped = false

    # go through the array and swap adjacent pairs
    (0...(n - 1)).each do |i|
      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        swapped = true
      end
    end

    # if no swaps happened, array is sorted
    break unless swapped
  end

  array
end

print bubble_sort([4,3,78,2,0,2])