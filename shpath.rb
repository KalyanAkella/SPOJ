
class Edge
  attr_accessor :head, :tail, :distance

  def initialize(head, tail, distance)
    @head = head
    @tail = tail
    @distance = distance
  end

  def visited?
    @head.length >= 0 and @tail.length >= 0
  end
end

class Node
  attr_reader :id
  attr_accessor :outgoing_edges, :length

  def initialize(id)
    @id = id
    @outgoing_edges = []
    @length = -1
  end
end

# Single source shortest path algorithm - Dijkstra
def compute(source, destination)
  x = [source]
  source.length = 0
  temp = source
  until temp.id == destination.id
    min_edge = nil
    min_distance = Float::INFINITY
    x.each do |xnode|
      xnode.outgoing_edges.each do |xedge|
        next if xedge.visited?
        curr_distance = xnode.length + xedge.distance
        if curr_distance <= min_distance
          min_distance = curr_distance
          min_edge = xedge
        end
      end
    end
    min_edge.head.length = min_distance
    x << min_edge.head
    temp = min_edge.head
  end
  destination.length
end

def process(graph, src, dest)
  nodes = []
  (0...graph.size).each do |i|
    nodes << Node.new(i)
  end
  graph.each_pair do |k,v|
    tail = nodes[k]
    v.each do |pair|
      head = nodes[pair[0]]
      distance = pair[1]
      tail.outgoing_edges << Edge.new(head, tail, distance)
    end
  end
  compute(nodes[src], nodes[dest])
end

def processInput(infile)
  s = infile.readline.to_i
  (1..s).each do |num|
    n = infile.readline.to_i
    cities = []
    graph = Hash.new { |h,k| h[k] = [] }
    (1..n).each do |i|
      cities << infile.readline.strip
      num_edges = infile.readline.to_i
      (1..num_edges).each do |j|
        vals = infile.readline.strip.split.map(&:to_i)
        graph[i - 1] << [(vals[0] - 1), vals[1]]
      end
    end
    r = infile.readline.to_i
    (1..r).each do |i|
      sd = infile.readline.strip.split
      puts process(graph, cities.find_index(sd[0]), cities.find_index(sd[1]))
    end
    infile.readline
  end
end

if ARGV.empty?
  processInput(STDIN)
else
  File.open(ARGV[0], 'r') do |infile|
    processInput(infile)
  end
end
