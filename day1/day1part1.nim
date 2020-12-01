import strutils
import times

var numbers: seq[int]

var line: TaintedString
while (readLine(stdin, line)):
    numbers.add(parseInt(line))

let time = cpuTime()

for number in numbers:
    let target = 2020 - number
    for number2 in numbers:
        if number2 == target:
            let time2 = cpuTime() - time
            echo "Match ", number, " ", number2
            echo "Time taken: ", time2
            quit 0