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
	while true do
		local x, y = guard_pos[1], guard_pos[2]
		local dx, dy = dir[1], dir[2]
		if x +dx > #board[1] or x+dx < 1 or y +dy > #board or y +dy < 1 then break end
		if board[y+dy][x+dx] == "#" then dir = rotate_dir(dir)
		else
			board[y+dy][x+dx], board[y][x] = board[y][x], "X"
			guard_pos[1], guard_pos[2] = guard_pos[1]+dx, guard_pos[2] + dy
		end
	end
	local sum = 1
	for _, row in ipairs(board) do
		for _, val in ipairs(row) do
			if val == "X" then sum = sum + 1 end
		end
	end
	print(sum)
end

function play_game(board)
	local guard_pos = find_guard(board)
	local dir = {0, -1}
	local counter_board = {}
	for i=1,#board do
		local row = {}
		for j=1, #board[1] do
			row[#row+1] = 0
		end
		counter_board[#counter_board+1] = row
	end
	while true do
		local x, y = guard_pos[1], guard_pos[2]
		local dx, dy = dir[1], dir[2]
		if x +dx > #board[1] or x+dx < 1 or y +dy > #board or y +dy < 1 then return 0, guard_pos end
		if board[y+dy][x+dx] == "#" then
			dir = rotate_dir(dir)
			counter_board[y+dy][x+dx] = counter_board[y+dy][x+dx] + 1
			if counter_board[y+dy][x+dx] == 4 then return 1, guard_pos end
		else
			--board[y+dy][x+dx], board[y][x] = board[y][x], board[y+dy][x+dx]
			guard_pos[1], guard_pos[2] = guard_pos[1]+dx, guard_pos[2] + dy
		end
	end
end

function p2()
	local board = read_input()
	local sum = 0
	local original_guard_pos = find_guard(board)
	for i = 1, #board do
		for j =1, #board[1] do
			if board[i][j] ~= "#" and board[i][j] ~= "^" then
				board[i][j] = "#"
				--for _, row in ipairs(board) do
				--	print(table.unpack(row, 1, #row))
				--end
				local count, guard_pos = play_game(board)
				sum = sum + count
				board[i][j] = "."
				board[guard_pos[2]][guard_pos[1]] = "."
				board[original_guard_pos[2]][original_guard_pos[1]] = '^'
				--print(original_guard_pos[1], original_guard_pos[2])
			end
		end
	end
	print(sum)
end

p2()
