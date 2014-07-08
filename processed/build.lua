--[[
	Scammer List
	Version 1.2.22
]]--

local file = io.open("../processed/processed.txt", "r")

local list = loadstring(file:read("*a"))()

file:close()

	-- defining headers and patterns;
local header = [[
[CENTER][SIZE=4][B]Scam Reports Processed[/B][/SIZE]
(To keep this thread clean, processed reports will be listed here and the post will be excluded)[/CENTER]

[TABLE="width: 200, align: center, class: cms_table_sortable"]
[tr="bgcolor: #000000"]
	[td="width: 5%%"][I][B][COLOR="#FFFFFF"]User[/B][/I]:[/COLOR][/td]
	[td="width: 15%%"][B][I][COLOR="#FFFFFF"]Scammer[/I][/B]:[/COLOR][/td]
	[td="width: 50%%"][I][B][COLOR="#FFFFFF"]Status[/B][/I]:[/COLOR][/td]
[/tr]
%s
[/TABLE]
]]
local line = [[
[tr]
	[td="width: 5%%"]%s[/td]
	[td="width: 15%%"]%s[/td]
	[td="width: 50%%"][COLOR="#FF0000"]%s[/COLOR][/td]
[/tr]
]]

setmetatable(list, {__tostring = function(self)
	-- creating output format;
	local str = ''

	for i, e in pairs(self) do
		str = str .. string.format(line, e.user, e.scammer, e.status == "B" and "Processed, Banned" or "Processed, Missing Proof")
	end

	return str:sub(1, -2)
end})

table.sort(list, function(a, b) return a.user < b.user end)

local fl = io.open("../outproc.txt", "w+")
if (fl ~= nil) then
	-- checks if creating/clearing file was successful;
	-- then write and close file;
	fl:write(string.format(header:sub(1, -2), tostring(list)))
	fl:flush()
	fl:close()
end
