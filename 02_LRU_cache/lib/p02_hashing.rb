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
    to_be_hashed = self.chars.hash
  end
end

class Hash
  def hash
    to_be_hashed = self.keys + self.values
    to_be_hashed = to_be_hashed.map(&:to_s).sort

    to_be_hashed.hash
  end
end
