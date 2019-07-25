
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "HKTank2018"
ENT.Model = "models/inaki/props_vehicles/terminator_salvation_hktank_mainx2.mdl"

// Speed Limits
ENT.MaxVelocity = 200
ENT.MinVelocity = -100

ENT.InitialHealth = 8000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// Weapons
ENT.MaxDamage = 40
ENT.MinDamage = 20
ENT.BlastRadius = 500
ENT.ChopperGunAttack = 0

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
	local ent = ents.Create( "sent_salvationtank" )
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
	self:SetModel("models/inaki/props_vehicles/terminator_salvation_hktank_mainx2.mdl" )
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
	
	self.Yaw = 0
	self.Pitch = 80
	self.EngineMux[1]:PlayEx( 500 , self.Pitch )
	self.EngineMux[2]:PlayEx( 500 , self.Pitch )
	self.EngineMux[3]:PlayEx( 500 , self.Pitch )
	
	self:SetUseType( SIMPLE_USE )
	self.IsDriving = false
	self.Pilot = nil
	
	self.Tower = ents.Create("prop_physics_override")
	self.Tower:SetModel("models/inaki/props_vehicles/terminator_salvation_hktank_torsox2.mdl")
	self.Tower:SetPos( self:GetPos() + self:GetForward() * 70 + self:GetUp() * 160 )
	self.Tower:SetParent( self )
	self.Tower:SetAngles( self:GetAngles() )
	self.Tower:Spawn()
	self.TowerPhys = self.Tower:GetPhysicsObject()	
	if ( self.TowerPhys:IsValid() ) then
	
		self.TowerPhys:Wake()
		self.TowerPhys:EnableGravity( true )
		self.TowerPhys:EnableDrag( false )
		
	end

	self.Barrel = ents.Create("prop_physics_override")
	self.Barrel:SetModel("models/inaki/props_vehicles/terminator_salvation_hktank_cannonsx2.mdl")
	self.Barrel:SetPos( self:GetPos() + self:GetForward() * 10 + self:GetUp() * 255 )
	self.Barrel:SetParent( self.Tower )
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
	self.TowerProp:SetModel( "models/props_lab/huladoll.mdl" )
	self.TowerProp:SetParent( self.Tower )
	self.TowerProp:Spawn()
	
	self.BarrelProp = ents.Create("prop_physics_override")
	self.BarrelProp:SetPos( self.Barrel:GetPos() + self.Barrel:GetUp()*-50 + self.Barrel:GetAngles():Forward() * 150 )
	self.BarrelProp:SetAngles( self.Tower:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.BarrelProp:SetModel( "models/weapons/ar2_grenade.mdl" )
	self.BarrelProp:SetParent( self.Barrel )
	self.BarrelProp:Spawn()

	self.MGunPos = ( self:GetForward() * -44 ) + ( self:GetUp() *129 )
	
	self.MGun = ents.Create("prop_physics_override")
	self.MGun:SetModel("models/wic/ground/t-80u/t-80u_gun.mdl")
	self.MGun:SetPos( self:GetPos() + self:GetForward() * 8 + self:GetRight() * 35 + self:GetUp() * 98 )
	self.MGun:SetParent( self.Tower )
	self.MGun:SetAngles( self.Tower:GetAngles() )
	self.MGun:Spawn()
	self.MGun:SetColor( 0, 0, 0, 0 )
	
	constraint.NoCollide( self.Tower, self, 0, 0 )
	constraint.NoCollide( self.Tower, self.MGun, 0, 0 )
	constraint.NoCollide( self.Tower, self.Barrel, 0, 0 )
	constraint.NoCollide( self.Barrel, self, 0, 0 )
	constraint.NoCollide( self.MGun, self, 0, 0 )
	constraint.NoCollide( self.MGun, self.Barrel, 0, 0 )
	
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
		self.PhysObj:SetMass( 5000 )
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
		
		self:SetNetworkedInt("health",self.HealthVal)
		
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
		
	if self.Speed > 0 then
	
		self:SetSkin( 1 )
	
	else
		
		self:SetSkin( 0 )
	
	end
		
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
		local pilot = self.Pilot
		pilot:SetPos( self:GetPos() + self:GetUp() * 82 )
	
		self:NeuroPlanes_CycleThroughHeliKeyBinds()
		
		if( pilot:KeyDown( IN_USE ) ) then
			
			-- self:TankExitVehicle()
		
		end
		
		// Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
			self:EjectPilot()
			
		end

		// Attack
		if ( pilot:KeyDown( IN_ATTACK ) ) then
			if ( self.ChopperGunAttack + 0.1 <= CurTime() ) then
				self:PrimaryAttack()
			end	
		end

		if ( pilot:KeyDown( IN_ATTACK2 ) ) then
		
			if ( self.GotChopperGunner ) then
			
				if ( self.ChopperGunAttack + 0.1 <= CurTime() ) then
					
					self:SecondaryAttack()
					
				end
				
			else
				
				if ( self.ChopperGunAttack + 0.1 <= CurTime() ) then
					
					self:SecondaryAttack()
					
				end
			
			end
			
		end
		
	end
		
	self:NextThink( CurTime() )
	return true
	
end

function ENT:PrimaryAttack()
	if ( !self ) then return end // silly timer errors.

	local bullet = {} 
 	bullet.Num 		= 1 
 	bullet.Src 		= self.Barrel:GetPos() + self.Barrel:GetForward() * 203	+ self.Barrel:GetRight() * 3// Source 
 	bullet.Dir 		= self.Barrel:GetAngles():Forward()			// Dir of bullet 
	bullet.Attacker = self
 	bullet.Spread 	= Vector( 0.01, 0.01, 0.01 )			// Aim Cone 
 	bullet.Tracer	= 1										// Show a tracer on every x bullets  
 	bullet.Force	= 1000					 					// Amount of force to give to phys objects 
 	bullet.Damage	= math.random( self.MinDamage, self.MaxDamage )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "GunshipTracer" 
 	bullet.Callback    = function ( a, b, c ) self:ExplosiveShellCallback( a, b, c ) end 
		
	if  ( self.BulletDelay < CurTime() ) then	
	
		self.BulletDelay = CurTime() + math.random(4,6)
		
		
	posA = self.BarrelProp:GetPos() + self.BarrelProp:GetRight()*-140
	posB = self.BarrelProp:GetPos() + self.BarrelProp:GetRight()*140
    
	local ShellA = ents.Create( "sent_tank_missile" )
	ShellA:SetPos( posA ) 				
	ShellA:SetAngles( self.BarrelProp:GetAngles() )
	ShellA:Spawn()
	ShellA:Activate()
	ShellA.Owner = self.Pilot
	ShellA.Creditor = self
	  
	local ShellB = ents.Create( "sent_tank_missile" )
	ShellB:SetPos( posB ) 				
	ShellB:SetAngles( self.BarrelProp:GetAngles() )
	ShellB:Spawn()
	ShellB:Activate()
	ShellB.Owner = self.Pilot
	ShellB.Creditor = self
	
	ShellA:GetPhysicsObject():SetVelocityInstantaneous( ShellA:GetForward() * AMMO_VELOCITY_aRTILLERY_SHELL )
	ShellA:GetPhysicsObject():EnableDrag( false )
	ShellB:GetPhysicsObject():SetVelocityInstantaneous( ShellB:GetForward() * AMMO_VELOCITY_aRTILLERY_SHELL )
	ShellB:GetPhysicsObject():EnableDrag( false )
	
	constraint.NoCollide( ShellA, self, 0, 0)	
	constraint.NoCollide( ShellA, self.Barrel, 0, 0)	
	constraint.NoCollide( ShellA, self.BarrelProp, 0, 0)
	
	constraint.NoCollide( ShellB, self, 0, 0)	
	constraint.NoCollide( ShellB, self.Barrel, 0, 0)	
	constraint.NoCollide( ShellB, self.BarrelProp, 0, 0)
	
    end
	
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
	
local bulletA = {} 
 	bulletA.Num 		= 1 
 	bulletA.Src 		= self.BarrelProp:GetPos() + self.BarrelProp:GetUp()*20 + self.BarrelProp:GetRight() * -140// Source 
 	bulletA.Dir 		= self.BarrelProp:GetAngles():Forward()			// Dir of bullet 
	bulletA.Attacker = self
 	bulletA.Spread 	= Vector( 0.01, 0.01, 0.01 )			// Aim Cone 
 	bulletA.Tracer	= 1										// Show a tracer on every x bullets  
 	bulletA.Force	= 1000					 					// Amount of force to give to phys objects 
	bulletA.Damage	= math.random( self.MinDamage, self.MaxDamage )
 	bulletA.AmmoType = "Ar2" 
 	bulletA.TracerName 	= "" 
 	bulletA.Callback    = function ( a, b, c ) self:ExplosiveShellCallback( a, b, c ) end 
	
	local bulletB = {} 
 	bulletB.Num 		= 1 
 	bulletB.Src 		= self.BarrelProp:GetPos() + self.BarrelProp:GetUp()*30 + self.BarrelProp:GetRight() * 140// Source 
 	bulletB.Dir 		= self.BarrelProp:GetAngles():Forward()			// Dir of bullet 
	bulletB.Attacker = self
 	bulletB.Spread 	= Vector( 0.01, 0.01, 0.01 )			// Aim Cone 
 	bulletB.Tracer	= 1										// Show a tracer on every x bullets  
 	bulletB.Force	= 1000					 					// Amount of force to give to phys objects 
	bulletB.Damage	= math.random( self.MinDamage, self.MaxDamage )
 	bulletB.AmmoType = "Ar2" 
 	bulletB.TracerName 	= "" 
 	bulletB.Callback    = function ( a, b, c ) self:ExplosiveShellCallback( a, b, c ) end 
	
	if ( self.ShellDelay < CurTime() ) then				
	    self.ShellDelay = CurTime() + 0.03
		
		self:FireBullets( bulletA )
		self:FireBullets( bulletB )
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
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()

		local pilotAng = self.Pilot:EyeAngles()
		local _t = self.Tower:GetAngles()
		local _g = self.MGun:GetAngles()
		local barrelpitch = math.Clamp( pilotAng.p, -15, 5 )

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

