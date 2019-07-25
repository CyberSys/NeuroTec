
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "ZSU-23-4 Shilka"
ENT.Model = "models/wic/ground/zsu-23-4/zsu-23-4_body.mdl"

// Speed Limits
ENT.MaxVelocity = 150
ENT.MinVelocity = -100

ENT.InitialHealth = 3000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0
ENT.BulletTimer = CurTime()
ENT.BulletDelay1 = CurTime()
ENT.BulletDelay2 = CurTime()
ENT.BulletDelay3 = CurTime()
ENT.BulletDelay4 = CurTime()
ENT.Overheat = 0
ENT.OverheatDelay = CurTime()

// Weapons
ENT.MaxDamage = 125
ENT.MinDamage = 25
ENT.BlastRadius = 512

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
	local ent = ents.Create( "sent_zsu-23-4_p" )
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
	self.Yaw = 0
	self.Damage = 100
	self.Radius = 256
	
	// Misc
	self:SetModel("models/wic/ground/zsu-23-4/zsu-23-4_body.mdl" )
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
	self.Pilot = nil
	
	self.Tower = ents.Create("prop_physics_override")
	self.Tower:SetModel("models/wic/ground/zsu-23-4/zsu-23-4_turret.mdl")
	self.Tower:SetPos( self:GetPos() + self:GetUp() * 65 )
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

	self.Barrel = ents.Create("prop_physics_override")
	self.Barrel:SetModel("models/wic/ground/zsu-23-4/zsu-23-4_cannon.mdl")
	self.Barrel:SetPos( self:GetPos() + self:GetForward() * 40 + self:GetUp() * 87 )
	self.Barrel:SetParent( self.Tower )
	self.Barrel:SetSkin( self:GetSkin() )
	self.Barrel:SetAngles( self:GetAngles() )
	self.Barrel:Spawn()
	self.BarrelPhys = self.Barrel:GetPhysicsObject()	
	if ( self.BarrelPhys:IsValid() ) then
	
		self.BarrelPhys:Wake()
		self.BarrelPhys:EnableGravity( true )
		//self.BarrelPhys:EnableDrag( true )
		
	end
	
	-- Hackfix until garry implements GetPhysicsObjectNum/count on the client.
	self.CannonTube = {}
	local CannonTubePos = {}
	CannonTubePos[1] = Vector( 123, -9, 93 )
	CannonTubePos[2] = Vector( 123, 9, 93 )
	CannonTubePos[3] = Vector( 132, -9, 80 )
	CannonTubePos[4] = Vector( 132, 9, 80 )

	for i= 1,4	do
	self.CannonTube[i] = ents.Create("prop_physics_override")
	self.CannonTube[i]:SetModel("models/weapons/ar2_grenade.mdl")
	self.CannonTube[i]:SetPos( self:LocalToWorld( CannonTubePos[i] ) )
	self.CannonTube[i]:SetAngles( self.Barrel:GetAngles() )
	self.CannonTube[i]:SetParent( self.Barrel )
	self.CannonTube[i]:SetColor(  Color (0, 0, 0, 0 ) )
	self.CannonTube[i]:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.CannonTube[i]:Spawn()

	constraint.NoCollide( self.CannonTube[i], self, 0, 0 )
	constraint.NoCollide( self.CannonTube[i], self.Tower, 0, 0 )
	constraint.NoCollide( self.CannonTube[i], self.Barrel, 0, 0 )
	end
	
	self.TowerProp = ents.Create("prop_physics_override")
	self.TowerProp:SetPos( self.Tower:GetPos() + self.Tower:GetAngles():Up() * 50 )
	self.TowerProp:SetAngles( self.Tower:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.TowerProp:SetModel( "models/weapons/ar2_grenade.mdl" )
	self.TowerProp:SetParent( self.Tower )
	self.TowerProp:SetColor( Color(  0, 0, 0, 0 ) )
	self.TowerProp:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.TowerProp:Spawn()
	
	self.BarrelProp = ents.Create("prop_physics_override")
	self.BarrelProp:SetPos( self.Barrel:GetPos() + self.Barrel:GetAngles():Forward() * 125 )
	self.BarrelProp:SetAngles( self.Tower:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.BarrelProp:SetModel( "models/weapons/ar2_grenade.mdl" )
	self.BarrelProp:SetParent( self.Barrel )
	self.BarrelProp:SetColor( Color( 0, 0, 0, 0 ) )
	self.BarrelProp:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.BarrelProp:Spawn()

	self.Radar = ents.Create("prop_physics_override")
	self.Radar:SetModel("models/wic/ground/zsu-23-4/zsu-23-4_radar.mdl")
	self.Radar:SetPos( self:GetPos() + self:GetForward() * -44 + self:GetUp() * 104 )
	self.Radar:SetParent( self.Tower )
	self.Radar:SetSkin( self:GetSkin() )
	self.Radar:SetAngles( self.Tower:GetAngles() )
	self.Radar:Spawn()
	self.RadarPhys = self.Radar:GetPhysicsObject()	
	if ( self.RadarPhys:IsValid() ) then	
		self.RadarPhys:Wake()
		self.RadarPhys:EnableGravity( true )	
	end

	constraint.NoCollide( self.Tower, self, 0, 0 )
	constraint.NoCollide( self.Tower, self.Barrel, 0, 0 )
	constraint.NoCollide( self.Barrel, self, 0, 0 )
	
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

	if self.Entity:GetOwner() == nil then
		
		return

	end
	
	self.Owner = self.Entity:GetOwner()
	
	self.Entity:SetPhysicsAttacker(self.Owner)

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
		p[1] = self:GetPos() + self:GetForward() * -15 + self:GetRight() * 59 + self:GetUp() * 60
		p[2] = self:GetPos() + self:GetForward() * -15 + self:GetRight() * 59 + self:GetUp() * 60
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
	
		self:EjectPilotSpecial()
	
	end

	for i=1,4 do
		self.CannonTube[i]:Remove()
	end
	self.Radar:Remove()
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
		
		self.LastUse = CurTime() + 1.0
		
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
		ply:SetNetworkedEntity( "Gun", self.BarrelProp )
		self:SetNetworkedEntity("Pilot", ply )
	else
		
		// Passenger seats
	
	
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
	self.Pilot:SetNetworkedEntity( "Barrel", NULL )
	self.Pilot:SetNetworkedEntity( "Weapon", NULL )
	self.Pilot:SetNetworkedEntity( "Gun", NULL )
	
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

	self.Tower:SetSkin( self:GetSkin() )
	self.Barrel:SetSkin( self:GetSkin() )
	self.Radar:SetSkin( self:GetSkin() )
	
	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 20 + 40 ),0,245 )

	for i = 1,3 do
	
		self.EngineMux[i]:ChangePitch( self.Pitch, 0.1 )
		
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
		
		if( self.Pilot:KeyDown( IN_USE ) && self.LastUse <= CurTime() ) then
			
			self.LastUse = CurTime() + 1.0
			self.Driving = false
			self.Pilot:SetNetworkedEntity("Tank",NULL)
			self.Pilot:SetNetworkedEntity("Barrel",NULL)
			self:EjectPilotSpecial()
			
			return
			
		end
		
		// Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
			self:EjectPilotSpecial()
			
		end

		// Attack
		if ( self.Pilot:KeyDownLast( IN_ATTACK ) &&  self.OverheatDelay < CurTime() &&  self.Overheat < 4 ) then
				self:PrimaryAttack()
				self.Overheat = self.Overheat + 0.025
					
		elseif	( self.Overheat >= 4 ) then 
				self.OverheatDelay = CurTime() + 2
				self.Overheat = 0			
				self:EmitSound( "bf2/tanks/m6_missile_reload.wav", 511, math.random( 70, 100 ) )

		
		end

	end
		
	self:NextThink( CurTime() )
	return true
	
