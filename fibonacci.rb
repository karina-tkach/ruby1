# Iterative Fibonacci
def fibs(n)
  return [] if n <= 0
  return [0] if n == 1

  fibs_array = [0, 1]

  (n - 2).times do
    fibs_array << fibs_array[-1] + fibs_array[-2]
  end

  fibs_array
end


# Recursive Fibonacci
def fibs_rec(n)
  puts "This was printed recursively"

  return [] if n <= 0
  return [0] if n == 1
  return [0, 1] if n == 2

  # build smaller result first
  arr = fibs_rec(n - 1)
  arr << arr[-1] + arr[-2]
end


# Tests
puts "fibs(8): #{fibs(8).inspect}"
puts "fibs_rec(8): #{fibs_rec(8).inspect}"
