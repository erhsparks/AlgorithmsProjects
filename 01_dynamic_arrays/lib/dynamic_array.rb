require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(@length)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    @store[index] = value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @length -= 1
    return_val = @store[@length]
    @store[@length] = nil

    return_val
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity

    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0
    return_val = @store[0]

    for i in (0...@length - 1) do
      @store[i] = @store[i + 1]
    end
    @store[@length - 1] = nil
    @length -= 1

    return_val
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity

    i = @length - 1
    while i >= 0 do
      @store[i + 1] = @store[i]
      i -= 1
    end
    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    raise 'index out of bounds' if index >= @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    for i in (0...@length) do
      new_store[i] = @store[i]
    end

    @store = new_store
  end
end