end

--[[
local function ShellMaths(a,b,c)
	local acc = 9.81 / 2
	local X0 = self.BarrelProp:GetAngles():Forward()
	local Y0 = self.BarrelProp:GetAngles():Up()
	local origin = self.BarrelProp:GetPos() -- origin of the shell
	local X = ( a - origin.y ) * ( a - origin.y  ) -- pitch coordinate
	local Y = ( b - origin.z ) * ( b - origin.z  ) -- roll coordinate
	
	return math.sqrt( acc * X*X / Y ) --calculate the launching speed of the shell to reach the target
end
]]--
function ENT:PrimaryAttack()
	if ( !self ) then // silly timer errors.
		
		return
		
	end

 	local bullet = {} 
 	bullet.Num 		= 1 
 	bullet.Src 		= self.CannonTube[1]:GetPos() + self.CannonTube[1]:GetForward() * 50	// Source 
 	bullet.Dir 		= self.CannonTube[1]:GetAngles():Forward()			// Dir of bullet 
 	bullet.Spread 	= Vector( 0.01, 0.01, 0.01 )			// Aim Cone 
 	bullet.Tracer	= 1										// Show a tracer on every x bullets  
 	bullet.Force	= 5					 					// Amount of force to give to phys objects 
 	bullet.Damage	= math.random( self.MinDamage, self.MaxDamage )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "GunshipTracer"
	bullet.Attacker = self.Pilot
 	bullet.Callback    = function ( a, b, c ) self:ExplosiveShellCallback( a, b, c ) end 
 		
