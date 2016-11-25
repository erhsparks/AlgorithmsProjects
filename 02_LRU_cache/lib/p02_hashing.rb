class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    to_be_hashed = self.inject("") do |sum, el|
      el = el.hash if el.is_a?(Array) || el.is_a?(Hash)

      sum + (el.ord.to_s)
    end

    to_be_hashed.to_i ^ 101010
  end
end

class String
  def hash
    to_be_hashed = self.chars.inject("") do |sum, el|
      el = el.hash if el.is_a?(Array) || el.is_a?(Hash)

      sum + (el.ord.to_s)
    end

    to_be_hashed.to_i ^ 101010
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_be_hashed = self.keys + self.values
    to_be_hashed = to_be_hashed.map(&:to_s).sort

    to_be_hashed.hash
  end
end
