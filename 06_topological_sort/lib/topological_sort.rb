require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  in_counts, to_sort = initialize_edge_counts(vertices)

  sorted = []

  until to_sort.empty?
    current = to_sort.pop
    sorted << current

    to_sort += inspect_children(current, in_counts)
  end

  vertices.count == sorted.count ? sorted : []
end

def initialize_edge_counts(vertices)
  in_counts = {}
  to_sort = []

  vertices.each do |vertex|
    num_ins = vertex.in_edges.count
    in_counts[vertex] = num_ins

    to_sort << vertex if num_ins.zero?
  end

  [in_counts, to_sort]
end

def inspect_children(current, in_counts)
  to_sort = []

  current.out_edges.each do |out_edge|
    child = out_edge.to_vertex
    in_counts[child] -= 1

    to_sort << child if in_counts[child].zero?
  end

  to_sort
end
