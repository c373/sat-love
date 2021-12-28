-- SEPERATE AXIS THEOREM

-- UTILITY FUNCTIONS
function GenerateAxes( polygon, edges, axes )

	for i = 1, #polygon, 1 do
	

		local n = i + 1
		if n > #polygon then n = 1 end

		-- get the first edge
		edges[i] = { polygon[n][1] - polygon[i][1], polygon[n][2] - polygon[i][2] }
		
		-- calculate the normal (y,-x)
		local normal = { edges[i][2], -edges[i][1] }

		axes[i] = normal

	end

end

function CheckCollision( axes1, vertices1, axes2, vertices2 )

	local axis, p1, p2

	for i = 1, #axes1, 1 do
	
		axis = axes1[i]

		p1 = Project( axis, vertices1 )
		p2 = Project( axis, vertices2 )

		if not Overlap( p1, p2 ) then
			return false
		end

	end
	
	for i = 1, #axes2, 1 do
	
		axis = axes2[i]

		p1 = Project( axis, vertices1 )
		p2 = Project( axis, vertices2 )

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
