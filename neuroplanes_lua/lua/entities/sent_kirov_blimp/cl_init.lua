include('shared.lua')

ENT.AutomaticFrameAdvance = true 

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	self.CamDist = 1550
	self.CamUp = 500

end

function ENT:CalcView( ply, Origin, Angles, Fov )

	local plane = ply:GetScriptedVehicle()

	local view = {
		origin = Origin,
		angles = Angles
		}

	if( IsValid( plane ) && ply:GetNetworkedBool( "InFlight", false )  ) then

		local pos = plane:GetPos() + plane:GetUp() * plane.CamUp + ply:GetAimVector() * -plane.CamDist
		local fov = GetConVarNumber("fov_desired")
		local ang,pAng = ply:GetAimVector():Angle(), plane:GetAngles()
		local myAng 

		myAng = Angle( ang.p, ang.y, pAng.r / 2.5 )
	
		view = {
			origin = pos,
			angles = myAng,
			fov = fov
			}

	end

	return view

end

function ENT:Draw()
	
	self:DrawModel()

end
