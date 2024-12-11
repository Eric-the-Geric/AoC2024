File = "./input.txt"
io.input(File)
function read_input()
	local map = {}
	for line in io.lines() do
		local row = {}
		for n in line:gmatch(".") do
			row[#row+1] = tonumber(n)
		end
		map[#map+1] = row
	end
	return map
end

-- how can we do this recursively? We need a base case
function find_neighbours(map, x, y, tally, covered_map)
	if map[x][y] == 9 then
		covered_map[x][y] = '#'
		tally = tally + 1
		return tally
	end
	local current = map[x][y]
	covered_map[x][y] = "#"
	for i=-1, 1 do
		for j=-1, 1 do
			if math.abs(i) ~= math.abs(j) and x+i <= #map and x+i > 0 and y+j <= #map[x] and y+j > 0 and covered_map[x+i][y+j] ~='#' then
				local neighbour = map[x+i][y+j]
				if neighbour - current == 1 then
					tally = find_neighbours(map, x+i, y+j, tally, covered_map)
				end
			end
		end
	end
	return tally
end

function make_covermap(map)
	local covered_map = {}
	for i, row in ipairs(map) do
		local new_row = {}
		for j, v in ipairs(row) do
			new_row[#new_row+1] = "."
		end
		covered_map[#covered_map+1] = new_row
	end
	return covered_map
end

function find_neighbours2(map, x, y, tally, covered_map)
	if map[x][y] == 9 then
		--covered_map[x][y] = '#'
		tally = tally + 1
		return tally
	end
	local current = map[x][y]
	covered_map[x][y] = "#"
	for i=-1, 1 do
		for j=-1, 1 do
			if math.abs(i) ~= math.abs(j) and x+i <= #map and x+i > 0 and y+j <= #map[x] and y+j > 0 then
				local neighbour = map[x+i][y+j]
				if neighbour - current == 1 then
					tally = find_neighbours2(map, x+i, y+j, tally, covered_map)
				end
			end
		end
	end
	return tally
end
function p2()
	local map = read_input()
	local trail_heads = {}
	for i, row in ipairs(map) do
		for j, val in ipairs(row) do
			if val == 0 then trail_heads[#trail_heads+1] = {i, j} end
		end
	end
	local score = 0
	for i, xy in ipairs(trail_heads) do
		local covered_map = make_covermap(map)
		--score = score + 
		local tally = find_neighbours2(map, xy[1], xy[2], 0, covered_map)
		print(tally)
		score = score + tally
	end
	print(score)
end

function p1()
	local map = read_input()
	local trail_heads = {}
	for i, row in ipairs(map) do
		for j, val in ipairs(row) do
			if val == 0 then trail_heads[#trail_heads+1] = {i, j} end
		end
	end
	local score = 0
	for i, xy in ipairs(trail_heads) do
		local covered_map = make_covermap(map)
		--score = score + 
		local tally = find_neighbours(map, xy[1], xy[2], 0, covered_map)
		score = score + tally
	end
	print(score)
end

p2()
