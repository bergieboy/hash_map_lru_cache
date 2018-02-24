require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    num = key.hash
    resize! if (count + 1) > num_buckets
    unless include?(key)
      store[self[num]] << key
      true
      @count += 1
    end
  end

  def include?(key)
    num = key.hash
    store[self[num]].each do |el|
      return true if el == key
    end
    false
  end

  def remove(key)
    num = key.hash
    store[self[num]].delete(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % num_buckets
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
