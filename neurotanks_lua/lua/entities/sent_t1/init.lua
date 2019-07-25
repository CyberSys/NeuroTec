
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "Terminator model 101"
ENT.Model = "models/t3/t1/t1.mdl"

// Speed Limits
ENT.MaxVelocity = 200
ENT.MinVelocity = -100

ENT.InitialHealth = 2500
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
	local newAng = Angle(0,vec.y + 180,0)
	local ent = ents.Create( "sent_t1" )
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
	
	// Misc
	self:SetModel("models/t3/t1/t1.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	// Sound
	local esound = {}
	self.EngineMux = {}
	esound[1] = "physics/metal/canister_scrape_smooth_loop1.wav"
	esound[2] = "physics/cardboard/cardboard_box_scrape_smooth_loop1.wav"
	esound[3] = "ambient/levels/canals/dam_water_loop2.wav"
	
	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	self.Pitch = 80
	self.EngineMux[1]:PlayEx( 500 , self.Pitch )
	self.EngineMux[2]:PlayEx( 500 , self.Pitch )
	self.EngineMux[3]:PlayEx( 500 , self.Pitch )
	
	self:SetUseType( SIMPLE_USE )
	self.IsDriving = false
	self.Pilot = NULL
	self.Yaw = 0
	
	self.Tower = ents.Create("prop_physics")
	self.Tower:SetModel("models/t3/t1/t1main.mdl")
	self.Tower:SetPos( self:GetPos() + self:GetForward() * 10 + self:GetUp() * 50 )
	self.Tower:SetParent( self )
	self.Tower:SetAngles( self:GetAngles() )
	self.Tower:Spawn()
	self.TowerPhys = self.Tower:GetPhysicsObject()	
	if ( self.TowerPhys:IsValid() ) then
	
		self.TowerPhys:Wake()
		self.TowerPhys:EnableGravity( true )
		//self.TowerPhys:EnableDrag( true )
		
	end

	
	--Spawn motherfucker!!!!
	
	self.Turretbase = {}
	local TurretbasePos = {}
	TurretbasePos[1] = Vector( -35, -65, -60 )
	TurretbasePos[2] = Vector( -35, 65, -60 )
	

	for i= 1,2	do
	self.Turretbase[i] = ents.Create("prop_physics_override")
	self.Turretbase[i]:SetModel("models/t3/t1/t1turret.mdl")
	self.Turretbase[i]:SetPos( self:LocalToWorld( TurretbasePos[i] ) )
	self.Turretbase[i]:SetAngles( self.Tower:GetAngles() )
	self.Turretbase[i]:SetParent( self.Tower )
	self.Turretbase[i]:Spawn()
	
	constraint.NoCollide( self.Turretbase[i], self.Tower, 0, 0 )
	
	self.basePhys = self.Turretbase[i]:GetPhysicsObject()
	
	if ( self.basePhys:IsValid() ) then
	
		self.basePhys:Wake()
		self.basePhys:EnableGravity( false )
	    self.basePhys:EnableCollisions( false )
		
	end
end

	self.turret = {}
	local TurretPos = {}
	TurretPos[1] = Vector( -35, -65, -60 )
	TurretPos[2] = Vector( -35, 65, -60 )
	
	for i= 1,2	do
	self.turret[i] = ents.Create("prop_physics_override")
	self.turret[i]:SetModel("models/t3/t1/turret.mdl")
	self.turret[i]:SetPos( self:LocalToWorld( TurretPos[i] ) )
	self.turret[i]:SetParent( self.Tower )
	self.turret[i]:SetAngles( self:GetAngles() )
	self.turret[i]:Spawn()
		
	end


	-- Hackfix until garry implements GetPhysicsObjectNum/count on the client.
	self.TowerProp = ents.Create("prop_physics_override")
	self.TowerProp:SetPos( self.Tower:GetPos() + self.Tower:GetAngles():Up() * 50 )
	self.TowerProp:SetAngles( self.Tower:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.TowerProp:SetModel( "models/weapons/ar2_grenade.mdl" )
	self.TowerProp:SetParent( self.Tower )
	self.TowerProp:Spawn()
	
	self.MGun = {}
	
	local MGPos = {}
	MGPos[1] = Vector( -35, -65, -60 )
	MGPos[2] = Vector( -35, 65, -60 )
	
	for i= 1,2	do
		
	self.MGun[i] = ents.Create("prop_physics_override")
	self.MGun[i]:SetModel("models/t3/t1/turretgun.mdl")
	self.MGun[i]:SetPos(  self:LocalToWorld( MGPos[i] ))
	self.MGun[i]:SetParent( self.Tower )
	self.MGun[i]:SetAngles( self.Tower:GetAngles() )
	self.MGun[i]:Spawn()
end
	self.MGunTube = ents.Create("prop_physics_override")
	self.MGunTube:SetModel("models/weapons/ar2_grenade.mdl")
	self.MGunTube:SetPos( self:GetPos() + self:GetForward() * 55 + self:GetUp() * 60 )
	self.MGunTube:SetParent( self.Tower)
	self.MGunTube:SetAngles( self:GetAngles() )
	self.MGunTube:Spawn()
	self.MGunTube:SetColor( 0, 0, 0, 0 )

	constraint.NoCollide( self.Tower, self, 0, 0 )
	constraint.NoCollide( self.Tower, self.MGun, 0, 0 )
	constraint.NoCollide( self.Tower, self.Barrel, 0, 0 )
	constraint.NoCollide( self.Barrel, self, 0, 0 )
	constraint.NoCollide( self.MGun, self, 0, 0 )
	constraint.NoCollide( self.MGun, self.turret, 0, 0 )
	constraint.NoCollide( self.Turretbase[i], self.Tower, 0, 0 )
	constraint.NoCollide( self.Turretbase[i], self.turret, 0, 0 )
		
	self.Wheels = {}
	local wheelpos = {}
	
	/*
	//RearLeft
	self.WrearLeft = ents.Create( "sent_Sakarias_CarWheel" )
	self.WrearLeft.TireModel = model	
	self.WrearLeft:SetPos( self.Entity:GetPos() + newPos)
	self.WrearLeft:SetOwner(self.Owner)		
	self.WrearLeft:SetAngles(self.Entity:GetAngles() + Angle(0,180,0))
	self.WrearLeft:Spawn()
	self.WrearLeft:SetCanTakeDamage( self.CanTakeWheelDamage )
	self.axisRL = constraint.Axis( self.WrearLeft, self.Entity, 0, 0, Vector(0,1,0) , newPos, 0, 0, 0 )	
	*/

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
		p[1] = self:GetPos() + self:GetForward() * -294 + self:GetRight() * 59 + self:GetUp() * 70
		p[2] = self:GetPos() + self:GetForward() * -294 + self:GetRight() * 59 + self:GetUp() * 70
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

	for i=1,3 do
	
		self.EngineMux[i]:Stop()
		
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilot()
	
	end
	self.TowerProp:Remove()
	self.BarrelProp:Remove()
	
end

function ENT:PhysicsCollide( data, physobj )

	if ( data.Speed > self.MaxVelocity * 0.8 && data.DeltaTime > 0.2 ) then 
		
		--self:SetNetworkedInt("health",self.HealthVal)
		
	end
	
end

function ENT:Use(ply,caller)

	if ( !self.IsDriving && !IsValid( self.Pilot ) ) then 

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
		
		ply:SetNetworkedBool("InFlight",true)
		ply:SetNetworkedEntity( "Tank", self.TowerProp )
		ply:SetNetworkedEntity( "Barrel", self.BarrelProp )
		self:SetNetworkedEntity("Pilot", ply )
		
	end
	
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
	self.Pilot:SetNetworkedEntity( "Tank", NULL ) 
	self.Pilot:SetNetworkedEntity( "Barrel", NULL )
	self:SetNetworkedEntity("Pilot", NULL )
	
	self.Pilot:SetPos( self:GetPos() + self:GetRight() * -150 + self:GetUp() * 500 )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = NULL
	self.Pilot:SetScriptedVehicle( NULL )
	
	self.Speed = 0
	self.IsDriving = false
	self:SetLocalVelocity(Vector(0,0,0))
	self.Pilot = NULL
	
end

function ENT:Think()
	
	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 20 + 40 ),0,245 )

	for i = 1,3 do
	
		self.EngineMux[i]:ChangePitch( self.Pitch )
		
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
		
		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 82 )
	
		--self:NeuroPlanes_CycleThroughHeliKeyBinds()
		
		if( self.Pilot:KeyPressed( IN_USE ) ) then
			
			self:EjectPilotSpecial()
			self.Driving = false
			self.Pilot:SetNetworkedEntity("Tank",NULL)
			self.Pilot:SetNetworkedEntity("Barrel",NULL)
			self.Pilot = NULL
			
			
		end
		
		// Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
			self:EjectPilot()
			
		end

		// Attack
		if ( self.Pilot:KeyDown( IN_ATTACK ) ) then
		--			if ( self.ChopperGunAttack + 0.1 <= CurTime() ) then
					
					self:PrimaryAttack()
		-- end	
		end

		if ( self.Pilot:KeyDown( IN_ATTACK2 ) ) then
		
