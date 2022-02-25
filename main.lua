require "sat"
require "transform"

------------------------------------------------------------
--	L O A D
------------------------------------------------------------

function love.load()

	mesh = love.graphics.newMesh(
		{
			{ 100, -100, 0, 0, 1, 0, 0, 1 },
			{ 0, 100, 0, 0, 1, 0, 1, 1 },
			{ -100, -100, 0, 0, 1, 1, 0, 1 }
		},
		"fan",
		"dynamic"
	)

	vertices = {}
	verticesTransformed = {}

	for i = 1, mesh:getVertexCount(), 1 do
		
		vertices[ #vertices + 1 ] = { mesh:getVertex( i ) }
		verticesTransformed[ #verticesTransformed + 1 ] = { mesh:getVertex( i ) }

	end

	edges = {}
	axes = {}

	transformer = Transform:New()

	transformer:Rotate( 1.67 )
	--transformer:Translate( 100, 100 )

	transformer:ApplyVertices( vertices, verticesTransformed )

	GenerateAxes( verticesTransformed, edges, axes )

	mesh:setVertices( verticesTransformed, 1, 3 )

	triMesh = love.graphics.newMesh(
		{
			{ 100, -100, 0, 0, 1, 0, 0, 1 },
			{ 0, 100, 0, 0, 1, 0, 1, 1 },
			{ -100, -100, 0, 0, 1, 1, 0, 1 }
		},
		"fan",
		"dynamic"
	)

	triVertices = {}

	for i = 1, triMesh:getVertexCount(), 1 do
		
		triVertices[ #triVertices + 1 ] = { triMesh:getVertex( i ) }

	end

	triEdges = {}
	triAxes = {}

	GenerateAxes( triVertices, triEdges, triAxes )


	x, y = 0, 0
	rotation = 0

end

------------------------------------------------------------
--	U P D A T E
------------------------------------------------------------

function love.update( dt )

	if love.keyboard.isDown( "right" ) then
		x = x + 5
	end

	if love.keyboard.isDown( "left" ) then
		x = x - 5
	end

	if love.keyboard.isDown( "down" ) then
		y = y + 5
	end

	if love.keyboard.isDown( "up" ) then
		y = y - 5
	end

	if love.keyboard.isDown( "," ) then
		rotation = rotation - 0.05
	end

	if love.keyboard.isDown( "." ) then
		rotation = rotation + 0.05
	end
	
	transformer:Reset()
	transformer:Rotate( rotation )
	transformer:Translate( x, y )
	transformer:ApplyVertices( vertices, verticesTransformed )
	
	GenerateAxes( verticesTransformed, edges, axes )

	mesh:setVertices( verticesTransformed, 1, 3 )

	collision = CheckCollision( axes, verticesTransformed, triAxes, triVertices )

end

------------------------------------------------------------
--	D R A W
------------------------------------------------------------

function love.draw()

	if collision then
		love.graphics.setColor( 1, 0, 0, 1 )
		love.graphics.print("COLLISION!", 0, 780, 0, 2, 2 )
	else
		love.graphics.setColor( 1, 1, 1, 1 )
	end

	love.graphics.push()
	love.graphics.translate( love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5 )
	
	love.graphics.draw( mesh, 0, 0 )

	love.graphics.draw( triMesh, 0, 0 )


	for i = 1, #triAxes, 1 do
	
		local n = i + 1
		if n > #triAxes then n = 1 end

		love.graphics.line( 0, 0, triAxes[i][1], triAxes[i][2] )

	end

	love.graphics.pop()

	love.graphics.push()

	love.graphics.translate( love.graphics.getWidth() * 0.5 + x, love.graphics.getHeight() * 0.5 + y )

	for i = 1, #axes, 1 do
	
		local n = i + 1
		if n > #axes then n = 1 end

		love.graphics.line( 0, 0, axes[i][1], axes[i][2] )

	end

	love.graphics.pop()

	love.graphics.setColor( 1, 1, 1, 1 )

	for i = 0, #verticesTransformed - 1, 1 do

		love.graphics.print( "verticesTransformed["..(i + 1).."] "..verticesTransformed[i + 1][1]..", "..verticesTransformed[i + 1][2], 0, i * 10 )
		love.graphics.print( "axes["..(i + 1).."] "..axes[i + 1][1]..", "..axes[i + 1][2], 0, 30 + i * 10 )

	end

	love.graphics.print( "Use arrows to move the triangle and ',' or '.' to rotate it", 0, 750, 0, 2, 2 )

end

------------------------------------------------------------
--	C A L L B A C K S
------------------------------------------------------------

function love.keypressed( key, scancode, isrepeat )

	if key == "escape" then
	   love.event.quit()
	end

end
