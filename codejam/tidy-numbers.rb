class Tidy

  def initialize(num)
    @num = num
  end

  def solve
    return @num if is_tidy?
    str = @num.to_s.chars.map(&:to_i).reverse
    str.each_with_index{ |c, i|
      if (c.to_i < (str[i+1] || 9).to_i) do
        fill_with_nines_at(str, i)
      end
    end
    str.reverse.join("").to_i
  end

  def naive_solve
    until is_tidy?
      @num -= 1
    end
    @num
  end

  def fill_with_nines_at(chars, i)
    primary = chars[i+1]
    if (primary == 0) then fill_with_nines_at(chars, i + 1)
    else 
      chars[i + 1] -= 1
      (0..i).each{|j| chars[j] = 9 }
    end
  end

  def is_tidy?
    i = 0
    return @num.to_s.chars.all?{|c| c.to_i <= (@num.to_s[i+=1] || 9).to_i }
  end
end

p Tiny.new("111111111110").solve

input = File.readlines("B-small-practice.in")
File.open("B-small.out", "w+") do |f|
  input[1..-1].each_with_index do |line, i|
    args = line.chomp.split(' ')
    #puts("Case ##{i}: #{Tidy.new(args[0].to_i).solve}")
    f.puts("Case ##{i+1}: #{Tidy.new(args[0].to_i).solve}")
  end
end