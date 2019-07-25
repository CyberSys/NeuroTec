// Use this as base for helicopters with physical rotors.
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include("shared.lua")

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 10
	local ent = ents.Create( "sent_mH53pavelow_new_p" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()

	self.HealthVal = self.InitialHealth
	self.LastPrimaryAttack = CurTime()
	self.LastSecondaryAttack = CurTime()
	
	self.LastFireModeChange = CurTime()
	self.LastRadarScan = CurTime()
	self.LastFlare = CurTime()
	self.ChopperGunAttack = CurTime()
	self.LastChopperGunToggle = CurTime() 
	self.LastLaserUpdate = CurTime()
	self.LastSecondaryKeyDown = 999999999999999
	
	self.LastDoor = CurTime()	
	self.DoorAng = 100
	self.DoorOpen = true
	self.DoorToggle = true
	
	self.MinigunRevolve = 0
	self.HoverVal = 0
	self.MoveRight = 0
	self.RotorVal = 0
	self.MaxRotorVal = 1600
	self.RotorMult = self.MaxRotorVal / 2000
	self.Started = false
	self.SpinUp = 0
	
	
	self.DoorOrigin = Vector( -205, 51, 0 ) --self:GetForward() * -271 + self:GetRight() * 55 + self:GetUp() * 54  
	self.DoorPos = Vector( -350, 0, 0 )-- self:GetForward() * -366 + self:GetUp() * 53   

	self.DoorAxis = ents.Create("prop_physics_override")
	self.DoorAxis:SetModel( "models/props_c17/signpole001.mdl" )
	self.DoorAxis:SetPos( self:LocalToWorld( self.DoorOrigin ) )
	self.DoorAxis:SetAngles( self:GetAngles() )
	self.DoorAxis:SetParent( self )
	self.DoorAxis:Spawn()
	--self.DoorAxis:SetNoDraw( true )

	self.Door = ents.Create("prop_physics_override")
	self.Door:SetModel( "models/props_phx/construct/plastic/plastic_panel2x4.mdl" )
	self.Door:SetPos( self:LocalToWorld( self.DoorPos ) )
	self.Door:SetAngles( self:GetAngles() )
	self.Door:SetParent( self.DoorAxis )
	self.Door:SetMaterial( "phoenix_storms/metalSet_1-2" )
	self.Door:Spawn()
	
	self.FakeDoor = ents.Create("prop_physics_override")
	self.FakeDoor:SetModel( "models/props_phx/construct/plastic/plastic_panel2x4.mdl" )
	self.FakeDoor:SetPos( self.Door:GetPos()   )
	self.FakeDoor:SetNoDraw( true )
	self.FakeDoor:SetAngles( self.Door:GetAngles() )
	self.FakeDoor:Spawn()
	self.FakeDoorObj = self.FakeDoor:GetPhysicsObject()
	
	if ( self.FakeDoorObj:IsValid() ) then	
	
		self.FakeDoorObj:Wake()
		self.FakeDoorObj:SetMass( 50000 )		
		self.FakeDoorObj:EnableGravity( false )
		self.FakeDoorObj:EnableCollisions( true )
		
	end
	self.BodyDetails = {}

	for i,v in pairs( self.Details ) do
		
		self.BodyDetails[i] = ents.Create("prop_physics")
		self.BodyDetails[i]:SetPos( self:LocalToWorld( v.Pos ) )
		self.BodyDetails[i]:SetAngles( self:GetAngles() + v.Ang )
		self.BodyDetails[i]:SetModel( v.Mdl )
		self.BodyDetails[i]:Spawn()
		self.BodyDetails[i]:SetParent( self )
	
	end
	
	self:HelicopterDefaultInit()
	-- self:HelicopterCreateEngineSound()
	-- self:HelicopterCreateRotors()
	
	-- // Create Seats
	-- self:HelicopterCreatePilotSeat()
	-- self:HelicopterCreatePassengerSeat()
	self:HelicopterCreateGunnerSeats( self.ExtraSeats )
	
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 500000000 )
	
	self:StartMotionController()
	
end

function ENT:OnTakeDamage(dmginfo)

	self:HelicopterDefaultDamageScript( dmginfo )
	
end

function ENT:OnRemove()
	
	self:HelicopterDefaultOnRemove()

end

function ENT:PhysicsCollide( data, physobj )
	
	self:DefaultCollisionCallback( data, physobj )
	
end

