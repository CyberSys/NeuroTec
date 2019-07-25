
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "Colonial Viper MKII"
ENT.Model = "models/inaki/props_vehicles/vipermk2.mdl"
//Speed Limits
ENT.MaxVelocity = 3800
ENT.MinVelocity = 0

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 4 for larger stuff.
ENT.BankingFactor = 2.1

ENT.InitialHealth = 2000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// VTOL specifik variable.
ENT.isHovering = false

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 5
ENT.MaxFlares = 8

// Equipment
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.CrosshairOffset = 26
ENT.MinigunTracer = "AirboatGunHeavyTracer"

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.1


function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_ViperMk2" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	
	self:SetNetworkedInt( "health",self.HealthVal)
	self:SetNetworkedInt( "HudOffset", self.CrosshairOffset )
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self:SetNetworkedInt( "MaxSpeed",self.MaxVelocity)

	self.LastPrimaryAttack = CurTime()
	self.LastSecondaryAttack = CurTime()
	self.LastFireModeChange = CurTime()
	self.LastRadarScan = CurTime()
	self.LastFlare = CurTime()
	self.LastLaserUpdate = CurTime()
	
    self.HoverVal = 0
	
	/* List of types:
		Homing
		Laser // Laser Guided - Optional: specify Damage / Radius for these, see below.
		Bomb
		Dumb
		Pod
		Effect
	*/
	
	self.Armament = {
					
					{ 
						PrintName = "AIM-132 ASRAAM",
						Mdl = "models/hawx/weapons/aim-132 asraam.mdl",
						Pos = Vector( 0, 20, -30 ),
						Ang = Angle( 0, 0, 5 ),
						Type = "Homing",
						Cooldown = 8,
						--isFirst	= true,
						Class = "sent_a3a_rocket"

					}; 
					
					{ 
						PrintName = "AIM-132 ASRAAM",
						Mdl = "models/hawx/weapons/aim-132 asraam.mdl",
						Pos = Vector( 0, -20, -30 ),
						Ang = Angle( 0, 0, 5 ),
						Type = "Homing",
						Cooldown = 8,
						isFirst	= false,
						Class = "sent_a3a_rocket"

					}; 


				}
	
	// Armamanet
	local i = 0
	local c = 0
	self.FireMode = 1
	self.EquipmentNames = {}
	self.RocketVisuals = {}
	
	for k,v in pairs( self.Armament ) do
		
		i = i + 1
		self.RocketVisuals[i] = ents.Create("prop_physics_override")
		self.RocketVisuals[i]:SetModel( v.Mdl )
		self.RocketVisuals[i]:SetPos( self:GetPos() + self:GetForward() * v.Pos.x + self:GetRight() * v.Pos.y + self:GetUp() * v.Pos.z )
		self.RocketVisuals[i]:SetAngles( self:GetAngles() + v.Ang )
		self.RocketVisuals[i]:SetParent( self )
		self.RocketVisuals[i]:SetSolid( SOLID_NONE )
		self.RocketVisuals[i].Type = v.Type
		self.RocketVisuals[i].PrintName = v.PrintName
		self.RocketVisuals[i].Cooldown = v.Cooldown
		self.RocketVisuals[i].isFirst = v.isFirst
		self.RocketVisuals[i].Identity = i
		self.RocketVisuals[i].Class = v.Class
		self.RocketVisuals[i].Owner = self.Entity.Owner or self.Pilot
		self.RocketVisuals[i]:Spawn()
		self.RocketVisuals[i].LastAttack = CurTime()
		
		if ( v.Damage && v.Radius ) then
			
			self.RocketVisuals[i].Damage = v.Damage
			self.RocketVisuals[i].Radius = v.Radius
		
		end
		
		// Usuable Equipment
		if ( v.isFirst == true || v.isFirst == nil /* Single Missile*/ ) then
		
			if ( v.Type != "Effect" && v.Type != "Flarepod" ) then
				
				c = c + 1
				self.EquipmentNames[c] = {}
				self.EquipmentNames[c].Identity = i
				self.EquipmentNames[c].Name = v.PrintName
				
			end
			
		end
		
	end
	
	self.NumRockets = #self.EquipmentNames or 0

	// Sound
	local esound = {}
	self.EngineMux = {}
	
	esound[1] = "physics/metal/canister_scrape_smooth_loop1.wav"
	esound[2] = "physics/cardboard/cardboard_box_scrape_smooth_loop1.wav"
	esound[3] = "ambient/levels/canals/dam_water_loop2.wav"
	
	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	// Sonic Boom variables
	local fxsound = { "ambient/levels/canals/dam_water_loop2.wav", "lockon/sonicboom.mp3", "lockon/supersonic.wav" }
	self.PCfx = 0
	self.FXMux = {}
	
	for i=1, #fxsound do
	
		self.FXMux[i] = CreateSound( self, fxsound[i] )
		
	end
	
	self.Pitch = 80
	self.EngineMux[1]:PlayEx( 500 , self.Pitch )
	self.EngineMux[2]:PlayEx( 500 , self.Pitch )
	self.EngineMux[3]:PlayEx( 500 , self.Pitch )
	
	self:SetUseType( SIMPLE_USE )
	self.IsFlying = false
	self.Pilot = NULL
	
	// Misc
	self:SetModel( self.Model )	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetPhysicsAttacker(self.Owner)

	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass(10000)
	end

    local minipos = { Vector( 40, 48, -5), Vector( 85, -48, -5) }
	self.Miniguns = {}
	
	for i=1,#minipos do
		
		self.Miniguns[i] = ents.Create("prop_physics_override")
		self.Miniguns[i]:SetPos( self:LocalToWorld( minipos[i] ) )
		self.Miniguns[i]:SetModel( self.MachineGunModel )
		self.Miniguns[i]:SetAngles( self:GetAngles() )
		self.Miniguns[i]:SetNoDraw( true )
		self.Miniguns[i]:SetParent( self )
		self.Miniguns[i]:SetSolid( SOLID_NONE )
		self.Miniguns[i]:Spawn()
		self.Miniguns[i].LastAttack = CurTime()
		
	end
	self.MinigunIndex = 1
	self.MinigunMaxIndex = #self.Miniguns