--	self:EmitSound( self.Sound, 511, math.random( 65, 71 ) )
	
	local bullet2 = {} 
	bullet2.Num 		= 1 
	bullet2.Src 		= self.CannonTube[2]:GetPos() + self.CannonTube[2]:GetForward() * 50
	bullet2.Dir 		= self.CannonTube[2]:GetAngles():Forward()
	bullet2.Spread 	= Vector( 0.01, 0.01, 0.01 )
	bullet2.Tracer	= 1
	bullet2.Force	= 5
	bullet2.Damage	= math.random( self.MinDamage, self.MaxDamage )
	bullet2.AmmoType = "Ar2"
	bullet2.TracerName 	= "Tracer"
	bullet2.Attacker = self.Pilot
	bullet2.Callback    = function ( a, b, c ) self:ExplosiveShellCallback( a, b, c ) end 
	
	local bullet3 = {} 
	bullet3.Num 		= 1 
	bullet3.Src 		= self.CannonTube[3]:GetPos() + self.CannonTube[3]:GetForward() * 50
	bullet3.Dir 		= self.CannonTube[3]:GetAngles():Forward()
	bullet3.Spread 	= Vector( 0.01, 0.01, 0.01 )
	bullet3.Tracer	= 1
	bullet3.Force	= 5
	bullet3.Damage	= math.random( self.MinDamage, self.MaxDamage )
	bullet3.AmmoType = "Ar2"
	bullet3.TracerName 	= "Tracer"
	bullet3.Attacker = self.Pilot
	bullet3.Callback    = function ( a, b, c ) self:ExplosiveShellCallback( a, b, c ) end 

	local bullet4 = {} 
	bullet4.Num 		= 1 
	bullet4.Src 		= self.CannonTube[4]:GetPos() + self.CannonTube[4]:GetForward() * 50
	bullet4.Dir 		= self.CannonTube[4]:GetAngles():Forward()
	bullet4.Spread 	= Vector( 0.01, 0.01, 0.01 )
	bullet4.Tracer	= 1
	bullet4.Force	= 5
	bullet4.Damage	= math.random( self.MinDamage, self.MaxDamage )
	bullet4.AmmoType = "Ar2"
	bullet4.TracerName 	= "Tracer"
	bullet4.Attacker = self.Pilot
	bullet4.Callback    = function ( a, b, c ) self:ExplosiveShellCallback( a, b, c ) end 
		
	if ( self.BulletDelay1 < CurTime() ) then	
	
		self.BulletDelay1 = CurTime() + 0.10//math.random(250,500) * 0.001
		self.CannonTube[1]:FireBullets( bullet )
		self:EmitSound( "bf2/tanks/m6_autocannon_1p.mp3", 511, math.random( 70, 100 ) )
	
		local shell1 = EffectData()
		shell1:SetStart( self.CannonTube[1]:GetPos() + self.CannonTube[1]:GetForward() * -44 )
		shell1:SetOrigin( self.CannonTube[1]:GetPos() + self.CannonTube[1]:GetForward() * -44 )
		util.Effect( "RifleShellEject", shell1 )
		
		-- local e1 = EffectData()
		-- e1:SetStart( self.CannonTube[1]:GetPos()+self.CannonTube[1]:GetForward() * 55  )
		-- e1:SetNormal( self.CannonTube[1]:GetForward() )
		-- e1:SetEntity( self.CannonTube[1] )
		-- e1:SetScale( 0.5 )
		-- util.Effect( "tank_muzzle", e1 )
	
		self:StopSound( "bf2/tanks/m6_autocannon_1p.mp3" )
	end
	
	if( self.BulletDelay2 < CurTime() ) then
		
		self.BulletDelay2 = CurTime() + 0.11//math.random(250,500) * 0.001
		self.CannonTube[2]:FireBullets( bullet2 )
		self:EmitSound( "bf2/tanks/m6_autocannon_1p.mp3", 511, math.random( 70, 100 ) )

		local shell2 = EffectData()
		shell2:SetStart( self.CannonTube[2]:GetPos() + self.CannonTube[2]:GetForward() * -44 )
		shell2:SetOrigin( self.CannonTube[2]:GetPos() + self.CannonTube[2]:GetForward() * -44)
		util.Effect( "RifleShellEject", shell2 )  
		
		ParticleEffect("AA_muzzleflash", self.CannonTube[math.random(1,4)]:GetPos()+self.CannonTube[2]:GetForward() * 55, self.CannonTube[2]:GetAngles(), self )
		
		-- local e2 = EffectData()
		-- e2:SetStart( self.CannonTube[2]:GetPos()+self.CannonTube[2]:GetForward() * 55  )
		-- e2:SetNormal( self.CannonTube[2]:GetForward() )
		-- e2:SetEntity( self.CannonTube[2] )
		-- e2:SetScale( 0.5 )
		-- util.Effect( "tank_muzzle", e2 )
	
		self:StopSound( "bf2/tanks/m6_autocannon_1p.mp3" )
	end
	
	if ( self.BulletDelay3 < CurTime() ) then
	
		self.BulletDelay3 = CurTime() + 0.12//math.random(250,500) * 0.001
		self.CannonTube[3]:FireBullets( bullet3 )
		self:EmitSound( "bf2/tanks/m6_autocannon_3p.mp3", 511, math.random( 70, 100 ) )
	
		local shell3 = EffectData()
		shell3:SetStart( self.CannonTube[3]:GetPos() + self.CannonTube[3]:GetForward() * -44 )
		shell3:SetOrigin( self.CannonTube[3]:GetPos() + self.CannonTube[3]:GetForward() * -44 )
		util.Effect( "RifleShellEject", shell3 )
		
		-- local e3 = EffectData()
		-- e3:SetStart( self.CannonTube[3]:GetPos()+self.CannonTube[3]:GetForward() * 55  )
		-- e3:SetNormal( self.CannonTube[3]:GetForward() )
		-- e3:SetEntity( self.CannonTube[3] )
		-- e3:SetScale( 0.5 )
		-- util.Effect( "tank_muzzle", e3 )
	
		self:StopSound( "bf2/tanks/m6_autocannon_3p.mp3" )
	end
	
	if ( self.BulletDelay4 < CurTime() ) then
		
		self.BulletDelay4 = CurTime() + 0.13//math.random(250,500) * 0.001
		self.CannonTube[4]:FireBullets( bullet4 )
		self:EmitSound( "bf2/tanks/m6_autocannon_3p.mp3", 511, math.random( 70, 100 ) )

		local shell4 = EffectData()
		shell4:SetStart( self.CannonTube[4]:GetPos() + self.CannonTube[4]:GetForward() * -44 )
		shell4:SetOrigin( self.CannonTube[4]:GetPos() + self.CannonTube[4]:GetForward() * -44 )
		util.Effect( "RifleShellEject", shell4 )
		
		-- local e4 = EffectData()
		-- e4:SetStart( self.CannonTube[4]:GetPos()+self.CannonTube[4]:GetForward() * 55  )
		-- e4:SetNormal( self.CannonTube[4]:GetForward() )
		-- e4:SetEntity( self.CannonTube[4] )
		-- e4:SetScale( 0.5 )
		-- util.Effect( "tank_muzzle", e4 )

		self:StopSound( "bf2/tanks/m6_autocannon_3p.mp3" )	
	end

