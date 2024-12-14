import re
def read_input():
    machines = []
    file = "./input.txt"
    with open(file, 'r') as f:
        contents = f.read().split('\n\n')
    for m in contents:
        machine = {}
        for line in m.split('\n'):
            #line = line.replace(" ", "")
            details = re.findall(r"\W[A-B]|Prize|\d+", line)
            if len(details) == 0:
                continue
            details[0] = details[0].replace(" ", "")
            machine[details[0]] = (int(details[1]), int(details[2]))
        if len(machine) > 0:
            machines.append(machine)

    return machines


def p1():
    machines = read_input()
    total = 0
    for machine in machines:
        Ax, Ay = machine['A'][0], machine['A'][1]
        Bx, By = machine['B'][0], machine['B'][1]
        prize_x, prize_y = machine['Prize'][0], machine['Prize'][1]
        lowest_solution = []
        for i in range(100):
            for j in range(100):
                if Ax*i + Bx*j == prize_x and Ay*i + By*j == prize_y:
                    lowest_solution.append((i, j))
                    print(i,j)

        solutions = 0
        if lowest_solution:
            for button_press_a, button_press_b in lowest_solution:
                tmp = 3*button_press_a + button_press_b
                if solutions == 0 or tmp < solutions:
                    solutions = tmp
        total+=solutions
    print(total)

def find_b(px, py, x1, y1, x2, y2):
    b = ((-x1*py) +(y1*px))/((y1*x2)-(x1*y2))
    return b

def find_a(b, py, y1, y2):
    a = (py - y2*b)/(y1)
    return a
def p2():
    # math in math.md
    machines = read_input()
    total = 0
    for machine in machines:
        Ax, Ay = machine['A'][0], machine['A'][1]
        Bx, By = machine['B'][0], machine['B'][1]
        prize_x, prize_y = machine['Prize'][0]+10000000000000, machine['Prize'][1]+10000000000000
        #prize_x, prize_y = machine['Prize'][0], machine['Prize'][1]
        b = find_b(prize_x, prize_y, Ax, Ay, Bx, By)
        a = find_a(b, prize_y, Ay, By)
        if a.is_integer() and b.is_integer():
            total += int(a)*3 + int(b)
    print(total)

  


p2()
    
