import strutils
import tables

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

proc getCanContain(goal: string, current: string): bool =
    if bag_table.contains(current):
        let entries = bag_table[current]
        for entry in entries:
            if entry.`type` == goal:
                return true
            else:
                if getCanContain(goal, entry.`type`): return true
    return false

var can_contain_count = 0

for bag, _ in bag_table:
    let can_contain = getCanContain("shiny gold bag", bag)
    echo "Bag: ", bag, " ", can_contain
    if (can_contain): inc can_contain_count

echo can_contain_count