hasJSON = fs.exists("json.lua")
if not hasJSON then
	shell.run("pastebin get E686YYEw json.lua")
end

local function get(url)
	local h = http.get(url)
	if not h then return 0,"" end -- ensure failure at the assert
	respc = h.getResponseCode()
	return respc,h.readAll()
end

local base = "https://raw.githubusercontent.com/MineRobber9000/CC-Scripts/master/"

local json = dofile("json.lua")

local code,contents = get(base.."list.json")
assert(code==200,"Unable to obtain list.json")

local programs = assert(json.decode(contents),"list.json is not valid JSON.").programs
local nSelected = 1

function displayList()
	for i=1,#programs do
		print((nSelected==i and "> " or "  ")..programs[i].name.." - "..programs[i].desc)
	end
end

displayList()
