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
