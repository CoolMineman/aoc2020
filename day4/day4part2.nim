import options
import strutils

type
  PassportData = object
    byr, iyr, eyr, hgt, hcl, ecl, pid, cid: Option[string]

var current_passport = PassportData(
    byr: none[string](),
    iyr: none[string](),
    eyr: none[string](),
    hgt: none[string](),
    hcl: none[string](),
    ecl: none[string](),
    pid: none[string](),
    cid: none[string]()
)

proc validate(passport: PassportData): bool =
    let fields_valid = passport.byr.isSome and passport.iyr.isSome and passport.eyr.isSome and passport.hgt.isSome and passport.hcl.isSome and passport.ecl.isSome and passport.pid.isSome
    if (not fields_valid): return false
    let birth = parseInt(passport.byr.get)
    if (not (birth >= 1920 and birth <= 2002)):
        echo "Invalid Birth ", birth
        return false
    let issue = parseInt(passport.iyr.get)
    if (not (issue >= 2010 and issue <= 2020)):
        echo "Invalid Issue ", issue
        return false
    let eyr = parseInt(passport.eyr.get)
    if (not (eyr >= 2020 and eyr <= 2030)):
        echo "Invalid Issue ", eyr
        return false
    if (passport.hgt.get.endsWith("cm")):
        let height = parseInt(passport.hgt.get.split("cm")[0])
        if (not (height >= 150 and height <= 193)): return false
    elif (passport.hgt.get.endsWith("in")):
        let height = parseInt(passport.hgt.get.split("in")[0])
        if (not (height >= 59 and height <= 76)): return false
    else:
        return false
    let hcl = passport.hcl.get
    if (not hcl.len == 7): return false
    if (not (hcl[0] == '#')): return false
    for i in 1..(hcl.len-1):
        if (not (hcl[i].isAlphaNumeric)):
            return false
        elif (hcl[i].isUpperAscii):
            echo "PANIC"
    let ecl = passport.ecl.get
    case ecl:
    of "amb", "blu", "brn", "gry", "grn", "hzl", "oth":
        discard
    else:
        return false
    let pid = passport.pid.get
    if (not (pid.len == 9)): return false
    for number in pid:
        if (not number.isDigit): return false
    return true

var validpassports = 0

var line: TaintedString
while (readLine(stdin, line)):
    let entries = line.split(" ")
    for entry in entries:
        let keyvalue = entry.split(":")
        case keyvalue[0]:
        of "byr":
            current_passport.byr = option(keyvalue[1])
        of "iyr":
            current_passport.iyr = option(keyvalue[1])
        of "eyr":
            current_passport.eyr = option(keyvalue[1])
        of "hgt":
            current_passport.hgt = option(keyvalue[1])
        of "hcl":
            current_passport.hcl = option(keyvalue[1])
        of "ecl":
            current_passport.ecl = option(keyvalue[1])
        of "pid":
            current_passport.pid = option(keyvalue[1])
        of "cid":
            current_passport.cid = option(keyvalue[1])
    if (line == ""):
        # echo %*current_passport
        if (validate(current_passport)): inc validpassports
        current_passport = PassportData(
            byr: none[string](),
            iyr: none[string](),
            eyr: none[string](),
            hgt: none[string](),
            hcl: none[string](),
            ecl: none[string](),
            pid: none[string](),
            cid: none[string]()
        )
if (validate(current_passport)): inc validpassports

echo validpassports