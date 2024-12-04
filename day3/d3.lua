-- regex should be something like this: mul\([0-9]{1,3},[0-9]{1,3}\)
-- answer 70478672
--s = 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))'
File = './test.txt'
io.input(File)
S = io.read('*all')
--S = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

function Find_occurences(p, d)
	local occurences = {}
	local i = 1
	while i < #S do
		local x, y = string.find(S, p, i, true)
		if d == true then
			if x ~= nil then table.insert(occurences, y); i = y+1 else break end
		else
			if x ~= nil then table.insert(occurences, x); i = y+1 else break end
		end
	end
	return occurences
end

function Extract_mults(inputs)
	local mults = {}
	for num in string.gmatch(inputs, "mul%(%d+,%d+%)") do
		 mults[#mults + 1] = num
	end
	return mults
end

function Mul(x, y)
	return x*y
end

function P2()
	local cleaned_string = ""
	local does = Find_occurences("do()", true)
	local donts = Find_occurences("don't()", false)
	local stop_index = donts[1]
	local start_index = nil
	local stop = false
	local index = 1
	for i=1, #S do
		if i>= stop_index then
			stop = true
			index = index + 1
			stop_index = donts[index]
		end
		if stop == true and i == start_index then
			stop = false
			for j=1,#does do
				if does[j] > stop_index then
					start_index = does[j]
				end
			end
		end
		print(start_index, stop_index)
		if stop == false then
			cleaned_string = cleaned_string..S:sub(i,i)
		end
	end
	--local index = 1
	--local stop = false
	--for i=1,#S do
	--	local cont_index = does[index]
	--	local stop_index = 
	--	cleaned_string = cleaned_string..S:sub(index, donts[i]-1)
	--	if does[i] == nil then
	--		break
	--	end
	--	for j=1,#does do
	--		if does[j] > donts[i] then index = does[j]; break end
	--	end

	--end
	--if donts[#donts] < does[#does] then
	--	cleaned_string = cleaned_string..S:sub(does[#does], -1)
	--end
	--local mults = Extract_mults(cleaned_string)
	--local sum = 0
	--for i=1,#mults do
	--	local f = mults[i]
	--	local num_pairs = {}
	--	for n in string.gmatch(f, "%d+") do
	--		if #n < 4 then table.insert(num_pairs, tonumber(n)) end
	--	end
	--	if #num_pairs == 2 then
	--		local n1, n2 = nil, nil
	--		for _, n in ipairs(num_pairs) do
	--			if _ == 1 then n1=n else n2=n end
	--		end
	--		sum =  sum + Mul(n1, n2)
	--	end
	--end
	--print(sum)
	--return sum
end
--print(S:sub(60,63))
P2()

function P1()
	local mults = Extract_mults(S)
	local sum = 0
	for i=1,#mults do
		local f = mults[i]
		local num_pairs = {}
		for n in string.gmatch(f, "%d+") do
			if #n < 4 then table.insert(num_pairs, tonumber(n)) end
		end
		if #num_pairs == 2 then
			local n1, n2 = nil, nil
			for _, n in ipairs(num_pairs) do
				if _ == 1 then n1=n else n2=n end
			end
			sum =  sum + Mul(n1, n2)
		end
	end
	return sum
end



local sum1 = P1()
print(sum1)
