SCAM_LIST = {}

SCAM_LIST[1] = {name = 'Joao Carlos Brinquete', nicks = 'joaoow, iJoaoW', reasons = 'Stole 4 Premium Times', adresses = 'joao.carlos.brinquete.avo, joaowbrinquete@hotmail.com, joaoow@outlook.pt'}
--SCAM_LIST[2] = {}
--SCAM_LIST[3] = {}
--...


-- DO NOT EDIT BELOW --

local VTABLE_PATTERN, tempDuplicate = [[
[tr]
	[td][B]%s[/B][/td]
	[td][B]%s[/B][/td]
	[td][B][noparse]%s[/noparse][/B][/td]
	[td][B]%s/B][/td]
[/tr]
]], {}

VTABLE_PATTERN = VTABLE_PATTERN:sub(1, -2)

setmetatable(SCAM_LIST, {__tostring = function(self)
	local str = ''
	
	for _, user in pairs(self) do
		str = string.format(VTABLE_PATTERN, user.nicks, user.reasons, user.adresses, user.name)
	end
	
	return str
end})


-- Sort by name, nick, adresses or reasons
table.sort(SCAM_LIST, function(a, b)
	if a.name == b.name then
		if a.nicks == b.nicks then
			if a.adresses == b.adresses then
				return a.reasons < b.reasons
			else
				return a.adresses < b.adresses
			end
		else
			return a.nicks < b.nicks
		end
	else
		return a.name < b.name
	end
end)

-- Exclude duplicated values
local index = 1
while SCAM_LIST[index] do
	if tempDuplicated[index] and tempDuplicated[index].name == SCAM_LIST[index].name then
		table.remove(SCAM_LIST, index)
	else
		tempDuplicated[index], index = SCAM_LIST[index], index + 1
	end
end

-- Print out scammers list
print(SCAM_LIST)
