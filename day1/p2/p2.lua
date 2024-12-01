--file = './example.txt'
file = './test.txt'
io.input(file)

n_left = { }
n_right = { }
count = 1
while true do
	local n1, n2 = io.read("*number","*number")
	table.insert(n_left, n1)
	table.insert(n_right, n2)
	count = count + 1
	if not n1 then break end
end

count_table = { }
for _, v in ipairs(n_left) do
	count = 0
	for tmp, v2 in ipairs(n_right) do
		if v == v2 then count = count + 1 end
	end
	table.insert(count_table, v*count)
end
sum = 0
for _, v in ipairs(count_table) do
	sum = sum + v
end
print(sum)
