AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


ENT.PrintName	= "Kirov Airship"
ENT.Model = "models/kirov/kirov.mdl"
//Speed Limits
ENT.MaxVelocity = 400
ENT.MinVelocity = -100

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 75.0

ENT.InitialHealth = 1300
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 10000
ENT.FlareCount = -1
ENT.MaxFlares = -1

ENT.CrosshairOffset = 0

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.08
ENT.SecondaryCooldown = 5.0
ENT.SecondaryFireMode = true // Initial secondary firemode: true = dumbfire, false = homing

ENT.GotChopperGunner = false

// VTOL specific variable.
ENT.isHovering = false

ENT.AutomaticFrameAdvance = true

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 999
	local ent = ents.Create( "sent_kirov_blimp" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()

	self.HealthVal = self.InitialHealth
	
	self:SetNetworkedInt( "health",self.HealthVal )
	self:SetNetworkedInt( "HudOffset", self.CrosshairOffset )
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self:SetNetworkedInt( "MaxSpeed",self.MaxVelocity)
	
	local now = CurTime() - 600
	self.LastPrimaryAttack 		= now
	self.LastSecondaryAttack 	= now
	self.LastFireModeChange 	= now
	self.LastRadarScan 			= now
	self.LastFlare 				= now
	self.ChopperGunAttack 		= now
	
	self.HoverVal = 0
	self.MoveRight = 0

	/* List of types:
		Homing
		Laser // Laser Guided - Optional: specify Damage / Radius for these.
		Bomb
		Dumb
		Pod
		Effect
	*/
	 

	self.Armament = {

						{ 
							PrintName = "JDAM Medium Missile"		,		 		// print name, used by the interface
							Mdl = "models/hawx/weapons/mk-82.mdl",  			// model, used when creating the object
							Pos = Vector( 258, 85, -234 ), 							// Pos, Hard point location on the plane fuselage.
							Ang = Angle( 0, 0, 0 ), 								// Ang, object angle
							Type = "Bomb", 											// Type, used when creating the object
							Cooldown = 7, 											// Cooldown between weapons
							isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
							Class = "sent_jdam_medium"								// the object that will be created.
						}; 
						-- { 
							-- PrintName = "Small Tactical Nuke"		,		 		// print name, used by the interface
							-- Mdl = "models/hawx/weapons/mk-82.mdl",  			// model, used when creating the object
							-- Pos = Vector( 258, -85, -234 ), 							// Pos, Hard point location on the plane fuselage.
							-- Ang = Angle( 0, 0, 0), 								// Ang, object angle
							-- Type = "Bomb", 											// Type, used when creating the object
							-- Cooldown = 7, 											// Cooldown between weapons
							-- isFirst	= nil,										// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
							-- Class = "sent_a2s_nuclear_bomb"								// the object that will be created.
						-- };
						{ 
						PrintName = "Napalm #1", 
						Mdl = "models/hawx/weapons/cbu-100 clusterbomb.mdl",	 
						Pos = Vector( 258, -85, -234 ), 
						Ang = Angle( 0, 0, 45 ), 
						Type = "Bomb",
						Cooldown = 3,
						isFirst	= nil,
						Class = "sent_napalm_bomb",
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
		self.RocketVisuals[i]:Spawn()
		self.RocketVisuals[i].LastAttack = CurTime()
		self.RocketVisuals[i]:SetNoDraw( true )
		
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
	
	self.NumRockets = #self.EquipmentNames
	
	self.LoopSound = CreateSound(self.Entity,Sound("npc/attack_helicopter/aheli_rotor_loop1.wav"))
	self.LoopSound:PlayEx(511,110)
	self.LoopSound:SetSoundLevel(511)
	
	self:SetUseType( SIMPLE_USE )
	self.IsFlying = false
	self.Pilot = nil
	
// self.RotorUp = (self:GetForward() * 40 + self:GetUp() * 75 )
//self.RotorMid = Up -60, Forward 50, Right 115; Up -60, Forward 50, Right -115
//self.RotorLow = Up -125, Forward 200, Right 80;Up -125, Forward 200, Right -80
//self.Turret = Up -160, Forward 100
	
	self.ChopperGun = ents.Create("prop_physics_override")
	self.ChopperGun:SetModel( "models/bf2/helicopters/ah-1 cobra/ah-1 cobra_cannon.mdl" )
	self.ChopperGun:SetPos( self:GetPos() + self:GetForward() * 172 + self:GetUp() * -34  )
	self.ChopperGun:SetAngles( self:GetAngles() )
	self.ChopperGun:SetSolid( SOLID_NONE )
	self.ChopperGun:SetParent( self )
	self.ChopperGun:Spawn()
	self.ChopperGun:SetOwner( self )
	
	// Misc
	self:SetModel( self.Model )	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 10000 )
		self.PhysObj:EnableGravity( true )
		self.PhysObj:EnableDrag( true )
		
	end
	
	self:StartMotionController()
	
end


function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed ) then
		
		return

	end
	
	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt("health",self.HealthVal)
	
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then
	
		self.Burning = true

		local f = ents.Create("env_Fire_trail")
		f:SetPos( self:GetPos() + self:GetForward() * -111 + self:GetUp() * 101  )
		f:SetParent( self )
		f:Spawn()

		
	end
	
	if ( self.HealthVal < 5 ) then
	
		self.Destroyed = true
		self.PhysObj:EnableGravity(true)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:SetMass( 20000 )
		self:Ignite(60,100)
		self:StopMotionController()
		
	end
	
end

function ENT:OnRemove()

	self.LoopSound:Stop()
		
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilotSpecial()
	
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
	self.Pilot:SetNetworkedEntity( "Plane", NULL ) 
	self:SetNetworkedEntity("Pilot", NULL )
	self.Pilot:SetNetworkedBool( "isGunner", false )
	
	self.Pilot:SetPos( self:GetPos() + Vector(0,0,128) )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = NULL
	self.Pilot:SetScriptedVehicle( NULL )
	
	self.Speed = 0
	self.IsFlying = false
	self:SetLocalVelocity(Vector(0,0,0))
	self.Pilot = NULL
	self:NextThink( CurTime() + 0.5 )
	
end

function ENT:Use(ply,caller)

	if ( !IsValid( self.Pilot ) ) then 

		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():EnableMotion(true)
		self.IsFlying = true
		self.Pilot = ply
		self.Owner = ply
		ply:DrawWorldModel( false )
		ply:DrawViewModel( false )
		ply:Spectate( OBS_MODE_CHASE  )
		ply:StripWeapons()
		ply:SetScriptedVehicle( self )

		ply:SetNetworkedBool("InFlight",true)
		ply:SetNetworkedEntity( "Plane", self ) 
		self:SetNetworkedEntity("Pilot", ply )
		ply:SetNetworkedBool( "isGunner", true )
		
		self.Entered = CurTime()
		
	end
	
end

function ENT:Think()

	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 100 + 40 ),0,85 )
	
	self.LoopSound:ChangePitch( self.Pitch, 0.01 )
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random( -62, 62 ) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 300 then
		
			self:EjectPilotSpecial()
			
			if( math.random( 1, 3 ) == 2 ) then
			
				local fx = EffectData()
				fx:SetOrigin( self:GetPos() )
				fx:SetNormal( Vector(0,0,1) )
				fx:SetScale( 0.4 )
				util.Effect("Missile_Nuke", fx)
				util.BlastDamage( self, self, self:GetPos(), 5000, 5000 )
				
			end
			
			self:DeathFX()
	
		
		end
		
	end
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() )
		
		// HUD Stuff
		self:UpdateRadar()
			
		self:NeuroPlanes_CycleThroughHeliKeyBinds()
		
		// Ejection Situations.
		if ( self:WaterLevel() > 1 ) then
		
			self:EjectPilotSpecial()
			
		end

	end
	
	self:NextThink( CurTime() )
		
	return true
	
