file = "./test.txt"
io.input(file)

function check_sign(distance)
	local normalized = distance/math.abs(distance)
	if normalized < 0 then return '-' else return '+' end
end

function check_distance(dist)
	if dist == 0 then
		return false
	elseif dist <1 then
		return false
	elseif dist >3 then
		return false
	else
		return true
	end
end

function p1 ()
	local safe = 0
	for line in io.lines(file) do
		local report = { }
		local check = false
		for w in line:gmatch("%d+") do
			table.insert(report, w)
		end
		local init_sign = nil
		for i=1,#report-1 do
			local num = report[i]
			local num2 = report[i+1]
		--	print(num, num2)
			local distance = num - num2
			local abs_distance = math.abs(distance)
			check = check_distance(abs_distance)
			if check == false then break end
			if i == 1 then
				init_sign = check_sign(distance)
			else
				local sign = check_sign(distance)
				if init_sign ~= sign then
					check = false
					break
				end
			end
		end
		if check == true then safe = safe +1 end
	end
	return safe
end

function p2_attempt1()
	local safe = 0
	for line in io.lines(file) do
		local report = { }
		local check = false
		for w in line:gmatch("%d+") do
			table.insert(report, w)
		end
		local init_sign = nil
		local i = 1
		local counter = 0
		while i < #report -1 and counter < 2 do
		::restart::
			local num = report[i]
			local num2 = report[i+1]
			local distance = num - num2
			local abs_distance = math.abs(distance)
			check = check_distance(abs_distance)
			if check == false and counter == 0 then
				table.remove(report, i+1)
				counter = counter + 1
				goto restart
			elseif check == false and counter > 0 then
				break
			end
			if i == 1 then
				init_sign = check_sign(distance)
			else
				local sign = check_sign(distance)
				if init_sign ~= sign and counter == 0 then
					check = false
					table.remove(report, i+1); counter = counter + 1; goto restart
				elseif init_sign ~= sign and counter > 0 then
					check = false
					break
				end
			end
			i = i + 1
		end
		if check == true then safe = safe +1 end
	end
	print(safe)
end


function check_report(report)
	local init_sign = nil
	local check = false
	for i=1,#report-1 do
		local num = report[i]
		local num2 = report[i+1]
		local distance = num - num2
		local abs_distance = math.abs(distance)
		check = check_distance(abs_distance)
		if check == false then break end
		if i == 1 then
			init_sign = check_sign(distance)
		else
			local sign = check_sign(distance)
			if init_sign ~= sign then
				check = false
				break
			end
		end
	end
	return check
end
function generate_report(line)
	local report = { }
	for w in line:gmatch("%d+") do
		table.insert(report, w)
	end
	return report
end

function p2_attemp2()
	local safe = 0
	for line in io.lines(file) do
		local report = { }
		local check = false
		for w in line:gmatch("%d+") do
			table.insert(report, w)
		end
		for i=1,#report-1 do
			local new_report = generate_report(line)
			check = check_report(report)
			if check == false then
			if check == true then safe = safe +1 end
	end
	return safe
end

