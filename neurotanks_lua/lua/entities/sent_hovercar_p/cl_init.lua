include('shared.lua')

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	-- self.CamDist = 200
	-- self.CamUp = 50
	
end


-- function ENT:CalcView( ply, Origin, Angles, Fov )

	-- local tank = ply:GetScriptedVehicle()

	-- local view = {
		-- origin = Origin,
		-- angles = Angles
		-- }
	
	-- //print( IsValid( tank ) )
	
	-- if( ply:GetNetworkedBool( "InFlight", false )  ) then

		-- local fov = GetConVarNumber("fov_desired")
		-- local ang,pAng = ply:GetAimVector():Angle(), tank:GetAngles()
		
		-- local pos = tank:GetPos() + tank:GetUp() * self.CamUp + ply:GetAimVector() * -self.CamDist

		-- local tAng = tank:GetAngles()
		
		
		-- view = {
			-- origin = pos,
			-- angles = Angle( ang.p, ang.y, pAng.r / 1.5 ),
			-- fov = fov
			-- }

	-- end

	-- return view

-- end

function ENT:Draw()
	
	self:DefaultDrawInfo()
	
end
