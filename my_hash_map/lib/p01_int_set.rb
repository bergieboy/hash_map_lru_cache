class MaxIntSet

  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    store[num] = true
  end

  def remove(num)
    validate!(num)
    store[num] = false
  end

  def include?(num)
    store[num]
  end

  private

  attr_accessor :store

  def is_valid?(num) # is actually a number?
    !(num > @store.size || num < 0)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket_idx = (num % num_buckets)
    store[bucket_idx] << num unless include?(num)
  end

  def remove(num)
    store[num % num_buckets].delete(num)
  end

  def include?(num)
    store[num % num_buckets].each do |el|
      return true if el == num
    end
    false
  end

  private

  attr_reader :store

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % num_buckets
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if (count + 1) > num_buckets
    bucket_idx = (num % num_buckets)
    unless include?(num)
      store[bucket_idx] << num
      true
      @count += 1
    end
  end

  def remove(num)
    store[num % num_buckets].delete(num)
  end

  def include?(num)
    store[num % num_buckets].each do |el|
      return true if el == num
    end
    false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    resize_store = Array.new(num_buckets * 2) { [] }
    @store.each do |bucket|
      bucket.each do |el|
        resize_store[ el % resize_store.length ] << el
      end
    end
    @store = resize_store
  end
end
