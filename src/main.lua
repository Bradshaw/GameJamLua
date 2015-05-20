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
	frame = 0
	started = false
	win = false
	sfx = love.audio.newSource("sound/blop.mp3", "static")
	deathSound = love.audio.newSource("sound/death.mp3", "static")
	
	
end

function love.update(dt)
	if(p.score > 15600) then
		winGame()
	end
	if(not win) then
		if(started ) then
			frame  = frame +5
		
			p.y = p.y +5
		end
		if(p.x > (500-64)) then
			p.x = (500-64)
			p.grounded = true
			p.yVelocity = 0
			love.audio.stop()
			love.audio.play(sfx)
		end
		if(p.x < (250)) then
			p.x = (250)
			p.grounded = true
			p.yVelocity = 0
			love.audio.stop()
			love.audio.play(sfx)
		end

		if(p.y > (600-64)) then
			gameOver()
		end
		if(p.yVelocity ~= 0) then
			p.y = p.y - p.yVelocity*dt
			if p.yVelocity > 0 then
				p.score = frame + 600-p.y
			end
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
	   	p.score = math.floor(p.score)
	else
		if love.keyboard.isDown( " " ) then
			gameOver()
		end
	end

end

function love.draw()
	love.graphics.setNewFont(40)
	if(p.score < 10000) then
		love.graphics.print(""..p.score,100,100)
	else
		love.graphics.print(""..p.score,75,100)
	end
	for i=0,table.getn(l.levelData) do
		love.graphics.setColor(100+i, 100+i, 100+i)
		love.graphics.rectangle("fill", 200, (600-(i+1)*tileSize)+frame , tileSize/2, tileSize)
		love.graphics.rectangle("fill", 500, (600-(i+1)*tileSize)+frame , tileSize/2, tileSize)
		
	end
	love.graphics.setColor(100-(p.y/tileSize), 100-(p.y/tileSize), 100-(p.y/tileSize))
	
	love.graphics.draw(p.img, p.x,p.y)
	
end

function love.keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
	if key == " " and p.grounded then
		if not started then
			started = true
		end
		p.yVelocity = p.yVelocity+p.jumpHeight
		p.grounded = false
	end
end

function gameOver( )
	print("gameOver")
	love.audio.stop()
	love.audio.play(deathSound)
	p = player.new()
	p.img = love.graphics.newImage("images/flan.png")
	started = false
	frame = 0 
	win = false
end

function winGame( )
	p.yVelocity = 0
	p.grounded = true
	win = true
end