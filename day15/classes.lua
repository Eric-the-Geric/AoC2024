Point = {x = 0, y = 0}
Point.__index = Point
function Point:new (o)
	local point1 = {}
	setmetatable(point1, Point)
	point1.x = o.x
	point1.y = o.y

	return point1
end

function Point:move (p)
	self.x = self.x + p.x
	self.y = self.y + p.y
end

function Point:PrintData ( )
	print("x: ", self.x)
	print("y: ", self.y)
end



-- creating points
--
p1 = Point:new{x=10, y=20}
p2 = Point:new{x=10}

p1:PrintData()
p1:move(p2)
p1:PrintData()


Pie = {"blueberry", 5}
Pie.__index = Pie

function Pie:new(flavor, slices)
    local pie1 = {}
    setmetatable(pie1, Pie)
    pie1.flavor = flavor
    pie1.slices = slices
    return pie1
end

function Pie:PrintData()
    print("Pie flavor: ", self.flavor)
    print("Slices remaining: ", tostring(self.slices))
end


pie1 = Pie:new("Apple", 7)
pie1:PrintData()