end

function ENT:ExplosiveShellCallback(a,b,c)

	local info = DamageInfo( )  
		info:SetDamageType( bit.band( DMG_BULLET, DMG_RADIATION )  )
		info:SetDamagePosition( b.HitPos )  
		info:SetMaxDamage( self.MaxDamage )  
		info:SetDamage( self.MinDamage )  
		info:SetAttacker( self.Pilot )  
		info:SetInflictor( self.Pilot )  
	
	local e = EffectData()
		e:SetOrigin( b.HitPos )
		e:SetScale( 0.1 )
		e:SetNormal( b.HitNormal )
	util.Effect("HelicopterMegaBomb", e)
		e:SetScale( 1.2 )
	util.Effect("ImpactGunship", e)
	
	for k, v in ipairs( ents.GetAll( ) ) do  
		
		if ( IsValid( v ) && v:Health( ) > 0 ) then  
			
			local p = v:GetPos( )  
			local t,tr = {},{}
				t.start = b.HitPos
				t.endpos = p
				t.mask = MASK_BLOCKLOS 
				t.filter = self
			tr = util.TraceLine( t )
			
			if ( p:Distance( b.HitPos ) <= self.BlastRadius ) then  
			
				if ( tr.Hit && tr.Entity ) then
				
					info:SetDamage( math.random( self.MinDamage, self.MaxDamage ) * ( 1 - p:Distance( b.HitPos ) / self.BlastRadius ) )
					info:SetDamageForce( ( p - b.HitPos ):GetNormalized() * 20 ) -- info:SetDamageForce( ( p - b.HitPos ): Normalize ( ) * 20 ) 
					v:TakeDamageInfo( info )  
					
				end
				
			end 
			
		end  

	end  
	
	return { damage = true, effects = DoDefaultEffect } 
	
