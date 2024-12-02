with open('./test.txt') as f:
    lines = f.readlines()
    reports = []
    for line in lines:
        line = line.replace('\n', "")
        line = line.split(" ")
        line = [int(x) for x in line]
        reports.append(line)

def is_safe(report):
    if report != sorted(report) and report != sorted(report, reverse=True):
        return False
    for x, y in zip(report, report[1:]):
        if x == y:
            return False
        if not 0 < abs(x - y) < 4:
            return False
    return True

print(sum(is_safe(report) for report in reports))
# p1 421 is correct and in my lua i get 431?? where are the extra 10 coming from...
print(sum(is_safe(report) or any(is_safe(report[:i] + report[i + 1:]) for i in range(len(report))) for report in reports))
