

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "Phalanx CIWS"
ENT.Model = "models/hunter/tubes/circle4x4.mdl"

// Speed Limits
ENT.MaxVelocity = 100
ENT.MinVelocity = -100

ENT.InitialHealth = 950
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

ENT.MaxDamage = 10
ENT.MinDamage = 5

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

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local vec = ply:GetAimVector():Angle()
	local newAng = Angle(0,vec.y + 180,0)
	local ent = ents.Create( "sent_phalanx_p" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	
--	construct.SetPhysProp( ply, ent, 0, nil,  { GravityToggle = true, Material = "rubber" } )  //useless because static
	
	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self.LastAttack = CurTime()
	self.MaxHeat = 25
	
	

	
	// Misc
	self:SetModel("models/hunter/tubes/circle4x4.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetColor(Color(150,150,150,255))
	self:SetMaterial( "phoenix_storms/dome" )

	self:SetUseType( SIMPLE_USE )
	self.IsDriving = false
	self.Pilot = NULL
	
	self.Yaw = 0
	
	self.Tower = ents.Create("prop_physics_override")
	self.Tower:SetModel("models/solcommand/typhoon/base.mdl")
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
	self.Weapon:SetModel("models/solcommand/phalanx.mdl")
	self.Weapon:SetPos( self.Tower:GetPos() + self.Tower:GetUp() * 37 )
	self.Weapon:SetParent( self.Tower )
	self.Weapon:SetSkin( self:GetSkin() )
	self.Weapon:SetAngles( self:GetAngles() )
	self.Weapon:Spawn()
	self.WeaponPhys = self.Weapon:GetPhysicsObject()	
	if ( self.WeaponPhys:IsValid() ) then
	
		self.WeaponPhys:Wake()
		self.WeaponPhys:EnableGravity( true )
		//self.WeaponPhys:EnableDrag( true )
		
	end
	self.WeaponPos = self.Weapon:GetPos() + self.Weapon:GetForward() * 100 + self.Weapon:GetUp() * -30.5 

	-- Hackfix until garry implements GetPhysicsObjectNum/Count on the client.
	self.TowerProp = ents.Create("prop_physics_override")
	self.TowerProp:SetPos( self.Tower:GetPos() + self.Tower:GetAngles():Up() * 50 )
	self.TowerProp:SetAngles( self.Tower:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.TowerProp:SetModel( "models/weapons/ar2_grenade.mdl" )
	self.TowerProp:SetParent( self.Tower )
	self.TowerProp:SetColor( Color ( 0,0,0,0 ) )
	self.TowerProp:SetRenderMode( RENDERMODE_TRANSALPHA )
	
	self.TowerProp:Spawn()
	
	self.WeaponProp = ents.Create("prop_physics_override")
	self.WeaponProp:SetPos( self.Weapon:GetPos() + self.Weapon:GetAngles():Forward() * 108 )
	self.WeaponProp:SetAngles( self.Tower:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.WeaponProp:SetModel( "models/weapons/ar2_grenade.mdl" )
	self.WeaponProp:SetParent( self.Weapon )
	self.WeaponProp:SetColor( Color( 0,0,0,0 ) )
	self.WeaponProp:SetRenderMode( RENDERMODE_TRANSALPHA )
	self.WeaponProp:Spawn()

	constraint.NoCollide( self.Tower, self, 0, 0 )
	constraint.NoCollide( self.Tower, self.Weapon, 0, 0 )
	constraint.NoCollide( self.Weapon, self, 0, 0 )
	
	/*
	local laserpos = Vector( 35, 35, 57 )
	
    local t = ents.Create("prop_physics")
	t:SetColor( 0,0,0,0 )
	t:SetSolid( SOLID_NONE )
    t:SetKeyValue("targetname", "laser_"..self.Weapon:EntIndex() )
    t:SetPos( self.Weapon:LocalToWorld( Vector( 36000, 0, 0 ) ) )
    t:Spawn()
	t:SetParent( self.Weapon )
	
    self.Beam = ents.Create("env_laser")
    self.Beam:SetPos( self.Weapon:LocalToWorld( laserpos ) )
    self.Beam:SetKeyValue("renderamt", "105")
    self.Beam:SetKeyValue("rendercolor", "255 0 0")
    self.Beam:SetKeyValue("texture", "cable/redlaser.vmt")
    self.Beam:SetKeyValue("TextureScroll", "20")
    //self.Beam:SetKeyValue("targetname", "laser_"..self.Weapon:EntIndex())
    self.Beam:SetKeyValue("damage", "0")
    self.Beam:SetKeyValue("spawnflags", "1")
    self.Beam:SetKeyValue("width", "1" )
    self.Beam:SetKeyValue("dissolvetype", "0")
    self.Beam:SetKeyValue("LaserTarget", "laser_"..self.Weapon:EntIndex() )
    self.Beam:Spawn()
	self.Beam:SetParent( self.Weapon )
	*/
	
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
		
			local f = ents.Create("env_Fire_trail")
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
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilotSpecial()
	
	end
	self.TowerProp:Remove()
	self.WeaponProp:Remove()
	
end

function ENT:PhysicsCollide( data, physobj )
	
end

function ENT:Use( ply,caller, a, b )

	if ( !self.IsDriving && !IsValid( self.Pilot ) ) then 
		
		self.LastUsed = CurTime()
		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():EnableMotion(true)
		self.IsDriving = true
		self.Pilot = ply
		self.Owner = ply
		//self.Beam:Fire("turnon","",0)
		
		-- ply:Spectate( OBS_MODE_CHASE  )
		ply:DrawViewModel( false )
		ply:DrawWorldModel( false )
		ply:StripWeapons()
		ply:SetScriptedVehicle( self )
		
		ply:SetNetworkedBool("InFlight",true )
		ply:SetNetworkedEntity( "Weapon", self.TowerProp )
		ply:SetNetworkedEntity( "Cannon", self.WeaponProp )
		self:SetNetworkedEntity("Pilot", ply )
		-- Temp hud fix				
		self.Pilot:SetNetworkedBool( "DrawPhalanxHUD", true )
		ply:SetNetworkedEntity( "Turret", self )
		//self.Pilot:SetNetworkedEntity( "ChopperGunnerEnt", self.Weapon )
		
		
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
	self.Pilot:SetNetworkedEntity( "ChopperGunnerEnt", NULL )
	self.Pilot:SetScriptedVehicle( NULL )
	
	//+self.Beam:Fire("turnoff","",0)
		
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
	
	if( !IsValid( self.Pilot ) ) then
		
		for k,v in pairs( ents.FindInSphere( self:GetPos(), 400 ) ) do
			
			if( v:IsPlayer() && v:KeyDown( IN_USE ) ) then
				
				local tr,trace = {},{}
				tr.start = v:GetShootPos()
				tr.endpos = tr.start + v:GetAimVector() * 400
				tr.filter = v
				trace = util.TraceLine( tr )
				
				if( trace.Hit && ( trace.Entity == self || trace.Entity:GetParent() == self ) ) then
				
					self:Use( v, v, 0, 0 )
				
				end
				
				break
				
			end
			
		end
	
	end
	
	self.Tower:SetSkin( self:GetSkin() )
	self.Weapon:SetSkin( self:GetSkin() )

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

		// Attack
		if ( self.Pilot:KeyDownLast( IN_ATTACK ) &&  self.OverheatDelay < CurTime() &&  self.Overheat < self.MaxHeat && self.LastAttack + 0.02 <=CurTime() ) then
		
				self:PrimaryAttack()
				self.Overheat = self.Overheat + 0.1
				self.LastAttack = CurTime()
				
		elseif	( self.Overheat >= self.MaxHeat ) then 
		
				self.OverheatDelay = CurTime() + 2
				self.Overheat = 0		
				self:EmitSound( "bf2/tanks/m6_missile_reload.wav", 511, math.random( 70, 100 ) )

		
		end

		if ( self.Pilot:KeyDown( IN_SPEED ) ) then
		
			if( !IsValid( self.Target ) ) then
			
				for k,v in pairs( ents.GetAll() ) do
					
					local vp = v:GetPos()
					
					if( ( v:IsNPC() || v.HealthVal ) && vp:Distance( self:GetPos() ) < 11000 && v:GetVelocity():Length() > 10 && vp.z > self:GetPos().z + 1500 ) then
						
						self.Target = v
						
						break
					
					end
				
				end
			
			else
				
				if( self:GetPos():Distance( self.Target:GetPos() ) < 11000 ) then
					
					self.Pilot:PointAtEntity( self.Target )
					
				else
					
					self.Target = NULL
					return
				
				end
				
			
			end
		
		end
	
	end
	
	
	self:NextThink( CurTime() )
	return true
	
end

function ENT:PrimaryAttack()
	if ( !self ) then // silly timer errors.
		
		return
		
	end
	
	local bullet = {} 
	bullet.Num 		= 1
	bullet.Src 		= self.WeaponProp:GetPos() + self.WeaponProp:GetForward() * 50
	bullet.Dir 		= self.Weapon:GetAngles():Forward()			-- Dir of bullet 
	bullet.Spread 	= Vector( 0.025, 0.022, 0.019 )						-- Aim Cone 
	bullet.Tracer	= math.random(10,25)					-- Show a tracer on every x bullets  
	bullet.Force	= 50					 					-- Amount of force to give to phys objects 
	bullet.Damage	= 15
	bullet.AmmoType = "Ar2" 
	bullet.TracerName 	= "AirboatGunHeavyTracer" 
	bullet.Callback    = function ( a, b, c ) self:TurretCallback( a, b, c ) end 

	self:EmitSound( "lockon/snare.mp3", 511, math.random( 70, 100 ) )
	ParticleEffect("AA_muzzleflash", self.Weapon:GetPos() + self.Weapon:GetForward() * 200, self.Weapon:GetAngles(), self )
	
	self.Weapon:FireBullets( bullet ) 

	-- local f = EffectData()
	-- f:SetStart( self.Weapon:LocalToWorld( Vector( 200, 0, 2 ) ) )
	-- f:SetScale( 0.85 )
	-- f:SetNormal( self.Weapon:GetForward() )
	-- f:SetEntity( self.Weapon )
	-- util.Effect( "ac130_muzzle", f )
	-- f:SetScale( 1.5 )
	-- util.Effect( "Launch2", f )
	
	local shell2 = EffectData()
	shell2:SetStart( self.Weapon:LocalToWorld( Vector( -38, -6, 18 ) ) )
	shell2:SetOrigin( self.Weapon:LocalToWorld( Vector( -38, -6, 18 ) ) )
	util.Effect( "RifleShellEject", shell2 ) 

	self:StopSound( "lockon/snare.mp3" )

end

function ENT:TurretCallback(a,b,c)

	local e = EffectData()
		e:SetOrigin( b.HitPos )
		e:SetScale( 1.0 )
		e:SetNormal( b.HitNormal )
	util.Effect("Launch2", e)
	util.Effect("HelicopterMegaBomb",e)
	
	util.BlastDamage( self, self.Pilot, b.HitPos, self.BlastRadius, math.random( self.MinDamage, self.MaxDamage ) )
	
	return { damage = true, effects = DoDefaultEffect } 
	
end

function ENT:SecondaryAttack()
	
	if ( !self ) then // silly timer errors.
		
		return
		
	end

	local bullet2 = {} 
	bullet2.Num 		= 1 
	bullet2.Src 		= self.Weapon:GetPos() + self.Weapon:GetForward() * 100 + self.Weapon:GetRight() * -5 + self.Weapon:GetUp() * -30.5
	bullet2.Dir 		= self.Weapon:GetAngles():Forward()
	bullet2.Attacker = self
	bullet2.Spread 	= Vector( 0.001, 0.001, 0.001 )
	bullet2.Tracer	= 1
	bullet2.Force	= 5
	bullet2.Damage	= math.random( 5, 25 )
	bullet2.AmmoType = "Ar2"
	bullet2.TracerName 	= "Tracer"
	bullet2.Callback    = function ( a, b, c ) self:TurretCallback( a, b, c ) end 

	if ( self.ShellDelay < CurTime() ) then				
	
		self.ShellDelay = CurTime() + 0.03
		self.WeaponProp:FireBullets( bullet2 )

--		self:EmitSound( "bf2/tanks/m6_autocannon_1p.wav", 511, math.random( 70, 100 ) )
		self:EmitSound( "lockon/snare.mp3", 511, math.random( 70, 100 ) )

		local shell2 = EffectData()
		shell2:SetStart( self.Weapon:GetPos() + self.Weapon:GetForward() * -4 + self.Weapon:GetRight() * 2 + self.Weapon:GetUp() * 8)
		shell2:SetOrigin( self.Weapon:GetPos() + self.Weapon:GetForward() * -4 + self.Weapon:GetRight() * 2 + self.Weapon:GetUp() * 8)
		util.Effect( "RifleShellEject", shell2 ) 
		
		local e2 = EffectData()
		e2:SetStart( self.Weapon:GetPos() + self.Weapon:GetForward() * 2)
		e2:SetOrigin( self.Weapon:GetPos() + self.Weapon:GetForward() * 2)
		e2:SetAngles( self.Weapon:GetAngles() )
		e2:SetEntity( self.Weapon )
		e2:SetScale( 0.5 )
		util.Effect( "tank_muzzlesmoke", e2 )
		util.Effect( "MuzzleEffect", e2 )
			
--		self:StopSound( "bf2/tanks/m6_autocannon_1p.wav" )
		self:StopSound( "lockon/snare.mp3" )

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
		local Weaponpitch = math.Clamp( pilotAng.p, -55, 15 )

		self.offs = self:VecAngD( ma.y, ta.y )	
		local angg = self:GetAngles()

		angg:RotateAroundAxis( self:GetUp(), -self.offs + 180 )

		self.Tower:SetAngles( LerpAngle( 0.05, _t, angg ) )
		_t = self.Tower:GetAngles()
		
		self.Weapon:SetAngles( Angle( Weaponpitch, _t.y, _t.r ) )
		
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
		tr.filter = {self,self.Tower,self.Weapon}
		tr.mask = MASK_SOLID
		//self:DrawLaserTracer( self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetRight() * dir, self:GetPos() + self:GetForward() * -128 + self:GetForward() * ( i * 11 ) + self:GetUp() * -17  + self:GetRight() * dir )
		
		trace = util.TraceLine( tr )
		
		if( trace.Hit && !trace.HitSky ) then
			
			hitcount = hitcount + 1
			//z = z + trace.HitPos.z
			
		end

		
	end
				
end