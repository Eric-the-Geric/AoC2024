File = './example.txt'
io.input(File)


function read_input()
	local inputs = {}
	for line in io.lines() do
		local numbers = {}
		for num in line:gmatch("%d+") do
			numbers[#numbers+1] = tonumber(num)
		end
		inputs[#inputs+1] = numbers
	end
	return inputs
end

function find_all_combinations(n_ops, n_combs)
	local index = 1
	local previous_comb = {}
	for i=1,n_combs do
		previous_comb[#previous_comb+1] = 0
	end
	local all_combs = {previous_comb}
	local offset = 1
	while #all_combs < n_ops^n_combs do
		local new_comb = {}
		for i, num in ipairs(previous_comb) do
			new_comb[#new_comb+1] = num
		end
		new_comb[index] = (new_comb[index]%n_ops + 1) %n_ops
		index = ((index + offset%index) % n_combs) + 1
		previous_comb = new_comb
		offset = offset + offset%n_combs
		all_combs[#all_combs+1] = previous_comb
	end
	print(#all_combs)
	for _, row in ipairs(all_combs) do
		print(table.unpack(row, 1,#row))
	end


end
function p1()
	local inputs = read_input()
	local operators = {"0", "1"}
	local num_operators = 0
	for _, line in ipairs(inputs) do
		num_operators = #line -2
		local operator_comb = {}
		for i=1, num_operators do
			local comb = {}
			for j=1, num_operators do
				comb[#comb+1] = operators[(i + j)%2 +1]
			end
			--print(#comb)
			--print(table.unpack(comb, 1, #comb))
			operator_comb[#operator_comb+1] = comb
		end
		print(#operator_comb)
		local answer = line[1]
		local eval = 0
		for i=2,#line do
		end

	end
end

function p2()
end

find_all_combinations(2, 3)
