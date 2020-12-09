import strutils

var instructions: seq[string] = @[]
var params: seq[int] = @[]

var line: TaintedString

while (readLine(stdin, line)):
    let a = line.split(' ')
    let instruction = a[0]
    let param = parseInt(a[1])
    instructions.add(instruction)
    params.add(param)

var instruction_pointer = 0
var used_instructions: seq[int] = @[]
var accumulator = 0

while not (instruction_pointer in used_instructions):
    used_instructions.add(instruction_pointer)
    case instructions[instruction_pointer]:
    of "jmp":
        instruction_pointer += params[instruction_pointer]
    of "nop":
        inc instruction_pointer
    of "acc":
        accumulator += params[instruction_pointer]
        inc instruction_pointer

echo "Part 1: ", accumulator

for i in 0..(instructions.len - 1):
    instruction_pointer = 0
    used_instructions = @[]
    accumulator = 0
    while not (instruction_pointer in used_instructions):
        used_instructions.add(instruction_pointer)
        var instruction: string
        if instructions[i] == "jmp":
            instruction = if instruction_pointer == i: "nop" else: instructions[instruction_pointer]
        elif instructions[i] == "nop":
            instruction = if instruction_pointer == i: "jmp" else: instructions[instruction_pointer]
        else:
            break
        case instruction:
            of "jmp":
                instruction_pointer += params[instruction_pointer]
            of "nop":
                inc instruction_pointer
            of "acc":
                accumulator += params[instruction_pointer]
                inc instruction_pointer
        if (instruction_pointer >= instructions.len):
            echo "Part 2: ", accumulator
            quit 0
