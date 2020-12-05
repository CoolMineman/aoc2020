import algorithm
var line: TaintedString

proc yeetHalf(sequence: var seq[int], upperHalf: bool) =
    if not upperHalf:
        let newlength = ((sequence.len + 1) div 2)
        setLen(sequence, newlength)
    else:
        var new_seq = newSeqOfCap[int](((sequence.len + 1) div 2))
        for i in (((sequence.len + 1) div 2))..(sequence.len - 1):
            new_seq.add(sequence[i])
        sequence = new_seq

var highest_seat_id = 0
var all_seat_ids: seq[int] = @[]

while (readLine(stdin, line)):
    var rows: seq[int] = @[]
    for i in 0..127: rows.add(i)
    for i in 0..6:
        case line[i]:
        of 'F': rows.yeetHalf(false)
        of 'B': rows.yeetHalf(true)
        else: discard
    let row = rows[0]
    var columns: seq[int] = @[]
    for i in 0..7: columns.add(i)
    for i in 7..9:
        case line[i]
        of 'R': columns.yeetHalf(true)
        of 'L': columns.yeetHalf(false)
        else: discard
    let column = columns[0]
    let seatid = row*8 + column
    if seatid > highest_seat_id: highest_seat_id = seatid
    all_seat_ids.add(seatid)

echo "Highest ID: ", highest_seat_id

sort all_seat_ids

for i in 0..(all_seat_ids.len - 2):
    if (all_seat_ids[i + 1] - all_seat_ids[i] != 1): echo "Your Seat ID: ", all_seat_ids[i] + 1