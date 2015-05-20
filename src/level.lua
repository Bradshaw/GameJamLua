local level_mt = {}
local level = {}


function level.new( )
	local self = setmetatable({},{__index=level_mt})
	self.x = 0
	self.y = 0
	self.levelData = {
		x =0,
		type = 0
}
	self:generateLevel()

	return self
end
function level_mt:generateLevel()
	for i=1,155 do
		self.levelData[i] = {x = i,type = math.floor(math.random())}
	end
end
return level


