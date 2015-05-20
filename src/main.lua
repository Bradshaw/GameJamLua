function love.load(args)
	math.randomseed(os.time())
	level = require("level")
	l = level.new()
	player = require("player")
	p = player.new()
	p.img = love.graphics.newImage("images/flan.png")
	tileSize = 100
	playerSize = 64
	gravity = 1000
	
	
end

function love.update(dt)
	if(p.x > (500-64)) then
		p.x = (500-64)
		p.grounded = true
		p.yVelocity = 0
	end
	if(p.x < (250)) then
		p.x = (250)
		p.grounded = true
		p.yVelocity = 0
	end

	if(p.y > (600-64)) then
		p.y = (600-64)
		p.grounded = true
		p.yVelocity = 0
	end
	if(p.yVelocity ~= 0) then
		p.y = p.y - p.yVelocity*dt
		p.score = p.score + p.yVelocity*dt
		p.yVelocity = p.yVelocity - gravity*dt
	end
	if love.keyboard.isDown( "right" ) then
		if not p.grounded then
			p.x  = p.x+p.speed*dt
		end

   	end
   	if love.keyboard.isDown( "left" ) then
		if not p.grounded then
			p.x  = p.x-p.speed*dt
		end
   	end

end

function love.draw()
	for i=0,table.getn(l.levelData) do
		love.graphics.setColor(100+i*10, 100+i*10, 100+i*10)
		love.graphics.rectangle("fill", 200, (600-(i+1)*tileSize) +p.score , tileSize/2, tileSize)
		love.graphics.rectangle("fill", 500, (600-(i+1)*tileSize) +p.score, tileSize/2, tileSize)
		
	end
	love.graphics.setColor(100-(p.y/tileSize)*10, 100-(p.y/tileSize)*10, 100-(p.y/tileSize)*10)
	love.graphics.draw(p.img, p.x, p.score*(600/15500) - 600+64)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
	if key == " " and p.grounded then
		p.yVelocity = p.yVelocity+p.jumpHeight
		p.grounded = false
	end
end