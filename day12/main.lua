
File = "./example.txt"
io.input(File)

function read_input()
	local map = {}
	for line in io.lines() do
		local row = {}
		for pot in line:gmatch('.') do
			row[#row+1] = pot
		end
		map[#map+1] = row
	end
	return map
end

function check_neighbors(x, y, map)
	for i=-1, 1 do
		for j = -1,1 do
			if math.abs(i) ~= math.abs(j) then
				local neighbor = map[x +i][y+j]
				local pot = map[x][y]
				if pot == neighbor then return true end
			end
		end
	end
	return false
end

function area(map, area_tbl)
	for i=2, #map-1 do
		for j=2, #map[i]-1 do
			if check_neighbors(i, j, map) then
				area_tbl[map[i][j]] = area_tbl[map[i][j]] + 1
			end
		end
	end
end

function pad_map(map)
	local x = #map+2
	local y = #map[1]+2
	local padded_map = {}
	for i=1,x do
		local row = {}
		for j=1,y do
			row[#row+1] = "."
		end
		padded_map[#padded_map+1] = row
	end
	for i, row in ipairs(map) do
		for j, val in ipairs(row) do
			padded_map[i+1][j+1] = val
		end
	end
	return padded_map
end

function recursive_neighbours(x, y, pot, map, map_copy, region_tbl)
	for i=-1, 1 do
		for j = -1,1 do
			if math.abs(i) ~= math.abs(j) then
				local neighbor = map[x +i][y+j]
			end
		end
	end
end

function count_perimeter(x, y, pot, map, perimeter_tbl)
	for i=-1, 1 do
		for j = -1,1 do
			if math.abs(i) ~= math.abs(j) then
				local neighbor = map[x +i][y+j]
				if neighbor ~= pot then
					perimeter_tbl[pot] = perimeter_tbl[pot] + 1
				end
			end
		end
	end
end

function get_region_map( pot, map )
	local new_map = {}
	for i=2, #map-1 do
		local new_row = {}
		for j=2, #map[i]-1 do
			if map[i][j] == pot then
				new_row[#new_row+1] = "#"
			else
				new_row[#new_row+1] = "."
			end
		end
		new_map[#new_map+1] = new_row
	end
	return new_map
end

function p1()
	local map = read_input()
	local perimeter_tbl = {}
	local area_tbl= {}
	local pots = {}
	for i, row in ipairs(map) do
		for j, val in ipairs(row) do
			if perimeter_tbl[val] == nil then
				perimeter_tbl[val] = 0
				area_tbl[val] = 0
			end
		end
	end
	for k, v in pairs(area_tbl) do
		pots[#pots+1] = k
	end
	local padded_map = pad_map(map)
	for _, pot in ipairs(pots) do
		local region_map = get_region_map(pot, padded_map)
	end
end

p1()
