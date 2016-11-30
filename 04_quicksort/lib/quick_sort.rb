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

    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length <= 1

    prc ||= Proc.new { |a, b| a <=> b }

    pivot_idx = partition(array, start, length, &prc)

    length_left = pivot_idx - start
    length_right = (length - 1) - length_left

    start_left = start
    start_right = pivot_idx + 1

    sort2!(array, start_left, length_left, &prc)
    sort2!(array, start_right, length_right, &prc)
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
