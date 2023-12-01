import sys

numbers = ["one", "1",
           "two", "2",
           "three", "3",
           "four", "4",
           "five", "5",
           "six", "6",
           "seven", "7",
           "eight", "8",
           "nine", "9",
           "zero", "0"]

for l in open(sys.argv[1]):

    pos = {}
    for n in numbers:
        i = l.find(n)
        if i != -1:
            pos[i] = n

    keys = list(pos.keys())
    keys.sort()
    print(keys)
    input()


