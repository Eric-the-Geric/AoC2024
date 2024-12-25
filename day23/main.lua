file = "./input.txt"
io.input(file)
function read_input()
	local computers = {}
	for line in io.lines() do
		local pairs = {}
		for pc in line:gmatch("%w+") do
			pairs[#pairs+1] = pc
		end
		computers[#computers+1] = pairs
	end
	return computers
end

function find_unique(computers)
	local unique_computers = {}
	local uc = {}
	for i, pair in ipairs(computers) do
		for _, p in ipairs(pair) do
			if unique_computers[p] == nil then
				unique_computers[p] = {}
			end
		end
	end
	for k, v in pairs(unique_computers) do
		uc[#uc+1] = k
		print(k)
	end
	return uc
end

function construct_ktoi(uc)
	local ktoi = {}
	for i, k in ipairs(uc) do
		ktoi[k] = i
	end
	return ktoi
end
function p1()
	local computers = read_input()
	local uc = find_unique(computers)
	local ktoi = construct_ktoi(uc) -- key to value
	local adj_matrix = {}
	for i=1, #uc do
		local row = {}
		for j=1, #uc do
			row[#row+1] = 0
		end
		adj_matrix[#adj_matrix+1] = row
	end
	for i, k in ipairs(uc) do
		for _, pcs in ipairs(computers) do
			local p1 = pcs[1]
			local p2 = pcs[2]
			if k == p1 then
				adj_matrix[i][ktoi[p2]] = 1
				adj_matrix[ktoi[p2]][i] = 1
			elseif k == p2 then
				adj_matrix[i][ktoi[p1]] = 1
				adj_matrix[ktoi[p1]][i] = 1
			end
		end
	end
	local networks = {}
	local l = #adj_matrix
	for i=1, l do
		for j=i+1,l do
			if adj_matrix[i][j] == 1 then
				for k=j+1,l do
					if adj_matrix[i][j] == 1 and adj_matrix[k][j] == 1 and adj_matrix[k][i] == 1 then
						networks[#networks+1] = {uc[i], uc[j], uc[k]}
					end
				end
			end
		end
	end
	local new_networks = {}
	local count = 0
	for i, row in ipairs(networks) do
		for j, v in ipairs(row) do
			--v = uc[v]
			for c=1, #v do
				if v:sub(c,c) == "t" then new_networks[#new_networks+1] = row; count = count +1; goto here end
			end
		end
		::here::
	end
	for _, n in ipairs(new_networks) do
		print(table.unpack(n, 1, #n))
	end
	print(#new_networks)
	print(count)
end

p1()
