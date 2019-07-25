

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Model = "models/cn2-8-2.mdl"

// Speed Limits
ENT.MaxVelocity = 100
ENT.MinVelocity = -100

ENT.InitialHealth = 8500
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// Weapons
ENT.MaxDamage = 500
ENT.MinDamage = 100
ENT.BlastRadius = 256

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y + 90,0)
	local ent = ents.Create( "sent_test_train" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	
	self.IsTrainCar = true
	self.DockingSlots = { /*Vector( 308, 0, 29 ),*/ Vector( -335, 0, 29 ) }
	self.DockedCars = {}
	self.DockBallsockets = {}
	
	self.Bogey = {}
	self.BogeyPos = { Vector( 138, 0,  -15 ), Vector( -134, 0, -15 ) }
	self.BogeyModel = "models/drumdevils_props/trains/wheelbase_single.mdl"
	
	self.BogeyAxis = {}
	
	for i=1,#self.BogeyPos do
		
		self.Bogey[i] = ents.Create("prop_physics")
		self.Bogey[i]:SetPos( self:LocalToWorld( self.BogeyPos[i] ) )
		self.Bogey[i]:SetAngles( self:GetAngles() + Angle( 0, 90, 0 ) )
		self.Bogey[i]:SetModel( self.BogeyModel )
		//self.Bogey[i]:SetOwner( self )
		self.Bogey[i]:Spawn()
		//self.rotoraxis = constraint.Axis( self.RotorPropeller, self, 0, 0, Vector(0,0,1) , self.RotorPropellerPos, 0, 0, 1, 0 )
		
		self.BogeyAxis[i] = constraint.Axis( self.Bogey[i], self, 0,0, Vector( 0,0,1),  self:LocalToWorld(  self.BogeyPos[i] ), 0, 0, 1, 0 )
	
	end
	
	// Misc
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	// Sound
	local esound = {}
	self.EngineMux = {}
	esound[1] = "vehicles/diesel_loop2.wav"
	esound[2] = "vehicles/diesel_loop2.wav"
	esound[3] = "vehicles/diesel_loop2.wav"

	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	self.Pitch = 100
	
	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:PlayEx( 511 , self.Pitch )
	
	end
	
	self:SetUseType( SIMPLE_USE )
	self.IsDriving = false
	self.Pilot = NULL
	
	self.Yaw = 0
	
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 10000 )
		
	end

	self:StartMotionController()

end

function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed ) then
		
		return

	end
	
	if( IsValid( self.Pilot ) ) then
	
		self.Pilot:ViewPunch( Angle( math.random(-2,2),math.random(-2,2),math.random(-2,2) ) )
	
	end
	
	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt("health",self.HealthVal)
	
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then

		self.Burning = true
		local p = {}
		p[1] = self:GetPos() + self:GetForward() * -50 + self:GetRight() * 25 + self:GetUp() * 15
		p[2] = self:GetPos() + self:GetForward() * -50 + self:GetRight() * 25 + self:GetUp() * 15
		for _i=1,2 do
		
			local f = ents.Create("env_fire_trail")
			f:SetPos( p[_i] )
			f:SetParent( self )
			f:Spawn()
			
		end
		
	end
	
	if ( self.HealthVal < 5 ) then
	
		self.Destroyed = true
		self.PhysObj:EnableGravity(true)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:SetMass(2000)
		self:Ignite(60,100)
		
	end
	
end

function ENT:OnRemove()
	
	for i=1,#self.Bogey do
		
		if( IsValid( self.Bogey[i] ) ) then
			
			self.Bogey[i]:Remove()
			
		end
	
	end
	
	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:Stop()
		
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilot()
	
	end

end

function ENT:PhysicsCollide( data, physobj )

	if ( data.Speed > self.MaxVelocity * 0.8 && data.DeltaTime > 0.2 ) then 

	end
	
end

function ENT:Use(ply,caller)

	if ( !self.IsDriving && !IsValid( self.Pilot ) ) then 
		
		self.LastUsed = CurTime()
		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():EnableMotion(true)
		self.IsDriving = true
		self.Pilot = ply
		self.Owner = ply
		
		ply:Spectate( OBS_MODE_CHASE  )
		ply:DrawViewModel( false )
		ply:DrawWorldModel( false )
		ply:StripWeapons()
		ply:SetScriptedVehicle( self )
		
		ply:SetNetworkedBool("InFlight",true )
		self:SetNetworkedEntity("Pilot", ply )
		
	end
	
end


