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

	--local horizontal_reverse = {}
	--for i=#board, 1, -1 do
	--	local row = {}
	--	for j=#board[i],1,-1 do
	--		row[#row+1] = board[i][j]
	--	end
	--	horizontal_reverse[#horizontal_reverse+1] = row
	--end
	--for i, row in ipairs(horizontal_reverse) do
	--	local words = Get_words(row)
	--	for _, w in ipairs(words) do
	--		all_words[#all_words+1] = w
	--	end
	--end

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

	--local vertical_reverse = {}
	--for i=#board, 1, -1 do
	--	local row = {}
	--	for j=#board[i],1,-1 do
	--		row[#row+1] = board[j][i]
	--	end
	--	vertical_reverse[#vertical_reverse+1] = row
	--end

	--for i, row in ipairs(vertical_reverse) do
	--	local words = Get_words(row)
	--	for _, w in ipairs(words) do
	--		all_words[#all_words+1] = w
	--	end
	--end

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




	--local diagonal_reverse = {}
	--for i=#board,1,-1 do
	--	local row = {}
	--	for j=#board[i],1,-1 do
	--		for k=#board,1+i,-1 do
	--			for m=#board,1+j,-1 do
	--				if k == m then
	--					row[#row+1] = board[i-k][j-m]
	--				end
	--			end
	--		end
	--	end
	--	diagonal_reverse[#diagonal_reverse+1] = row
	--end

	--for i, row in ipairs(diagonal_reverse) do
	--	local words = Get_words(row)
	--	for _, w in ipairs(words) do
	--		all_words[#all_words+1] = w
	--	end
	--end
	local sum = 0
	for _, w in ipairs(all_words) do
		if w == "XMAS" or w == "SAMX" then sum = sum +1 end
	end
	print(sum)
end


P1()
