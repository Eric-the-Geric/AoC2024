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

function find_start(map)
	for i, row in ipairs(map) do
		for j, val in ipairs(row) do
			if val == 'S' then return i, j end
		end
	end
end

local function rotate_dir_clockwise(dir)
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

local function rotate_dir_anticlockwise(dir)
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


function p1()
	local map = read_input()
	local x, y = find_start(map)
	local points = 0
	local turn = {
		cw = rotate_dir_clockwise,
		acw = rotate_dir_anticlockwise
	}

	while map[x][y] ~= 'E' do
		local vel = {-1, 0}
		local next = map[x+vel[1]][y+vel[2]]
		if next == "#" then
			local vel_cl = rotate_dir_clockwise(vel)
			local vel_acl = rotate_dir_anticlockwise(vel)

	end
end

p1()
