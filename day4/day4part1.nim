import options
import strutils
import json

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
    passport.byr.isSome and passport.iyr.isSome and passport.eyr.isSome and passport.hgt.isSome and passport.hcl.isSome and passport.ecl.isSome and passport.pid.isSome

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

echo validpassports