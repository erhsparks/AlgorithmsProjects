require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map[key])

      @map.get(key)
    else
      eject! if count == @max

      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    @map[key] = @store.insert(key, val)

    val
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.insert(link.key, link.val)
  end

  def eject!
    least_recently_used = @store.first.key

    @store.remove(least_recently_used)
    @map.delete(least_recently_used)
  end
end