end

function ENT:PrimaryAttack()
	return
end

function ENT:SecondaryAttack( wep, id )
	
	if ( IsValid( wep ) ) then
	
		self:NeuroPlanes_FireRobot( wep, id )
		
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	local pr = {} 
	
	if ( self.IsFlying ) then
		
		phys:Wake()
		
		local pilotAng = self.Pilot:GetAimVector():Angle()
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 + self:GetUp() * 256 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		self.offs = self:VecAngD( ma.y, ta.y )		
		local r = r or 0
	
		local maxang = 15

		local vel = self:GetVelocity():Length()

		if ( self.Pilot:KeyDown( IN_JUMP ) ) then
			
			self.HoverVal = self.HoverVal + 0.5
			pilotAng.p = -7
			
		elseif ( self.Pilot:KeyDown( IN_DUCK ) ) then
			
			self.HoverVal = self.HoverVal - 0.5
			pilotAng.p = 7
			
		end
		
		if( self.Pilot:KeyDown( IN_FORWARD ) ) then
			
			self.Speed = self.Speed + 1.25
		
		elseif( self.Pilot:KeyDown( IN_BACK ) ) then
		
			self.Speed = self.Speed - 1.25
			
		end
		
		self.HoverVal = math.Clamp( self.HoverVal, -200, 200 )
		
		self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
		
		
		local desiredPos = self:GetPos() + self:GetForward() * self.Speed + self:GetUp() * ( self.HoverVal + math.cos(CurTime()/5.5) * 16 ) + self:GetRight() * ( math.cos( CurTime()*40 ) * 16 )
		
		pilotAng.p = math.sin( -CurTime() - ( 100 * self:EntIndex() ) / 1.25 ) * 2.45
		pilotAng.r = math.cos( CurTime() - ( 100 * self:EntIndex() ) / -1.25 ) * 4
		
		pr.secondstoarrive	= 1
		pr.pos 				= desiredPos
 		pr.maxangular		= maxang // 400
		pr.maxangulardamp	= maxang // 10 000
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.8
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = pilotAng

		phys:ComputeShadowControl(pr)
		
	else
		
		
		local tr,trace = {},{}
		tr.start = self:GetPos() + Vector(0,0,-200)
		tr.endpos = tr.start + Vector(0,0,-3000)
		//tr.mask = MASK_SOLID
		tr.filter = self
		
		trace = util.TraceLine( tr ) 
		
		local pos = self:GetPos()
		
		if ( trace.Hit ) then
			
			pos = trace.HitPos + Vector( 0,0, 1400 + math.sin( CurTime() / self:EntIndex() ) * 32 )
		
			
		end
		
		local ang = self:GetAngles()
		
		ang.p = math.sin( -CurTime() - ( 10 * self:EntIndex() ) / 1.25 ) * 2
		ang.r = math.cos( CurTime() - ( 10 * self:EntIndex() ) / -1.25 ) * 3.5
		
		pos.x = pos.x + math.sin( CurTime() - ( self:EntIndex() * 10 ) ) * 14 + math.random( -2, 2 )
		pos.y = pos.y + math.cos( CurTime() - ( self:EntIndex() * 10 ) ) * 14 + math.random( -2, 2 )
		
		pr.secondstoarrive	= 1
		pr.pos 				= pos
 		pr.maxangular		= 2
		pr.maxangulardamp	= 2
		pr.maxspeed			= 100
		pr.maxspeeddamp		= 100
		pr.dampfactor		= 0.8
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = ang--LerpAngle(0.115, ang

		
		phys:ComputeShadowControl(pr)
		
	end
end

