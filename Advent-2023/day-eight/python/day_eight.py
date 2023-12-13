import re


def part_one(locs):
    found = ""
    steps = 0
    curr = locs["AAA"]
    starting = find_starts(locs)
    print(starting)
    while found != "ZZZ":
        move = steps % len(moves)
        r_l = moves[move]
        if r_l == "R":
            nextMove = curr[1]
            curr = locs[nextMove]
            found = nextMove
        else:
            nextMove = curr[0]
            curr = locs[nextMove]
            found = nextMove

        steps += 1
    print(steps)


def find_starts(locs):
    starts = []
    for k, v in locs.items():
        if k[-1] == "A":
            starts.append(v)
    return starts


with open("day_eight.txt", mode="r") as file:
    moves = file.readline()
    moves = list(moves.strip())
    print(f"moves {moves}")
    locs = {}
    # file.readline()
    for line in file.readlines():
        l = line.strip().split("=")
        # print(l)
        strings = re.findall(r"\b\w+\b", l[1])
        locs[l[0].strip()] = strings
    # print(locs)
    found = ["ZYY"]  # arbitrary found start
    steps = 0
    curr = find_starts(locs)
    # print(curr)

    while any(y[-1] != "Z" for y in found):
        move = steps % len(moves)
        r_l = moves[move]
        # print(r_l)
        next_moves = curr
        found = []
        for i in range(len(next_moves)):
            # print(f"curr {i}")
            if r_l == "R":
                nextMove = next_moves[i][1]
                curr[i] = locs[nextMove]
                found.append(nextMove)
            else:
                nextMove = next_moves[i][0]
                curr[i] = locs[nextMove]
                found.append(nextMove)

        steps += 1
    print(steps)