//New Red lights(and trails) added by I�aki.
		self.redlightL1 = ents.Create( "env_sprite" )
		self.redlightL1:SetParent( self.Entity )	
		self.redlightL1:SetPos( self:GetPos() + self:GetForward() * -61.5 + self:GetUp() * -38.4 + self:GetRight() * -107.92 ) -----143.9 -38.4 -82
		self.redlightL1:SetAngles( self:GetAngles() )
		self.redlightL1:SetKeyValue( "spawnflags", 1 )
		self.redlightL1:SetKeyValue( "renderfx", 0 )
		self.redlightL1:SetKeyValue( "scale", 0.5 )
		self.redlightL1:SetKeyValue( "rendermode", 9 )
		self.redlightL1:SetKeyValue( "HDRColorScale", .75 )
		self.redlightL1:SetKeyValue( "GlowProxySize", 2 )
		self.redlightL1:SetKeyValue( "model", "sprites/orangeglow1.vmt" )
		self.redlightL1:SetKeyValue( "framerate", "10.0" )
		self.redlightL1:SetKeyValue( "rendercolor", "255 255 255" )
		self.redlightL1:SetKeyValue( "renderamt", 255 )
		self.redlightL1:Spawn()

		self.redlightL2 = ents.Create( "env_sprite" )
		self.redlightL2:SetParent( self.Entity )	
		self.redlightL2:SetPos( self:GetPos() + self:GetForward() * -135.375 + self:GetUp() * -33.15 + self:GetRight() * -99.45 ) -------132.59 -33.15 -180.5
		self.redlightL2:SetAngles( self:GetAngles() )
		self.redlightL2:SetKeyValue( "spawnflags", 1 )
		self.redlightL2:SetKeyValue( "renderfx", 0 )
		self.redlightL2:SetKeyValue( "scale", 0.5 )
		self.redlightL2:SetKeyValue( "rendermode", 9 )
		self.redlightL2:SetKeyValue( "HDRColorScale", .75 )
		self.redlightL2:SetKeyValue( "GlowProxySize", 2 )
		self.redlightL2:SetKeyValue( "model", "sprites/orangeglow1.vmt" )
		self.redlightL2:SetKeyValue( "framerate", "10.0" )
		self.redlightL2:SetKeyValue( "rendercolor", "255 255 255" )
		self.redlightL2:SetKeyValue( "renderamt", 255 )
		self.redlightL2:Spawn()

		self.redlighttrailL2 = ents.Create( "env_spritetrail" )
		self.redlighttrailL2:SetParent( self.Entity )	
		self.redlighttrailL2:SetPos( self:GetPos() + self:GetForward() * -135.375 + self:GetUp() * -33.15 + self:GetRight() * -99.45 ) -------132.59 -33.15 -180.5
		self.redlighttrailL2:SetAngles( self:GetAngles() )
		self.redlighttrailL2:SetKeyValue( "lifetime", 0.5 )
		self.redlighttrailL2:SetKeyValue( "startwidth", 30 )
		self.redlighttrailL2:SetKeyValue( "endwidth", 4 )
		self.redlighttrailL2:SetKeyValue( "spritename", "sprites/combineball_trail_red_1.vmt" )
		self.redlighttrailL2:SetKeyValue( "renderamt", 255 )
		self.redlighttrailL2:SetKeyValue( "rendercolor", "255 0 0" )
		self.redlighttrailL2:SetKeyValue( "rendermode", 5 )
		self.redlighttrailL2:SetKeyValue( "HDRColorScale", .75 )
		self.redlighttrailL2:Spawn()

		self.redlightR1 = ents.Create( "env_sprite" )
		self.redlightR1:SetParent( self.Entity )	
		self.redlightR1:SetPos( self:GetPos() + self:GetForward() * -61.5 + self:GetUp() * -38.4 + self:GetRight() * 107.92 ) -----143.9 -38.4 -82
		self.redlightR1:SetAngles( self:GetAngles() )
		self.redlightR1:SetKeyValue( "spawnflags", 1 )
		self.redlightR1:SetKeyValue( "renderfx", 0 )
		self.redlightR1:SetKeyValue( "scale", 0.5 )
		self.redlightR1:SetKeyValue( "rendermode", 9 )
		self.redlightR1:SetKeyValue( "HDRColorScale", .75 )
		self.redlightR1:SetKeyValue( "GlowProxySize", 2 )
		self.redlightR1:SetKeyValue( "model", "sprites/orangeglow1.vmt" )
		self.redlightR1:SetKeyValue( "framerate", "10.0" )
		self.redlightR1:SetKeyValue( "rendercolor", "255 255 255" )
		self.redlightR1:SetKeyValue( "renderamt", 255 )
		self.redlightR1:Spawn()

		self.redlightR2 = ents.Create( "env_sprite" )
		self.redlightR2:SetParent( self.Entity )	
		self.redlightR2:SetPos( self:GetPos() + self:GetForward() * -135.375 + self:GetUp() * -33.15 + self:GetRight() * 99.45 ) -------132.59 -33.15 -180.5
		self.redlightR2:SetAngles( self:GetAngles() )
		self.redlightR2:SetKeyValue( "spawnflags", 1 )
		self.redlightR2:SetKeyValue( "renderfx", 0 )
		self.redlightR2:SetKeyValue( "scale", 0.5 )
		self.redlightR2:SetKeyValue( "rendermode", 9 )
		self.redlightR2:SetKeyValue( "HDRColorScale", .75 )
		self.redlightR2:SetKeyValue( "GlowProxySize", 2 )
		self.redlightR2:SetKeyValue( "model", "sprites/orangeglow1.vmt" )
		self.redlightR2:SetKeyValue( "framerate", "10.0" )
		self.redlightR2:SetKeyValue( "rendercolor", "255 255 255" )
		self.redlightR2:SetKeyValue( "renderamt", 255 )
		self.redlightR2:Spawn()

		self.redlighttrailR2 = ents.Create( "env_spritetrail" )
		self.redlighttrailR2:SetParent( self.Entity )	
		self.redlighttrailR2:SetPos( self:GetPos() + self:GetForward() * -135.375 + self:GetUp() * -33.15 + self:GetRight() * 99.45) -------132.59 -33.15 -180.5
		self.redlighttrailR2:SetAngles( self:GetAngles() )
		self.redlighttrailR2:SetKeyValue( "lifetime", 0.5 )
		self.redlighttrailR2:SetKeyValue( "startwidth", 30 )
		self.redlighttrailR2:SetKeyValue( "endwidth", 4 )
		self.redlighttrailR2:SetKeyValue( "spritename", "sprites/combineball_trail_red_1.vmt" )
		self.redlighttrailR2:SetKeyValue( "renderamt", 255 )
		self.redlighttrailR2:SetKeyValue( "rendercolor", "255 0 0" )
		self.redlighttrailR2:SetKeyValue( "rendermode", 5 )
		self.redlighttrailR2:SetKeyValue( "HDRColorScale", .75 )
		self.redlighttrailR2:Spawn()
		
	self:StartMotionController()

