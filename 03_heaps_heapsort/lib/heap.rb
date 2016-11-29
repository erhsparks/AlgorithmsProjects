class BinaryMinHeap
  def initialize(&prc)
    @prc = prc || Proc.new { |el1, el2| el1 <=> el2 }
    @store = []
  end

  def count
    @store.length
  end

  def extract
    extracted = @store.first

    @store[0] = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, &prc)

    extracted
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, count - 1)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    [(2 * parent_index) + 1, (2 * parent_index) + 2].select { |i| i < len }
  end

  def self.parent_index(child_index)
    if child_index == 0
      raise 'root has no parent'
    else
      (child_index - 1) / 2
    end
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    i, j = self.child_indices(len, parent_idx)
    while i
      child_idx = j ? ((prc.call(array[i], array[j]) == -1) ? i : j) : i

      if prc.call(array[parent_idx], array[child_idx]) == 1
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      end

      parent_idx = child_idx
      i, j = self.child_indices(len, parent_idx)
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }

    until child_idx == 0
      parent_idx = self.parent_index(child_idx)

      if prc.call(array[child_idx], array[parent_idx]) == -1
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      end

      child_idx = parent_idx
    end

    array
  end
end
