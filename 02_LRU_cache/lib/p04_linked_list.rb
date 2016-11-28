class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new(:head)
    @tail = Link.new(:tail)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    empty? ? nil : @head.next
  end

  def last
    empty? ? nil : @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head
  end

  def get(key)
    link = find { |current| current.key == key }

    link.nil? ? nil : link.val
  end

  def include?(key)
    any? { |current| current.key == key }
  end

  def insert(key, val)
    if include?(key)
      each { |link| link.val = val if link.key == key }
    else
      new_link = Link.new(key, val)

      old_last = @tail.prev
      new_link.prev = old_last
      old_last.next = new_link

      new_link.next = @tail
      @tail.prev = new_link
    end
  end

  def remove(key)
    link = find { |current| current.key == key }

    if link.nil?
      nil
    else
      prev_link = link.prev
      next_link = link.next

      prev_link.next = next_link
      next_link.prev = prev_link

      link.val
    end
  end

  def each
    current = @head.next

    until current == @tail
      yield current
      current = current.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