end

function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed ) then
		
		return

	end
	
	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt( "health", self.HealthVal )
	
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then

		self.Burning = true
		
		
		local pos = { Vector( 123, 18, 4 ), Vector( 123, -18, 4 ) }
			
		for i=1,#pos do
			
			for j=1,2 do

				local f = ents.Create("env_Fire_trail")
				f:SetPos( self:LocalToWorld( pos[i] ) + Vector( math.random(-16,16), math.random(-16,16), 0 ) )
				f:SetParent( self )
				f:Spawn()
				
			end
			
		end
		
	end
	
	if ( self.HealthVal < 5 ) then
	
		self.Destroyed = true
		self.PhysObj:EnableGravity(true)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:SetMass( 2000 )
		self:Ignite( 60,100 )
		
	end
	
end

function ENT:OnRemove()

	for i=1,3 do
	
		self.EngineMux[i]:Stop()
		
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilot()
	
	end
	
end

function ENT:PhysicsCollide( data, physobj )

	if ( self.Speed > self.MaxVelocity * 0.25 && data.DeltaTime > 0.2 ) then  
		self:EmitSound( "lockon/PlaneHit.mp3", 510, math.random( 100, 130 ) )
			if ( self:GetVelocity():Length() > self.MaxVelocity * 0.70 ) then
			self:DeathFX()
			end
	end
	
