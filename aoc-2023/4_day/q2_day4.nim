import print
import std/[re, strutils, os, tables, sets, math, sequtils]
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

var cardsPerNum = newSeq[int]()
for i in 1..numCards:
  cardsPerNum.add(1)


proc cardWin(cardNumber: int) =
  var straightWin = cardWins[cardNumber]
  # print straightWin

  for j in 1..cardsPerNum[cardNumber]:
    # print j
    for bonus in cardNumber+1 .. min(cardNumber+straightWin,  numCards - 1):
      # print bonus
      cardsPerNum[bonus] += 1



# print cardsPerNum

for i in 0..(numCards - 1):
  # print cardsPerNum[i]
  cardWin(i)


# print cardsPerNum
print cardsPerNum.foldl(a + b)
