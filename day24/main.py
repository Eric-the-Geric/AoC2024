
def read_input():
    with open("./input.txt", "r") as f:
        initial_values, computation = f.read().split("\n\n")

    initial_values = initial_values.split("\n")
    pairs = {k: int(v) for p in initial_values for k, v in [p.strip().split(":")]}
    computation = computation.split("\n")[:-1]
    computation = [[x1, x2, x3, x5] for c in computation for x1, x2, x3, x4, x5 in [c.split()]]
    return pairs, computation

def gate(x1, logic, x2):
    if logic == "OR":
        return x1 | x2
    elif logic == "XOR":
        return x1 ^ x2
    elif logic == "AND":
        return x1 & x2
    else:
        print("no logic found")

def p1():
    dictionary_values, computation = read_input()
    while len(computation) > 0:
        for i, (x1, logic, x2, result) in enumerate(computation):
            if x1 in dictionary_values.keys() and x2 in dictionary_values:
                dictionary_values[result] = gate(dictionary_values[x1], logic, dictionary_values[x2])
                del computation[i]
    new_dict = {}
    for k,v in dictionary_values.items():
        if "z" in k:
            new_dict[k] = v
    sorted_keys = sorted(new_dict, reverse=True)
    bin = ""
    for k in sorted_keys:
        bin += str(new_dict[k])
    print(int(bin, 2))
    




def p2():
    dictionary, computation = read_input()
    print(computation)


p2()
