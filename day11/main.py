def part2(input):
    stones = input.split(" ")
    blinks = 5

    stone_counts = {} # es chunt nöd uf dposition druf a (so werded doppelti stei igspart) => Es git viel glichi stei wege begrenzti regle und art
    for stone in stones:
        if stone in stone_counts:
            stone_counts[stone] += 1
        else:
            stone_counts[stone] = 1

    for _ in range(blinks):
        new_stones = {}
        for stone, count in stone_counts.items():
            stone_int = int(stone)

            if stone_int == 0:
                if "1" in new_stones:
                    new_stones["1"] += count
                else:
                    new_stones["1"] = count
            elif len(str(stone)) % 2 == 0:
                left = stone[:len(str(stone)) // 2]
                right = stone[len(str(stone)) // 2:]

                if left in new_stones:
                    new_stones[left] += count
                else:
                    new_stones[left] = count
                if str(int(right)) in new_stones:
                    new_stones[str(int(right))] += count
                else:
                    new_stones[str(int(right))] = count
            else:
                new_stone = str(stone_int * 2024)
                if new_stone in new_stones:
                    new_stones[new_stone] += count
                else:
                    new_stones[new_stone] = count

        for k, v in new_stones.items():
            print(k, v)
        stone_counts = new_stones

    total_stones = 0
    for count in stone_counts.values():
        total_stones += count

    return total_stones
tot = part2("20 82084 1650 3 346355 363 7975858 0")
print(tot)

