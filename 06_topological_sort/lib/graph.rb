class Vertex
  attr_reader :value, :in_edges, :out_edges

  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end

  def append_edge(edge, direction)
    dir_edge = get_edge(direction)
    dir_edge << edge
  end

  def delete_edge(edge, direction)
    dir_edge = get_edge(direction)
    dir_edge.delete(edge)
  end

  def get_edge(direction)
    case direction
    when 'in'
      @in_edges
    when 'out'
      @out_edges
    else
      nil
    end
  end
end

class Edge
  attr_reader :from_vertex, :to_vertex, :cost

  def initialize(from_vertex, to_vertex, cost = 1)
    @from_vertex = from_vertex
    @to_vertex = to_vertex
    add_self_to_vertices!

    @cost = cost
  end

  def add_self_to_vertices!
    @from_vertex.append_edge(self, 'out')
    @to_vertex.append_edge(self, 'in')
  end

  def destroy!
    @from_vertex.delete_edge(self, 'out')
    @from_vertex = nil

    @to_vertex.delete_edge(self, 'in')
    @to_vertex = nil
  end
end
