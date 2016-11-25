require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(@length)
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)

    index = actual_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, val)
    check_index(index)

    index = actual_index(index)
    @store[index] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0

    return_val = self[@length - 1]

    self[@length - 1] = nil
    @length -= 1

    return_val
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity

    @length += 1
    self[@length - 1] = val
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length == 0

    return_val = self[0]

    @start_idx += 1
    @start_idx -= @capacity if @start_idx > @capacity

    @length -= 1
    return_val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity

    @start_idx -= 1
    @start_idx += @capacity if @start_idx < 0

    @length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def actual_index(index)
    index += @start_idx
    index -= @capacity if index >= @capacity

    index
  end

  def check_index(index)
    raise 'index out of bounds' if index >= @length
  end

  def resize!
    new_capacity = 2 * @capacity
    new_store = StaticArray.new(new_capacity)

    for i in (0...@length) do
      new_store[i] = self[i]
    end

    @store = new_store
    @capacity = new_capacity
    @start_idx = 0
  end
end
