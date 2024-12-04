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
		if i+4 > #row then break end
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
			all_words[#all_words+1] = w
		end
	end

	-- diagonal
	local diagonal_forward = {}
	for i=1,#board do
		local row = {}
		for j=1,#board[i] do
			for k=1,#board-i do
				for m=1,#board-j do
					row[#row+1] = board[i+k][j+m]
				end
			end
		end
		diagonal_forward[#diagonal_forward+1] = row
	end

	for i, row in ipairs(diagonal_forward) do
		local words = Get_words(row)
		for _, w in ipairs(words) do
			all_words[#all_words+1] = w
		end
	end

	local sum = 0
	for _, w in ipairs(all_words) do
		if w == "XMAS" then sum = sum +1 end
	end
	print(sum)

	-- diagonal
end


P1()
