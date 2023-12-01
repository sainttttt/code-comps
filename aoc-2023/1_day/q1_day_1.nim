import print
import std/[strutils, os]

proc isNumber(x: char): bool =
  try:
    discard parseInt($x)
    result = true
  except ValueError:
    result = false


var total = 0

for l in lines paramStr(1):
  var subtotal = 0
  var break1 = false
  var break2 = false
  for i in 0..l.len-1:
    if l[i].isNumber and not break1:
      subtotal += 10 * parseInt($l[i])
      break1 = true


    var reverseIndex = l.len - 1 - i
    if l[reverseIndex].isNumber and not break2:
      subtotal += parseInt($l[reverseIndex])
      break2 = true

    if break1 and break2:
      break

  print subtotal
  total += subtotal

print total
