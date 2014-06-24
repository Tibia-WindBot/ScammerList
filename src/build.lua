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
		if index == 1 or index % 2 ~= 0 then
			str = str .. string.format(ThreadListMaker.Line1P, index, entry.name, entry.nicks, entry.reasons, entry.contact)
		else
			str = str .. string.format(ThreadListMaker.Line2P, index, entry.name, entry.nicks, entry.reasons, entry.contact)
		end
	end

	return str
end})

table.sort(ThreadListMaker.List, function(a, b)
	if a.name == b.name then
		if a.nicks == b.nicks then
			if a.contact == b.contact then
				return a.reasons < b.reasons
			else
				return a.contact < b.contact
			end
		else
			return a.nicks < b.nicks
		end
	else
		return a.name < b.name
	end
end)

local fl = io.open("../output.txt", "w+")

if (fl ~= nil) then
	--// checks if creating/clearing file was successful;
	--// if true then write and close file;
	fl:write(string.format(ThreadListMaker.Header, tostring(ThreadListMaker.List) .. "\n"))
	fl:close()
end
