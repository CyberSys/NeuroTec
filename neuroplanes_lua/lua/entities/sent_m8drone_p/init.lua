// Use this as base for helicopters with physical rotors.

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Model = "models/mq8/mq8.mdl"
//Speed Limits
ENT.MaxVelocity = 600
ENT.MinVelocity = -600

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 1.85

ENT.InitialHealth = 1500
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.Velpitch = 0

// Timers
ENT.RotorTimer = 500
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 10
ENT.FlareCount = 20
ENT.MaxFlares = 20

ENT.NumRockets = nil
ENT.PrimaryCooldown = 99999999999999
ENT.SecondaryCooldown = 5.0

ENT.GotChopperGunner = false

// VTOL specifik variable.
ENT.isHovering = false

ENT.AutomaticFrameAdvance = true

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_m8drone_p" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	self.LastPrimaryAttack = CurTime()
	self.LastSecondaryAttack = CurTime()
	
	self.HasMGun = false
	
	self.LastFireModeChange = CurTime()
	self.LastRadarScan = CurTime()
	self.LastFlare = CurTime()
	self.ChopperGunAttack = CurTime()
	self.LastChopperGunToggle = CurTime() 
	self.LastLaserUpdate = CurTime()
	self.LastSecondaryKeyDown = CurTime()
	
	self.MinigunRevolve = 0
	self.HoverVal = 0
	self.MoveRight = 0
	self.RotorVal = 0
	self.MaxRotorVal = 1600
	self.RotorMult = self.MaxRotorVal / 2000
	self.Started = false
	self.SpinUp = 0

	
	
	self:HelicopterDefaultInit()
	-- self:HelicopterCreateEngineSound()

	// Create Seats
	-- self:HelicopterCreatePilotSeat()
	-- self:HelicopterCreatePassengerSeat()
	-- self:HelicopterCreateChopperGun()
	
	-- // Misc
	-- self:SetModel( self.Model )	
	-- self:PhysicsInit( SOLID_VPHYSICS )
	-- self:SetMoveType( MOVETYPE_VPHYSICS )
	-- self:SetSolid( SOLID_VPHYSICS )
	-- self.PhysObj = self:GetPhysicsObject()
	-- self.PhysObj:SetMass( 500000000 )
	
	-- // Create the rotor blades
	-- self:HelicopterCreateRotors()
		
	-- self:SetNetworkedInt( "health", self.HealthVal )
	-- self:SetNetworkedInt( "HudOffset", self.CrosshairOffset )
	-- self:SetNetworkedInt( "MaxHealth", self.InitialHealth )
	-- self:SetNetworkedInt( "MaxSpeed", self.MaxVelocity )
	-- self:SetNetworkedEntity("NeuroPlanesMountedGun", self.ChopperGun )
	
	--self:SetSkin( math.random( 0, 4 ) )
	-- self:StartMotionController()
	
end

function ENT:OnTakeDamage(dmginfo)

	self:HelicopterDefaultDamageScript( dmginfo )
	
end

function ENT:OnRemove()
	
	self:HelicopterDefaultOnRemove()

end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime < 0.2 ) then return end
	
	self:DefaultCollisionCallback( data, physobj )
	
end

function ENT:EjectPilotSpecial()
	
	if ( !IsValid( self.Pilot ) ) then 
	
		return
		
	end
	
	
	self.Pilot:UnSpectate()
	self.Pilot:DrawViewModel( true )
	self.Pilot:DrawWorldModel( true )

	self.Pilot:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.Pilot:SetColor( Color( 255,255,255,255 ) ) 
	self.Pilot:SetNetworkedBool( "InFlight", false )
	self.Pilot:SetNetworkedEntity( "Plane", NULL ) 
	self:SetNetworkedEntity("Pilot", NULL )

	
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = NULL
	self.Pilot:SetScriptedVehicle( NULL )
	self.Pilot:SetMoveType( MOVETYPE_isOMETRIC )
	self.Speed = 0
	self.IsFlying = false
	self:SetLocalVelocity(Vector(0,0,0))
	
	self.Pilot:Spawn()
	self.Pilot:SetPos( self.EnterPos )
	
	self.Pilot = NULL
	
end

function ENT:Use(ply,caller)
	
	if( ply == self.Pilot ) then return end
	
	if ( !self.IsFlying && !IsValid( self.Pilot ) ) then 
		
		self.EnterPos = ply:GetPos()
		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():EnableMotion(true)
		self.IsFlying = true
		self.Pilot = ply
		self.Owner = ply
		self.Pilot:SetMoveType( MOVETYPE_NONE )
		
		self:SetNetworkedEntity("Pilot", ply )
		
		ply:Spectate( OBS_MODE_CHASE  )
		ply:DrawViewModel( false )
		ply:DrawWorldModel( false )
		ply:StripWeapons()
		ply:SetScriptedVehicle( self )
		ply:SetNetworkedBool("InFlight",true)
		ply:SetNetworkedEntity( "Plane", self ) 
		ply:SetNetworkedBool( "isGunner", false )
		ply:SetNetworkedEntity( "ChopperGunnerEnt", self.ChopperGun )
		//ply:EnterVehicle( self.PilotSeat )
		self.Entered = CurTime()

	end
	
end

