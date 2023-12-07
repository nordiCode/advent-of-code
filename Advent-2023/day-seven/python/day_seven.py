from collections import Counter

custom_order = {
    "A": 14,
    "K": 13,
    "Q": 12,
    "J": 1,
    "T": 10,
    "9": 9,
    "8": 8,
    "7": 7,
    "6": 6,
    "5": 5,
    "4": 4,
    "3": 3,
    "2": 2,
}


def is_five_kind(hand):
    return len(hand.keys()) == 1


def is_four_kind(hand):
    if len(hand.keys()) != 2:
        return False
    return all((v == 1) or (v == 4) for v in hand.values())


def is_full_house(hand):
    if len(hand.keys()) != 2:
        return False
    return all((v == 2) or (v == 3) for v in hand.values())


def is_three_kind(hand):
    if len(hand.keys()) != 3:
        return False
    return all((v == 1) or (v == 3) for v in hand.values())


def is_two_pair(hand):
    if len(hand.keys()) != 3:
        return False
    return all((v == 2) or (v == 1) for v in hand.values())


def is_one_pair(hand):
    if len(hand.keys()) != 4:
        return False
    return all((v == 2) or (v == 1) for v in hand.values())


def is_high_card(hand):
    return len(hand.keys()) == 5


def get_sorted_card(hand):
    # cards = ["A", "K", "9", "8", "7", "6", "5", "4", "3", "2"]

    # Sorting cards based on the custom order
    return list(reversed(sorted(hand, key=lambda card: custom_order[card])))


def compare_cards(item):
    mapped_values = [custom_order[char] for char in item[0]]
    return int(item[-1]), mapped_values


def find_kind(hand, card):
    checks = {
        "7": is_five_kind,
        "6": is_four_kind,
        "5": is_full_house,
        "4": is_three_kind,
        "3": is_two_pair,
        "2": is_one_pair,
        "1": is_high_card,
    }
    if "J" not in hand.keys():
        for v, check_func in checks.items():
            if check_func(hand):
                return v
    else:
        hands = []
        for l in hand.keys():
            new_card = card.replace("J", l)
            hand = Counter(new_card)
            for v, check_func in checks.items():
                if check_func(hand):
                    hands.append(v)
        pos_hands = sorted(hands, reverse=True)[0]
        return max(sorted(hands, reverse=True))

    return False


with open("day_seven.txt", mode="r") as file:
    cards = []
    curr_card = None
    for line in file.readlines():
        line = line.strip().split(" ")
        card = line[0]
        bid = line[1]
        counter = Counter(card)
        result = (card, bid, find_kind(counter, card))
        curr_card = result
        cards.append(curr_card)

    sorted_tuples = sorted(cards, key=compare_cards)
    sum_wins = 0
    for i in range(0, len(sorted_tuples)):
        print(f"{i+1} -> {sorted_tuples[i]}")
        sum_wins += (i + 1) * int(sorted_tuples[i][1])
    print(sum_wins)
