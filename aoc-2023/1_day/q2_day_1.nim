import print
import std/[strutils, os, tables, algorithm, sequtils]

proc isNumber(x: string): bool =
  try:
    discard parseInt(x)
    result = true
  except ValueError:
    result = false



proc findAll(hay: string, needle: string): seq[int] =
  var ret =  newSeq[int]()
  var x = hay.find(needle)
  while x != -1:
    ret.add(x)
    x = hay.find(needle, start=x + 1)
  return ret


var total = 0

var numbers = @["one", "1",
                "two", "2",
                "three", "3",
                "four", "4",
                "five", "5",
                "six", "6",
                "seven", "7",
                "eight", "8",
                "nine", "9",
                ]

var wordToInt = {"one": 1,
                "two": 2,
                "three": 3,
                "four": 4,
                "five": 5,
                "six": 6,
                "seven": 7,
                "eight": 8,
                "nine": 9,
                }.toTable

for l in lines paramStr(1):
  var subtotal = 0

  var numLocs = initTable[int, string]()
  for n in numbers:
    var i = l.findAll(n)
    for f in i:
      numLocs[f] = n

  print numLocs
  var keys = numLocs.keys.toSeq
  keys.sort
  print keys

  var firstVal = numLocs[keys[0]]
  var lastVal = numLocs[keys[^1]]


  if firstVal.isNumber:
    subtotal += firstVal.parseInt * 10
  else:
    subtotal += wordToInt[firstVal] * 10

  var secondVal = numLocs[keys[^1]]

  if lastVal.isNumber:
    subtotal += lastVal.parseInt
  else:
    subtotal += wordToInt[lastVal]

  print subtotal
  total += subtotal

print total
