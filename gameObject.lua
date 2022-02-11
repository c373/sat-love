gameObject = {
	mesh = nil,
	vertices = {},
	axes = {},
	edges = {},
	position = { 0, 0 },
	posVel = { 0, 0 },
	rotation = 0,
	rotVel = 0,
	dirtyTransform = false,
	transform = nil
}

function gameObject:new( m, pos, pVel, rot, rVel )
	mesh = m

	for i in mesh:getVertexCount() do
		vertices[ #vertices + 1 ] = mesh:getVertex( i )
	end

	GenerateAxes( vertices, edges, axes )
end

function gameObject:update( delta )

	position[1] = position[1] + posVel[1] * delta
	position[2] = position[2] + posVel[2] * delta

	--TODO test the angle wrapping code it might not work as intended below zero lol
	if rotation + rotVel > 6.28 or rotation + rotVel < 0 then
		rotation = 6.28 - rotVel
	else
		rotation = rotation + rotVel
	end

end
