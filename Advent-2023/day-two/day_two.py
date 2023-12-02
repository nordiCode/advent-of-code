from functools import reduce


def parse_round(round_str):
    return [(int(item.split()[0]), item.split()[1]) for item in round_str.split(", ")]


def check_tuple(tup, cubes):
    count, colour = tup
    return count <= cubes[colour]


def min_tuple(game, cubes):
    for round in game:
        for count, colour in round:
            if count >= cubes[colour]:
                cubes[colour] = count
    return list(cubes.values())


def main():
    cubes = {"blue": 1, "green": 1, "red": 1}
    game_ok = []  # p1
    game_mins = []  # p2

    with open("day_two.txt", mode="r") as file:
        game_index = 0
        for line in file:
            game_index += 1
            game_data = [
                parse_round(round_data)
                for round_data in line.strip().split(":")[1].split(";")
                if round_data.strip()
            ]
            flat_game_data = [el for sublist in game_data for el in sublist]

            if all(
                check_tuple(tup, {"red": 12, "green": 13, "blue": 14})
                for tup in flat_game_data
            ):
                game_ok.append(game_index)

            mins = min_tuple(game_data, cubes.copy())
            prod_mins = reduce(lambda x, y: x * y, mins)
            game_mins.append(prod_mins)

    print(f"P1: {sum(game_ok)}")
    print(f"P2: {sum(game_mins)}")


if __name__ == "__main__":
    main()
