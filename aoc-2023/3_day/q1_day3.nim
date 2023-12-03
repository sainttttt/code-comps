import print
import std/[re, strutils, os, tables]
import npeg

proc isNumber(x: string): bool =
  try:
    discard parseInt(x)
    result = true
  except ValueError:
    result = false

# var matrix = initOrderedTable[int, OrderedTable[int, char]]()

# var i = 0
# for line in lines(paramStr(1)):
#   matrix[i] = initOrderedTable[int, char]()
#   var j = 0;
#   for c in line:
#     matrix[i][j] = c
#     j += 1
#   i += 1

# print $matrix

var matrix = newSeq[string]()

var i = 0
for line in lines(paramStr(1)):
  matrix.add(line)



var adjacentMatrix = initOrderedTable[int, OrderedTable[int, bool]]()

# for j in 0..matrix.len-1:
#   adjacentMatrix[j] = initOrderedTable[int, bool]()

for j in 0..matrix.len-1:
  adjacentMatrix[j] = initOrderedTable[int, bool]()

  for i in 0..matrix[i].len-1:
    for x in @[i - 1, i, i + 1]:
      for y in @[j - 1, j, j + 1]:
        if x < 0 or y < 0 or x > matrix[0].len-1 or y > matrix.len-1:
          continue
        if match($matrix[y][x], re"^[^\.0-9]+$"):
          adjacentMatrix[j][i] = true



# for j in 0..matrix.len-1:
#   echo adjacentMatrix[j]

for j in 0..matrix.len-1:
  for i in 0..matrix[i].len-1:
    stdout.write adjacentMatrix[j].getOrDefault(i, false)
  stdout.write "\n"


var numberStart = false
var numBuf = ""
var adj = false
var runTotal = 0
for j in 0..matrix.len-1:
  for i in 0..matrix[i].len-1:
    if isNumber($matrix[j][i]):
      numBuf.add($matrix[j][i])
      if adjacentMatrix[j].getOrDefault(i, false):
        adj = true
    else:
      if adj:
        print numBuf
        if numBuf != "":
          runTotal += parseInt(numBuf)
      numBuf = ""
      adj = false


print runTotal
