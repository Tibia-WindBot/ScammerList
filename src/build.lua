--[[
	Scammer List
	Version 1.2.22
]]--

local file = io.open("../src/blacklist.txt", "r")

local list = loadstring(file:read("*a"))()

file:close()

	-- defining headers and patterns;
local header = [[
[CENTER][B][SIZE=7][IMG]http://i.imgur.com/zuRnITx.png[/IMG][/SIZE][/B][/CENTER]

[hr][/hr]

[TABLE="width: 1024, align: center, class: cms_table_sortable"]
[tr="bgcolor: #000000"]
	[td="width: 5%%"][I][B][COLOR="#FFFFFF"]# ID[/B][/I]:[/COLOR][/td]
	[td="width: 15%%"][B][I][COLOR="#FFFFFF"]Real Name[/I][/B]:[/COLOR][/td]
	[td="width: 50%%"][I][B][COLOR="#FFFFFF"]Known Nickname(s)[/B][/I]:[/COLOR][/td]
	[td="width: 15%%"][B][I][COLOR="#FFFFFF"]Reason(s)[/I][/B]:[/COLOR][/td]
	[td="width: 15%%"][B][I][COLOR="#FFFFFF"]Contact[/I][/B]:[/COLOR][/td]
[/tr]
%s[/TABLE]
]]
local line1 = [[
[tr="bgcolor: #cccccc"]
	[td][B]%d[/B][/td]
	[td][B]%s[/B][/td]
	[td][B]%s[/B][/td]
	[td][B]%s[/B][/td]
	[td][B][noparse]%s[/noparse][/B][/td]
[/tr]
]]
local line2 = [[
[tr="bgcolor: #ffffff"]
	[td][B]%d[/B][/td]
	[td][B]%s[/B][/td]
	[td][B]%s[/B][/td]
	[td][B]%s[/B][/td]
	[td][B][noparse]%s[/noparse][/B][/td]
[/tr]
]]

setmetatable(list, {__tostring = function(self)
	-- creating output format;
	local str = ''

	for i, e in pairs(self) do
		str = str .. string.format(i % 2 ~= 0 and line1 or line2, i, e.name, e.nicks, e.reasons, e.contact)
	end

	return str
end})

table.sort(list, function(a, b)
	-- sorting list members;
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
	-- checks if creating/clearing file was successful;
	-- then write and close file;
	fl:write(string.format(header, tostring(list)))
	fl:flush()
	fl:close()
end
