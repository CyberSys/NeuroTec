
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "A-Wing"
ENT.Model = "models/sw/awing/awing.mdl"
//Speed Limits
ENT.MaxVelocity = 3500
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
ENT.MinigunTracer = "TracerB"

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.1

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_a-Wing_p" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Precache( )
	
	for k,v in pairs(CrashDebris) do
	
		util.PrecacheModel(tostring(v))
	
	end
	
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
						PrintName = "Dymek HM-6 Concussion missile",
						Mdl = "models/hawx/weapons/python-5.mdl",
						Pos = Vector( 59, 99, -8 ),
						Ang = Angle( 0, 0, 5 ),
						Type = "Homing",
						Cooldown = 8,
						--isFirst	= true,
						Class = "sent_a2a_rocket"

					}; 
					
					{ 
						PrintName = "Dymek HM-6 Concussion missile",
						Mdl = "models/hawx/weapons/python-5.mdl",
						Pos = Vector( 59, -99, -8 ),
						Ang = Angle( 0, 0, 5 ),
						Type = "Homing",
						Cooldown = 8,
						isFirst	= false,
						Class = "sent_a2a_rocket"

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

    local minipos = { Vector( 27, 150, -8), Vector( 27, -150, -8), Vector( 2, 157, 1), Vector( 2, -157, 1) }
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
	
//flame effect
		self.FlameSprR = ents.Create( "env_sprite" )
		self.FlameSprR:SetParent( self.Entity )	
		self.FlameSprR:SetPos( self:GetPos() + self:GetForward() * -190 + self:GetRight() * 79 + self:GetUp() * -8  )
		self.FlameSprR:SetAngles( self:GetAngles() )
		self.FlameSprR:SetKeyValue( "spawnflags", 1 )
		self.FlameSprR:SetKeyValue( "renderfx", 0 )
		self.FlameSprR:SetKeyValue( "scale", 0.25 )
		self.FlameSprR:SetKeyValue( "rendermode", 9 )
		self.FlameSprR:SetKeyValue( "HDRColorScale", .75 )
		self.FlameSprR:SetKeyValue( "GlowProxySize", 2 )
		self.FlameSprR:SetKeyValue( "model", "sprites/splodesprite.vmt" )
		self.FlameSprR:SetKeyValue( "framerate", "10.0" )
		self.FlameSprR:SetKeyValue( "rendercolor", "255 255 255" )
		self.FlameSprR:SetKeyValue( "renderamt", 255 )
		self.FlameSprR:Spawn()

		self.FlameTrailR = ents.Create( "env_spritetrail" )
		self.FlameTrailR:SetParent( self.Entity )	
		self.FlameTrailR:SetPos( self:GetPos() + self:GetForward() * -190 + self:GetRight() * 79 + self:GetUp() * -8  )
		self.FlameTrailR:SetAngles( self:GetAngles() )
		self.FlameTrailR:SetKeyValue( "lifetime", 0.1 )
		self.FlameTrailR:SetKeyValue( "startwidth", 128 )
		self.FlameTrailR:SetKeyValue( "endwidth", 0 )
		self.FlameTrailR:SetKeyValue( "spritename", "sprites/afterburner.vmt" )
		self.FlameTrailR:SetKeyValue( "renderamt", 255 )
		self.FlameTrailR:SetKeyValue( "rendercolor", "255 175 0" )
		self.FlameTrailR:SetKeyValue( "rendermode", 5 )
		self.FlameTrailR:SetKeyValue( "HDRColorScale", .75 )
		self.FlameTrailR:Spawn()

		self.FlameSprL = ents.Create( "env_sprite" )
		self.FlameSprL:SetParent( self.Entity )	
		self.FlameSprL:SetPos( self:GetPos() + self:GetForward() * -190 + self:GetRight() * -79 + self:GetUp() * -8  )
		self.FlameSprL:SetAngles( self:GetAngles() )
		self.FlameSprL:SetKeyValue( "spawnflags", 1 )
		self.FlameSprL:SetKeyValue( "renderfx", 0 )
		self.FlameSprL:SetKeyValue( "scale", 0.25 )
		self.FlameSprL:SetKeyValue( "rendermode", 9 )
		self.FlameSprL:SetKeyValue( "HDRColorScale", .75 )
		self.FlameSprL:SetKeyValue( "GlowProxySize", 2 )
		self.FlameSprL:SetKeyValue( "model", "sprites/splodesprite.vmt" )
		self.FlameSprL:SetKeyValue( "framerate", "10.0" )
		self.FlameSprL:SetKeyValue( "rendercolor", "255 255 255" )
		self.FlameSprL:SetKeyValue( "renderamt", 255 )
		self.FlameSprL:Spawn()

		self.FlameTrailL = ents.Create( "env_spritetrail" )
		self.FlameTrailL:SetParent( self.Entity )	
		self.FlameTrailL:SetPos( self:GetPos() + self:GetForward() * -190 + self:GetRight() * -79 + self:GetUp() * -8  )
		self.FlameTrailL:SetAngles( self:GetAngles() )
		self.FlameTrailL:SetKeyValue( "lifetime", 0.1 )
		self.FlameTrailL:SetKeyValue( "startwidth", 128 )
		self.FlameTrailL:SetKeyValue( "endwidth", 0 )
		self.FlameTrailL:SetKeyValue( "spritename", "sprites/afterburner.vmt" )
		self.FlameTrailL:SetKeyValue( "renderamt", 255 )
		self.FlameTrailL:SetKeyValue( "rendercolor", "255 175 0" )
		self.FlameTrailL:SetKeyValue( "rendermode", 5 )
		self.FlameTrailL:SetKeyValue( "HDRColorScale", .75 )
		self.FlameTrailL:Spawn()

		local burnershockwaveR = EffectData()
		burnershockwaveR:SetOrigin( self:GetPos() + self:GetForward() * -249 + self:GetRight() * 51 + self:GetUp() * 89 )
		burnershockwaveR:SetStart( self:GetPos() + self:GetForward() * -249 + self:GetRight() * 51 + self:GetUp() * 89 )
		burnershockwaveR:SetScale( 2 )
			util.Effect( "Afterburner", burnershockwaveR )
		local burnershockwaveL = EffectData()
		burnershockwaveL:SetOrigin( self:GetPos() + self:GetForward() * -249 + self:GetRight() * -51 + self:GetUp() * 89 )
		burnershockwaveL:SetStart( self:GetPos() + self:GetForward() * -249 + self:GetRight() * 51 + self:GetUp() * 89 )
		burnershockwaveL:SetScale( 2 )
			util.Effect( "Afterburner", burnershockwaveL )

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
		
		
		local pos = { Vector( -170, 79, -8 ), Vector( -170, -79,-8 ) }
			
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
	self:EmitSound( "hk/hk_Fire.wav", 510, math.random( 100, 130 ) )
	
	self.LastPrimaryAttack = CurTime()
	
end

function ENT:SecondaryAttack( wep, id )
	
	if ( IsValid( wep ) ) then
	
		self:NeuroPlanes_FireRobot( wep, id )
		
	end
	
end

function ENT:Think()

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
		
			local f1 = EffectData()
			f1:SetOrigin( self:GetPos() )
			f1:SetStart( self:GetPos() )
			util.Effect( "immolate", f1 )
			
			self:EjectPilot()
			self:DeathFX()
			
			return
			
		end
		
	end
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 500 )
		self:UpdateRadar()
		self:SonicBoomTicker()
		self:Jet_LockOnMethod()
		self:NeuroPlanes_CycleThroughJetKeyBinds()
		
		//afterburner effect
		local Speed = math.floor( self:GetVelocity():Length() )
		self.FlameSprL:SetKeyValue( "scale", 0.5 * Speed / self.MaxVelocity  )
		self.FlameSprR:SetKeyValue( "scale", 1 * Speed / self.MaxVelocity  )					
				if ( self:GetVelocity():Length() > 1000 ) then
				self.FlameSprL:SetKeyValue( "scale", 0.5 )
				self.FlameSprR:SetKeyValue( "scale", 0.5 )					
				else
				self.FlameSprL:SetKeyValue( "scale", 0.25 )
				self.FlameSprR:SetKeyValue( "scale", 0.25 )									
				end
		
		

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
				