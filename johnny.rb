def compute(weights)
  weight_map = {}
  weights.each_with_index do |weight, index|
    weight_map[weight] = index.next
  end

  weights.sort! { |x,y| y <=> x }
  left = []
  right = []
  lw = rw = 0

  weights.each do |weight|
    nlw = lw + weight
    nrw = rw + weight
    dlw = (nlw - rw).abs
    drw = (nrw - lw).abs
    if dlw < drw
      left << weight_map[weight]
      lw = nlw
    else
      right << weight_map[weight]
      rw = nrw
    end
  end

  left
end

def run(f=STDIN)
  num = f.readline.to_i
  weights = []
  (1..num).each do |i|
    weights << f.readline.to_i
  end
  puts compute(weights)
end

run
