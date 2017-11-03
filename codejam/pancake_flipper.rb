class PancakeGrill
  attr_reader :s

  @@IMPOSSIBLE = "IMPOSSIBLE"

  def initialize(s, k, flips = 0, states = nil)
    @s = s 
    @k = k 
  end

  def self.solve(s, k)
    flips = 0
    states = { 0 => [s] }
    grills = [PancakeGrill.new(s, k)]
    until grills.any?{ |f| f.happy? } do
      grills.map!{ |a| a.next_generation }.flatten!.uniq!{|f| f.s}

      return @@IMPOSSIBLE if grills.all?{ |f| 
        states.any?{ |k, v| v.include?(f.s) }
      }

      p grills.length

      states[ flips += 1 ] = grills.map{|f| f.s}
    end
    flips
  end
  
  def happy?
    return @s.chars.all?{ |c| c == '+' }
  end
 
  def next_generation
    (0..@s.length - @k).map.with_index do |s, i|
      PancakeGrill.new(flip(i), @k)
    end
  end

  private
  
  def flip(start)
    s = @s.dup()
    (start...start + @k).each do |i|
      s[i] = s[i] == '+' ? '-' : '+'
    end
    s
  end
end

p PancakeGrill.solve('---+-++-', 3)
p PancakeGrill.solve('-+-+-', 4)

p PancakeGrill.solve('++--+-+--', 3)
# input = File.readlines("A-small-practice.in")
input = File.readlines("A-large-practice.in")
testNum = 0
File.open("A-small.out", "w+") do |f|
  input[1..-1].each do |line|
    args = line.chomp.split(' ')
    puts("Case ##{testNum}: #{PancakeGrill.solve(args[0], Integer(args[1]))}")
    f.puts("Case ##{testNum += 1}: #{PancakeGrill.solve(args[0], Integer(args[1]))}")
  end
end


