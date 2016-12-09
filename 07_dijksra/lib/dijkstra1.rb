require_relative 'graph'

# O(|V|**2 + |E|).
def dijkstra1(source)
  shortest_paths = {}
  possible_paths = {
    source => {
      cost: 0,
      previous: nil
    }
  }

  until possible_paths.empty?
    lowest_cost_vertex, _ = possible_paths.min_by do |vertex, vertex_info|
      vertex_info[:cost]
    end

    shortest_paths[lowest_cost_vertex] = possible_paths[lowest_cost_vertex]
    possible_paths.delete(lowest_cost_vertex)

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
