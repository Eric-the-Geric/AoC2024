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
	local index = 0
	for i=1,#report-1 do
		local num = report[i]
		local num2 = report[i+1]
		local distance = num - num2
		local abs_distance = math.abs(distance)
		check = check_distance(abs_distance)
		if check == false then index = i; break end
		if i == 1 then
			init_sign = check_sign(distance)
		else
			local sign = check_sign(distance)
			if init_sign ~= sign then
				check = false
				index = i
				break
			end
		end
	end
	return check, index
end
function generate_report(line, index)
	local report = { }
	for w in line:gmatch("%d+") do
		table.insert(report, w)
	end
	if index ~= 0 then
		table.remove(report, index)
	end
	return report
end

function p2_attemp2()
	local safe = 0
	for line in io.lines(file) do
		local check = false
		local count = 0
		local index = 0
		local rs = false
		::restart::
		local report = generate_report(line, index)
		for i=1,#report-1 do
			local new_report
			if rs == true then
				new_report = generate_report(line, index+1)
			else
				new_report = generate_report(line, index)
			end

			check, index= check_report(new_report)
			if check == false and count < 2 then
				count = count + 1
				rs = true
				if count == 1 then
					 index = index
				elseif count ==2 then
					index = index + 1
				end
				goto restart
			elseif check == true then safe = safe +1; break
			else
				break
			end

			if check == true then safe = safe +1 end
		end
	end
	return safe
end

function p2_attempt3()
	local safe = 0
	for line in io.lines(file) do
		local report = generate_report(line, 0)
		for i=1,#report do
			local new_report = generate_report(line, i)
			local check, _ = check_report(new_report)
			if check == true then safe = safe + 1; break end
		end
	end
	return safe
end
part1 = p1()
print(part1)
p2= p2_attempt3()
print(p2)
--p2_attempt1()


