import std/algorithm
proc twoOldestAges*(ages: seq[int]): array[2, int] =
  var sortedAges = ages.sorted
  var first = sortedAges[^1]
  var second = sortedAges[^2]
  var ret: array[2, int]

  ret[0] =  second
  ret[1] =  first
  return ret


import std/unittest
suite "Two Oldest Ages":
  test "Basic tests":
    check:
      @[45,87] == twoOldestAges(@[1,5,87,45,8,8])
      @[18,83] == twoOldestAges(@[6,5,83,5,3,18])
