-- SEPERATE AXIS THEOREM

-- UTILITY FUNCTIONS

function GenerateAxes( vertices, edges, axes )

	for i = 1, #vertices, 1 do
	

		local n = i + 1
		if n > #vertices then n = 1 end

		-- get the first edge
		edges[i] = { vertices[n][1] - vertices[i][1], vertices[n][2] - vertices[i][2] }
		
		-- calculate the normal (y,-x)
		local normal = { edges[i][2], -edges[i][1] }

		axes[i] = normal

	end

end

function CheckCollision( axes_1, vertices_1, axes_2, vertices_2 )

	local axis, p1, p2

	for i = 1, #axes_1, 1 do
	
		axis = axes_1[i]

		p1 = Project( axis, vertices_1 )
		p2 = Project( axis, vertices_2 )

		if not Overlap( p1, p2 ) then
			return false
		end

	end
	
	for i = 1, #axes_2, 1 do
	
		axis = axes_2[i]

		p1 = Project( axis, vertices_1 )
		p2 = Project( axis, vertices_2 )

		if not Overlap( p1, p2 ) then
			return false
		end

	end

	return true

end

function Project( axis, vertices )

	local min = Dot( vertices[1], axis )
	local max = min

	for i = 2, #vertices, 1 do

		local p = Dot( vertices[i], axis )

		if p < min then
			min = p
		elseif p > max then
			max = p
		end

	end

	return { min, max }

end

function Overlap( p1, p2 )

	if p1[1] < p2[2] and p1[2] > p2[1] then
		return true
	else
		return false
	end

end


function Dot( v1, v2 )

	return v1[1] * v2[1] + v1[2] * v2[2]

end
