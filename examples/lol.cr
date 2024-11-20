require "../src/lolcat"

Lolcat.cat(Path[__FILE__], spread: 5, freq: 0.2)

Lolcat.lol("Rainbow", invert: true) do |line|
  puts line
end
