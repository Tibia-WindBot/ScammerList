local ThreadListMaker = {
	List	=	dofile("TLMlist.lua"),
	Header	=	dofile("TLMheader.lua"),
	Line1P	=	dofile("TLMpattern1.lua"),
	Line2P	=	dofile("TLMpattern2.lua"),
}

function table.values(self)
	local vals = {}

	for _, v in pairs(self) do
		vals[#vals + 1] = v
	end

	return vals
end

function table.keys(self)
	local keys = {}

	for key, _ in pairs(self) do
		if (type(key) ~= 'number') then
			keys[#keys + 1] = key
		end
	end

	return keys
end

setmetatable(ThreadListMaker.List, {__tostring = function(self)
	--// setting the output string as a metamod;
	local str = ''

	for index, entry in pairs(self) do
		local tblValues = table.values(entry)

		if index == 1 or index % 2 ~= 0 then
			str = str .. string.format(ThreadListMaker.Line1P, index, unpack(tblValues))
		else
			str = str .. string.format(ThreadListMaker.Line2P, index, unpack(tblValues))
		end
	end

	return str
end})

table.sort(ThreadListMaker.List, function(a, b)
	for k, v in ipairs(a) do
		if v < b[k] then
			return a
		else
			return b
		end
	end
end)

local fl = io.open("../output.txt", "w+")

if (fl ~= nil) then
	--// checks if creating/clearing file was successful;
	fl:write(ThreadListMaker.Header .. "\n")
	fl:write(tostring(ThreadListMaker.List))
	fl:close()
end
