require "sat"

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

	GenerateAxes( vertices, edges, axes )
	
end

------------------------------------------------------------
--	U P D A T E
------------------------------------------------------------

function love.update( dt )

end

------------------------------------------------------------
--	D R A W
------------------------------------------------------------

function love.draw()

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

end

------------------------------------------------------------
--	C A L L B A C K S
------------------------------------------------------------

function love.keypressed( key, scancode, isrepeat )

	if key == "escape" then
	   love.event.quit()
	end

 end
