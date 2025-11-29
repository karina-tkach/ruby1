class HashMap
  attr_reader :capacity, :load_factor

  def initialize(load_factor: 0.75, initial_capacity: 16)
    @load_factor = load_factor
    @capacity = initial_capacity
    @buckets = Array.new(@capacity) { [] } # Each bucket holds an array of [key, value] pairs
    @size = 0
  end

  # Hash function for string keys
  def hash(key)
    raise TypeError, 'Key must be a string' unless key.is_a?(String)

    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  # Returns bucket index
  def index_for(key)
    idx = hash(key) % @capacity
    raise IndexError if idx.negative? || idx >= @buckets.length
    idx
  end

  # Set or update a key/value
  def set(key, value)
    idx = index_for(key)
    bucket = @buckets[idx]

    # Update value if key exists
    bucket.each { |pair| if pair[0] == key; pair[1] = value; return; end }

    # Add new key/value
    bucket << [key, value]
    @size += 1

    # Resize if load factor exceeded
    resize if @size.to_f / @capacity > @load_factor
  end

  # Get value for key
  def get(key)
    idx = index_for(key)
    bucket = @buckets[idx]
    pair = bucket.find { |k, _| k == key }
    pair ? pair[1] : nil
  end

  # Check if key exists
  def has?(key)
    !!get(key)
  end

  # Remove key/value
  def remove(key)
    idx = index_for(key)
    bucket = @buckets[idx]
    pair_idx = bucket.index { |k, _| k == key }
    return nil unless pair_idx

    value = bucket[pair_idx][1]
    bucket.delete_at(pair_idx)
    @size -= 1
    value
  end

  # Return number of stored keys
  def length
    @size
  end

  # Remove all entries
  def clear
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  # Return all keys
  def keys
    @buckets.flat_map { |bucket| bucket.map(&:first) }
  end

  # Return all values
  def values
    @buckets.flat_map { |bucket| bucket.map(&:last) }
  end

  # Return all entries
  def entries
    @buckets.flat_map { |bucket| bucket.map(&:dup) }
  end

  private

  # Resize bucket array when load factor exceeded
  def resize
    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity) { [] }
    @size = 0

    old_buckets.each do |bucket|
      bucket.each { |key, value| set(key, value) }
    end
  end
end
