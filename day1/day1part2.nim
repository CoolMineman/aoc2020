import strutils
import times

let time = cpuTime()

var numbers: seq[int]

var line: TaintedString
while (readLine(stdin, line)):
    numbers.add(parseInt(line))

for number in numbers:
    for number2 in numbers:
        for number3 in numbers:
            if number + number2 + number3 == 2020:
                echo "Match ", number, " ", number2, " ", number3
                echo "Time taken: ", cpuTime() - time
                quit 0