function ENT:EjectPilotSpecial()
	
	if ( !IsValid( self.Pilot ) ) then 
	
		return
		
	end
	
	self.Pilot:UnSpectate()
	self.Pilot:Spawn()
	self.Pilot:DrawViewModel( true )
	self.Pilot:DrawWorldModel( true )
	self.Pilot:SetNetworkedBool( "InFlight", false )
	self:SetNetworkedEntity("Pilot", NULL )
	
	self.Pilot:SetPos( self:GetPos() + self:GetRight() * -150 + self:GetUp() * 16 )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = NULL
	self.Pilot:SetScriptedVehicle( NULL )
	
	self.Speed = 0
	self.IsDriving = false
	self:SetLocalVelocity(Vector(0,0,0))
	
	self.Pilot = NULL
	
end

function ENT:Think()

	local _mod = self.Speed
	if( _mod < 0 ) then
		
		_mod = -1*_mod
		
	end
	
	self.Pitch = math.Clamp( math.floor( ( 200 * ( _mod / 100 ) ) + ( self:GetVelocity():Length() / 7 ) ), 140,255 )

	for i = 1,#self.EngineMux do
	
		self.EngineMux[i]:ChangePitch( self.Pitch - ( i * 5 ) )
		
	end
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 35 then
		
			self:EjectPilotSpecial()
			self:Remove()
		
		end
		
	end
	
	
	
	if ( self.IsDriving && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() )

		if( self.Pilot:KeyDown( IN_USE ) && self.LastUsed + 0.5 <= CurTime() ) then
			
			self:EjectPilotSpecial()
			self.LastUsed = CurTime()
			
			return
			
		end
		
		// Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
			self:EjectPilotSpecial()
			
		end

		
	end
		
	self:NextThink( CurTime() )
	return true
	
end

function ENT:PhysicsUpdate()
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	local tr, trace = {}
	local hitcount = 0
	local _a = self:GetAngles()
	local z = 0

	for i=1,20 do
		
		tr.start = self:GetPos() + self:GetForward() * -120 + self:GetForward() * ( i * 11.55 ) + self:GetRight() * math.sin(CurTime()) * 50
		tr.endpos = self:GetPos() + self:GetForward() * -120 + self:GetForward() * ( i * 11.55 ) + self:GetUp() * -9  + self:GetRight() * math.sin(CurTime()) * 50
		tr.filter = self
		tr.mask = MASK_SOLID
		--//self:DrawLaserTracer( self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetRight() * dir, self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetUp() * -17  + self:GetRight() * dir )
		
		trace = util.TraceLine( tr )
		
		if( trace.Hit && !trace.HitSky ) then
			
			hitcount = hitcount + 1
			//z = z + trace.HitPos.z
			
		end
		
	end
	
	if( hitcount < 10 ) then
		
		//self.Speed = math.Approach( self.Speed, 0, 0.02 )
		
	end
	
	if ( self.IsDriving && IsValid( self.Pilot ) && hitcount > 5 ) then
	
		phys:Wake()
		
		local mYaw = self:GetAngles().y
		local ap = self:GetAngles()
		local dir = Angle( 0,0,0 )
		local p = { { Key = IN_FORWARD, Speed = 0.65 };
					{ Key = IN_BACK, Speed = -0.65 }; }
		
		local keydown = false
		
		for k,v in ipairs( p ) do
		
			if ( self.Pilot:KeyDown( v.Key ) ) then
			
				self.Speed = self.Speed + v.Speed
				keydown = true
			
			end			
			
		end
		
		if( self.Pilot:KeyDown( IN_JUMP ) ) then
				
			self.Speed = self.Speed * 0.999
			
		end
		
		local dir = 0
		
		self.Speed = math.Clamp( self.Speed,  -100, 100 )//-10.8, 10.88 )
			
		local p = self:GetPos()

		local pr = {}
		pr.secondstoarrive	= 0.1
		pr.pos 				= p + self:GetForward() * self.Speed
		pr.maxangular		= 1000
		pr.maxangulardamp	= 1000
		pr.maxspeed			= 19
		pr.maxspeeddamp		= 12.95 //13
		pr.dampfactor		= 0.1 //.05 // 1.5
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = self:GetAngles()
		
		phys:ComputeShadowControl(pr)
	
	elseif( !self.IsDriving && !IsValid( self.Pilot )  ) then
	
		local pr = {}
		pr.secondstoarrive	= 0.1
		pr.pos 				= self:GetPos() + self:GetForward() * self.Speed
		pr.maxangular		= 1000
		pr.maxangulardamp	= 1000
		pr.maxspeed			= 19
		pr.maxspeeddamp		= 12.95 
		pr.dampfactor		= 0.1
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = self:GetAngles()
		
		phys:ComputeShadowControl(pr)
	
	end
	
end


