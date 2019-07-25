include('shared.lua')

function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	self.CamDist = 200
	self.CamUp = 40
	
end


function ENT:CalcView( ply, Origin, Angles, Fov )

	local tank = ply:GetNetworkedEntity("Tank", NULL )
	local barrel = ply:GetNetworkedEntity("Barrel",NULL)
	local ragdoll = ply:GetNetworkedEntity("Ragdoll",NULL)
	local pos2,ang2 = ragdoll:GetBonePosition(2)

	local view = {
		origin = Origin,
		angles = Angles
		}

	if( IsValid( tank ) && ply:GetNetworkedBool( "InFlight", false )  ) then

		local ang,pAng,bAng = ply:GetAimVector():Angle(), ang2, barrel:GetAngles()
		if( GetConVarNumber("jet_cockpitview") > 0 ) then
				
			pos = barrel:GetPos() + barrel:GetAngles():Right() * -12 + barrel:GetAngles():Forward() * -120 + barrel:GetAngles():Up() * 4
			ang = bAng
			
		else
			
			pos = pos2 + ang2:Up() * self.CamUp + ply:GetAimVector() * -self.CamDist
		
		end
		
		//local pos = pos2 + ang2:Up() * self.CamUp + ply:GetAimVector() * -self.CamDist
		local fov = GetConVarNumber("fov_desired")
		
		local tAng = ang2
		
		
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
