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
    x += 3

echo trees