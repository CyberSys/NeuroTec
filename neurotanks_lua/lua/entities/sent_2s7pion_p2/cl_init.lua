include('shared.lua')

function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	self.CamDist = 305//250
	self.CamUp = 270//80
	
end

function ENT:CalcView( ply, Origin, Angles, Fov )

	local tank = ply:GetScriptedVehicle()
	local barrel = ply:GetNetworkedEntity( "Tank", NULL )

	local view = {
		origin = Origin,
		angles = Angles
		}

	if( IsValid( tank ) && ply:GetNetworkedBool( "InFlight", false )  ) then
		
		local pos
		local fov = GetConVarNumber("fov_desired")
		local ang,pAng = ply:GetAimVector():Angle(), tank:GetAngles()
		
		if( GetConVarNumber("jet_cockpitview") > 0 ) then
				
			pos = tank:LocalToWorld( Vector( -140, 26, 84+43 ) ) //Origin//
			
		else
			
			pos = tank:GetPos() + tank:GetUp() * self.CamUp + ply:GetAimVector() * -self.CamDist -- + tank:GetForward() * -self.CamDist
		
		end
		
		--local pos = tank:GetPos() + tank:GetForward() * -350 + tank:GetUp() * 72
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