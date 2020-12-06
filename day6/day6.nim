import tables

var line: TaintedString

var sum_part_1 = 0
var sum_part_2 = 0

var answered_questions_part_1: seq[char] = @[]
var answered_questions_part_2 = initTable[char, int]()
var lines = 0
while (readLine(stdin, line)):
    if line.len == 0:
        sum_part_1 += answered_questions_part_1.len()
        answered_questions_part_1.setLen(0)
        for _, amount in answered_questions_part_2:
            if amount == lines:
                sum_part_2 += 1
        lines = 0
        answered_questions_part_2 = initTable[char, int]()
    else:
        lines += 1
    for ch in line:
        if not (ch in answered_questions_part_1):
            answered_questions_part_1.add(ch)
        discard answered_questions_part_2.hasKeyOrPut(ch, 0)
        answered_questions_part_2[ch] += 1

sum_part_1 += answered_questions_part_1.len()
for _, amount in answered_questions_part_2:
    if amount == lines:
        sum_part_2 += 1

echo "Part1: ", sum_part_1
echo "Part2: ", sum_part_2