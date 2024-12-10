File = "./example.txt"
io.input(File)
function read_input()
	return io.read("a")
end

function _print2d(tbl)
	for _, row in ipairs(tbl) do
		print(table.unpack(row,1, #row))
	end
end

function tbltos(tble)
	local s = ""
	for _, c in ipairs(tble) do
		s = s.. c
	end
	print(s)
end

function _print1d(tble)
	print(table.unpack(tble, 1, #tble))
end
function p1()
	local input = read_input()
	local numbers = {}
	for n in input:gmatch("%d") do
		numbers[#numbers+1] = tonumber(n)
	end
	local file_struc = {}
	local count = 0
	for i, n in ipairs(numbers) do
		if i%2 == 0 then
			for _=1, n do
				file_struc[#file_struc+1] = "."
			end

		else
			for _=1, n do
				file_struc[#file_struc+1] = count
			end
			count = count + 1
		end
	end
	local files = file_struc
	local left = 1
	local right = #files
	while left < right do
		while files[left] ~= "." do
			left = left + 1
		end
		while files[right] == "." do
			right = right -1
		end
		if left < right then
			files[left], files[right] = files[right], files[left]
		end
	end
	local sum = 0
	for i=0, #files-1 do
		if files[i+1] == "." then break
		end
		sum = sum + i* tonumber(files[i+1])
	end
	print(sum)
end
function calc_free(tbl)
	local count = 0
	for _, v in ipairs(tbl) do
		if v == "." then count = count + 1
		end
	end
	return count
end
function p2()
	local input = read_input()
	local numbers = {}
	for n in input:gmatch("%d") do
		numbers[#numbers+1] = tonumber(n)
	end
	local file_struc = {}
	local count = 0
	for i, n in ipairs(numbers) do
		if i%2 == 0 then
			if n ~= 0 then
			local free = {}
			for _=1, n do
				free[#free+1] = "."
			end
			file_struc[#file_struc+1] = free
		end

		else
			local disk = {}
			for _=1, n do
				disk[#disk+1] = count
			end
			file_struc[#file_struc+1] = disk
			count = count + 1
		end
	end
	local files = file_struc
	local left = 1
	local right = #files
	while right> 1 do
		if files[right][1] == "." then
			right = right - 1
		else
			for i=1, right do
				local free = calc_free(files[i])
				local tot_space = #files[i]
				if free >= #files[right] and i ~= right then
					--print(#files[i], #files[right])
					if free == tot_space then
						for j=1, #files[right] do
							files[i][j], files[right][j] = files[right][j], files[i][j]
						end
					else
						for j=tot_space-free, tot_space do
							files[i][j], files[right][j] = files[right][j], files[i][j]
						end
					end
				end
			end
			right = right - 1
			print(#files[left], #files[right])
		end
	end
	local final_defrag = {}
	for _, row in ipairs(files) do
		for yolo, v in ipairs(row) do
			final_defrag[#final_defrag+1] = v
		end
	end
	tbltos(final_defrag)
	local sum = 0
	for i=0, #final_defrag-1 do
		if final_defrag[i+1] ~= "." then
			sum = sum + i* tonumber(final_defrag[i+1])
		end
	end
	print(sum)
end
p2()
