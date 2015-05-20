local player_mt = {}
local player = {}

function player.new()
	self = setmetatable({}, {__index = player_mt})
	
	self.x = 350
	self.y = 400
	self.score = 400
	self.yVelocity = 0
	self.speed = 400
	self.jumpHeight = 800
	
	self.grounded = true
	return self
end


return player
