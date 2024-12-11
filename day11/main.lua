File = "./input.txt"
io.input(File)

function read_input()
	local stones = {}
	for num in io.read('a'):gmatch("%d+") do
		local stone = tonumber(num)
		stones[#stones+1] = stone
	end
	return stones
end

function read_input2()
	local stones = {}
	for num in io.read('a'):gmatch("%d+") do
		local stone = num
		stones[#stones+1] = stone
	end
	return stones
end

function return_new_stone(stone)
	if stone == 0 then return {1}
	elseif #tostring(stone)%2 == 0 then
		local new_stone = tostring(stone)
		local stone_length = #new_stone
		local s1 = ""
		local s2 = ""
		for i=1, stone_length do
			if i <= math.floor(stone_length/2+0.5) then
				s1 = s1..string.sub(new_stone, i, i)
			else
				s2 = s2..string.sub(new_stone, i,i)
			end
		end
		if s1.sub(1,1) == "0" then s1 = "0" end
		if s2.sub(1,1) == "0" then s2 = "0" end
		return {tonumber(s1), tonumber(s2)}
	else
		return {stone*2024}
	end
end

function p1()
	local stones = read_input()
	local blinks = {stones}
	local iterations = 25
	for it=1, iterations do
		print(it)
		local new_stones = {}
		for _, stone in ipairs(blinks[#blinks]) do
			local new_stone = return_new_stone(stone)
			for _, s in ipairs(new_stone) do
				new_stones[#new_stones+1] = s
			end
		end
		blinks[#blinks+1] = new_stones
	end
	print(#blinks[#blinks])

end

function return_new_stonep2(stone, map)
	if map[stone] then return map[stone], map end
	if stone == "0" then
		map["0"] = {"1"}
		return {"1"}, map
	elseif #stone%2 == 0 then
		local stone_length = #stone
		local s1 = ""
		local s2 = ""
		for i=1, stone_length do
			if i <= math.floor(stone_length/2+0.5) then
				s1 = s1..string.sub(stone, i, i)
			else
				s2 = s2..string.sub(stone, i,i)
			end
		end
		--if string.sub(s1, 1,1) == "0" then s1 = "0" end
		--if string.sub(s2, 1,1) == "0" then s2 = "0" end
		map[stone] = {tostring(tonumber(s1)), tostring(tonumber(s2))}
		return {tostring(tonumber(s1)), tostring(tonumber(s2))}, map
	else
		map[stone] = {tostring(tonumber(stone) * 2024)}
		return {tostring(tonumber(stone) * 2024)}, map
	end
end

function p3()
	local stones = read_input2()
	local blinks = {stones}
	local iterations = 75
	local map = {}
	local count = 0
	for it=1, iterations do
		print(it)
		local new_stones = {}
		for _, stone in ipairs(blinks[#blinks]) do
			local new_stone, map = return_new_stonep2(stone, map)
			for _, s in ipairs(new_stone) do
				new_stones[#new_stones+1] = s
			end
		end
		blinks[#blinks+1] = new_stones
	end
	print(#blinks[#blinks])
end

function p2()
	local stones = read_input2()
	local blinks = 4
	local stone_count = {}
	for _, stone in ipairs(stones) do
--		print(stone)
		if stone_count[stone] then stone_count[stone] = stone_count[stone] + 1 else stone_count[stone] = 1 end
	end
	for it=1, blinks do
		local new_stones = {}
		for stone, count in pairs(stone_count) do
			if stone == "0" then
				if new_stones["1"] ~= nil then new_stones["1"] = new_stones["1"] + count else new_stones["1"] = 1 end
			elseif #stone%2 == 0 then
				local stone_length = #stone
				local left = ""
				local right = ""
				for i=1, stone_length do
					if i <= math.floor(stone_length/2+0.5) then
						left = left..string.sub(stone, i, i)
					else
						right = right..string.sub(stone, i,i)
					end
				end
				left = tostring(tonumber(left))
				right = tostring(tonumber(right))
				if new_stones[left] ~= nil then new_stones[left] = new_stones[left] + count else new_stones[left] = count end
				if new_stones[right] ~= nil then new_stones[right] = new_stones[right] + count else new_stones[right] = count end
			else
				local new_stone = tostring(tonumber(stone) * 2024)
				if new_stones[new_stone] ~= nil then
					new_stones[new_stone] = new_stones[new_stone] + count
				else new_stones[new_stone] = count
				end
			end
		end
		for k, v in pairs(new_stones) do
			print(k, v)
		end
		stone_count = new_stones
	end
	local sum = 0
	for k, v in pairs(stone_count) do
--		print(k, v)
		sum = sum + v
	end
	print(sum)
end

p2()
