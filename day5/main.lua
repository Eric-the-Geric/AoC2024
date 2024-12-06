File = './input.txt'
io.input(File)


local function Read_input()
	local rules = {}
	local prints = {}
	local printing = false
	for line in io.lines() do
		if printing == true then
			local print_line = {}
			for num in line:gmatch("%d+") do
				print_line[#print_line+1] = num
			end
			prints[#prints+1] = print_line
		else
			if line == "" then printing = true
			else
				local rule = {}
				for num in line:gmatch("%d+") do
					if num == nil then printing = true; print('here'); break
					else
						rule[#rule+1] = tonumber(num)
					end

				end
				if #rule ~= 0 then
					rules[#rules+1] = rule
				end
			end
		end
	end
	return prints, rules
end


local function Check(report, rules)
	local check = true
	for i, initial_v in ipairs(report) do
		initial_v = tonumber(initial_v)
		-- loop through ruleset and find a rule that has v in it
		for _, rule in ipairs(rules) do
			local before = rule[1]
			local after = rule[2]
			if initial_v == before then
				for index, v in ipairs(report) do
					v = tonumber(v)
					if v == after then
						if index < i then check = false break end
					end
				end
			end
		end
	end
	return check
end
local function Check_prints(prints, rules, correct)
	local clean_prints = {}
	for _, report in ipairs(prints) do
		-- initial loop through each value in print
		-- create a check to see if the print is valid
		local check = Check(report, rules)
		if correct then
			if check == true then clean_prints[#clean_prints+1] = report end
		else
			if check == false then clean_prints[#clean_prints+1] = report end
		end
	end
	return clean_prints
end

local function P1(prints, rules)
	--local prints, rules = Read_input()
	-- loop through the prints
	local clean_prints = Check_prints(prints, rules, true)
	local sum = 0
	for _, rep in ipairs(clean_prints) do
		--print(table.concat(rep, ",", 1, #rep))
		local middle_num = tonumber(rep[(#rep+1)/2])
		sum = sum + middle_num
	end
	return sum
end

local function Sort_prints(clean_prints, rules)
	local sorted_prints = {}
	for _, report in ipairs(clean_prints) do
		while not Check(report, rules) do
			for i, initial_v in ipairs(report) do
				initial_v = tonumber(initial_v)
				-- loop through ruleset and find a rule that has v in it
				for _, rule in ipairs(rules) do
					local before = rule[1]
					local after = rule[2]
					if initial_v == before then
						for index, v in ipairs(report) do
							v = tonumber(v)
							if v == after then
								if index < i then report[index], report[i] = report[i], report[index]; break end
							end
						end
					end
				end
			end
		end
		sorted_prints[#sorted_prints+1] = report
	end
	return sorted_prints
end

local function P2(prints, rules)
	--local prints, rules = Read_input()
	local clean_prints = Check_prints(prints, rules, false)
	local sorted_prints = Sort_prints(clean_prints, rules)

	local sum = 0
	for _, rep in ipairs(sorted_prints) do
		--print(table.concat(rep, ",", 1, #rep))
		local middle_num = tonumber(rep[(#rep+1)/2])
		sum = sum + middle_num
	end
	return sum
end
local prints, rules = Read_input()
local p1_sum = P1(prints, rules)
local p2_sum = P2(prints, rules)

print("p1", p1_sum)
print("p2", p2_sum)

