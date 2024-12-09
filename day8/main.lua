File = "./input.txt"
io.input(File)
function read_input()
	local map = {}
	for line in io.lines() do
		local row = {}
		for c in line:gmatch('.') do
			row[#row+1] = c
		end
		map[#map+1] = row
	end
	return map
end

function _print2d(tbl)
	for _, row in ipairs(tbl) do
		print(table.unpack(row,1, #row))
	end
end

function _print1d(tble)
	print(table.unpack(tble, 1, #tble))
end

function calc_distance(p1, p2)
	return math.sqrt((p1[1]-p2[1])^2 + (p1[2] - p2[2])^2)
end

function make_coordinates(map)
	local cords = {}
	for i=1,#map do
		for j=1,#map[i] do
			if map[i][j] ~= '.' then
				local char = map[i][j]
				if cords[char] == nil then cords[char] = {{i,j}}
				else cords[char][#cords[char]+1] = {i, j}
				end
			end
		end
	end
	return cords
end

function get_antenna(cords)
	local unique_antenna = {}
	for k, v in pairs(cords) do
		unique_antenna[#unique_antenna+1] = k
	end
	return unique_antenna
end
function find_slope(y1, x1, y2, x2)
	return (y2-y1)/(x2-x1)
end
function find_intercept(point, m)
	return (m*point[2])/point[1]
end

function find_anti_node(point, distance, m, b)
	local y1 = (point[2]-distance)*m + b
	local x1 = (y1-b)/m
	return {math.floor(y1+0.5), math.floor(x1+0.5)}
end

function line_eq(p1, p2)
	-- y = mx + b
	local y1 = p1[1]
	local x1 = p1[2]
	local y2 = p2[1]
	local x2 = p2[2]
	local m = find_slope(y1, x1, y2, x2)
	local b = find_intercept(p1, m)
	return m, b
end
function p1()
	local map = read_input()
	_print2d(map)
	local cords = make_coordinates(map)
	local chars = get_antenna(cords)
	for _, c in ipairs(chars) do
		for i=1,#cords[c] do
			for j=1,#cords[c] do
				if i ~=j then
					local p1 = cords[c][i]
					local p2 = cords[c][j]
					local dx = p1[1] - p2[1]
					local dy = p1[2] - p2[2]
					if p1[1]+dx >= 1 and p1[1]+dx <= #map and p1[2] +dy >= 1 and p1[2] +dy <=#map[1] then
						map[p1[1]+dx][p1[2]+dy] = '#'
					end
				end
			end
		end
	end
	_print2d(map)
	local sum = 0
	for _, row in ipairs(map) do
		for _, val in ipairs(row) do
			if val == '#' then sum = sum +1 end
		end
	end
	print(sum)
end

function p2()
	local map = read_input()
	_print2d(map)
	local cords = make_coordinates(map)
	local chars = get_antenna(cords)
	for _, c in ipairs(chars) do
		for i=1,#cords[c] do
			for j=1,#cords[c] do
				if i ~=j then
					local p1 = cords[c][i]
					local p2 = cords[c][j]
					local dx = p1[1] - p2[1]
					local dy = p1[2] - p2[2]
					local nx, ny = p2[1], p2[2]
					while nx >= 1 and nx <= #map and ny >= 1 and ny <=#map[1] do
						map[nx][ny] = '#'
						nx = nx + dx
						ny = ny + dy
					end
				end
			end
		end
	end
	_print2d(map)
	local sum = 0
	for _, row in ipairs(map) do
		for _, val in ipairs(row) do
			if val == '#' then sum = sum +1 end
		end
	end
	print(sum)
end
p2()
