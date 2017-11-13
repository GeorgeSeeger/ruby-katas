def luhn_check(numstr)
  numstr.chars
  .map(&:to_i)
  .reverse
  .map.with_index{ |e, i|
    i % 2 != 0 ? (e * 2).to_s.chars.map(&:to_i).reduce(&:+) : e 
  }.reduce(&:+) % 10 == 0
end