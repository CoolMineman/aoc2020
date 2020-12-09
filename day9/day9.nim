import strutils
import algorithm

var data: seq[int] = @[]

var line: TaintedString
while (readLine(stdin, line)):
    data.add(parseInt(line))

proc valid(cursor: int): bool =
    for i in cursor-25..(cursor-1):
        for j in cursor-25..(cursor-1):
            if data[j] + data[i] == data[cursor] and data[j] != data[i]:
                return true
    return false

var cursor = 25

while cursor < data.len:
    if not valid(cursor):
        echo "Part1: ", data[cursor]
        let target = data[cursor]
        for i in 0..data.len:
            var sum = 0
            var used = 0
            cursor = i
            while (sum < target):
                sum += data[cursor]
                inc used
                inc cursor
            if (sum == target):
                var weakness_pool: seq[int] = @[]
                for j in i..(i + used - 1):
                    weakness_pool.add(data[j])
                weakness_pool.sort()
                echo "Part2: ", weakness_pool[0] + weakness_pool[weakness_pool.len - 1]
                quit 0
    inc cursor