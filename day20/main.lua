file = "./input.txt"
io.input(file)

function read_input()
	local map = {}
	for line in io.lines() do
		local row = {}
		for c in line:gmatch(".") do
			row[#row+1] = c
		end
		map[#map+1] = row
	end
	return map
end

function find_square(map, letter)
	for i, row in ipairs(map) do
		for j, val in ipairs(row) do
			if val == letter then return {x=i, y=j} end
		end
	end
end

function find_walls(map)
	local walls = {}
	for i, row in ipairs(map) do
		for j, val in ipairs(row) do
			if val == "#" then walls[#walls+1] = {i, j} end
		end
	end
	return walls
end

function create_steps(map) 
	local step_map = {}
	for i=1,#map do
		local row = {}
		for j=1,#map[i] do
			row[#row+1] = 0
		end
		step_map[#step_map+1] = row
	end
	return step_map

end

function BFS(start, finish, map, step_map)
	local queue = {start}
	while #queue > 0 do
		local node = table.remove(queue, 1)
		if node.x == finish.x and node.y == finish.y then return step_map[node.x][node.y] end
		local x, y = node.x, node.y
		for i=-1,1 do
			for j=-1,1 do
				if math.abs(i) ~= math.abs(j) then
					if x + i > 0 and y+j > 0 and x+i <= #map and y+j <=#map[x] and step_map[x+i][y+j] == 0 and map[x+i][y+j] ~="#" then
						step_map[x+i][y+j] = step_map[x][y] + 1
						table.insert(queue, {x=x+i, y=y+j})
					end
				end
			end
		end
	end
end

function copy_map(map)
	local new_map = {}
	for i, row in ipairs(map) do
		local new_row = {}
		for j, val in ipairs(row) do
			new_row[#new_row+1] = val
		end
		new_map[#new_map+1] = new_row
	end
	return new_map
end

function p1()
	local map = read_input()
	local s = find_square(map, "S")
	local e = find_square(map, "E")
	local walls = find_walls(map)
	local steps_map = create_steps(map)
	local initial_speed = BFS(s, e, map, steps_map)
	local count = 0
	for i, pos in ipairs(walls) do
		local step_map = create_steps(map)
		local map_copy = copy_map(map)
		map_copy[pos[1]][pos[2]] = "."
		local speed = BFS(s, e, map_copy, step_map)
		if initial_speed - speed >= 100 then count = count + 1 end
	end
	print(count)
end

function calc_distance(p1, p2)
	local dist = math.abs(p1[1] - p2[1] + p1[2] - p2[2])
	return dist
end
function BFS2(start, finish, map, step_map, initial_speed)
	local queue = {start}
	local count = 0
	while #queue > 0 do
		print(#queue)
		local node = table.remove(queue, 1)
		if node.x == finish.x and node.y == finish.y then print(#queue); if initial_speed - step_map[node.x][node.y] >= 100 then count = count + 1 end end
		local x, y = node.x, node.y
		for i=-1,1 do
			for j=-1,1 do
				if math.abs(i) ~= math.abs(j) then
					if x + i > 0 and y+j > 0 and x+i <= #map and y+j <=#map[x] then
						if map[x+i][y+j] == "#" then
							if initial_speed - calc_distance({x, y}, {finish.x, finish.y}) < 20 and (step_map[x+i][y+j] == 0 or step_map[x][y]+ 1 < step_map[x+i][y+j]) then
								step_map[x+i][y+j] = step_map[x][y] + 1
								table.insert(queue, {x=x+i, y=y+j})
							end
						else
							step_map[x+i][y+j] = step_map[x][y] + 1
							table.insert(queue, {x=x+i, y=y+j})
						end
					end
				end
			end
		end
	end
	return count
end

function p2()
	local map = read_input()
	local s = find_square(map, "S")
	local e = find_square(map, "E")
	local step_map = create_steps(map)
	local initial_speed = BFS(s, e, map, step_map)
	local counts = BFS2(s, e, map, step_map, initial_speed)
	print(counts)
end
p2()
--p1()
