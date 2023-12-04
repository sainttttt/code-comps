import print
import std/[re, strutils, os, tables, sets, math]
import npeg

# var totalScore = 0
var maxline = 197
# var i = 0

var cardWins = newSeq[int]()
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


  cardWins.add(numMatches)
  # i += 1
  # print gameInfo


# print cardWins
var numCards = cardWins.len
proc cardWin(cardNumber: int): int =
  var totalCards = 0
  var straightWin = cardWins[cardNumber]

  totalCards += straightWin
  # print cardNumber
  # print straightWin
  for bonus in cardNumber+1 .. min(cardNumber+1+straightWin+1,  numCards- 1):
    # print bonus
    totalCards += cardWin(bonus)
  return totalCards

var allCardWins = 0
for i in 0..(numCards - 1):
  # print i
  allCardWins += cardWin(i)
  # print allCardWins

var final = allCardWins + numCards
print final


