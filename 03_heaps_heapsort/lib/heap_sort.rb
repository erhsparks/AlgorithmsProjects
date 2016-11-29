require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new { |el1, el2| el2 <=> el1 }

    for i in (1...length) do
      BinaryMinHeap.heapify_up(self, i, i + 1, &prc)
    end

    for i in (1...length) do
      i = length - i
      self[i], self[0] = self[0], self[i]
      BinaryMinHeap.heapify_down(self, 0, i, &prc)
    end
  end
end
