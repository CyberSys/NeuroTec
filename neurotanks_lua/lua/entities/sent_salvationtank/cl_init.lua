include('shared.lua')

function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	self.CamDist = 420
	self.CamUp = 120
	
end

function ENT:CalcView( ply, Origin, Angles, Fov )

	local tank = ply:GetNetworkedEntity("Tank",nil)
	local barrel = ply:GetNetworkedEntity("Barrel",nil)

	local view = {
		origin = Origin,
		angles = Angles
		}

	if( tank && IsValid( tank ) && ply:GetNetworkedBool( "InFlight", false )  ) then

		local pos = tank:GetPos() + tank:GetUp() * self.CamUp + ply:GetAimVector() * -self.CamDist + tank:GetForward() * -self.CamDist
		local fov = GetConVarNumber("fov_desired")
		local ang,pAng = ply:GetAimVector():Angle(), tank:GetAngles()
		
		local pos = tank:GetPos() + tank:GetForward() * -350 + tank:GetUp() * 72
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

