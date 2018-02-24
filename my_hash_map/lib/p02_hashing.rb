class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    total = 0
    self.each_with_index do |el, idx|
      total += (el.ord.hash + idx.hash).abs
    end
    total
  end
end

class String
  def hash
    arr = self.chars
    arr.is_a?(Array)
    arr.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