end

function ENT:Use(ply,caller)

	if ( !self.IsFlying && !IsValid( self.Pilot ) ) then 
		
		self:Jet_DefaultUseStuff( ply, caller )
	
    end
end

function ENT:PrimaryAttack()
	
	if ( !IsValid( self.Pilot ) ) then
		
		return
		
	end
	
	self:Jet_FireMultiBarrel()
	self:EmitSound( "IL-2/gun_17_22.mp3", 510, math.random( 100, 130 ) )
	
	self.LastPrimaryAttack = CurTime()
	
end

function ENT:SecondaryAttack( wep, id )
	
	if ( IsValid( wep ) ) then
	
		self:NeuroPlanes_FireRobot( wep, id )
		
	end
	
end

function ENT:Think()
//THIS WAS ADDED.

local phys = self:GetPhysicsObject()
 
if phys:IsValid() then
			local PlaneDrive = phys:GetAngleVelocity()
			self:SetPoseParameter( "move_yaw", PlaneDrive.z * 1.0 ) 

//disabled coz it makes all looks odd
//			self:SetPoseParameter( "move_pitch", PlaneDrive.x * 1.0 ) 

			local PlaneVelocity = phys:GetVelocity()
			self:SetPoseParameter( "move_speed", PlaneVelocity.x * 0.1 ) 
			local PlaneVelocityx = phys:GetVelocity():Length()
