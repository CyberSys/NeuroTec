

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "T-80U"
ENT.Model = "models/wic/ground/t-80u/t-80u_body.mdl"

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

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 75
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y + 180,0)
	local ent = ents.Create( "sent_t-80u_p" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	ent:SetSkin( math.random(1,4 ) )
	
	construct.SetPhysProp( ply, ent, 0, nil,  { GravityToggle = true, Material = "rubber" } ) 
	
	return ent
	
end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime < 0.2 ) then return end
	
	self:TankDefaultCollision( data, physobj )
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	
	// Misc
	self:SetModel("models/wic/ground/t-80u/t-80u_body.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

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
	
		self.EngineMux[i]:PlayEx( 511 , self.Pitch )
	
	end
	
	self:SetUseType( SIMPLE_USE )
	self.IsDriving = false
	self.Pilot = NULL
	
	self.Yaw = 0
	
	self.Tower = ents.Create("prop_physics_override")
	self.Tower:SetModel("models/wic/ground/t-80u/t-80u_turret.mdl")
	self.Tower:SetPos( self:GetPos() + self:GetUp() * 56 )
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
	self.Barrel:SetModel("models/wic/ground/t-80u/t-80u_cannon.mdl")
	self.Barrel:SetPos( self:GetPos() + self:GetForward() * 40 + self:GetRight() * 3 + self:GetUp() * 70 )
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
	self.TowerProp = ents.Create("prop_physics_override")
	self.TowerProp:SetPos( self.Tower:GetPos() + self.Tower:GetAngles():Up() * 50 )
	self.TowerProp:SetAngles( self.Tower:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.TowerProp:SetModel( "models/weapons/ar2_grenade.mdl" )
	self.TowerProp:SetParent( self.Tower )
	self.TowerProp:SetColor( 0,0,0,0 )
	self.TowerProp:Spawn()
	
	self.BarrelProp = ents.Create("prop_physics_override")
	self.BarrelProp:SetPos( self.Barrel:GetPos() + self.Barrel:GetAngles():Forward() * 150 )
	self.BarrelProp:SetAngles( self.Tower:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.BarrelProp:SetModel( "models/weapons/ar2_grenade.mdl" )
	self.BarrelProp:SetParent( self.Barrel )
	self.BarrelProp:SetColor( 0,0,0,0 )
	self.BarrelProp:Spawn()

	self.MGunPos = ( self:GetForward() * -44 ) + ( self:GetUp() *129 )
	
	self.MGun = ents.Create("prop_physics_override")
	self.MGun:SetModel("models/wic/ground/t-80u/t-80u_gun.mdl")
	self.MGun:SetPos( self:GetPos() + self:GetForward() * 8 + self:GetRight() * 35 + self:GetUp() * 98 )
	self.MGun:SetParent( self.Tower )
	self.MGun:SetSkin( self:GetSkin() )
	self.MGun:SetAngles( self.Tower:GetAngles() )
	self.MGun:Spawn()

	self.MGunTube = ents.Create("prop_physics_override")
	self.MGunTube:SetModel("models/weapons/ar2_grenade.mdl")
	self.MGunTube:SetPos( self.MGun:GetPos() + self.MGun:GetForward() * 55 + self.MGun:GetUp() * 8 )
	self.MGunTube:SetParent( self.MGun)
	self.MGunTube:SetAngles( self.MGun:GetAngles() )
	self.MGunTube:Spawn()
	self.MGunTube:SetColor( 0, 0, 0, 0 )

	self.MGunAxis = constraint.Axis( self.MGun, self.Tower, 0, 0, Vector(0,0,1) , self.MGunPos, 0, 0, 1, 0 )

	self.Knife = ents.Create("prop_physics_override")
	self.Knife:SetModel("models/wic/ground/t-80u/t-80u_knife.mdl")
	self.Knife:SetPos( self.Barrel:GetPos() + self.Barrel:GetForward() * 198 )
	self.Knife:SetParent( self.Barrel )
	self.Knife:SetSkin( self:GetSkin() )
	self.Knife:SetAngles( self:GetAngles() )
	self.Knife:Spawn()
	self.KnifePhys = self.Knife:GetPhysicsObject()	
	
	if ( self.KnifePhys:IsValid() ) then	
		self.KnifePhys:Wake()
		self.KnifePhys:EnableGravity( true )	
	end

	constraint.NoCollide( self.Tower, self, 0, 0 )
	constraint.NoCollide( self.Tower, self.MGun, 0, 0 )
	constraint.NoCollide( self.Tower, self.Barrel, 0, 0 )
	constraint.NoCollide( self.Barrel, self, 0, 0 )
	constraint.NoCollide( self.MGun, self, 0, 0 )
	constraint.NoCollide( self.MGun, self.Barrel, 0, 0 )
	

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
	
	if( self.HealthVal < 150 ) then
		
		local parts = { "models/wic/ground/t-80u/t-80u_body.mdl", 
						"models/wic/ground/t-80u/t-80u_cannon.mdl", 
						"models/wic/ground/t-80u/t-80u_gun.mdl", 
						"models/wic/ground/t-80u/t-80u_knife.mdl", 
						"models/wic/ground/t-80u/t-80u_turret.mdl" }
						
		for i=1,#parts do
			
			local p = ents.Create("prop_physics")
			p:SetPos( self:GetPos() )
			p:SetModel( parts[i] )
			p:SetAngles( self:GetAngles() )
			p:Spawn()
			p:Fire("kill","",math.random(10,15))
			p:GetPhysicsObject():ApplyForceCenter( Vector( math.random(-1,1), math.random(-1,1), math.random(0,1) ) * math.random( 1000, 2500 ) )
			
		end
		
	end
	
	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:Stop()
		
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilotSpecial()
	
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
		ply:SetNetworkedEntity( "Tank", self.TowerProp )
		ply:SetNetworkedEntity( "Barrel", self.BarrelProp )
		ply:SetNetworkedEntity( "Weapon", self.MGun )
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
	self.Pilot:SetNetworkedEntity( "Tank", NULL ) 
	self.Pilot:SetNetworkedEntity( "Barrel", NULL )
	self.Pilot:SetNetworkedEntity( "Weapon", NULL )
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
	self.MGun:SetSkin( self:GetSkin() )
	
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

		// Attack
		if ( self.Pilot:KeyDown( IN_ATTACK ) ) then

			self:PrimaryAttack()
	
		end

		if ( self.Pilot:KeyDown( IN_ATTACK2 ) ) then
		

			self:SecondaryAttack()

			
		end
		
	end
		
	self:NextThink( CurTime() )
	return true
	
end

function ENT:PrimaryAttack()
	if ( !self ) then // silly timer errors.
		
		return
		
	end
	if  ( self.BulletDelay < CurTime() ) then	
	
		self.BulletDelay = CurTime() + 2 //math.random(3,6)

		self:EmitSound( "bf2/tanks/t-90_shoot.wav", 511, math.random( 70, 100 ) )
		self:EmitSound( "bf2/tanks/t-90_reload.wav", 511, math.random( 70, 100 ) )
		self:GetPhysicsObject():ApplyForceCenter( self.Barrel:GetAngles():Forward() * -10000 )
		
		local e1 = EffectData()
		e1:SetStart( self.Barrel:GetPos() + self.Barrel:GetForward() * 203	+ self.Barrel:GetRight() * 3  )
		e1:SetNormal( self.Barrel:GetForward() )
		e1:SetEntity( self.Barrel )
		e1:SetScale( 1.5 )
		util.Effect( "tank_muzzle", e1 )
		
		for i =1,4 do
		
			timer.Simple( i/16, function()
				
				if( IsValid( self.Barrel ) ) then
				
					local e1 = EffectData()
					e1:SetStart( self.Barrel:GetPos() + self.Barrel:GetForward() * 300 + self.Barrel:GetRight() * 3  )
					e1:SetNormal( self.Barrel:GetForward() )
					e1:SetEntity( self.Barrel )
					e1:SetScale( i )
					util.Effect( "Launch2", e1 ) 
					
				end
				
			end )
			
		end
		

		local Shell = ents.Create( "sent_tank_shell" )
		Shell:SetPos( self.BarrelProp:GetPos() ) 				
		Shell:SetAngles( self.BarrelProp:GetAngles() )
		Shell.Owner = self.Pilot
		Shell:SetPhysicsAttacker( self.Pilot )
		Shell:Spawn()
		Shell:Activate() 
		Shell:GetPhysicsObject():Wake()
		Shell:GetPhysicsObject():SetMass( 10 )
		Shell:GetPhysicsObject():ApplyForceCenter( self.Barrel:GetAngles():Forward() * 9999999 )
		constraint.NoCollide( Shell, self, 0, 0)	
		constraint.NoCollide( Shell, self.Barrel, 0, 0)	
		constraint.NoCollide( Shell, self.BarrelProp, 0, 0)	
		
		
	end


	self:StopSound( "bf2/tanks/t-90_shoot.wav" )
	self:StopSound( "bf2/tanks/t-90_reload.wav" )

end

function ENT:ExplosiveShellCallback(a,b,c)

	local info = DamageInfo( )  
		info:SetDamageType( DMG_NEVERGIB )  
		info:SetDamagePosition( b.HitPos )  
		info:SetMaxDamage( self.MaxDamage )  
		info:SetDamage( self.MinDamage )  
		info:SetAttacker( self )  
		info:SetInflictor( self )  
	
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
				
					info:SetDamage( self.Damage * ( 1 - p:Distance( b.HitPos ) / self.BlastRadius ) )  
					info:SetDamageForce( ( p - b.HitPos ):Normalize( ) * 10 )  
					v:TakeDamageInfo( info )  
					
				end
				
			end 
			
		end  

	end  
	
	return { damage = true, effects = DoDefaultEffect } 
	
end

function ENT:SecondaryAttack()
	
	if ( !self ) then // silly timer errors.
		
		return
		
	end

	local bullet2 = {} 
	bullet2.Num 		= 1 
	bullet2.Src 		= self.MGun:GetPos() + self.MGun:GetForward() * 60 + self.MGun:GetRight() * 4 + self.MGun:GetUp() * 8
	bullet2.Dir 		= self.MGun:GetAngles():Forward()
	bullet2.Attacker = self.Pilot
	bullet2.Spread 	= Vector( 0.05, 0.05, 0.05 )
	bullet2.Tracer	= 1
	bullet2.Force	= 5
	bullet2.Damage	= math.random( 1, 5 )
	bullet2.AmmoType = "Ar2"
	bullet2.TracerName 	= "Tracer"
	bullet2.Callback    = function ( a, b, c ) self:MountedGunCallback( a, b, c ) end 

	if ( self.ShellDelay < CurTime() ) then				
	
		self.ShellDelay = CurTime() + 0.03
		self.MGunTube:FireBullets( bullet2 )

		self:EmitSound( "bf2/weapons/type85_fire.mp3", 511, math.random( 70, 100 ) )

		local shell2 = EffectData()
		shell2:SetStart( self.MGun:GetPos() + self.MGun:GetForward() * -4 + self.MGun:GetRight() * 2 + self.MGun:GetUp() * 8)
		shell2:SetOrigin( self.MGun:GetPos() + self.MGun:GetForward() * -4 + self.MGun:GetRight() * 2 + self.MGun:GetUp() * 8)
		util.Effect( "RifleShellEject", shell2 ) 
		
		local e2 = EffectData()
		e2:SetStart( self.MGunTube:GetPos() + self.MGun:GetForward() * 2)
		e2:SetOrigin( self.MGunTube:GetPos() + self.MGun:GetForward() * 2)
		e2:SetAngle( self.MGunTube:GetAngles() )
		e2:SetEntity( self.MGunTube )
		e2:SetScale( 0.5 )
		util.Effect( "tank_muzzlesmoke", e2 )
		util.Effect( "MuzzleEffect", e2 )
			
		self:StopSound( "bf2/weapons/type85_fire.mp3" )

	end
	
end

function ENT:MountedGunCallback( a, b, c )

	if ( IsValid( self.MGun ) ) then
	
		local e = EffectData()
		e:SetOrigin(b.HitPos)
		e:SetNormal(b.HitNormal)
		e:SetScale( 0.5 )
		util.Effect("ManhackSparks", e)

		util.BlastDamage( self.MGun, self.MGun, b.HitPos, 100, math.random(2,4) )
		
	end
	
	return { damage = true, effects = DoDefaultEffect } 	
	
end

local function apr(a,b,c)
	local z = math.AngleDifference( b, a )
	return math.Approach( a, a + z, c )
end

function ENT:PhysicsUpdate()

	if ( self.IsDriving && self.Pilot ) then

		self:GetPhysicsObject():Wake()
		
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()

		local pilotAng = self.Pilot:EyeAngles()
		local _t = self.Tower:GetAngles()
		local _g = self.MGun:GetAngles()
		local barrelpitch = math.Clamp( pilotAng.p, -45, 3 )

		_g.p, _g.y, _g.r = apr( _g.p, pilotAng.p, 40.5 ),apr( _g.y, pilotAng.y, 40.5 ),apr( _g.r, _t.r, 40.5 )

		self.offs = self:VecAngD( ma.y, ta.y )	
		local angg = self:GetAngles()

		angg:RotateAroundAxis( self:GetUp(), -self.offs + 180 )

		self.Tower:SetAngles( LerpAngle( 0.1, _t, angg ) )
		_t = self.Tower:GetAngles()
		
		self.Barrel:SetAngles( Angle( barrelpitch, _t.y, _t.r ) )
		self.MGun:SetAngles( _g )
		
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
		--p.z = p.z
		
		local downparam = ap.p
		if( downparam > 0 ) then downparam = 0 end
		//self.Pilot:PrintMessage( HUD_PRINTCENTER, self.Speed )
		
		local pr = {}
		pr.secondstoarrive	= 0.1
		pr.pos 				= p + self:GetForward() * self.Speed
		pr.maxangular		= 1000
		pr.maxangulardamp	= 1000
		pr.maxspeed			= 24
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

