# Flag parameters typed `boolish` (core's `type boolish = top`) or `top`,
# and `true` / `false` returns, as Active Support writes `titleize`,
# `humanize` and `acts_like_string?`. `top` is any value, so it pins
# nothing and the rest of the signature applies; `true` and `false` are
# bool. The `untyped` slot beside them pins what inference would not choose,
# so the C shows the signature applied, and the program compiled with
# `--no-inline-rbs --rbs sig/flag_types` produces the same C byte for byte.
class Word
  #: (untyped, ?keep: boolish) -> String
  def title(s, keep: false) = keep ? s.to_s : s.to_s.capitalize

  #: (untyped, top) -> untyped
  def show(x, y) = "#{x}#{y}"

  #: (untyped) -> true
  def word?(x) = true

  #: (untyped) -> false
  def blank?(x) = false
end

w = Word.new
p w.title("ab"), w.title("ab", keep: 1), w.title(:cd, keep: nil)
p w.show(3, nil), w.show("a", [1])
p w.word?(1), w.blank?("")
