file = "./input.txt"
--file = "./example.txt"
io.input(file)
I = 71
J = 71
N_BYTES = 1024
--I = 7
--J = 7
--N_BYTES = 12
function read_input2()
	local coords = {}
	for line in io.lines() do
		local xy = {}
		for n in line:gmatch("%d+") do
			xy[#xy+1] = tonumber(n)+1
		end
		coords[#coords+1] = xy
	end
	return coords
end
function read_input()
	local map = {}
	for i=1,I do
		local row = {}
		for j=1,J do
			row[#row+1] = "."
		end
		map[#map+1] = row
	end
	local bytes = 1
	for line in io.lines() do
		if bytes > N_BYTES then break end
		local xy = {}
		for n in line:gmatch("%d+") do
			xy[#xy+1] = tonumber(n)+1
		end
		map[xy[2]][xy[1]] = "#"
		bytes = bytes + 1
	end
	return map
end

function p1()
	local map = read_input()
	--for _, row in ipairs(map) do
	--	print(table.unpack(row, 1, #row))
	--end
	local step_map = {}
	for i=1,#map do
		local row = {}
		for j=1,#map do
			row[#row+1] = 0
		end
		step_map[#step_map+1] = row
	end
	local start = {1,1}
	local fin = {I,J}
	local queue = {{x=start[1],y=start[2]}}
	while #queue > 0 do
		local node = table.remove(queue, 1)
		if node.x == fin[1] and node.y == fin[2] then print(step_map[node.x][node.y]); break end
		map[node.x][node.y] = "O"
		--step_map[node.x][node.y] = 1
		for i=-1,1 do
			for j=-1,1 do
				if math.abs(i) ~= math.abs(j) then
					if node.x +i > 0 and
						node.y +j >0 and
						node.x+i <=J and
						node.y+j <=J and
						map[node.x+i][node.y+j] == "." and
						step_map[node.x+i][node.y+j] == 0 then
						table.insert(queue, #queue+1, {x=node.x+i, y=node.y+j})
						step_map[node.x+i][node.y+j] = step_map[node.x][node.y]+1
					end
				end
			end
		end
		--for _, row in ipairs(step_map) do
		--	print(table.unpack(row, 1, #row))
		--end
	end
end
function construct_map(coords, iteration)
	local map = {}
	for i=1,I do
		local row = {}
		for j=1,J do
			row[#row+1] = "."
		end
		map[#map+1] = row
	end
	for i, xy in ipairs(coords) do
		if i > iteration then break end
		map[xy[2]][xy[1]] = "#"
	end
	return map, {coords[iteration][1], coords[iteration][2]}
end
function p2()
	local coords = read_input2()
	local iteration = 1024
	while true do
		local map, last_coord = construct_map(coords, iteration)
		local step_map = {}
		for i=1,#map do
			local row = {}
			for j=1,#map do
				row[#row+1] = 0
			end
			step_map[#step_map+1] = row
		end
		local start = {1,1}
		local fin = {I,J}
		local queue = {{x=start[1],y=start[2]}}
		local found = false
		while #queue > 0 do
			local node = table.remove(queue, 1)
			if node.x == fin[1] and node.y == fin[2] then found=true; break end
			map[node.x][node.y] = "O"
			--step_map[node.x][node.y] = 1
			for i=-1,1 do
				for j=-1,1 do
					if math.abs(i) ~= math.abs(j) then
						if node.x +i > 0 and
							node.y +j >0 and
							node.x+i <=J and
							node.y+j <=J and
							map[node.x+i][node.y+j] == "." and
							step_map[node.x+i][node.y+j] == 0 then
							table.insert(queue, #queue+1, {x=node.x+i, y=node.y+j})
							step_map[node.x+i][node.y+j] = step_map[node.x][node.y]+1
						end
					end
				end
			end
		end
		if found == false then
			print("map has been obstructed")
			print(last_coord[1]-1, last_coord[2]-1)
			break
		else
			iteration = iteration +1
		end
	end
end
p2()
