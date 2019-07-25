

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "Panther"
ENT.Model = "models/beat the zombie/wot/german/panther.mdl"
//ENT.Model = "models/beat the zombie/wot/german/tiger ii.mdl"
//ENT.Model = "models/beat the zombie/wot/german/tiger i.mdl"
//ENT.Model = "models/beat the zombie/wot/german/maus.mdl"
//ENT.Model = "models/beat the zombie/wot/american/m4a3e8.mdl"
//ENT.Model = "models/beat the zombie/wot/american/m6a2e1.mdl"
//ENT.Model = "models/beat the zombie/wot/american/pershing.mdl"

// Speed Limits
ENT.MaxVelocity = 100
ENT.MinVelocity = -100

ENT.InitialHealth = 7000
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
	local ent = ents.Create( "sent_panther" )
	ent:SetPos( SpawnPos )
	ent:SetAngles( newAng )
	ent:Spawn()
	ent:Activate()
	
	construct.SetPhysProp( ply, ent, 0, nil,  { GravityToggle = true, Material = "rubber" } ) 
	
	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	
	self:SetModel( "models/dav0r/hoverball.mdl" )
	
	// Misc
	self.Ragdoll = ents.Create("prop_ragdoll")
	self.Ragdoll:SetModel(self.Model)
	self.Ragdoll:SetPos(self:GetPos())  
	self.Ragdoll:Spawn()
	self.Ragdoll:GetPhysicsObjectNum(1):EnableGravity(false)
	self.Ragdoll:GetPhysicsObjectNum(2):EnableGravity(false)
	self.Ragdoll:GetPhysicsObjectNum(1):SetMass(10)
	self.Ragdoll:GetPhysicsObjectNum(2):SetMass(10)
	self.Ragdoll:SetMoveType( MOVETYPE_VPHYSICS )
	self.Ragdoll:SetSolid( SOLID_VPHYSICS )
	
	self:SetPos( self.Ragdoll:GetPhysicsObjectNum(2):GetPos() )
	
	//self:SetAngles( self.Ragdoll:GetPhysicsObjectNum(1):GetAngle() + Angle(0,90,0) )
	
	//self:SetPos( self:LocalToWorld(Vector(0,0,50)) )
	

	
	--[[ local mins,maxs = self.Ragdoll:OBBMins(), self.Ragdoll:OBBMaxs()
	 local oy = mins.y; mins.y = mins.z; mins.z = oy
	oy = maxs.y; maxs.y = maxs.z; maxs.z = oy
	self:PhysicsInitBox(mins,maxs) ]]--
	self:PhysicsInit(MOVETYPE_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetColor(0,0,0,0)	
	self:SetCollisionGroup(10)
	self:GetPhysicsObject():SetMass(1000)

    local phys = self.Ragdoll:GetPhysicsObjectNum(0)
	if(phys:IsValid()) then phys:Wake() end
	
	constraint.Weld(self, self.Ragdoll, 0, 0, 0, false)
	
	// Sound
	local esound = {}
	self.EngineMux = {}
	esound[1] = "vehicles/diesel_loop2.wav"
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
	
	//self:SetUseType( SIMPLE_USE )
	self.Ragdoll.Tank = self
	self.IsDriving = false
	self.Pilot = NULL
	self.IsHuge = false
	
	self.Yaw = 0
	
	self.Body = self.Ragdoll:GetPhysicsObjectNum(0)
	self.Body:SetAngle( self:GetAngles() )
	
	self.Tower = self.Ragdoll:GetPhysicsObjectNum(1)
	self.Tower:SetAngle( self:GetAngles() )

	self.Barrel = self.Ragdoll:GetPhysicsObjectNum(2)
	self.Barrel:SetAngle( self:GetAngles() + Angle(0,0,-90))
	
	self.TowerProp = ents.Create("prop_physics_override")
	self.TowerProp:SetPos( self.Tower:GetPos() + self.Tower:GetAngle():Up() * 50 )
	self.TowerProp:SetAngles( self.Tower:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.TowerProp:SetModel( "models/airboatgun.mdl" )
	self.TowerProp:Spawn()
	//self.TowerProp:SetColor(0,0,0,0)	
	
	self.BarrelProp = ents.Create("prop_physics_override")
	self.BarrelProp:SetPos( self.Barrel:GetPos() + self.Barrel:GetAngle():Forward() * 150 )
	self.BarrelProp:SetAngles( self.Tower:GetAngles()  ) --+ Angle( 0, -90, 0 )
	self.BarrelProp:SetModel( "models/airboatgun.mdl" )
	self.BarrelProp:Spawn()
	//self.BarrelProp:SetColor(0,0,0,0)	
	
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
		p[1] = self:GetPos() + self:GetAngles():Forward() * -50 + self:GetAngles():Right() * 25 + self:GetAngles():Up() * 15
		p[2] = self:GetPos() + self:GetAngles():Forward() * -50 + self:GetAngles():Right() * 25 + self:GetAngles():Up() * 15
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

	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:Stop()
		
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilot()
	
	end
	
	
	self.TowerProp:Remove()
	self.BarrelProp:Remove()
	self.Ragdoll:Remove()
	self.Pilot:SetNetworkedBool( "InFlight", false )
	self.Pilot:SetNetworkedEntity( "Tank", NULL ) 
	self.Pilot:SetNetworkedEntity( "Barrel", NULL )
	self.Pilot:SetNetworkedEntity( "Ragdoll", NULL)
	self:SetNetworkedEntity("Pilot", NULL )
	
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
		ply:SetNetworkedEntity("Ragdoll",self.Ragdoll)
		ply:SetNetworkedBool("WW2",true )
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
	self.Pilot:SetNetworkedEntity( "Ragdoll", NULL)
	self:SetNetworkedEntity("Pilot", NULL )
	
	self.Pilot:SetPos( self:GetPos() + self:GetAngles():Right() * -150 + self:GetAngles():Up() * 16 )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = NULL
	self.Pilot:SetScriptedVehicle( NULL )
	
	self.Speed = 0
	self.IsDriving = false
	self:SetLocalVelocity(Vector(0,0,0))
	
	self.Pilot = NULL
	
end

function ENT:Think()

	
	self.Pitch = math.Clamp( math.floor( ( 150 * self.Speed ) + ( self:GetVelocity():Length() / 10 ) ), 120,255 )

	 for i = 1,#self.EngineMux do
	
		self.EngineMux[i]:ChangePitch( self.Pitch - ( i * 5 ) )
		
	 end
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetAngles():Right() * math.random(-62,62) + self:GetAngles():Forward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 35 then
		
			self:EjectPilotSpecial()
			self:Remove()
		
		end
		
	end
	
	
	
	if ( self.IsDriving && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self.Tower:GetPos() + self.Tower:GetAngles():Up() * 82 )

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
		
	//local ang = -self.Barrel:GetAngles() + Angle( 0,0,-90)
	local ang = self.Barrel:GetAngles() + Angle( 90,0,0)
	print(ang)
	self.TowerProp:SetAngles( ang )
	self.BarrelProp:SetAngles( ang )
	self.BarrelProp:SetPos( self.Barrel:GetPos())
	self.TowerProp:SetPos( self.Tower:GetPos())
	//self.BarrelProp:SetPos( self.Barrel:GetPos() + self.Barrel:GetAngle():Forward() * 170 + self.Barrel:GetAngle():Right() * 5 )
	//self.TowerProp:SetPos( self.Tower:GetPos() + self.Tower:GetAngle():Up() * 50 )	
	
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
	if  ( self.BulletDelay < CurTime() ) then	
	
		self.BulletDelay = CurTime() + math.random(2,4)

		self:EmitSound( "bf2/tanks/t-90_shoot.wav", 511, math.random( 70, 100 ) )
		self:EmitSound( "bf2/tanks/t-90_reload.wav", 511, math.random( 70, 100 ) )
		self.Body:ApplyForceCenter( self.Barrel:GetAngles():Up() * -10000 )
		
		local e1 = EffectData()
		e1:SetStart( self.Barrel:GetPos() + self.Barrel:GetAngles():Up() * 400 )	--//+ self.Barrel:GetAngles():Right() * 3  )
		e1:SetNormal( self.Barrel:GetAngles():Up() )
		e1:SetEntity( self.Barrel )
		e1:SetScale( 1.5 )
		util.Effect( "tank_muzzle", e1 )

		local Shell = ents.Create( "sent_tank_shell" )
		Shell:SetPos( self.Barrel:GetPos() ) 				
		Shell:SetAngles( self.Barrel:GetAngles() - Angle(75,0,0) )
		Shell.Owner = self.Pilot
		Shell:SetPhysicsAttacker( self.Pilot )
		Shell:Spawn()
		Shell:Activate() 
		Shell:GetPhysicsObject():Wake()
		Shell:GetPhysicsObject():SetMass( 10 )
		Shell:GetPhysicsObject():ApplyForceCenter( self.Barrel:GetAngles():Up() * 9999999 )
		constraint.NoCollide(Shell, self, 0, 0)
		constraint.NoCollide(Shell,self.Ragdoll,0,0)
		constraint.NoCollide(Shell,self.Ragdoll,0,1)
		constraint.NoCollide(Shell,self.Ragdoll,0,2)

		
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

function ENT:PhysicsUpdate()

	if ( self.IsDriving && self.Pilot ) then

		self:GetPhysicsObject():Wake()
		
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()

		local pilotAng = self.Pilot:EyeAngles()
		local _t = self.Tower:GetAngles()
		local barrelyaw = pilotAng.y
		local barrelpitch = pilotAng.p
		self.offs = self:VecAngD( ma.y, ta.y )	
		local angg = self:GetAngles()

		angg:RotateAroundAxis( self:GetAngles():Up(), -self.offs + 180 )

		self.Tower:SetAngle( angg + Angle( 90, 0, 0 ) )
		_t = self.Tower:GetAngles()
		
		
		self.Barrel:SetAngle( Angle(  barrelpitch + 75, barrelyaw , 0 ) )

	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	local tr, trace = {}
	local hitcount = 0
	local _a = self:GetAngles()
	local z = 0

	for i=1,20 do
		
		tr.start = self:GetPos() + self:GetAngles():Forward() * -120 + self:GetAngles():Forward() * ( i * 11.55 ) + self:GetAngles():Right() * math.sin(CurTime()) * 50
		tr.endpos = self:GetPos() + self:GetAngles():Forward() * -120 + self:GetAngles():Forward() * ( i * 11.55 ) + self:GetAngles():Up() * -100  + self:GetAngles():Right() * math.sin(CurTime()) * 50
		tr.filter = self
		tr.mask = MASK_SOLID
		//self:DrawLaserTracer( self:GetPos() + self:GetAngles():Forward() * -128 + self:GetAngles():Forward() * ( i * 11 ) + self:GetAngles():Right() * dir, self:GetPos() + self:GetAngles():Forward() * -128 + self:GetAngles():Forward() * ( i * 11 ) + self:GetAngles():Up() * -17  + self:GetAngles():Right() * dir )
		
		trace = util.TraceLine( tr )
		
		if( trace.Hit && !trace.HitSky ) then
			
			hitcount = hitcount + 1
			//z = z + trace.HitPos.z
			
		end
		
	end
	
	if( hitcount < 10 ) then
		
		self.Speed = math.Approach( self.Speed, 0, 0.02 )
		
	end
	
	if ( self.IsDriving && IsValid( self.Pilot ) /*&& conditions*/ ) then
		phys:Wake()
		
		local mYaw = self.Body:GetAngles().y
		local ap = self.Body:GetAngles()
		local dir = Angle( 0,0,0 )
		local p = { { Key = IN_FORWARD, Speed = 0.15 };
					{ Key = IN_BACK, Speed = -0.15 }; }

		for k,v in ipairs( p ) do
		
			if ( self.Pilot:KeyDown( v.Key ) ) then
			
				self.Speed = self.Speed + v.Speed

			else
			
				self.Speed = math.Approach( self.Speed, 0, 0.01 )
				
			end			
			
		end
		
		if( self.Pilot:KeyDown( IN_JUMP ) ) then
				
			self.Speed = self.Speed * 0.99
			
		end
		
		local dir = 0
		
		self.Speed = math.Clamp( self.Speed, -0.8, 0.88 )
		
		if( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
					
			self.Yaw = math.Approach( self.Yaw, 0.12, 0.025 )
			dir = -0.2
			
		elseif( self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
		
			self.Yaw = math.Approach( self.Yaw, -0.12, 0.025 )
			dir = 0.2
			
		else
			
			self.Yaw = math.Approach( self.Yaw, 0, 0.01 )
		
		end
			
		local p = self.Body:GetPos()
		--p.z = p.z
		
		local downparam = ap.p
		if( downparam > 0 ) then downparam = 0 end
		

		local pr = {}
		pr.secondstoarrive= 0.1
		pr.pos = p - self.Body:GetAngles():Forward() * self.Speed 
		pr.maxangular= 10000
		pr.maxangulardamp= 10000
		pr.maxspeed= 10000000
		pr.maxspeeddamp= 10000000
		pr.dampfactor= 0.0001 //0.0001 // 1.5
		pr.teleportdistance= 10000
		pr.deltatime= deltatime
		pr.angle = Angle( self.Body:GetAngles().p, mYaw + self.Yaw, self.Body:GetAngles().r )

		self.Body:ComputeShadowControl(pr)




		//self.Body:AddAngleVelocity(self.Body:GetAngleVelocity() - Angle(self.Body:GetAngles().p, self.Yaw, self.Body:GetAngles().r))

		
		//self.Body:SetVelocity(pr.pos - p)
		//self.Body:AddAngleVelocity(self.Body:GetAngleVelocity() - self.Body:GetAngles() - pr.angle)
		
		//phys:ComputeShadowControl(pr)
	
	else
		
		self.Speed = math.Approach( self.Speed, 0, 2 )
	
	end	
end

