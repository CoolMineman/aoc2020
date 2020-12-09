import strutils
import tables
import times
let time = cpuTime()

type
    Contained = object
        quantity: int
        `type`: string

var bag_table = initTable[string, seq[Contained]]()

var line: TaintedString

while (readLine(stdin, line)):
    let a = line.split("s contain ")
    var container = a[0]
    container.removeSuffix('s')
    var b = a[1]
    if not (b == "no other bags."):
        b.removeSuffix('.')
        let contained_strs = b.split(", ")
        var containeds: seq[Contained] = @[]
        for item in contained_strs:
            let c = item.split(" ", maxsplit=1)
            let quantity = parseInt(c[0])
            var item2 = c[1]
            item2.removeSuffix('s')
            containeds.add(Contained(quantity: quantity, `type`: item2))
        bag_table.add(container, containeds)

proc getCanContain(current: string): int =
    if bag_table.contains(current):
        let entries = bag_table[current]
        for entry in entries:
            result += entry.quantity
            result += entry.quantity * getCanContain(entry.`type`)

let timetook = cpuTime() - time
let answer = getCanContain("shiny gold bag")

echo "Answer: ", answer, " Completed In: ", timetook