import re

memory = ''

with open("test.txt") as f:
    memory = f.read()

def part1(memory):
    matches = re.findall(r"mul\(\d{1,3},\d{1,3}\)", memory)

    sum = 0
    for match in matches:
        nums = re.findall(r"\d{1,3}", match)
        sum += int(nums[0]) * int(nums[1])

    return sum

def compute(memory, enabled):
    if enabled:
        if "don't()" in memory:
            i = memory.index("don't()")
            return part1(memory[:i]) + compute(memory[i:], False)
        else:
            return part1(memory)
    else:
        if "do()" in memory:
            i = memory.index("do()")
            return compute(memory[i:], True)
        else:
            return 0

print(compute(memory, True))
