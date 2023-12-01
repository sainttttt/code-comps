import print
import std/[strutils, os, tables, algorithm, sequtils]

proc findAll(hay: string, needle: string): seq[int] =
  var ret =  newSeq[int]()
  var x = hay.find(needle)
  while x != -1:
    ret.add(x)
    x = hay.find(needle, start=x + 1)
    print x
  return ret


var a = "dfdfc3"

print a.find("c")
print a.findAll("c")
