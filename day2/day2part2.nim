import strutils

var validpasswords = 0

var line: TaintedString
while (readLine(stdin, line)):
    echo "Processing Line ", line
    let a = line.split(": ")
    let password = a[1]
    let b = a[0].split(" ")
    let letter: char = b[1][0]
    let c = b[0].split("-")
    let mincount = parseInt(c[0])
    let maxcount = parseInt(c[1])
    var validifone = 0
    if password[mincount - 1] == letter: validifone += 1
    if password[maxcount - 1] == letter: validifone += 1
    if validifone == 1:
        validpasswords += 1
        echo "Valid Password ", password
    else:
        echo "Invalid Password ", password, " ", validifone
echo "Total Valid ", validpasswords