function ENT:Think()
	
		
	if ( self.Burning && self:WaterLevel() < 2 ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-32,32) + self:GetForward() * math.random(-32,32)  )
		util.Effect( "immolate", effectdata )
		self.HealthVal = self.HealthVal - 1
		
	end
		
	if( self.Destroyed ) then
		
		self.DeathTimer = self.DeathTimer + 1
		
		if( self.DeathTimer > 100 ) then
		
			self.Destroyed = true
			
			self:DeathFX()
				
			return
				
		end
		
	end
	
	if( !IsValid( self.rotoraxis ) ) then	
		
		self.Destroyed = true
		
		return
		
	end
			
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
	
		self.VelPitch = self:GetVelocity():Length() / 100
		
	else 
		
		self.VelPitch = 0
	
	end
	
	self.Pitch = math.Clamp( math.floor( self.VelPitch + self.RotorPhys:GetAngleVelocity():Length() / 30  ),0,175 )
	self.LoopSound:ChangePitch( self.Pitch, 0.01 )
		
	if( IsValid( self.ChopperGun ) ) then
	
		self.ChopperGun:SetSkin( self:GetSkin() )
	
	end
	
	if( IsValid( self.RotorPropeller ) ) then
	
		self.RotorPropeller:SetSkin( self:GetSkin() )
	
	end
	
	if( IsValid( self.TailPropeller ) ) then
	
		self.TailPropeller:SetSkin( self:GetSkin() )
		
	end
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then

		// HUD Stuff
		self:UpdateRadar()
		// Lock On method
		if( self.CanLockon != false ) then
		
			self:Jet_LockOnMethod()
		
		end
		
		// Clear Target 
		if ( self.Pilot:KeyDown( IN_SPEED ) && IsValid( self.Target ) ) then
			
			self:ClearTarget()
			self.Pilot:PrintMessage( HUD_PRINTCENTER, "Target Released" )
			
		end

		if ( self.LastSecondaryKeyDown + 0.125 <= CurTime() && self.Pilot:KeyDown( IN_ATTACK2 ) && !self.Pilot:GetNetworkedBool( "isGunner", false ) ) then
			
			local id = self.EquipmentNames[ self.FireMode ].Identity
			local wep = self.RocketVisuals[ id ]
			self.LastSecondaryKeyDown = CurTime()
			
			if ( wep.LastAttack + wep.Cooldown <= CurTime() ) then
			
				self:HelicopterSecondaryAttack( wep, id )
				
			end
	
		end
		
		// Firemode 
		if ( self.Pilot:KeyDown( IN_RELOAD ) && self.LastFireModeChange + 0.5 <= CurTime() ) then

			self:CycleThroughWeaponsList()
			
		end
		
		// Flares
		if ( self.Pilot:KeyDown( IN_SCORE ) && !self.isHovering && self.FlareCount > 0 && self.LastFlare + self.FlareCooldown <= CurTime() && self.LastFireModeChange + 0.2 <= CurTime() ) then
			
			self.LastFireModeChange = CurTime()
			self.FlareCount = self.FlareCount - 1
			self:SetNetworkedInt( "FlareCount", self.FlareCount )
			self:SpawnFlare()
			
			if ( self.FlareCount == 0 ) then
			
				self.LastFlare = CurTime() 
				self.FlareCount = self.MaxFlares
				
			end
			
		end
	
		if ( self.Pilot:KeyDown( IN_USE ) && self.Entered + 1.0 <= CurTime() ) then

			self:EjectPilotSpecial()
			
		end	
		
		// Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
			self:EjectPilotSpecial()
			
		end

	end
	
	self:NextThink( CurTime() )
		
	return true
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	local a = self:GetAngles()
	local p,r = a.p,a.r
	local stallAng = ( p > 90 || p < -90 || r > 90 || r < -90 )

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
			
			self.HoverVal = self.HoverVal + 3.5
			
		elseif ( self.Pilot:KeyDown( IN_DUCK ) ) then
			
			self.HoverVal = self.HoverVal - 3.5
		
		end
		
		self.HoverVal = math.Clamp( self.HoverVal, -400, 700 )

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
		
			self.MoveRight = math.Approach( self.MoveRight, r * 40, 1.555 )
		
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
	
			self.Speed = self.Speed + ma.p / 4.9
		
		elseif ( ma.p < -3 ) then
			
			self.Speed = self.Speed + ma.p / 4.5
		
		elseif ( ma.p > -3 && ma.p < 3 ) then
		
			self.Speed = self.Speed / 1.005
		
		end
		
		if ( self.Pilot:KeyDown( IN_WALK ) || IsValid( self.LaserGuided ) ) then
			
			--// Pull up ( or down ) the nose if we're going too fast.
			if( math.floor(self:GetVelocity():Length() / 1.8 ) > 400 && !( self.MoveRight > 500 || self.MoveRight < -500 ) ) then 
			
				if( self.Speed > 0 ) then
					
					pilotAng.p = -15
				
				elseif( self.Speed < 0) then
					
					pilotAng.p = 25
					
				end
				
				self.HoverVal = self.HoverVal / 1.05
				
			else
				
				pilotAng.p = 1.0 + ( math.sin( CurTime() - (self:EntIndex() * 10 ) ) / 2 )
				pilotAng.y = self:GetAngles().y
				r = 0
				
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
		
		-- if( ( self.offs > 0 && self.offs < 180 && ma.r > 0 ) || ( self.offs > -180 && self.offs < 0 && ma.r < 0 ) ) then
			
			-- pilotAng.y = ma.y
			
		-- end
		
		pilotAng.p = math.Approach( pilotAng.p, self:GetAngles().p, 0.11 )
		
		local desiredPos = self:GetPos() + self:GetForward() * self.Speed + self:GetUp() * self.HoverVal + self:GetRight() * self.MoveRight + wind
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