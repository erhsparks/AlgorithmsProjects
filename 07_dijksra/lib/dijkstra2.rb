require_relative 'graph'
require_relative 'priority_map'

# O(|V| + |E|*log(|V|)).
def dijkstra2(source)
  shortest_paths = {}

  possible_paths = PriorityMap.new do |v1_info, v2_info|
    v1_info[:cost] <=> v2_info[:cost]
  end

  possible_paths[source] = {
    cost: 0,
    previous: nil
  }

  until possible_paths.empty?
    lowest_cost_vertex, lcv_info = possible_paths.extract
    shortest_paths[lowest_cost_vertex] = lcv_info

    current_cost = shortest_paths[lowest_cost_vertex][:cost]

    lowest_cost_vertex.out_edges.each do |out_edge|
      to_vertex = out_edge.to_vertex
      next if shortest_paths.has_key?(to_vertex)

      next_cost = current_cost + out_edge.cost

      if possible_paths.has_key?(to_vertex) && possible_paths[to_vertex][:cost] <= next_cost
        next
      else
        possible_paths[to_vertex] = {
          cost: next_cost,
          previous: out_edge
        }
      end
    end
  end

  shortest_paths
end
