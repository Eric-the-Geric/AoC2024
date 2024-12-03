-- regex should be something like this: mul\([0-9]{1,3},[0-9]{1,3}\)

--s = 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))'
--file = './test.txt'
--io.input(file)
s = io.read('*all')
--s = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

function p2()
	local new_string = ""
	for i=1,#s do
		local c= s.sub(i,i)
		
end
function extract_mults(inputs)
	local mults = {}
	for num in string.gmatch(inputs, "mul%(%d+,%d+%)") do
		 mults[#mults + 1] = num
	end
	return mults
end

function p1()
	local mults = extract_mults(s)
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
			sum =  sum + mul(n1, n2)
		end
	end
	return sum
end

function mul(x, y)
	return x*y
end

local sum1 = p1()
print(sum1)
