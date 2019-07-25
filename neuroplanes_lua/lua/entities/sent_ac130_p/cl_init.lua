include('shared.lua')

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	self.CamDist = 1500
	self.CamUp = 370
	
end


function ENT:CalcView( ply, Origin, Angles, Fov )

	local plane = ply:GetScriptedVehicle()

	local view = {
		origin = Origin,
		angles = Angles
		}
	
	if ( IsValid( plane ) && ply:GetNetworkedBool("IsAC130Gunner") && plane == self ) then
		
		local pos = {}
		
		origin = pos
	
	
	
	
	end
	
	if( ply:GetNetworkedEntity("NeuroPlanesAC130", NULL ) == self ) then
		
		if( ply:GetNetworkedBool("NeuroPlanes__DrawAC130Overlay", false ) ) then
			
			local gun = ply:GetNetworkedEntity( "NeuroPlanesMountedGun" )
			view = {
			origin = gun:GetPos() + gun:GetForward() * 300,
			angles = Angles,
			fov = fov
			}
			
			return view
			
		end


	
	end
	
	if( IsValid( plane ) && ply:GetNetworkedBool( "InFlight", false )  ) then

		local fov = GetConVarNumber("fov_desired")
		local ang,pAng = ply:GetAimVector():Angle(), plane:GetAngles()
		local pos
		
		if( GetConVarNumber("jet_cockpitview") > 0 ) then
				
			pos = plane:LocalToWorld( Vector( 314, 15, 150 ) ) //Origin//
			
		else
			
			pos = plane:GetPos() + plane:GetUp() * plane.CamUp + ply:GetAimVector() * -plane.CamDist
		
		end
		
		view = {
			origin = pos,
			angles = Angle( ang.p, ang.y, pAng.r / 2.4 ),
			fov = fov
			}

	end

	return view

end


function ENT:Draw()

	local p = LocalPlayer()
	self:DrawModel()
	
	if ( p:GetEyeTrace().Entity == self && EyePos():Distance( self:GetPos() ) < 512 ) then
			
			AddWorldTip(self:EntIndex(),"Health: "..tostring( math.floor( self:GetNetworkedInt( "health" , 0 ) ) ), 0.5, self:GetPos() + Vector(0,0,72), self )
			
	end

end
