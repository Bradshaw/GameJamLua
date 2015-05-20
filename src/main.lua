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
	piqueLeft = love.graphics.newImage("images/piqueL.png")
	piqueRight = love.graphics.newImage("images/piqueR.png")
	
	
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
		if(p.x > (500-playerSize)) then
			p.x = (500-playerSize)
			p.grounded = true
			p.yVelocity = 0
			testCollision()
		end
		if(p.x < (250)) then
			p.x = (250)
			p.grounded = true
			p.yVelocity = 0
			testCollision()
			
		end

		if(p.y > (600-playerSize)) then
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
		if l.levelData[i].id == 0 then 
			love.graphics.setColor(100+i, 100+i, 100+i)
			love.graphics.rectangle("fill", 200, (600-(i+1)*tileSize)+frame , tileSize/2, tileSize)
			love.graphics.rectangle("fill", 500, (600-(i+1)*tileSize)+frame , tileSize/2, tileSize)
		else
			love.graphics.setColor(100+i, 100+i, 100+i)
			love.graphics.draw(piqueLeft, 200, (600-(i+1)*tileSize)+frame)
			love.graphics.draw(piqueRight, 500, (600-(i+1)*tileSize)+frame)
		end
		
	end
	love.graphics.setColor(100+(p.score/15600)*155, 100+(p.score/15600)*155, 100+(p.score/15600)*155)
	
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
	l = level.new()
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

function testCollision()
	top = (frame+(600-p.y))/tileSize
	top = math.floor(top)
	bot = (frame+((600-p.y)-playerSize))/tileSize
	bot = math.floor(bot)
	if(l.levelData[top].id == 1 or l.levelData[bot].id == 1) then
		gameOver()
	else
		love.audio.stop()
		love.audio.play(sfx)
	end
end