class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    pivot = array[0]
    left = []
    right = []

    prc = Proc.new { |a, b| a <=> b }

    (1...array.length).each do |i|
     if prc.call(array[i], pivot) == -1
       left << array[i]
     else
       right << array[i]
     end
    end

    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length <= 1

    prc ||= Proc.new { |a, b| a <=> b }

    pivot_idx = QuickSort.partition(array, start, length, &prc)

    QuickSort.sort2!(array, start, pivot_idx - start, &prc)
    QuickSort.sort2!(array, pivot_idx, length - 1 - pivot_idx, &prc)
    # seems like it would be more efficient to start at pivot_idx + 1, but the specs for worst case expect the extra comparsions of the pivot with itself...
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    pivot_idx = start
    pivot = array[pivot_idx]

    (1...length).each do |i|
      i += start
      test_el = array[i]

      if prc.call(test_el, pivot) == -1
        array[pivot_idx] = test_el
        pivot_idx += 1

        array[i] = array[pivot_idx]
        array[pivot_idx] = pivot
      end
    end

    pivot_idx
  end
end
