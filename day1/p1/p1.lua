--file = './example.txt'
file = './test.txt'
io.input(file)

numbers_left = { }
numbers_right = { }
count = 1
while true do

	local n1, n2 = io.read("*number", "*number")
	if not n1 then break end
	numbers_left[ count ] = n1
	numbers_right[ count ] = n2
	count = count + 1
end
table.sort(numbers_left)
table.sort(numbers_right)
distances = { }
for i, v in ipairs(numbers_left) do
	v2 = numbers_right[i]
	table.insert(distances, math.abs(v-v2))
end
sum = 0
for i, v in ipairs(distances) do
	sum = sum + v
end
print(sum)

