include('shared.lua')

function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	self.CamDist = 200
	self.CamUp = 50
	self.CamRight = 45
	self.CockpitPosition = Vector( -55, 0, 15 )
	
end


function ENT:CalcView( ply, Origin, Angles, Fov )

	local tank = ply:GetNetworkedEntity("Tank", NULL )
	local barrel = ply:GetNetworkedEntity("Barrel",NULL)

	local view = {
		origin = Origin,
		angles = Angles
		}

	if( IsValid( tank ) && ply:GetNetworkedBool( "InFlight", false )  ) then

		local fov = GetConVarNumber("fov_desired")
		local ang,pAng,bAng = ply:GetAimVector():Angle(), tank:GetAngles(), barrel:GetAngles()
		
		local pos
		
		if( GetConVarNumber("jet_cockpitview") > 0 ) then
				
			pos = barrel:LocalToWorld( self.CockpitPosition )
			ang = bAng
			
		else
			
			pos = tank:GetPos() + tank:GetUp() * self.CamUp + tank:GetRight() * self.CamRight + ply:GetAimVector() * -self.CamDist
		
		end
		
		local tAng = tank:GetAngles()
		
		
		view = {
			origin = pos,
			angles = Angle( ang.p, ang.y, ang.r / 1.5 ),
			fov = fov
			}

	end

	return view

end

function ENT:Draw()
	
	self:DefaultDrawInfo()
	
end

