include('shared.lua')

function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	self.CamDist = 380//250
	self.CamUp = 220//80
	
end

function ENT:CalcView( ply, Origin, Angles, Fov )

	local tank = ply:GetNetworkedEntity("Tank",NULL)
	local barrel = ply:GetNetworkedEntity("Barrel",NULL)

	local view = {
		origin = Origin,
		angles = Angles
		}

	if( tank && IsValid( tank ) && ply:GetNetworkedBool( "InFlight", false )  ) then

		local pos = tank:GetPos() + tank:GetUp() * self.CamUp + ply:GetAimVector() * -self.CamDist -- + tank:GetForward() * -self.CamDist
		local fov = GetConVarNumber("fov_desired")
		local ang,pAng = ply:GetAimVector():Angle(), tank:GetAngles()

		local tAng = tank:GetAngles()
		
		
		view = {
			origin = pos,
			angles = Angle( ang.p, ang.y, 0 ),
			fov = fov
			}

	end

	return view

end

function ENT:Draw()
	
	self:DefaultDrawInfo()
	
end