// Use this as base for helicopters with physical rotors.

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


ENT.PrintName = "AH-64 Apache II"
ENT.Model = "models/Apache/apache.mdl"
//Speed Limits
ENT.MaxVelocity = 970
ENT.MinVelocity = -800

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 3.7

ENT.InitialHealth = 4000
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
ENT.PrimaryCooldown = 0.03
ENT.SecondaryCooldown = 5.0

ENT.GotChopperGunner = false

// VTOL specifik variable.
ENT.isHovering = false

ENT.AutomaticFrameAdvance = true

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_aH-64_apache_p" )
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

	-- // Create Seats
	-- self:HelicopterCreatePilotSeat()
	-- self:HelicopterCreatePassengerSeat()
	self:HelicopterCreateChopperGun()
	
	// Misc
	-- self:SetModel( self.Model )	
	-- self:PhysicsInit( SOLID_VPHYSICS )
	-- self:SetMoveType( MOVETYPE_VPHYSICS )
	-- self:SetSolid( SOLID_VPHYSICS )
	self.PhysObj = self:GetPhysicsObject()
	self.PhysObj:SetMass( 50000000 )
	
	// Create the rotor blades
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
	self.Pilot:Spawn()
	self.Pilot:SetNetworkedBool( "InFlight", false )
	self.Pilot:SetNetworkedEntity( "Plane", NULL ) 
	self:SetNetworkedEntity("Pilot", NULL )
	self:SetNetworkedBool("ChopperGunner",false)
	self.Pilot:SetNetworkedBool( "isGunner", false )
	self.GotChopperGunner = false
	self.Pilot:SetNetworkedEntity("ChopperGunnerEnt", NULL )
	
	self.Pilot:ExitVehicle()
	
	self.Pilot:SetPos( self:GetPos() + self:GetRight() * -75 + self:GetForward() * 145 + self:GetUp() * -16 )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = NULL
	self.Pilot:SetScriptedVehicle( NULL )
	
	self.Speed = 0
	self.IsFlying = false
	self:SetLocalVelocity(Vector(0,0,0))
	self.Pilot = NULL
	
end

function ENT:Use(ply,caller)
	
	self:NeuroPlanes_DefaultHeloUse( ply )
	
end

function ENT:SetChoppergunner( plr, oldplr )
	
	self.LastChopperGunToggle = CurTime()
	self.GotChopperGunner = !self.GotchopperGunner
	
	plr:SetNetworkedBool("isGunner", self.GotChopperGunner )
	plr:SetNetworkedEntity("NeuroPlanesMountedGun", self.GotChopperGunner )
	
	if( plr != oldplr ) then
		
		oldplr:SetNetworkedBool("isGunner", false )
		oldplr:SetNetworkedEntity("NeuroPlanesMountedGun", oldplr )
	
	end

end

function ENT:Think()
	
	self:HelicopterDefaultThink()

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
			if( math.floor(self:GetVelocity():Length() / 1.8 ) > 400 && !( self.MoveRight > 500 || self.MoveRight < -500 ) ) then 
			
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
			
			-- pilotAng.y = ma.y
			
		end
		
		pilotAng.p = math.Approach( pilotAng.p, self:GetAngles().p, 0.11 )
		
		local desiredPos = self:GetPos() + self:GetForward() * self.Speed + self:GetUp() * self.HoverVal + self:GetRight() * self.MoveRight// + wind
		pr.secondstoarrive	= 1
		pr.pos 				= desiredPos
 		pr.maxangular		= maxang // 400
		pr.maxangulardamp	= maxang // 10 000
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.77
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