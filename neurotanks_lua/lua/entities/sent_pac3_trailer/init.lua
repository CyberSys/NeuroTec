

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "RIM-116 Rolling Airframe Missile"
ENT.Model = "models/pla/mim-104f patriot_platform.mdl"

// Speed Limits
ENT.MaxVelocity = 100
ENT.MinVelocity = -100

ENT.InitialHealth = 5000
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
ENT.Overheat = 0
ENT.OverheatDelay = CurTime()
ENT.LastRelease = CurTime()
function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y + 180,0)
	local ent = ents.Create( "sent_pac3_trailer" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	ent:SetSkin( math.random(1,4 ) )
	
--	construct.SetPhysProp( ply, ent, 0, nil,  { GravityToggle = true, Material = "rubber" } )  //useless because static
	
	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	
	// Misc
	self:SetModel("models/hunter/tubes/circle4x4.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetColor( Color(150,150,150,255) )
	self:SetMaterial( "phoenix_storms/dome" )

	// Sound
	local esound = {}
	self.EngineMux = {}
	esound[1] = "vehicles/diesel_loop2.wav"
	//esound[2] = "t3/hk_tank/hk_tank.wav"
	esound[2] = "vehicles/diesel_loop2.wav"
	esound[3] = "vehicles/diesel_loop2.wav"
	/*esound[2] = "physics/cardboard/cardboard_box_scrape_smooth_loop1.wav"
	esound[3] = "ambient/levels/canals/dam_water_loop2.wav"
	*/
	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	self.Pitch = 100
	
	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:PlayEx( 511*0  , self.Pitch )
	
	end
	
	self:SetUseType( SIMPLE_USE )
	self.IsDriving = false
	self.Pilot = NULL
	
	self.Yaw = 0
	
	self.Tower = ents.Create("prop_physics_override")
	self.Tower:SetModel("models/pla/mim-104f patriot_turret.mdl")
	self.Tower:SetPos( self:GetPos() + self:GetUp() * 45 )
	self.Tower:SetParent( self )
	self.Tower:SetSkin( self:GetSkin() )
	self.Tower:SetAngles( self:GetAngles() )
	self.Tower:Spawn()
	self.TowerPhys = self.Tower:GetPhysicsObject()	
	if ( self.TowerPhys:IsValid() ) then
	
		self.TowerPhys:Wake()
		self.TowerPhys:EnableGravity( true )
		//self.TowerPhys:EnableDrag( true )
		
	end

	self.Weapon = ents.Create("prop_physics_override")
	self.Weapon:SetModel("models/pla/mim-104f patriot_launcher.mdl")
	self.Weapon:SetPos( self.Tower:GetPos() + self.Tower:GetUp() * 40 )
	self.Weapon:SetParent( self.Tower )
	self.Weapon:SetSkin( self.Tower:GetSkin() )
	self.Weapon:SetAngles( self.Tower:GetAngles() )
	self.Weapon:Spawn()
	self.WeaponPhys = self.Weapon:GetPhysicsObject()	
	if ( self.WeaponPhys:IsValid() ) then
	
		self.WeaponPhys:Wake()
		self.WeaponPhys:EnableGravity( true )
		//self.WeaponPhys:EnableDrag( true )
		
	end
	self.WeaponPos = self.Weapon:GetPos() + self.Weapon:GetForward() * 100 + self.Weapon:GetRight() *-5 + self.Weapon:GetUp() * -30.5 

	local Missilepos = {}
	Missilepos[1] = Vector( 7, 11, 58 )
	Missilepos[2] = Vector( 7, 0, 58 )
	Missilepos[3] = Vector( 7, -11, 58 )

	Missilepos[4] = Vector( 7, 11, 45 )
	Missilepos[5] = Vector( 7, 0, 45 )
	Missilepos[6] = Vector( 7, -11, 45 )

	Missilepos[7] = Vector( 7, 11, 31 )
	Missilepos[8] = Vector( 7, 0, 31 )
	Missilepos[9] = Vector( 7, -11, 31 )

	Missilepos[10] = Vector( 7, 11, 17 )
	Missilepos[11] = Vector( 7, 0, 17 )
	Missilepos[12] = Vector( 7, -11, 17 )
	
	self.Missile = {}
		   for i = 1, 12 do
		
		self.Missile[i] = ents.Create("prop_physics")
		self.Missile[i]:SetPos( self.Tower:LocalToWorld( Missilepos[i] ) )
		self.Missile[i]:SetModel( "models/hawx/weapons/aim-9 sidewinder.mdl" )
		self.Missile[i]:SetAngles( self:GetAngles() )
		self.Missile[i]:SetParent( self.Weapon )
		self.Missile[i]:Spawn()
	
		
	end
		
	self.MissilePhys = {}
	for i = 1, 2 do
	
		self.MissilePhys[i] = self.Missile[i]:GetPhysicsObject()
		self.MissilePhys[i]:Wake()
		self.MissilePhys[i]:SetMass( 1 )
		self.MissilePhys[i]:EnableGravity( false )
		self.MissilePhys[i]:EnableCollisions( false )

	end

	-- Hackfix until garry implements GetPhysicsObjectNum/count on the client.
	self.TowerProp = ents.Create("prop_physics_override")
	self.TowerProp:SetPos( self.Tower:GetPos() + self.Tower:GetAngles():Up() * 50 )
	self.TowerProp:SetAngles( self.Tower:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.TowerProp:SetModel( "models/weapons/ar2_grenade.mdl" )
	self.TowerProp:SetParent( self.Tower )
	self.TowerProp:SetColor( Color(  0,0,0,0 ) )
	self.TowerProp:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.TowerProp:Spawn()
	
	self.WeaponProp = ents.Create("prop_physics_override")
	self.WeaponProp:SetPos( self.Weapon:GetPos() + self.Weapon:GetAngles():Forward() * 150 )
	self.WeaponProp:SetAngles( self.Tower:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.WeaponProp:SetModel( "models/weapons/ar2_grenade.mdl" )
	self.WeaponProp:SetParent( self.Weapon )
	self.WeaponProp:SetColor( Color( 0,0,0,0 ) )
	self.WeaponProp:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.WeaponProp:Spawn()

	constraint.NoCollide( self.Tower, self, 0, 0 )
	constraint.NoCollide( self.Tower, self.Weapon, 0, 0 )
	constraint.NoCollide( self.Weapon, self, 0, 0 )
	

	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 1000 )
		
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
		p[1] = self.Tower:GetPos() + self.Tower:GetForward() * -50 + self.Tower:GetRight() * 25 + self.Tower:GetUp() * 15
		p[2] = self.Tower:GetPos() + self.Tower:GetForward() * -50 + self.Tower:GetRight() * 25 + self.Tower:GetUp() * 15
		for _i=1,2 do
		
			local f = ents.Create("env_fire_trail")
			f:SetPos( p[_i] )
			f:SetParent( self.Tower )
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

	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:Stop()
		
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilot()
	
	end
	self.TowerProp:Remove()
	self.WeaponProp:Remove()
	
end

function ENT:PhysicsCollide( data, physobj )
	
end

function ENT:Use(ply,caller)

	if ( !self.IsDriving && !IsValid( self.Pilot ) ) then 
		
		self.LastUsed = CurTime()
		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():EnableMotion(true)
		self.IsDriving = true
		self.Pilot = ply
		self.Owner = ply
		
		-- ply:Spectate( OBS_MODE_CHASE  )
		ply:DrawViewModel( false )
		ply:DrawWorldModel( false )
		ply:StripWeapons()
		ply:SetScriptedVehicle( self )
		
		ply:SetNetworkedBool("InFlight",true )
		ply:SetNetworkedEntity( "Weapon", self.TowerProp )
		ply:SetNetworkedEntity( "Cannon", self.WeaponProp )
		self:SetNetworkedEntity("Pilot", ply )

		self.Pilot:SetNetworkedBool( "DrawPhalanxHUD", true )
		ply:SetNetworkedEntity( "Turret", self )
		
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
	self.Pilot:SetNetworkedEntity( "Tank", NULL ) 
	self.Pilot:SetNetworkedEntity( "Weapon", NULL )
	self:SetNetworkedEntity("Pilot", NULL )
	self.Pilot:SetNetworkedBool( "DrawPhalanxHUD", false )

	
	self.Pilot:SetPos( self.Tower:GetPos() + self.Tower:GetRight() * -150 + self.Tower:GetUp() * 16 )
	self.Pilot:SetAngles( Angle( 0, self.Tower:GetAngles().y,0 ) )
	self.Owner = NULL
	-- self.Pilot:SetScriptedVehicle( NULL )
	
	self.Speed = 0
	self.IsDriving = false
	self:SetLocalVelocity(Vector(0,0,0))
	
	self.Pilot = NULL
	
end

function ENT:Think()

	self.Tower:SetSkin( self:GetSkin() )
	self.Weapon:SetSkin( self:GetSkin() )
	
	local _mod = self.Speed
	if( _mod < 0 ) then
		
		_mod = -1*_mod
		
	end
	
	self.Pitch = math.Clamp( math.floor( ( 200 * ( _mod / 100 ) ) + ( self:GetVelocity():Length() / 7 ) ), 140,255 )

	for i = 1,#self.EngineMux do
	
		self.EngineMux[i]:ChangePitch( self.Pitch - ( i * 5 ), 0.01 )
		
	end
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self.Tower:GetPos() + self.Tower:GetRight() * math.random(-62,62) + self.Tower:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 35 then
		
			self:EjectPilotSpecial()
			self:Remove()
		
		end
		
	end
	
	
	
	if ( self.IsDriving && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self.Tower:GetPos() )

		if( self.Pilot:KeyDown( IN_USE ) && self.LastUsed + 0.5 <= CurTime() ) then
			
			self:EjectPilotSpecial()
			self.LastUsed = CurTime()
			
			return
			
		end
		
		// Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
			self:EjectPilotSpecial()
			
		end
		
		//lock-On
		self:Turret_LockOnMethod()

		if( self.Pilot:KeyPressed( IN_SPEED ) && self.LastRelease + 0.1 <= CurTime() ) then
			if( IsValid( self.Target ) ) then		
			self.LastRelease = CurTime()
			self.Pilot:PrintMessage( HUD_PRINTCENTER, "TARGET CLEARED" )
			self:ClearTarget()
			end
		end

		// Attack
		if ( self.Pilot:KeyDownLast( IN_ATTACK ) &&  self.OverheatDelay < CurTime() &&  self.Overheat < 1 ) then
				self:FireMissile(math.random(1,12))
				self.Overheat = self.Overheat + 0.5
					
		elseif	( self.Overheat >= 1 ) then 
				self.OverheatDelay = CurTime() + 3
				self.Overheat = 0			
				self:EmitSound( "bf2/tanks/m6_missile_reload.wav", 511, math.random( 70, 100 ) )

		
		end

		if ( self.Pilot:KeyDown( IN_JUMP ) &&  self.OverheatDelay < CurTime() &&  self.Overheat < 1) then		
			self:FireSTORM()
			self.Overheat = self.Overheat + 0.25
					
		elseif	( self.Overheat >= 1 ) then 
				self.OverheatDelay = CurTime() + 5
				self.Overheat = 0			
				self:EmitSound( "bf2/tanks/m6_missile_reload.wav", 511, math.random( 70, 100 ) )

			
		end
		
	end
		
	self:NextThink( CurTime() )
	return true
	
end

function ENT:FireMissile(n)

	local Missilepos = {}
	Missilepos[1] = Vector( 7, 11, 58 )
	Missilepos[2] = Vector( 7, 0, 58 )
	Missilepos[3] = Vector( 7, -11, 58 )

	Missilepos[4] = Vector( 7, 11, 45 )
	Missilepos[5] = Vector( 7, 0, 45 )
	Missilepos[6] = Vector( 7, -11, 45 )

	Missilepos[7] = Vector( 7, 11, 31 )
	Missilepos[8] = Vector( 7, 0, 31 )
	Missilepos[9] = Vector( 7, -11, 31 )

	Missilepos[10] = Vector( 7, 11, 17 )
	Missilepos[11] = Vector( 7, 0, 17 )
	Missilepos[12] = Vector( 7, -11, 17 )

	local r = ents.Create("sent_a2a_rocket")
	r:SetPos( self.Tower:GetPos() + Missilepos[n] )
	r:SetAngles(self.Weapon:GetAngles())
	r:SetModel( "models/hawx/weapons/aim-9 sidewinder.mdl" ) 
	r:Spawn()
	r.Target = self.Target
	r.Owner = self
	r:SetOwner(self)
	r.Damage = math.random( 2500, 5500 )
	r.Radius = 3000
	r:SetPhysicsAttacker(self)
	self:EmitSound( "lockon/missileshoot.mp3", 510, math.random( 100, 130 ) )
	self.Missile[n]:SetNoDraw(true)
	if ( IsValid( self.Missile[n] )) then
	timer.Simple( 3, function() if( IsValid( self.Missile[n] ) ) then  self.Missile[n]:SetNoDraw(false) end end, self.Missile[n])
	end
end

function ENT:FireSTORM()
	
	local Missilepos = {}
	Missilepos[1] = Vector( 7, 11, 58 )
	Missilepos[2] = Vector( 7, 0, 58 )
	Missilepos[3] = Vector( 7, -11, 58 )

	Missilepos[4] = Vector( 7, 11, 45 )
	Missilepos[5] = Vector( 7, 0, 45 )
	Missilepos[6] = Vector( 7, -11, 45 )

	Missilepos[7] = Vector( 7, 11, 31 )
	Missilepos[8] = Vector( 7, 0, 31 )
	Missilepos[9] = Vector( 7, -11, 31 )

	Missilepos[10] = Vector( 7, 11, 17 )
	Missilepos[11] = Vector( 7, 0, 17 )
	Missilepos[12] = Vector( 7, -11, 17 )
	local n = math.random(1,12)
	local r = ents.Create("sent_a2a_rocket")
	r:SetPos( self.Tower:GetPos() + Missilepos[n] )
	r:SetAngles(self.Weapon:GetAngles())
	r:SetModel( "models/items/AR2_Grenade.mdl" ) 
	r:Spawn()
	r.Target = self.Target
	r.Owner = self
	r:SetOwner(self)
	r:SetPhysicsAttacker(self)				
	self:EmitSound( "lockon/missileshoot.mp3", 510, math.random( 100, 130 ) )
	self.Missile[n]:SetNoDraw(true)
	if ( IsValid( self.Missile[n] )) then
	timer.Simple( 5, function() self.Missile[n]:SetNoDraw(false) end, self.Missile[n])
	end
end

local function apr(a,b,c)
	local z = math.AngleDifference( b, a )
	return math.Approach( a, a + z, c )
end

function ENT:PhysicsUpdate()

	if ( self.IsDriving && self.Pilot ) then

		self:GetPhysicsObject():Wake()
		
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 // This is the point the plane is chasing.
		local ta = ( self.Tower:GetPos() - a ):Angle()
		local ma = self:GetAngles()

		local pilotAng = self.Pilot:EyeAngles()
		local _t = self.Tower:GetAngles()
		local Weaponpitch = math.Clamp( pilotAng.p, -45, 3 )

		self.offs = self:VecAngD( ma.y, ta.y )	
		local angg = self:GetAngles()

		angg:RotateAroundAxis( self:GetUp(), -self.offs + 180 )

		self.Tower:SetAngles( LerpAngle( 0.1, _t, angg ) )
		_t = self.Tower:GetAngles()
		
		self.Weapon:SetAngles( Angle( Weaponpitch, _t.y, _t.r ) )
			if (pilotAng.y == _t.y) then
--			self:StopSound( "lockon/TurretRotation.mp3" )			
			else
--			self:EmitSound( "lockon/TurretRotation.mp3", 511, math.random( 70, 100 ) )  //Play while turning the turret but looping --'
			end
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	local tr, trace = {}
	local hitcount = 0
	local _a = self:GetAngles()
	local z = 0

	for i=1,20 do
		
		tr.start = self.Tower:GetPos() + self.Tower:GetForward() * -120 + self.Tower:GetForward() * ( i * 11.55 ) + self.Tower:GetRight() * math.sin(CurTime()) * 50
		tr.endpos = self.Tower:GetPos() + self.Tower:GetForward() * -120 + self.Tower:GetForward() * ( i * 11.55 ) + self.Tower:GetUp() * -14  + self.Tower:GetRight() * math.sin(CurTime()) * 50
		tr.filter = self
		tr.mask = MASK_SOLID
		//self:DrawLaserTracer( self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetRight() * dir, self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetUp() * -17  + self:GetRight() * dir )
		
		trace = util.TraceLine( tr )
		
		if( trace.Hit && !trace.HitSky ) then
			
			hitcount = hitcount + 1
			//z = z + trace.HitPos.z
			
		end

		
	end
				
end