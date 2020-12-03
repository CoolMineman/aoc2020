var map: seq[string]

var line: TaintedString
while (readLine(stdin, line)):
    map.add(line)

proc getTree(x, y: int): bool =
    let line = map[y]
    return line[x mod line.len] == '#'

var trees = 0

var x = 0

for y in 0..(map.len - 1):
    if getTree(x, y): trees += 1
    x += 1

x = 0
var totaltrees = trees
trees = 0

for y in 0..(map.len - 1):
    if getTree(x, y): trees += 1
    x += 3

totaltrees *= trees
x = 0
trees = 0

for y in 0..(map.len - 1):
    if getTree(x, y): trees += 1
    x += 5

totaltrees *= trees
x = 0
trees = 0

for y in 0..(map.len - 1):
    if getTree(x, y): trees += 1
    x += 7

totaltrees *= trees
x = 0
trees = 0

for y in 0..((map.len - 1) div 2):
    if getTree(x, y * 2): trees += 1
    x += 1

totaltrees *= trees

echo totaltrees