--			if ( self.GotChopperGunner ) then
			
	--			if ( self.ChopperGunAttack + 0.1 <= CurTime() ) then
					
					self:SecondaryAttack()
					
	--			end
				
	--		else
				
	--			if ( self.ChopperGunAttack + 0.1 <= CurTime() ) then
					
	--				self:SecondaryAttack()
					
	--			end
			
	--		end
			
		end
		
	end
		
	self:NextThink( CurTime() )
	return true
	
end


function ENT:MountedGunCallback( a, b, c )

	if ( IsValid( self.Weapon ) ) then
	
		local e = EffectData()
		e:SetOrigin(b.HitPos)
		e:SetNormal(b.HitNormal)
		e:SetScale( 2.0 )
		util.Effect("ManhackSparks", e)

		util.BlastDamage( self.Weapon, self.Weapon, b.HitPos, 100, math.random(15,19) )
		
	end
	
	return { damage = true, effects = DoDefaultEffect } 	
	
end

local function apr(a,b,c)
	local z = math.AngleDifference( b, a )
	return math.Approach( a, a + z, c )
end


function ENT:PhysicsSimulate( phys, deltatime )
	
	local tr, trace = {}
	local hitcount = 0
	local _a = self:GetAngles()
	local z = 0

	for i=1,20 do
		
		tr.start = self:GetPos() + self:GetForward() * -120 + self:GetForward() * ( i * 11.55 ) + self:GetRight() * math.sin(CurTime()) * 40
		tr.endpos = self:GetPos() + self:GetForward() * -120 + self:GetForward() * ( i * 11.55 ) + self:GetUp() * -128  + self:GetRight() * math.sin(CurTime()) * 60
		tr.filter = self
		tr.mask = MASK_SOLID
		//self:DrawLaserTracer( self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetRight() * dir, self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetUp() * -17  + self:GetRight() * dir )
		
		trace = util.TraceLine( tr )
		
		if( trace.Hit ) then
			
			hitcount = hitcount + 1
			z = z + trace.HitPos.z
			
		end
		
	end
	
	z = z / hitcount

	local conditions = ( hitcount >= 7 || ( hitcount > 4 && _a.p > 1.5 ) ) && _a.p > -45 

	if ( self.IsDriving && IsValid( self.Pilot ) && conditions ) then
		phys:Wake()
		
		local mYaw = self:GetAngles().y
		local ap = self:GetAngles()
		local dir = Angle( 0,0,0 )
		local p = { { Key = IN_FORWARD, Speed = 0.275 };
					{ Key = IN_BACK, Speed = -0.15 }; }

		for k,v in ipairs( p ) do
		
			if ( self.Pilot:KeyDown( v.Key ) ) then
			
				self.Speed = self.Speed + v.Speed

			else
			
				self.Speed = math.Approach( self.Speed, 0, 0.12 )
				
			end			
			
		end
		
		self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
		
		if( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
					
			self.Yaw = math.Approach( self.Yaw, 2.9, 0.2 )

		elseif( self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
		
			self.Yaw = math.Approach( self.Yaw, -2.9, 0.2)
			
		else
			
			self.Yaw = math.Approach( self.Yaw, 0, 1 )
		
		end
			
		local p = self:GetPos()
		p.z = z + 0.5
		
		local downparam = ap.p
		if( downparam > 0 ) then downparam = 0 end
		
		local pr = {}
		pr.secondstoarrive	= 0.1
		pr.pos 				= p + self:GetForward() * self.Speed
		pr.maxangular		= 1000
		pr.maxangulardamp	= 1000
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000000
		pr.dampfactor		= 1.5
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = Angle( self:GetAngles().p, mYaw + self.Yaw, self:GetAngles().r )
		
		phys:ComputeShadowControl(pr)

	end	
end

