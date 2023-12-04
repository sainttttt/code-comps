import print
import std/[re, strutils, os, tables, sets, math]
import npeg

var totalCards = 0
for line in lines paramStr 1:


  var winningNums = initHashSet[int]()
  var haveNums = initHashSet[int]()

  let parser = peg "lines":
    lines <- "Card" * +Blank * +Digit * ":" * +Blank * winningNums * "|" * *Blank * haveNums * !1
    # lines <- "Card" * +Blank * +Digit * ":" * +Blank * winningNums * " | " * haveNums * !1
    wNum <- >+Digit * >+Blank:
      winningNums.incl(parseInt($1))

    winningNums <- +wNum
    haveNums <- +hNum

    hNum <- >+Digit * *Blank:
      haveNums.incl(parseInt($1))

  let r = parser.match(line)
  print r
  print winningNums
  print haveNums
  var numMatches = 0
  for h in haveNums:
    if winningNums.contains h:
      numMatches += 1

  var score = 0
  if numMatches != 0:
    score = 2 ^ (numMatches - 1)
  print score
  totalScore += score
  # print gameInfo


print totalScore