function ENT:EjectPilotSpecial()
	
	if ( !IsValid( self.Pilot ) ) then 
	
		return
		
	end
	
	self.Pilot:UnSpectate()
	self.Pilot:DrawViewModel( true )
	self.Pilot:DrawWorldModel( true )
	self.Pilot:Spawn()
	self.Pilot:SetNetworkedBool( "InFlight", false )
	self.Pilot:SetNetworkedEntity( "Plane", NULL ) 
	self:SetNetworkedEntity("Pilot", NULL )
	
	self.Pilot:ExitVehicle()
	
	self.Pilot:SetPos( self:LocalToWorld( Vector( 140, 0, 14 ) ) )
	self.Pilot:SetAngles( Angle( 0, -self:GetAngles().y,0 ) )
	self.Owner = NULL
	self.Pilot:SetScriptedVehicle( NULL )
	
	self.Speed = 0
	self.IsFlying = false
	self:SetLocalVelocity(Vector(0,0,0))
	self.Pilot = NULL
	
end

function ENT:Touch( ent )


end

function ENT:Use(ply,caller)
	
	if( ply == self.Pilot ) then return end
	
	if ( !self.IsFlying && !IsValid( self.Pilot ) ) then 

		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():EnableMotion(true)
		self.IsFlying = true
		self.Pilot = ply
		self.Owner = ply
		
		self:SetNetworkedEntity("Pilot", ply )
		
		ply:Spectate( OBS_MODE_CHASE  )
		ply:DrawViewModel( false )
		ply:DrawWorldModel( false )
		ply:StripWeapons()
		ply:SetScriptedVehicle( self )
		ply:SetNetworkedBool("InFlight",true)
		ply:SetNetworkedEntity( "Plane", self ) 
		//ply:EnterVehicle( self.PilotSeat )
		self.Entered = CurTime()
		
	else
	
		local d = self.PassengerSeat:GetDriver()

		if( !IsValid( d ) ) then

			ply:EnterVehicle( self.PassengerSeat )
			
			if( IsValid( self.Pilot ) ) then

				self.Pilot:PrintMessage( HUD_PRINTCENTER, ply:GetName().." is your new co-pilot." )

			end
		
		else
				
			for i=1,#self.GunnerSeats do
				
				if( !IsValid( self.GunnerSeats[i]:GetDriver() ) ) then
					
					ply:EnterVehicle( self.GunnerSeats[i] )
					
					return
					
				end
			
			end
	
		end
		
	end
	
end

