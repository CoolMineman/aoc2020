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
    var charcount = 0
    for passchar in password:
        if passchar == letter:
            charcount += 1
    if charcount >= mincount and charcount <= maxcount:
        validpasswords += 1
        echo "Valid Password ", password
    else:
        echo "Invalid Password ", password
echo "Total Valid ", validpasswords