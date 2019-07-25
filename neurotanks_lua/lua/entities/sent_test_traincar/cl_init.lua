include('shared.lua')

function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	self.CamDist = 500
	self.CamUp = 500
	
end


function ENT:CalcView( ply, Origin, Angles, Fov )

	local view = {
		origin = Origin,
		angles = Angles
		}
	
	//local pilot = self:GetNetworkedEntity("Pilot", NULL )
	
	local train = ply:GetScriptedVehicle()
	
	if( IsValid( train ) && ply:GetNetworkedBool( "InFlight", false )  ) then

		local pos = train:GetPos() + train:GetUp() * self.CamUp + ply:GetAimVector() * -self.CamDist
		local fov = GetConVarNumber("fov_desired")
		
		view = {
			origin = pos,
			angles = ply:GetAimVector():Angle(),
			fov = fov
			}

	end

	return view

end

function ENT:Draw()
	
	self:DefaultDrawInfo()
	
end
