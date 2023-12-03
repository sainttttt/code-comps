import std/re
import std/sequtils
import print

if match("abc5defg", re"^[^\.0-9]+$"):
  print "meow"
