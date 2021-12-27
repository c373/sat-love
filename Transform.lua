Transform = {}

Transform.matrix = {
	{ 1, 0, 0 },
	{ 0, 1, 0 },
	{ 0, 0, 1 }
}

function Transform:New()

	local t = {}

	self.__index = self
	setmetatable( t, Transform )

	return t

end

function Transform:Translate( x, y )

	self.matrix[1][3] = x
	self.matrix[2][3] = y

end

function Transform:Rotate( angle )

	self.matrix[1][1] = math.cos( angle )
	self.matrix[1][2] = math.sin( angle )
	self.matrix[2][1] = math.sin( angle ) * -1
	self.matrix[2][2] = math.cos( angle )

end

function Transform:Apply( vector )

	local x = vector[1]
	local y = vector[2]

	vector[1] = self.matrix[1][1] * x + self.matrix[1][2] * y + self.matrix[1][3]
	vector[2] = self.matrix[2][1] * x + self.matrix[2][2] * y + self.matrix[2][3]

end

function Transform:Reset()

	self.matrix[1][1] = 1
	self.matrix[1][2] = 0
	self.matrix[1][3] = 0
	self.matrix[2][1] = 0
	self.matrix[2][2] = 1
	self.matrix[2][3] = 0
	self.matrix[3][1] = 0
	self.matrix[3][2] = 0
	self.matrix[3][3] = 1

end