end

local function apr(a,b,c)
	local z = math.AngleDifference( b, a )
	return math.Approach( a, a + z, c )
end

function ENT:PhysicsUpdate()

	if ( self.IsDriving && IsValid( self.Pilot ) ) then

		self:GetPhysicsObject():Wake()
		
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()

		local pilotAng = self.Pilot:EyeAngles()
		local _t = self.Tower:GetAngles()
		local barrelpitch = math.Clamp( pilotAng.p, -45, 3 )


		self.offs = self:VecAngD( ma.y, ta.y )	
		local angg = self:GetAngles()

		angg:RotateAroundAxis( self:GetUp(), -self.offs + 180 )

		self.Tower:SetAngles( LerpAngle( 0.285, _t, angg ) )
		_t = self.Tower:GetAngles()
		
		self.Barrel:SetAngles( Angle( barrelpitch, _t.y, _t.r ) )
		
	end
	
end
function ENT:PhysicsSimulate( phys, deltatime )
	
	local tr, trace = {}
	local hitcount = 0
	local _a = self:GetAngles()
	local z = 0

	for i=1,20 do
		
		tr.start = self:GetPos() + self:GetForward() * -120 + self:GetForward() * ( i * 11.55 ) + self:GetRight() * math.sin(CurTime()) * 50
		tr.endpos = self:GetPos() + self:GetForward() * -120 + self:GetForward() * ( i * 11.55 ) + self:GetUp() * -14  + self:GetRight() * math.sin(CurTime()) * 50
		tr.filter = self
		tr.mask = MASK_SOLID
		//self:DrawLaserTracer( self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetRight() * dir, self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetUp() * -17  + self:GetRight() * dir )
		
		trace = util.TraceLine( tr )
		
		if( trace.Hit && !trace.HitSky ) then
			
			hitcount = hitcount + 1
			//z = z + trace.HitPos.z
			
		end

		
	end


	if( hitcount < 10 ) then
		
		//self.Speed = math.Approach( self.Speed, 0, 0.02 )
		
	end
	
	if ( self.IsDriving && IsValid( self.Pilot ) && hitcount > 5 && !self.Pilot:KeyDown( IN_JUMP ) ) then
	
		phys:Wake()
		
		if( self:GetVelocity():Length() > 50 && hitcount > 6 ) then			
						
			local fx = EffectData()
			fx:SetOrigin( self:GetPos() + self:GetForward() * -60 )
			fx:SetScale( 2.0 )
			util.Effect("WheelDust", fx )
			
		end
		
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
		
		if( !keydown ) then
			
			self.Speed = math.Approach( self.Speed, 0, 0.6 )
				
		end
		
		if( self.Pilot:KeyDown( IN_JUMP ) ) then
				
			self.Speed = self.Speed * 0.99
			
		end
		
		local dir = 0
		
		self.Speed = math.Clamp( self.Speed,  -100, 100 )//-10.8, 10.88 )
		
		if( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
					
			self.Yaw = math.Approach( self.Yaw, 0.44, 0.052 )
			dir = -0.2
			
		elseif( self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
		
			self.Yaw = math.Approach( self.Yaw, -0.44, 0.052 )
			dir = 0.2
			
		else
			
			self.Yaw = math.Approach( self.Yaw, 0, 0.02 )
		
		end
			
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
		pr.angle = Angle( self:GetAngles().p, mYaw + self.Yaw, self:GetAngles().r )
		
		phys:ComputeShadowControl(pr)
	
	else
		
		self.Speed = math.Approach( self.Speed, 0, 0.1 )
	
	end	
end


