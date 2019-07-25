include('shared.lua')

function ENT:Initialize()

	-- self:SetShouldDrawInViewMode( true )
	self.CamDist = 400
	self.CamUp = 120
	self.ExhaustPos = { Vector( 65, -25, 23 ), Vector( 65, 25, 23 ) }
	self.Emitter = ParticleEmitter( self:GetPos(), false )
	-- 88.3919 -25.0267 23.7581

	
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
				
			pos = plane:LocalToWorld( Vector( 3, 0, 56.5 ) ) //Origin//
			
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

	for i =1,#self.ExhaustPos do
	
		local particle = self.Emitter:Add( "particle/smokesprites_000"..math.random(1,9), self:LocalToWorld( self.ExhaustPos[i] ) )

		if ( particle ) then
			
			particle:SetVelocity( Vector( math.Rand( -1.5,1.5),math.Rand( -1.5,1.5),math.Rand( 2.5,15.5)  ) )
			particle:SetDieTime( math.Rand( 4, 6 ) )
			particle:SetStartAlpha( math.Rand( 20, 30 ) )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( math.Rand( 3, 5 ) )
			particle:SetEndSize( math.Rand( 8, 16 ) )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( math.Rand(-1, 1) )
			particle:SetColor( math.Rand(35,45), math.Rand(35,45), math.Rand(35,45) ) 
			particle:SetAirResistance( 100 ) 
			particle:SetGravity( VectorRand():GetNormalized()*math.Rand(7, 16)+Vector(0,0,math.Rand(70, 110)) ) 	

		end
		
	end
	
	self:DrawModel()
	self:DefaultDrawInfo()
	
end
