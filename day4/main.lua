File = "./test.txt"
io.input(File)

function Construct_board()
	local board = {}
	for line in io.lines() do
		local row = {}
		for i=1,#line do
			row[#row+1] = line:sub(i,i)
		end
		board[#board+1] = row
	end
	return board
end

function Get_words(row)
	local words = {}
	for i=1,#row do
		if i+3 > #row then break end
		local word = ""
		local idx = i
		while #word < 4 do
			word = word..row[idx]
			idx = idx + 1
		end
		words[#words+1] = word
	end
	return words
end

function Extract_diaganol(board, start_row, start_col)
	local diag = {}
	local r, c = start_row, start_col
	while r < #board and c < #board[r] do
		diag[#diag+1] = board[r][c]
		r = r + 1
		c = c + 1
	end
	return diag
end

function Extract_diaganol2(board, start_row, start_col)
	local diag = {}
	local r, c = start_row, start_col
	while r < #board and c > 0 do
		diag[#diag+1] = board[r][c]
		r = r + 1
		c = c - 1
	end
	return diag
end

function P1()
	local board = Construct_board()
	local all_words = {}

	-- horizontal words
	local horizontal_forward = {}
	for i=1,#board do
		local row = {}
		for j=1,#board[i] do
			row[#row+1] = board[i][j]
		end
		horizontal_forward[#horizontal_forward+1] = row
	end
	for i, row in ipairs(horizontal_forward) do
		local words = Get_words(row)
		for _, w in ipairs(words) do
			print(w)
			all_words[#all_words+1] = w
		end
	end

	-- vertical
	local vertical_forward = {}
	for i=1,#board do
		local row = {}
		for j=1,#board[i] do
			row[#row+1] = board[j][i]
		end
		vertical_forward[#vertical_forward+1] = row
	end

	for i, row in ipairs(vertical_forward) do
		local words = Get_words(row)
		for _, w in ipairs(words) do
			print(w)
			all_words[#all_words+1] = w
		end
	end

	-- diagonal
	local diagonal_forward = {}
	for i=1,#board do
		diagonal_forward[#diagonal_forward+1] = Extract_diaganol(board, i, 1)
	end
	for i=1,#board[1] do
		diagonal_forward[#diagonal_forward+1] = Extract_diaganol(board, 1, i)
	end
	for i, row in ipairs(diagonal_forward) do
		local words = Get_words(row)
		for _, w in ipairs(words) do
			print(w)
			all_words[#all_words+1] = w
		end
	end

	local diagonal_reverse = {}
	for i=1,#board do
		diagonal_reverse[#diagonal_reverse+1] = Extract_diaganol2(board, i, #board[1])
	end

	for i = #board, 1, -1 do
		diagonal_reverse[#diagonal_reverse+1] = Extract_diaganol2(board, 1, i)
	end

	for i, row in ipairs(diagonal_reverse) do
		local words = Get_words(row)
		for _, w in ipairs(words) do
			print(w)
			all_words[#all_words+ 1] = w
		end
	end
	local sum = 0
	for _, w in ipairs(all_words) do
		if w == "XMAS" or w == "SAMX" then sum = sum +1 end
	end
	print(sum)
end

BOARD = Construct_board()

function Traverse(x, y, num, match, dir)
	local count = 0
	for _, d in ipairs(dir) do
		local i = 1
		while i <=#match do
			if x + d[1]*i < 1 or x + d[1]*i > #BOARD then break end
			if y + d[2]*i < 1 or y + d[2]*i > #BOARD[1] then break end
			local letter = BOARD[x+d[1]*i][y+d[2]*i]
			if letter == nil then
				break
			elseif letter == match[i] then
				i = i +1
			else break
			end
		end
		if i == num then count = count +1 end
	end
	return count
end


function P1_attempt2()
	local match = {"M","A","S"}
	local directions = {
		{-1, -1}, --NW
		{-1, 0}, --N
		{-1, 1}, --NE
		{0, 1}, --E
		{1, 1},--SE
		{1, 0},--S
		{1, -1},--SW
		{0, -1},--W
	}
	local count = 0
	for i=1,#BOARD do
		for j=1,#BOARD[i] do
			if BOARD[i][j] == "X" then
				count = count + Traverse(i, j, 4, match, directions)
			end
		end
	end
	print("p1 count =", count)
end

function Traversep2(x, y, match, dir)
	local prev_letter = nil
	for i, d in ipairs(dir) do
			if x + d[1] < 1 or x + d[1] > #BOARD then break end
			if y + d[2] < 1 or y + d[2] > #BOARD[1] then break end
			local letter = BOARD[x+d[1]][y+d[2]]
			if prev_letter == nil then
				if letter == match[1] or letter == match[2] then
					prev_letter = letter
				else break
				end
			elseif prev_letter == "M" and letter == "S" then
				return 1
			elseif prev_letter == "S" and letter == "M" then
				return 1
			else return 0
			end
	end
	return 0
end

function P2()
	local match = {"M","S"}
	local dir1 = {
		{-1, 1}, --NE
		{1, -1},--SW
	}
	local dir2 = {
		{-1, -1}, --NW
		{1, 1}--SE
	}
	local count = 0
	for i=1,#BOARD do
		for j=1,#BOARD[i] do
			if BOARD[i][j] == "A" then
				local count1 = Traversep2(i, j, match, dir1)
				local count2 = Traversep2(i, j, match, dir2)
				if count1 + count2 == 2 then count = count + 1 end
			end
		end
	end
	print("p1 count =", count)
end
--P1_attempt2()
P2()
