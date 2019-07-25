include('shared.lua')

ENT.VehicleCrosshairType = 21

function ENT:Initialize()

	self:SetShouldDrawInViewMode( true )
	self.CamDist = 305//250
	self.CamUp = 270//80
	self.ShellLastAlive = 0
	self.ShellLastPos = Vector( 0,0,0 )
	self.Emitter = ParticleEmitter( self:GetPos(), false )
	self.ExhaustPorts = {Vector( 52, -53, 74 ), Vector( 52, 53, 74 ) }
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
				
			pos = tank:LocalToWorld( Vector( 145, -0, 89 ) ) //Origin//
			
		else
			
			pos = tank:GetPos() + tank:GetUp() * self.CamUp + ply:GetAimVector() * -self.CamDist -- + tank:GetForward() * -self.CamDist
		
		end
		
		-- if( GetConVarNumber("tank_artillery_killcam", 0 ) > 0 ) then
		
			-- local Shell = ply:GetNetworkedEntity("ArtilleryShell", NULL )
			-- if( IsValid( Shell ) ) then
				
				-- pos = Shell:GetPos() 
				-- self.ShellLastPos = Shell:GetPos()
				-- self.ShellLastAlive = CurTime()
				
			-- else
				
				-- if( self.ShellLastPos && self.ShellLastAlive + 3 >= CurTime() ) then
						
					-- pos = self.ShellLastPos
					
				-- elseif( self.ShellLastPos && self.ShellLastAlive + 3 < CurTime() ) then
				
					-- self.ShelLastPos = nil
					-- self.ShellLastAlive = nil
					
				-- end
				
				
			-- end
			
		-- end
		
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
	
	if( self:GetNetworkedBool("StartEmitters", false ) ) then
		
		-- for i=1,#self.ExhaustPorts do
			
			-- local particle = self.Emitter:Add( "sprites/heatwave", self:LocalToWorld( self.ExhaustPorts[i] ) + self:GetForward() * math.random( -22,22 ) )
			-- local ppos = { self:GetRight() * 45 + self:GetUp() * 45, self:GetRight() * -45 + self:GetUp() * 45 }
			
			-- if( particle ) then
				
				-- particle:SetDieTime( 0.3 )
				-- particle:SetStartAlpha( 255 )
				-- particle:SetEndAlpha( 255 )
				-- particle:SetStartSize( 16 )
				-- particle:SetEndSize( 0 )
				-- particle:SetColor( 255, 255, 255 )
				-- particle:SetCollide( false )
				-- particle:SetRoll( math.random(-1,1) )
				-- particle:SetGravity( ppos[i] )
				-- particle:SetCollide( true )
				
			-- end
		
		-- end
		
		-- self.Emitter:Finish()
		
	end
	
end