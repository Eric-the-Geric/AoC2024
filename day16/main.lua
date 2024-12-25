--file = "./small_ex.txt"
file = "./example.txt"
io.input(file)

function read_input()
	local map = {}
	for line in io.lines() do
		local row = {}
		for char in line:gmatch(".") do
			row[#row+1] = char
		end
		map[#map+1] = row
	end
	return map
end

function find_square(map, letter)
	for i, row in ipairs(map) do
		for j, val in ipairs(row) do
			if val == letter then return i, j end
		end
	end
end

function same(dir)
	local rotation_matrix = {
		{1, 0},
		{0, 1}
	}
	local newdir = {
		dir[1] * rotation_matrix[1][1] + dir[2]*rotation_matrix[2][1],
		dir[1] * rotation_matrix[1][2] + dir[2]*rotation_matrix[2][2]
	}
	return newdir
end

function cw(dir)
	local rotation_matrix = {
		{0, -1},
		{1, 0}
	}
	local newdir = {
		dir[1] * rotation_matrix[1][1] + dir[2]*rotation_matrix[2][1],
		dir[1] * rotation_matrix[1][2] + dir[2]*rotation_matrix[2][2]
	}
	return newdir
end

function acw(dir)
	local rotation_matrix = {
		{0, 1},
		{-1, 0}
	}
	local newdir = {
		dir[1] * rotation_matrix[1][1] + dir[2]*rotation_matrix[2][1],
		dir[1] * rotation_matrix[1][2] + dir[2]*rotation_matrix[2][2]
	}
	return newdir
end

function create_points_map(map)
	local points_map = {}
	for i, row in ipairs(map) do
		local new_row = {}
		for j, val in ipairs(row) do
			new_row[#new_row+1] = 0
		end
		points_map[#points_map+1] = new_row
	end
	return points_map
end

function search(map, unexplored)
	local vel = unexplored[#unexplored].dir
	local points = unexplored[#unexplored].points
	local x, y = unexplored[#unexplored].x, unexplored[#unexplored].y
	print(points)
	unexplored[#unexplored] = nil
	local explored = {}
	local pointer = "*"
	while true do
		--print('start map')
		--for i, row in ipairs(map) do
		--	print(table.unpack(row, 1, #row))
		--end
		--print('end map')
		local vel_cw = cw(vel)
		local vel_acw = acw(vel)

		local next = map[x+vel[1]][y+vel[2]]
		local nextcw = map[x+vel_cw[1]][y+vel_cw[2]]
		local nextacw = map[x+vel_acw[1]][y+vel_acw[2]]
		if map[x][y] ~= "S" and map[x][y] ~= "E" then
			map[x][y] = pointer
		end

		if map[x][y] == "E" then
			break
		end

		if next ~= "#" and next ~= "*"then
			explored[#explored+1] = {x, y}
			x = x + vel[1]
			y = y + vel[2]
			points = points + 1
			if nextcw == "." then
				unexplored[#unexplored+1] = {dir=vel_cw, x=x, y=y, points=points}
			end
			if nextacw == "." then
				unexplored[#unexplored+1] = {dir=vel_acw, x=x, y=y, points=points}
			end

		elseif nextcw ~= "#" and nextcw ~= "*" then
			explored[#explored+1] = {x, y}
			if next == "." then
				unexplored[#unexplored+1] = {dir=vel, x=x, y=y, points=points}
			end
			if nextacw == "." then
				unexplored[#unexplored+1] = {dir=vel_acw, x=x, y=y, points=points}
			end
			x = x + vel_cw[1]
			y = y + vel_cw[2]
			points = points + 1000
			vel = vel_cw

		elseif nextacw ~= "#" and nextacw ~= "*" then
			explored[#explored+1] = {x, y}
			if next == "." then
				unexplored[#unexplored+1] = {dir=vel, x=x, y=y, points=points}
			end
			if nextcw == "." then
				unexplored[#unexplored+1] = {dir=vel_cw, x=x, y=y, points=points}
			end
			x = x + vel_acw[1]
			y = y + vel_acw[2]
			vel = vel_acw
			points = points + 1000
		else
			print(#unexplored)
			if #unexplored == 0 then
				return {}, map, 100000000000
			end
			x = unexplored[#unexplored].x
			y = unexplored[#unexplored].y
			vel = unexplored[#unexplored].dir
			points = unexplored[#unexplored].points
			unexplored[#unexplored] = nil
			local points_map = create_points_map(map)
			for i, xy in ipairs(explored) do
				points_map[xy[1]][xy[2]] = "S"
			end
			print("start")
			for i, row in ipairs(points_map) do
				print(table.unpack(row, 1, #row))
			end
			print("end")

		end
	end
	local points_map = create_points_map(map)
	for i, xy in ipairs(explored) do
		points_map[xy[1]][xy[2]] = "S"
	end
	print("start")
	for i, row in ipairs(points_map) do
		print(table.unpack(row, 1, #row))
	end
	print("end")

	return unexplored, map, points
end


function p1()
	local orig_map = read_input()
	local x, y = find_square(orig_map, "S")
	local initial = {{
			x=x,
			y=y,
			dir={0, 1},
			points=0
		}
	}
	local points = nil
	while true do
		local map = orig_map
		local unexplored, new_map, new_points = search(map, initial)
		if #unexplored == 0 then break end
		if points == nil then
			points = new_points
		elseif new_points < points then
			points = new_points
		end
		print(new_points)
		local sum = 0
		for i, row in ipairs(new_map) do
			for j, val in ipairs(row) do
				if val == "." then sum = sum + 1 end
			end
		end
		if sum == 0 then break end
		--map = new_map
		initial = unexplored
	end
	print(points)

end
p1()
