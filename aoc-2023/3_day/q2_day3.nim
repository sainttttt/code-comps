import print
import std/[sets, re, strutils, os, tables]
import npeg

proc isNumber(x: string): bool =
  try:
    discard parseInt(x)
    result = true
  except ValueError:
    result = false


var matrix = newSeq[string]()

var i = 0
for line in lines(paramStr(1)):
  matrix.add(line)

var adjacentMatrix = initOrderedTable[int, OrderedTable[int, (int, int)]]()

# for j in 0..matrix.len-1:
#   adjacentMatrix[j] = initOrderedTable[int, bool]()

for j in 0..matrix.len-1:
  adjacentMatrix[j] = initOrderedTable[int, (int, int)]()

  for i in 0..matrix[i].len-1:
    # adjacentMatrix[j][i] = 1

    for x in @[i - 1, i, i + 1]:
      for y in @[j - 1, j, j + 1]:
        if x < 0 or y < 0 or x > matrix[0].len-1 or y > matrix.len-1:
          continue
        if $matrix[y][x] == "*":
          print "adding"
          print j, i, y, x
          adjacentMatrix[j][i] = (y, x)



# for j in 0..matrix.len-1:
#   echo adjacentMatrix[j]

for j in 0..matrix.len-1:
  for i in 0..matrix[i].len-1:
    stdout.write $adjacentMatrix[j].getOrDefault(i, (-1,-1))
  stdout.write "\n"




var touches = initOrderedTable[int, OrderedTable[int, seq[int]]]()
for j in 0..matrix.len-1:
  touches[j] = initOrderedTable[int, seq[int]]()
  for i in 0..matrix[i].len-1:
    touches[j][i] = newSeq[int]()



var numberStart = false
var numBuf = ""
var adj = initHashSet[(int, int)]()
var runTotal = 0
for j in 0..matrix.len-1:
  for i in 0..matrix[i].len-1:
    if isNumber($matrix[j][i]):
      numBuf.add($matrix[j][i])
      if adjacentMatrix[j].hasKey(i):
        print adjacentMatrix[j][i]
        adj.incl(adjacentMatrix[j][i])
    else:
      if numBuf == "":
        continue

      if adj.len > 0:
        print numBuf
        print adj
        for a in adj:
          print a
          touches[a[0]][a[1]].add(numBuf.parseInt)

      numBuf = ""
      adj = initHashSet[(int, int)]()


var total = 0
for j in 0..matrix.len-1:
  for i in 0..matrix[i].len-1:
    if touches[j][i].len == 2:
      total += touches[j][i][0] * touches[j][i][1]

print total

