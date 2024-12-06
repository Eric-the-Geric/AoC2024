File = './input.txt'
io.input(File)

local function read_input()
	local board = {}
	for line in io.lines() do
		local row = {}
		for c in line:gmatch(".") do
			row[#row+1] = c
		end
		board[#board+1] = row
	end
	return board
end

local function find_guard(board)
	for i, row in ipairs(board) do
		for j, val in ipairs(row) do
			if val == '^' then return {j, i} end
		end
	end
end

local function rotate_dir(dir)
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

local function p1()
	local board = read_input()
	local guard_pos = find_guard(board)
	local dir = {0, -1}
	local distinct_pos = 0
	local move_count = 0
	while true do
		--print("start")
		--for _, row in ipairs(board) do
		--	print(table.unpack(row, 1, #row))
		--end
		local x, y = guard_pos[1], guard_pos[2]
		local dx, dy = dir[1], dir[2]
		if x +dx > #board[1] or x+dx < 1 or y +dy > #board or y +dy < 1 then break end
		if board[y+dy][x+dx] == "#" then dir = rotate_dir(dir)--; sum = sum + 1
		else
			if board[y+dy][x+dx] == "X" then distinct_pos = distinct_pos + 1 end
			board[y+dy][x+dx], board[y][x] = board[y][x], "X"
			guard_pos[1], guard_pos[2] = guard_pos[1]+dx, guard_pos[2] + dy
			move_count = move_count + 1
		end
		--print("end")
	end
	local final = move_count - distinct_pos
	local sum = 1
	for _, row in ipairs(board) do
		for _, val in ipairs(row) do
			if val == "X" then sum = sum + 1 end
		end
	end
	print(sum)
	--for _, row in ipairs(board) do
	--	print(table.unpack(row, 1, #row))
	--end
end


p1()