//Traileffect increaser added by I�aki.
		self.redlighttrailL2:Fire("color",""..math.Clamp( PlaneVelocityx * 0.05, 0, 255 ).." 0 0",0)
		self.redlighttrailR2:Fire("color",""..math.Clamp( PlaneVelocityx * 0.05, 0, 255 ).." 0 0",0)

//Propeller Blur effect.
		 if self.Speed > 900 then

			self:ResetSequence( self:LookupSequence( "idletoground" ) )
		 //self.Grounding = false
		else
			self:ResetSequence( self:LookupSequence( "groundtoidle" ) )
				//self.Grounding = true	
		end
end
 
self:NextThink( CurTime() )
	
	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 20 + 40 ), 0, 200 )
	
	for i = 1,3 do
	
		self.EngineMux[i]:ChangePitch( self.Pitch, 0.01 )
		
	end
	

	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + Vector( math.random(-50,50), math.random(-50,50), 0 ) )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if ( self.DeathTimer > 150 ) then
		
			self:EjectPilot()
			self:DeathFX()
		
		end
		
	end
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 500 )
		self:UpdateRadar()
		self:SonicBoomTicker()
		self:Jet_LockOnMethod()
		self:NeuroPlanes_CycleThroughJetKeyBinds()
		
		
	   end
	 return true  
end
	


function ENT:PhysicsSimulate( phys, deltatime )
	
	if ( self.IsFlying ) then
		
		local p = { { Key = IN_FORWARD, Speed = 5 };
					{ Key = IN_BACK, Speed = -5 }; }
					
		phys:Wake()
		
		for k,v in pairs( p ) do
			
			if ( self.Pilot:KeyDown( v.Key ) ) then
			
				self.Speed = self.Speed + v.Speed
			
			end
			
		end
		
		self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
		
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		self.offs = self:VecAngD( ma.y, ta.y )		
		local r
		
		local maxang
		local up = 0
		local pilotAng = self.Pilot:GetAimVector():Angle()
		
		if ( self:GetVelocity():Length() < 1000 ) then
			
			self.isHovering = true
			maxang = 20
			self.BankingFactor = 7
			
			if ( self.Pilot:KeyDown( IN_JUMP ) ) then
				
				self.HoverVal = self.HoverVal + 1.5
				
			else
				
				self.HoverVal = self.HoverVal - 1.5
			
			end
			
			self.HoverVal = math.Clamp( self.HoverVal, -128, 128 )
			up = self.HoverVal
			
			pilotAng.p = -4 + math.sin(CurTime()) * 2
			
		else
		
			self.isHovering = false
		
			maxang = 100
			self.BankingFactor = 2.5
			self.HoverVal = 0
			
		end
		
		if( self.offs < -160 || self.offs > 160 ) then
			
			r = 0
			
		else
		
			r = ( self.offs / self.BankingFactor ) * -1
			
		end
		
		if ( self:OnGround() ) then
		
			pilotAng.y = self:GetAngles().y
			
		end
		
		local pr = {}	
		pr.secondstoarrive	= 1
		pr.pos 				= self:GetPos() + self:GetForward() * self.Speed + self:GetUp() * self.HoverVal
		pr.maxangular		= maxang // 400
		pr.maxangulardamp	= maxang // 10 000
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.8
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = pilotAng + Angle( 0, 0, r )
		phys:ComputeShadowControl(pr)
		
end
end
				