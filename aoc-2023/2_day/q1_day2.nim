import print
import std/[strutils, os, tables]
import npeg

var totalGames = 0
for data in lines(paramStr(1)):

  # const data = "Game 1: 12 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"

  var gameInfo = initTable[string, int]()
  var currentGame = 0

  let parser = peg "lines":
    lines <- gameNum * +details * !1
    gameNum <- "Game " * >+Digit * ": ":
      # gameInfo[parseInt($1)] = initTable[string, int]()
      currentGame = parseInt($1)
    details <- +bagDet
    bagDet <- >+Digit * >(" blue" | " red" | " green") * ?>(',' | ';' | ' ') * ?' ':
      var color = strip($2)
      var num = parseInt($1)
      if gameInfo.getOrDefault(color) < num:
        gameInfo[color] = num

  let r = parser.match(data)
  print gameInfo

  var max = {"red": 12, "green": 13, "blue": 14}.toTable

  var add = true
  for k,v in max.pairs:
    print v, gameInfo[k]
    if gameInfo[k] > v:
      add = false
      break

  print add
  if add:
    totalGames += currentGame

  print r.captures
  print r.ok

print totalGames
