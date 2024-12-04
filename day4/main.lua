File = "./example.txt"
io.input(File)

function Construct_board()
	local board = {}
	for line in io.lines() do
		print(line)
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
	for _, m in ipairs(match) do
		for k, d in pairs(dir) do
			print(d)
		end
	end
end

function P1_attempt2()
	local match = {"M","A","S"}
	local directions = {
		NW={-1, -1}, --NW
		N={-1, 0}, --N
		NE={-1, 1}, --NE
		E={0, 1}, --E
		SE={1, 1},--SE
		S={1, 0},--S
		SW={1, -1},--SW
		W={0, -1},--W
	}
	local count = 0
	for i=1,#BOARD do
		for j=1,#BOARD[i] do
			if BOARD[i][j] == "X" then
			--	count = count + 
				Traverse(i, j, match, directions)
			end
		end
	end
end

P1_attempt2()
