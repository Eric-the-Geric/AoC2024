File = './example.txt'
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
--[[
--create an index for each number in the print
--look at each role ofr that number in after. if the current number comes after that then it is incorrect?
--]]
function P1()
	local prints, rules = Read_input()
end

function P2()
end

P1()
