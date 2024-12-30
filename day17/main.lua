--file = "./example.txt"
file = "./input.txt"
io.input(file)

COMBO_OPERAND = {}
COMBO_OPERAND['0'] = 0
COMBO_OPERAND['1'] = 1
COMBO_OPERAND['2'] = 2
COMBO_OPERAND['3'] = 3
COMBO_OPERAND['4'] = 'A'
COMBO_OPERAND['5'] = 'B'
COMBO_OPERAND['6'] = 'C'
COMBO_OPERAND['7'] = nil
instruction_pointer = 0
output = ""

function read_input()
	local p = false
	local register = {}
	local count = 0
	local program = {}
	while true do
		local line = io.read("L")
		if line == "\n" then p=true end
		if not line then break end
		if p == false then
			if count == 0 then
				register["A"] = tonumber(line:match("%d+"))
			elseif count == 1 then
				register["B"] = tonumber(line:match("%d+"))
			elseif count == 2 then
				register["C"] = tonumber(line:match("%d+"))
			end
		else
			for n in line:gmatch("%d+") do
				program[#program+1] = n
			end
		end
		count = count + 1
	end
	return register, program
end

function adv(register, operand)
	local op = COMBO_OPERAND[operand]
	if op == nil then return false end
	if type(op) == "number" then
		register.A = math.floor(register.A / (2^op))
	else
		register.A = math.floor(register.A / (2^register[op]))
	end
end

function bxl(register, operand)
	register.B = register.B ~ tonumber(operand)
end

function bst(register, operand)
	local op = COMBO_OPERAND[operand]
	if op == nil then return false end
	if type(op) == "number" then
		register.B = op%8
	else
		register.B = register[op]%8
	end
end
function jnz(register, operand)
	if register.A ~= 0 then
		instruction_pointer = tonumber(operand) -2
	end
end

function bxc(register, operand)
	register.B = register.B ~ register.C
end

function out(register, operand)
	local op = COMBO_OPERAND[operand]
	if type(op) == "number" then
		output = output..tostring(op%8)..","
	else
		output = output..tostring(register[op]%8)..","
	end
end

function bdv(register, operand)
	local op = COMBO_OPERAND[operand]
	if op == nil then return false end
	if type(op) == "number" then
		register.A = math.floor(register.A / (2^op))
	else
		register.A = math.floor(register.A / (2^register[op]))
	end
end

function cdv(register, operand)
	local op = COMBO_OPERAND[operand]
	if op == nil then return false end
	if type(op) == "number" then
		register.C = math.floor(register.A / (2^op))
	else
		register.C = math.floor(register.A / (2^register[op]))
	end

end

opcodes = {}
opcodes["0"] = adv
opcodes["1"] = bxl
opcodes["2"] = bst
opcodes["3"] = jnz
opcodes["4"] = bxc
opcodes["5"] = out
opcodes["6"] = bdv
opcodes["7"] = cdv
function p1()
	local register, program = read_input()
	local program_len = #program
	while true do
		if instruction_pointer+1 > program_len then break end
		local opcode = program[instruction_pointer+1]
		local operand = program[instruction_pointer+2]
		opcodes[opcode](register, operand)
		instruction_pointer = instruction_pointer + 2
	end
	print(output)
end

function test()
	while true do
		local register = {}
		register.A =  8^15 + 8 +8  + 8 + 8 + 8
		register.B = 0
		register.C = 0
		local program = {2,4,1,5,7,5,1,6,4,2,5,5,0,3,3,0}
		--local register, program = read_input()
		local program_len = #program
		while true do
			if instruction_pointer+1 > program_len then break end
			local opcode = tostring(program[instruction_pointer+1])
			local operand = tostring(program[instruction_pointer+2])
			opcodes[opcode](register, operand)
			instruction_pointer = instruction_pointer + 2
		end
		print(output)
		print(register.A)
	break
	end
end

function check_programs(p1, p2)
	for i=1, #p1 do
		local n1, n2 = p1[i], p2[i]
		if n1 ~= n2 then
			return false
		end
	end
	return true
end
function p2()
	local initial_A = 1
	local register, program = read_input()
	local A,B,C = register.A, register.B, register.C
	local program_len = #program
	::incrimentA::
	initial_A = initial_A + 1
	while true do
		if instruction_pointer+1 > program_len then break end
		local opcode = program[instruction_pointer+1]
		local operand = program[instruction_pointer+2]
		opcodes[opcode](register, operand)
		instruction_pointer = instruction_pointer + 2
		if #output > 0 then
			local p2 = {}
			for n in output:gmatch("%d+") do
				p2[#p2+1] = n
			end
			for i=1,#p2 do
				if p2[i] ~= program[i] then
					output = ""
					register.B = B
					register.C = C
					register.A = initial_A
					instruction_pointer = 0
					goto incrimentA
				end
			end
		end
	end
	local p2 = {}
	for n in output:gmatch("%d+") do
		p2[#p2+1] = n
	end
	if #program == #p2 then
		if check_programs(program, p2) then
			print(initial_A -1)
		else
			output = ""
			register.B = B
			register.C = C
			register.A = initial_A
			instruction_pointer = 0
			goto incrimentA
		end
	else
		output = ""
		register.B = B
		register.C = C
		register.A = initial_A
		instruction_pointer = 0
		goto incrimentA
	end
end
test()

