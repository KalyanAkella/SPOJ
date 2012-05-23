def comp(w)
  c = Hash.new { |h,k| h[k] = 1 }
  c['T'] = c['D'] = c['L'] = c['F'] = 2
  w.chars.reduce(1) { |p,ch| p * c[ch] }
end

def run(f=STDIN)
  (1..10).each do
    puts comp(f.readline.strip)
  end
end

run
