file = "./example.txt"
io.input(file)
Agent = {
	x =0,
	y = 0,
	map = {{}},
	dir = {}


}
Agent.__index = Agent

function Agent:new (agent, map)
	local new_agent = {}
	setmetatable(new_agent, Agent)
	new_agent.x = agent.x
	new_agent.y = agent.y
	new_agent.map = map
	return new_agent

end

function Agent:get_dir(dir)
	if dir == "^" then self.dir = {-1, 0}
	elseif dir == "v" then self.dir = {1, 0}
	elseif dir == ">" then self.dir = {0, 1}
	elseif dir == "<" then self.dir = {0, -1}
	end
end
function Agent:PrintDir()
	print(self.dir[1], self.dir[2])
end
function Agent:move ()
	local next
	local next_x, next_y
	local stack = {{self.x, self.y},{self.x+self.dir[1], self.y+self.dir[2]}}
	local block = nil
	while true do
		local next_x, next_y = stack[#stack][1], stack[#stack][2]
		if self.map[next_x][next_y] == "#" then stack[#stack]=nil; break end
		--stack[#stack] = nil
		next = self.map[next_x][next_y]
		if next == "." then block = 'space';  break
		elseif next == "#" then block ='wall'; break
		elseif next == "O" then stack[#stack+1] = {next_x+self.dir[1], next_y+self.dir[2]}
		end
	end
	if block == 'space' then
		for i=#stack, 2, -1 do
			self.map[stack[i][1]][stack[i][2]], self.map[stack[i-1][1]][stack[i-1][2]] = self.map[stack[i-1][1]][stack[i-1][2]], self.map[stack[i][1]][stack[i][2]]
		end
		self.x, self.y = stack[2][1], stack[2][2]
	end
end

function Agent:move2 ()
	local next
	local next_x, next_y
	local stack = {{self.x, self.y},{self.x+self.dir[1], self.y+self.dir[2]}}
	local block = nil
	while true do
		local next_x, next_y = stack[#stack][1], stack[#stack][2]
		if self.map[next_x][next_y] == "#" then stack[#stack]=nil; break end
		--stack[#stack] = nil
		next = self.map[next_x][next_y]
		if next == "." then block = 'space';  break
		elseif next == "#" then block ='wall'; break
		elseif next == "[" then
			if math.abs(self.dir[1]) == -1 then
				stack[#stack+1] = {next_x+0, next_y+1}
				stack[#stack+1] = {next_x+self.dir[1], next_y+self.dir[2]}
			else
				stack[#stack+1] = {next_x+self.dir[1], next_y+self.dir[2]}
			end
		elseif next == "]" then
			if self.dir[1] == 0 and self.dir[2] == -1 then
				stack[#stack+1] = {next_x+self.dir[1], next_y+self.dir[2]}
			else
				stack[#stack+1] = {next_x+0, next_y-1}
				stack[#stack+1] = {next_x+self.dir[1], next_y+self.dir[2]}
			end
		end
	end
	if block == 'space' then
		for i=#stack, 2, -1 do
			local x1, y1 = stack[i][1], stack[i][2]
			local x2, y2 = stack[i-1][1], stack[i-1][2]
			local this = self.map[x1][y1]
			local next = self.map[x2][y2]
			self.map[stack[i][1]][stack[i][2]], self.map[stack[i-1][1]][stack[i-1][2]] = self.map[stack[i-1][1]][stack[i-1][2]], self.map[stack[i][1]][stack[i][2]]
		end
		self.x, self.y = stack[2][1], stack[2][2]
	end
end
function Agent:PrintMap ()
	for i, row in ipairs(self.map) do
		print(table.unpack(row, 1, #row))
	end
end

function read_input ( )
	local map = {}
	local movements = {}

	for line in io.lines() do
		local map_row = {}
		for char in line:gmatch('.') do
			if char == '^' or char == '>' or char == 'v' or char == '<' then
				movements[#movements+1] = char
			else
				map_row[#map_row+1] = char
			end
		end
		map[#map+1] = map_row
	end
	return map, movements
end

function Agent:p1()
	local coords = {}
	for i, row in ipairs(self.map) do
		for j, val in ipairs(row) do
			if val == "O" then coords[#coords+1] = {x=i,y=j} end
		end
	end
	local sum = 0
	for i, v in ipairs(coords) do
		sum = sum + ((v.x-1)*100 + v.y-1)
	end
	print(sum)

end

function read_inputp2 ( )
	local map = {}
	local movements = {}

	for line in io.lines() do
		local map_row = {}
		for char in line:gmatch('.') do
			if char == '^' or char == '>' or char == 'v' or char == '<' then
				movements[#movements+1] = char
			else
				if char == "#" or char == "." then
					for i=1,2 do
						map_row[#map_row+1] = char
					end
				elseif char == "O" then
					map_row[#map_row+1] = "["
					map_row[#map_row+1] = "]"
				elseif char == "@" then
					map_row[#map_row+1] = "@"
					map_row[#map_row+1] = "."
				end
			end
		end
		map[#map+1] = map_row
	end
	return map, movements
end


function find_xy  ( map )
	for i, row in ipairs(map) do
		for j, symb in ipairs(row) do
			if symb == "@" then return {x=i,y=j} end
		end
	end
	print('could not find the symbol')
	return false
end

function p1 ( )
	local map, moves = read_input()
	local init_pos = find_xy(map)
	local agent = Agent:new(init_pos, map)
	--agent:PrintMap()
	for _, dir in ipairs(moves) do
		agent:get_dir(dir)
		agent:move()
		--agent:PrintMap()
	end
	agent:p1()


end


function p2 ( )
	local map, moves = read_inputp2()
	local init_pos = find_xy(map)
	local agent = Agent:new(init_pos, map)
	agent:PrintMap()
	for _, dir in ipairs(moves) do
		agent:get_dir(dir)
		agent:move2()
		agent:PrintMap()
	end
	agent:p1()
end
p2()
