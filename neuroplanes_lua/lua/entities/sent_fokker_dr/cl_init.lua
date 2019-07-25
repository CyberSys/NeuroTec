include('shared.lua')

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	self.CamDist = 550
	self.CamUp = 140
	
end

function ENT:CalcView( ply, Origin, Angles, Fov )

	local plane = ply:GetScriptedVehicle()

	local view = {
		origin = Origin,
		angles = Angles
		}

	if( IsValid( plane ) && ply:GetNetworkedBool( "InFlight", false )  ) then

		local pos
		
		if( GetConVarNumber("jet_cockpitview") > 0 ) then
				
			pos = plane:LocalToWorld( Vector( -20, 0, 41 ) ) //Origin//
			
		else
			
			pos = plane:GetPos() + plane:GetUp() * plane.CamUp + ply:GetAimVector() * -plane.CamDist
		
		end
		
		local isGuidingRocket = plane:GetNetworkedBool( "DrawTracker", false )
		local fov = GetConVarNumber("fov_desired")
		local ang,pAng = ply:GetAimVector():Angle(), plane:GetAngles()

		if ( isGuidingRocket ) then

			pos = plane:GetPos() + plane:GetUp() * -135
			fov = 60
			
		end
		
		if ( ply:KeyDown( IN_ATTACK ) ) then
				
				ang.p = ang.p + math.Rand(-.35,.35)
				ang.y = ang.y + math.Rand(-.35,.35)
					
		end
		
		view = {
			origin = pos,
			angles = Angle( ang.p, ang.y, pAng.r / 2.15 ),
			fov = fov
			}

	end

	return view

end



function ENT:Draw()

	self:DrawModel()

end