function ENT:Think()
	
	self:HelicopterDefaultThink()

	if( IsValid( self.Pilot ) && self.IsFlying ) then
	
		-- Let's drop some vehicles! by StarChick ;D
		if ( self.Pilot:KeyDown( IN_SPEED ) and self.LastDoor + 0.25 <= CurTime() ) then		
		
			self:EmitSound("lockon/TurretRotation.mp3",511,100)

			if self.DoorToggle == false then
				
				self.DoorToggle = true 	
			
			else
			
				if self.DoorToggle == true then
					
					self.DoorToggle = false
					
				end
				
			end		

			self.LastDoor = CurTime()
		
		end

	end

	
	if ( self.DoorToggle ) then		
		
		self.DoorAng = self.DoorAng + 2.5

		if ( self.DoorAng >= 105 ) then
			
			self.DoorAng = 105
			self:StopSound( "lockon/TurretRotation.mp3" )
	

		end
		
	end

	if ( !self.DoorToggle ) then	
	
		self.DoorAng = self.DoorAng - 3

		if ( self.DoorAng < 0 ) then 
		
			self.DoorAng = 0
			self:StopSound( "lockon/TurretRotation.mp3" )		

		end

	end
			

	self.DoorAxis:SetLocalAngles( Angle( 0.2 * self.DoorAng, 0, 0 ) )
		
	self:NextThink( CurTime() )
		
	return true
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	local a = self:GetAngles()
	local p,r = a.p,a.r
	local stallAng = ( p > 90 || p < -90 || r > 90 || r < -90 )
	local topval = ( self.Pilot != nil && ( self.MaxRotorVal / 2 ) ) or 0 // Should not be > 500
	
	self:HelicopterSpinThatThing()
	
	if ( stallAng ) then
		
		self.Speed = self.Speed / 1.15
		
	end
	
	if ( self.IsFlying && self.Started && !self.Destroyed && !self.RotorPropeller.isTouching ) then

		phys:Wake()
		self:CreateRotorwash()
		
		local pilotAng = self.Pilot:GetAimVector():Angle()
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 + self:GetUp() * 256 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		self.offs = self:VecAngD( ma.y, ta.y )		
		local r = r or 0
		local maxang = 42

		local vel = self:GetVelocity():Length()
		if ( vel > -600 && vel < 600 ) then
			
			self.isHovering = true
			self.BankingFactor = 15
		
		else
		
			self.isHovering = false
			self.BankingFactor = 4
			
		end
	
		if ( self.Pilot:KeyDown( IN_JUMP ) ) then
			
			self.HoverVal = self.HoverVal + 2.15
			
		elseif ( self.Pilot:KeyDown( IN_DUCK ) ) then
			
			self.HoverVal = self.HoverVal - 2.35
		
		end
		
		self.HoverVal = math.Clamp( self.HoverVal, -550, 600 )

		if( self.offs < -160 || self.offs > 160 ) then
			
			r = 0

		else

			r = ( self.offs / self.BankingFactor ) * -1

		end

		if ( self:GetVelocity():Length() < 1000 ) then 
		
			if ( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
				
				self.MoveRight = self.MoveRight - 7.5
				r  = -25
				
			elseif (  self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
				
				self.MoveRight = self.MoveRight + 7.5
				r = 25
				
			else
				
				self.MoveRight = math.Approach( self.MoveRight, 0, 0.995 )
			
			end

			self.MoveRight = math.Clamp( self.MoveRight, -556, 556 )
		
		else
		
			self.MoveRight = math.Approach( self.MoveRight, r * 10, 0.555 )
		
		end
		
		
		if ( self.GotChopperGunner && !IsValid( self.PassengerSeat:GetDriver() )  ) then
			
			if ( pilotAng.p < 5 || pilotAng.p > 300 ) then pilotAng.p = 5 end
	
			if ( self.Pilot:KeyDown( IN_FORWARD ) ) then
			
				pilotAng.p = 6
			
			elseif ( self.Pilot:KeyDown( IN_BACK ) ) then
				
				pilotAng.p = -6	
				
			else
			
				pilotAng.p = math.cos( CurTime() - ( self:EntIndex() * 10 ) ) * 1.25
			
			end

		end
		
		if ( ma.p > 2.5 ) then
	
			self.Speed = self.Speed + ma.p / 2.9
		
		elseif ( ma.p < -3 ) then
			
			self.Speed = self.Speed + ma.p / 2.5
		
		elseif ( ma.p > -3 && ma.p < 3 ) then
		
			self.Speed = self.Speed / 1.005
		
		end
		
		if ( self.Pilot:KeyDown( IN_WALK ) || IsValid( self.LaserGuided ) ) then
			
			--// Pull up ( or down ) the nose if we're going too fast.
			if( math.floor(self:GetVelocity():Length() / 1.8 ) > 300 && !( self.MoveRight > 500 || self.MoveRight < -500 ) ) then 
			
				if( self.Speed > 0 ) then
					
					pilotAng.p = -15
				
				elseif( self.Speed < 0) then
					
					pilotAng.p = 25
					
				end
				
				self.HoverVal = self.HoverVal / 1.05
				
			else
				
				pilotAng.p = 1.0 + ( math.sin( CurTime() - (self:EntIndex() * 10 ) ) / 2 )
			
			end
			
			self.Speed = self.Speed / 1.0035
		
		end
		
		self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
		
		local pr = {}
		local wind = Vector( math.sin( CurTime() - ( self:EntIndex() * 2 ) ) * 6, math.cos( CurTime() - ( self:EntIndex() * 2 ) ) * 5.8, math.sin( CurTime() - ( self:EntIndex() * 3 ) ) * 7 )
		
		if( self.HealthVal < 400 ) then
		
			local t = t or 0.15
			t = math.Approach( t, 4.5, 0.15 )
			
			wind = Vector( math.sin(CurTime() - ( self:EntIndex()*10) )*38 + math.random(-64,64),math.cos(CurTime() - ( self:EntIndex()*10) )*38 + math.random(-64,64), -0.01 ) 
			pilotAng.y = pilotAng.y + t
			self.HoverVal = self.HoverVal / 2 - 5
			
		end
		
		if( ( self.offs > 0 && self.offs < 180 && ma.r > 0 ) || ( self.offs > -180 && self.offs < 0 && ma.r < 0 ) ) then
			
			pilotAng.y = ma.y
			
		end
		
		pilotAng.p = math.Approach( pilotAng.p, self:GetAngles().p, 0.11 )
		
		local desiredPos = self:GetPos() + self:GetForward() * self.Speed + self:GetUp() * self.HoverVal + self:GetRight() * self.MoveRight// + wind
		pr.secondstoarrive	= 1
		pr.pos 				= desiredPos
 		pr.maxangular		= maxang // 400
		pr.maxangulardamp	= maxang // 10 000
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.8
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = pilotAng + Angle( 0, 0, r  )
		
		phys:ComputeShadowControl(pr)
	
	else
			
		self:RemoveRotorwash()
	
	end
	
end


function ENT:CreateRotorwash()
	
	if( !self.IsRotorwashing ) then
	
		self.Rotorwash = ents.Create("env_rotorwash_emitter")
		self.Rotorwash:SetPos( self:GetPos() )
		self.Rotorwash:SetParent( self )
		self.Rotorwash:SetKeyValue( "altitude", "",1024 )
		self.Rotorwash:Spawn()
		
		self.IsRotorwashing = true
	
	end

end

function ENT:RemoveRotorwash()
	
	if( IsValid( self.Rotorwash ) ) then
		
		self.Rotorwash:Remove()
		self.IsRotorwashing = false
	
	end

end