local level_mt = {}
local level = {}

level.id = {
	normal = 0,
	pique = 1
}

function level.new( )
	math.randomseed(os.time())
	local self = setmetatable({},{__index=level_mt})
	self.x = 0
	self.y = 0
	self.levelData = {
		x =0,
		id = 0
}
	self:generateLevel()

	return self
end
function level_mt:generateLevel()
	for i=0,155 do
		rand = math.random()
		if rand > 0.9 then
			rand = 1
		else
			rand = 0
		end
		self.levelData[i] = {x = i,id = rand}
	end
end
return level