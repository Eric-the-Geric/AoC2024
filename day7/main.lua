File = './input.txt'
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
    local all_combinations = {}
    local total_combinations = n_ops^n_combs

    for i = 0, total_combinations - 1 do
        local combination = {}
        for j = 1, n_combs do
            table.insert(combination, math.floor(i / (n_ops^(j-1))) % n_ops)
        end
        table.insert(all_combinations, combination)
    end
	return all_combinations
end

function p1()
	local inputs = read_input()
	local true_answer = 0
	for _, line in ipairs(inputs) do
		local answer = line[1]
		local n_ops = 2
		local n_combs = #line-2
		local combs = find_all_combinations(n_ops, n_combs)
		for tmp, ops in ipairs(combs) do
			local sum = line[2]
			for i=3, #line do
				if ops[i-2] == 0 then sum = sum + line[i]
				else
					sum = sum * line[i]
				end
			end
			if sum == answer then true_answer = true_answer + sum; break end
		end
	end
	print(true_answer)
end

function p2()
	local inputs = read_input()
	local true_answer = 0
	for _, line in ipairs(inputs) do
		local answer = line[1]
		local n_ops = 3
		local n_combs = #line-2
		local combs = find_all_combinations(n_ops, n_combs)
		for tmp, ops in ipairs(combs) do
			local sum = line[2]
			for i=3, #line do
				if ops[i-2] == 0 then sum = sum + line[i]
				elseif ops[i-2] == 1 then sum = sum * line[i]
				else
					sum = tonumber(tostring(sum) .. tostring(line[i]))

				end
			end
			if sum == answer then true_answer = true_answer + sum; break end
		end
	end
	print(true_answer)
end
p2()
