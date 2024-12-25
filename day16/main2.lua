--file = "./small_ex.txt"
file = "./example.txt"
io.input(file)

function read_input()
	local map = {}
	for line in io.lines() do
		local row = {}
		for char in line:gmatch(".") do
			row[#row+1] = char
		end
		map[#map+1] = row
	end
	return map
end

function find_square(map, letter)
	for i, row in ipairs(map) do
		for j, val in ipairs(row) do
			if val == letter then return i, j end
		end
	end
end

function same(dir)
	local rotation_matrix = {
		{1, 0},
		{0, 1}
	}
	local newdir = {
		dir[1] * rotation_matrix[1][1] + dir[2]*rotation_matrix[2][1],
		dir[1] * rotation_matrix[1][2] + dir[2]*rotation_matrix[2][2]
	}
	return newdir
end

function cw(dir)
	local rotation_matrix = {
		{0, -1},
		{1, 0}
	}
	local newdir = {
		dir[1] * rotation_matrix[1][1] + dir[2]*rotation_matrix[2][1],
		dir[1] * rotation_matrix[1][2] + dir[2]*rotation_matrix[2][2]
	}
	return newdir
end

function acw(dir)
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
DIRECTIONS = {forward=same, right=cw, left=acw}
function create_points_map(map)
	local points_map = {}
	for i, row in ipairs(map) do
		local new_row = {}
		for j, val in ipairs(row) do
			new_row[#new_row+1] = 0
		end
		points_map[#points_map+1] = new_row
	end
	return points_map
end

Point = {
	x =0,
	y = 0,
	dir = {}
}
Point.__index = Point
function Point:new (point)
	local new_point = {}
	setmetatable(new_point, Point)
	new_point.x = point.x
	new_point.y = point.y
	new_point.dir = point.dir
	return new_point
end
queueNode = {
	pt = {},
	cost = 0
}
queueNode.__index = queueNode
function queueNode:new (pt, cost)
	local q = {}
	setmetatable(q, queueNode)
	q.pt = pt
	q.cost = cost
	return q
end

function isvalid(map, x, y)
	if map[x][y] ~= "#" then return true
	else return false end
end

function BFS(map, points_map)
	local s1, s2 = find_square(map, "S")
	local e1, e2 = find_square(map, "E")
	local destination = Point:new({x=e1, y=e2, dir={0, 0}})
	local src = Point:new({x=s1, y=s2, dir={0, 1}})

	local q = {}
	local s = queueNode:new(src, 0)
	q[#q+1] = s
	local scores = {}

	while #q > 0 do
		local curr = q[#q]
		q[#q] = nil
		local pt = curr.pt
		if pt.x == destination.x and pt.y == destination.y then
			scores[#scores+1] = curr.cost
		else
			for k, v in pairs(DIRECTIONS) do
				local dir = v(pt.dir)
				local x = pt.x+ dir[1]
				local y = pt.y+dir[2]
				if isvalid(map, x, y) then
					if points_map[x][y] == 0 then
						if k == "forward" then
							local adjcel = queueNode:new(
							Point:new({x=x, y=y, dir=dir}),
							curr.cost + 1
							)
							q[#q+1] = adjcel
							points_map[x][y] = adjcel.cost
						else
							local adjcel = queueNode:new(
							Point:new({x=x, y=y, dir=dir}),
							curr.cost + 1 + 1000
							)
							q[#q+1] = adjcel
							points_map[x][y] = adjcel.cost
						end
					elseif points_map[x][y] > curr.cost then
						if k == "forward" then
							local adjcel = queueNode:new(
							Point:new({x=x, y=y, dir=dir}),
							curr.cost + 1
							)
							q[#q+1] = adjcel
							points_map[x][y] = adjcel.cost
						else
							local adjcel = queueNode:new(
							Point:new({x=x, y=y, dir=dir}),
							curr.cost + 1 + 1000
							)
							q[#q+1] = adjcel
							points_map[x][y] = adjcel.cost
						end
					end
				end
			end
		end
	end
	local score = nil
	table.sort(scores)
	return scores[1]
end


function p1()
	local map = read_input()
	local cost_map = create_points_map(map)
	local price = BFS(map, cost_map)
end

function BFSp2(map, points_map)
	local s1, s2 = find_square(map, "S")
	local e1, e2 = find_square(map, "E")
	local destination = Point:new({x=e1, y=e2, dir={0, 0}})
	local src = Point:new({x=s1, y=s2, dir={0, 1}})

	local q = {}
	local s = queueNode:new(src, 0)
	q[#q+1] = s
	local scores = {}
	local paths = {}
	local real_paths = {}
	local sc = nil

	while #q > 0 do
		local curr = q[#q]
		--paths[#paths+1] = {curr.pt.x, curr.pt.y}
		q[#q] = nil
		local pt = curr.pt
		if pt.x == destination.x and pt.y == destination.y then
			scores[#scores+1] = curr.cost
			if sc == nil then
				sc = curr.cost
				real_paths[#real_paths+1] = paths
			elseif curr.cost < sc then
				sc = curr.cost
				real_paths[#real_paths] = nil
				real_paths[#real_paths+1] = paths
			elseif curr.cost == sc then
				real_paths[#real_paths+1] = paths
			end
		else
			for k, v in pairs(DIRECTIONS) do
				local dir = v(pt.dir)
				local x = pt.x+ dir[1]
				local y = pt.y+dir[2]
				if isvalid(map, x, y) then
					if points_map[x][y] == 0 then
						if k == "forward" then
							local adjcel = queueNode:new(
							Point:new({x=x, y=y, dir=dir}),
							curr.cost + 1
							)
							q[#q+1] = adjcel
							points_map[x][y] = adjcel.cost
						else
							local adjcel = queueNode:new(
							Point:new({x=x, y=y, dir=dir}),
							curr.cost + 1 + 1000
							)
							q[#q+1] = adjcel
							points_map[x][y] = adjcel.cost
						end
					elseif points_map[x][y] > curr.cost then
						if k == "forward" then
							local adjcel = queueNode:new(
							Point:new({x=x, y=y, dir=dir}),
							curr.cost + 1
							)
							q[#q+1] = adjcel
							points_map[x][y] = adjcel.cost
						else
							local adjcel = queueNode:new(
							Point:new({x=x, y=y, dir=dir}),
							curr.cost + 1 + 1000
							)
							q[#q+1] = adjcel
							points_map[x][y] = adjcel.cost
						end
					else
						paths[#paths] = nil
					end
				end
			end
		end
	end
	return sc, real_paths
end

function p2attempt2()
	local map = read_input()
	local new_map  = {}
	for _, row in ipairs(map) do
		local new_row = {}
		for i, v in ipairs(row) do
			new_row[#new_row+1] = v
		end
		new_map[#new_map+1] = new_row
	end
	local cost_map = create_points_map(map)
	local x, y = find_square(map, "E")
	local xs, ys = find_square(map, "S")
	local price, paths = BFSp2(map, cost_map)
	print(#paths)
	for _, path in ipairs(paths) do
		print(#path)
	end
end

function p2attempt1()
	local map = read_input()
	local new_map  = {}
	for _, row in ipairs(map) do
		local new_row = {}
		for i, v in ipairs(row) do
			new_row[#new_row+1] = v
		end
		new_map[#new_map+1] = new_row
	end
	local x, y = find_square(map, "E")
	local xs, ys = find_square(map, "S")
	local cost_map = create_points_map(map)
	local price = BFS(map, cost_map)
	local old_price = price
	--print(price)
	--print(map[x][y])
	--print(cost_map[x+1][y])
	--print(old_price)
	--x, y = 4, 14
	new_map[x][y] = "O"
	new_map[xs][ys] = "O"
	cost_map[xs][ys] = 1
	local queue = {{x, y, price}}
	while #queue > 0 do
		x, y, old_price = queue[#queue][1], queue[#queue][2], queue[#queue][3]
		if x == xs and y == ys then break end
		queue[#queue] = nil
		for i=-1,1 do
			for j=-1,1 do
				if math.abs(i) ~= math.abs(j) then
					if cost_map[x+i][y+j] <= old_price and cost_map[x+i][y+j] ~= 0 then
						print(cost_map[x+i][y+j])
						new_map[x+i][y+j] = "O"
						queue[#queue+1] = {x+i, y+j, cost_map[x+i][y+j]}
					end
				end
			end
		end
	end
	local sum = 0
	for _, row in ipairs(new_map) do
		print(table.unpack(row, 1, #row))
		for i, v in ipairs(row) do
			if v == "O" then sum = sum +1
			end
		end
	end
	print(sum)

end
p2attempt2()
