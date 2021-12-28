require "SAT"
require "Transform"

------------------------------------------------------------
--	L O A D
------------------------------------------------------------

function love.load()

	mesh = love.graphics.newMesh(
		{
			{ 0, 0, 0, 0, 1, 0, 0, 1 },
			{ 100, 0, 0, 0, 0, 1, 0, 1 },
			{ 100, 100, 0, 0, 0, 0, 1, 1 }
		},
		"fan",
		"dynamic"
	)

	vertices = {}

	for i = 1, mesh:getVertexCount(), 1 do
		
		vertices[ #vertices + 1 ] = { mesh:getVertex( i ) }

	end

	edges = {}
	axes = {}

	transformer = Transform:New()

	transformer:Rotate( 45 )
	transformer:Translate( 100, 100 )

	for i = 1, #vertices, 1 do
	
		transformer:Apply( vertices[i] )

	end

	GenerateAxes( vertices, edges, axes )

	mesh:setVertices( vertices, 1, 3 )

	triMesh = love.graphics.newMesh(
		{
			{ 10, -10, 0, 0, 1, 1, 1, 1 },
			{ 0, 10, 0, 0, 1, 1, 1, 1 },
			{ -10, -10, 0, 0, 1, 1, 1, 1 }
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

	mouseTransform = Transform:New()

	GenerateAxes( triVertices, triEdges, triAxes )

end

------------------------------------------------------------
--	U P D A T E
------------------------------------------------------------

function love.update( dt )

	mouseTransform:Translate( love.mouse.getX(), love.mouse.getY() )

	for i = 1, #triVertices, 1 do
	
	mouseTransform:Apply( triVertices[i] )

	end

	GenerateAxes( triVertices, triEdges, triAxes )

	collision = CheckCollision( axes, vertices, triAxes, triVertices )

end

------------------------------------------------------------
--	D R A W
------------------------------------------------------------

function love.draw()

	if collision then
		love.graphics.setColor( 1, 0, 0, 1 )
	else
		love.graphics.setColor( 1, 1, 1, 1 )
	end

	love.graphics.push()
	love.graphics.translate( love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5 )
	
	love.graphics.draw( mesh, 0, 0 )

	for i = 0, #vertices - 1, 1 do

		love.graphics.print( vertices[i + 1], -960, -540 + i * 10 )
		love.graphics.print( axes[i + 1], -960, -510 + i * 10 )

	end

	for i = 1, #axes, 1 do
	
		local n = i + 1
		if n > #axes then n = 1 end

		love.graphics.line( 0, 0, axes[i][1], axes[i][2] )

	end

	love.graphics.pop()

	love.graphics.push()
	love.graphics.translate( love.mouse.getX(), love.mouse.getY() )
	
	love.graphics.draw( triMesh, 0, 0 )


	for i = 1, #triAxes, 1 do
	
		local n = i + 1
		if n > #triAxes then n = 1 end

		love.graphics.line( 0, 0, triAxes[i][1], triAxes[i][2] )

	end

	love.graphics.pop()

end

------------------------------------------------------------
--	C A L L B A C K S
------------------------------------------------------------

function love.keypressed( key, scancode, isrepeat )

	if key == "escape" then
	   love.event.quit()
	end

end
