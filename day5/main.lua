File = './input.txt'
io.input(File)


function Read_input()
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
function P1()
	local prints, rules = Read_input()
	-- loop through the prints
	local clean_prints = {}
	for _, report in ipairs(prints) do
		-- initial loop through each value in print
		-- create a check to see if the print is valid
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
		if check == true then clean_prints[#clean_prints+1] = report end
		--break
	end
	local sum = 0
	for _, rep in ipairs(clean_prints) do
		print(table.concat(rep, ",", 1, #rep))
		local middle_num = tonumber(rep[(#rep+1)/2])
		sum = sum + middle_num
	end
	print(sum)
end

function P2()
end

P1()
