from functools import reduce


def part_one(times, dists):
    i = 0
    wins = []
    for i in range(0, len(times)):
        t = times[i]
        d = dists[i]
        sum_win = 0

        while i <= t:
            speed = i
            # released at this time i
            remaining_time = t - i
            # if released at this time 0
            dist_traveled = remaining_time * speed
            if dist_traveled > d:
                sum_win += 1
            i += 1
        wins.append(sum_win)
    return reduce(lambda x, y: x * y, wins)


def part_two(time, dist):
    i = 0
    t = time
    d = dist
    sum_win = 0

    while i <= t:
        speed = i
        # released at this time i
        remaining_time = t - i
        # if released at this time 0
        dist_traveled = remaining_time * speed
        if dist_traveled > d:
            sum_win += 1
        i += 1
    return sum_win


with open("day_six.txt", mode="r") as file:
    line_one = file.readline().strip().split(":")[1].split(" ")
    line_two = file.readline().strip().split(":")[1].split(" ")

    # P1
    times = list(map(lambda x: int(x), list(filter(lambda x: x != "", line_one))))
    dists = list(map(lambda x: int(x), list(filter(lambda x: x != "", line_two))))

    time = int("".join(list(filter(lambda x: x != "", line_one))))
    dist = int("".join(list(filter(lambda x: x != "", line_two))))

    print(f"Part 1 {part_one(times,dists)}")
    print(f"Part 2 {part_two(time,dist)}")
