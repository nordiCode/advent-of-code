import re


def score(matches):
    return 2 ** (len(matches) - 1) if matches else 0


def parse_numbers(string):
    return re.findall(r"\b\d+\b", string)


def part_two(wins):
    # originals && copies!
    copies = {k: 0 for k in wins.keys()}

    for k, v in wins.items():
        c = copies[k]
        if v > 0:
            i = 0
            while i < 1 + c:
                for w in range(0, v):
                    copies[k + w + 1] += 1
                i += 1
    return sum(v for v in copies.values()) + len(wins.keys())


def main():
    ans = 0
    wins = {}
    with open("day_four.txt", mode="r") as file:
        game = 1

        for line in file:
            card = line.strip().split("|")
            my_nums = parse_numbers(card[1])
            lotto = card[0].split(":")
            winning_nums = parse_numbers(lotto[1])

            match_nums = list(filter(lambda x: x in my_nums, winning_nums))
            wins[game] = len(match_nums)
            game += 1
        ans += part_two(wins)

        # part1
        # ans += score(match_nums)

    # part2
    print(ans)


if __name__ == "__main__":
    main()
