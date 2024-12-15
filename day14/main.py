import re
import numpy as np
import matplotlib.pyplot as plt
def read_input():
    file = "./input.txt"
    robots = []
    with open(file, 'r') as f:
        for line in f.readlines():
            nums = re.findall(r'\-?\d+', line)
            nums = [int(x) for x in nums]
            robots.append(nums)
    return robots


def p2():
    robots = read_input()
    x_bound = 101
    y_bound = 103
    robot_counts = []
    #seconds = 11
    variances = []

    for i in range(10000):
        new_robot_coords = []
        new_robot = []
        for robot in robots:
            x, y, dx, dy = robot
            x = (x + dx+x_bound)%x_bound
            y = (y+dy+y_bound)%y_bound
            new_robot.append([x, y, dx, dy])
            new_robot_coords.append((x, y))
        robots = new_robot

        robot_count = [[0 for _ in range(x_bound)] for h in range(y_bound)]
        for m, n in new_robot_coords:
            robot_count[n][m] += 1
        robot_count = np.array(robot_count)
        var = np.var(np.array(new_robot_coords))
        variances.append((i+1, var))
        robot_counts = robot_count
        if i == 6474:
            plt.imshow(robot_count)
            plt.title(f"{i+1}")
            plt.pause(10)
            plt.cla()
        #else:
        #    plt.imshow(robot_count)
        #    plt.title(f"{i+1}")
        #    plt.pause(0.1)
        #    plt.cla()

    #for row in robot_count:
       # print(row)

    center_x, center_y = y_bound//2, x_bound//2
    robot_counts = np.array(robot_counts)
    q1 = robot_counts[:center_x, :center_y]         # Top-left
    q2 = robot_counts[:center_x, center_y+1:]      # Top-right
    q3 = robot_counts[center_x+1:, :center_y]      # Bottom-left
    q4 = robot_counts[center_x+1:, center_y+1:]    # Bottom-right

    total_sum = 0 
    counts = []
    for q in [q1, q2, q3, q4]:
        count = 0
        for r in q:
            count+=sum(r)
        counts.append(count)
    
    for count in counts:
        if total_sum == 0:
            total_sum = count
        else:
            total_sum*=count
    print(total_sum)
    print(sorted(variances, key=lambda x: x[1])[0:5])
def p1():
    robots = read_input()
    x_bound = 101
    y_bound = 103
    new_robot_coords = []
    for robot in robots:
        x, y, dx, dy = robot
        for i in range(100):
            x = (x + dx+x_bound)%x_bound
            y = (y+dy+y_bound)%y_bound
        new_robot_coords.append((x, y))

    robot_count = [[0 for _ in range(x_bound)] for h in range(y_bound)]
    for j, i in new_robot_coords:
        robot_count[i][j] += 1
    robot_count = np.array(robot_count)


    center_x, center_y = y_bound//2, x_bound//2
    q1 = robot_count[:center_x, :center_y]         # Top-left
    q2 = robot_count[:center_x, center_y+1:]      # Top-right
    q3 = robot_count[center_x+1:, :center_y]      # Bottom-left
    q4 = robot_count[center_x+1:, center_y+1:]    # Bottom-right

    total_sum = 0 
    counts = []
    for q in [q1, q2, q3, q4]:
        count = 0
        for r in q:
            count+=sum(r)
            print(r)
        print()
        counts.append(count)
    print(counts)
    
    for count in counts:
        if total_sum == 0:
            total_sum = count
        else:
            total_sum*=count
    print(total_sum)


p2()


