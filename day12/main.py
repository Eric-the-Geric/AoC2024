
def get_input(file):
    garden = []
    with open(file, 'r') as f:
        map = f.readlines()
        for row in map:
            new_row = []
            for pot in row:
                if pot != "\n":
                    new_row.append(pot)
            garden.append(new_row)
    return garden


def recursion(pot, x, y, garden, visited=set()):
    m = len(garden) -1
    n = len(garden[0]) -1
    if (x,y) in visited or x > m or x < 0 or y > n or y < 0: 
        return visited
    elif garden[x][y] == pot:
        visited.add((x,y))
        visited = recursion(pot, x, y+1, garden, visited)
        visited = recursion(pot, x, y-1, garden, visited)
        visited = recursion(pot, x+1, y, garden, visited)
        visited = recursion(pot, x-1, y, garden, visited)

    return visited
    
def recursionp2(pot, x, y, garden, new_map, visited=set()):
    m = len(garden) -1
    n = len(garden[0]) -1

    if (x,y) in visited or x > m or x < 0 or y > n or y < 0: 
        if (x,y) not in visited:
            new_map[x+1][y+1] = "*"
        return visited, new_map
    elif garden[x][y] == pot:
        visited.add((x,y))
        new_map[x+1][y+1] = pot
        visited, new_map = recursionp2(pot, x, y+1, garden, new_map, visited)
        visited, new_map = recursionp2(pot, x, y-1, garden, new_map, visited)
        visited, new_map = recursionp2(pot, x+1, y, garden, new_map, visited)
        visited, new_map = recursionp2(pot, x-1, y, garden, new_map, visited)
    else:
        new_map[x+1][y+1] = "*"

    return visited, new_map

def p1():
    garden = get_input('./input.txt')
    pots = []
    for row in garden:
        for pot in row:
            if pot not in pots:
                pots.append(pot)
    total = 0
    for pot in pots:
        total_visited = set()
        fence = 0
        visited = set()
        for x, row in enumerate(garden):
            for y, val in enumerate(row):
                if val == pot and (x, y) not in total_visited:
                    visited = recursion(pot, x, y, garden, visited)
                    for i, j in visited:
                        total_visited.add((i,j))
                        for m in range(-1, 2):
                            for n in range(-1,2):
                                if abs(m) == abs(n):
                                    continue
                                if (i+m, j+n) not in visited:
                                    fence +=1
                            
                    total += len(visited)*fence
                    print(pot, len(visited), fence)
                else:
                    fence =0
                    visited = set()

    print(total)


            
def p2():
    garden = get_input('./example.txt')
    pots = []

    for row in garden:
        for pot in row:
            if pot not in pots:
                pots.append(pot)
    total = 0
    for pot in pots:
        total_visited = set()
        fence = 0
        visited = set()
        region_map = []
        for i in range(len(garden)*2):
            new_row = []
            for j in range(len(garden[0])*2):
                new_row.append("")
            region_map.append(new_row)
        for x, row in enumerate(garden):
            for y, val in enumerate(row):
                if val == pot and (x, y) not in total_visited:
                    visited, region_map = recursionp2(pot, x, y, garden, region_map, visited)
                    for row in region_map:
                        print(row)
                    sides = 0
                    for i, j in visited:
                        total_visited.add((i,j))
                        for k, n in visited:
                            if i != k and j != n:
                                for m in range(-1, 2):
                                    for n in range(-1,2):
                                        if abs(m) != abs(n) and m !=0:
                                            if (i+m, j+n) not in visited:
                                                fence+=1
                            
                    total += len(visited)*fence
                    print(pot, len(visited), fence)

                    #print(direction_count)
                else:
                    fence =0
                    visited = set()

    print(total)

if __name__ == "__main__":
    p2()
