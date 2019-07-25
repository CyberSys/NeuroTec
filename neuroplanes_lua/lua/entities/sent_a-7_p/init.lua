AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName = "A-7 Corsair II"
ENT.Model = "models/hawx/planes/a-7 corsair ii.mdl"
//Speed Limits
ENT.MaxVelocity = 3500
ENT.MinVelocity = 0

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 4 for larger stuff.
ENT.BankingFactor = 2.9

ENT.InitialHealth = 2500
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
ENT.FlareCooldown = 15
ENT.FlareCount = 5
ENT.MaxFlares = 5

// Equipment
ENT.MachineGunModel = "models/weapons/w_shot_xm1014.mdl"
ENT.MachineGunOffset = Vector( 227, 25, 48 )
ENT.CrosshairOffset = 48

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.03


function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_a-7_p" )
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
						PrintName = "Aim-9 Sidewinder"		,		 			// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
						Pos = Vector( -12, -129, 59), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"								// the object that will be created.
					}; 

					{ 
						PrintName = "Aim-9 Sidewinder", 						// print name, used by the interface
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  		// model, used when creating the object
						Pos = Vector( -12, 129, 59), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						isFirst	= false,										// Secondary rocket. 
						Class = "sent_a2a_rocket"
					}; 

					{ 
						PrintName = "AGM-65 Maverick", 
						Mdl = "models/hawx/weapons/agm-65 maverick.mdl",	 
						Pos = Vector( -19, -94, 55 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Laser",
						Cooldown = 10,
						--isFirst	= true,
						Class = "sent_a2l_rocket",
						Damage = 250,
						Radius = 1024
					}; 

					{ 
						PrintName = "AGM-65 Maverick", 
						Mdl = "models/hawx/weapons/agm-65 maverick.mdl",	 
						Pos = Vector( -19, 94, 55 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Laser",
						Cooldown = 10,
						isFirst	= false,
						Class = "sent_a2l_rocket",
						Damage = 250,
						Radius = 1024
					}; 					

					{ 
						PrintName = "MK-82", 
						Mdl = "models/hawx/weapons/mk-82.mdl",	 
						Pos = Vector( -12, -59, 60 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Bomb",
						Cooldown = 10,
						--isFirst	= true,
						Class = "sent_mk82"
					}; 
					
					{ 
						PrintName = "MK-82", 
						Mdl = "models/hawx/weapons/mk-82.mdl",	 
						Pos = Vector( -12, 59, 60 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Bomb",
						Cooldown = 0,
						isFirst	= false,
						Class = "sent_mk82"
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

	self.Trails = {}
	self.TrailPos = {}
	self.TrailPos[1] = Vector( -79, -225, 79 )
	self.TrailPos[2] = Vector( -79, 225, 79 )

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
	self.IsFlying = false
	self.Pilot = nil
	
	local o = self.MachineGunOffset
	self.Weapon = ents.Create("prop_physics_override")
	self.Weapon:SetModel( self.MachineGunModel )
	self.Weapon:SetPos( self:GetPos() + self:GetForward() * o.x + self:GetRight() * o.y + self:GetUp() * o.z  )
	self.Weapon:SetAngles( self:GetAngles() )
	self.Weapon:SetSolid( SOLID_NONE )
	self.Weapon:SetParent( self )
	self.Weapon:Spawn()
	
	// Misc
	self:SetModel( self.Model )	
	self:SetSkin( math.random( 0, 3 ) )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass(10000)
		
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
		p[1] = self:GetPos() + self:GetForward() * -223 + self:GetRight() * 0 + self:GetUp() * 75 
		p[2] = self:GetPos() + self:GetForward() * -223 + self:GetRight() * 0 + self:GetUp() * 75 
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

	for i=1,3 do
	
		self.EngineMux[i]:Stop()
		
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilot()
	
	end
	
end

function ENT:PhysicsCollide( data, physobj )

	if ( data.Speed > self.MaxVelocity * 0.2 && data.DeltaTime > 0.2 ) then 
		
		if ( self:GetVelocity():Length() < self.MaxVelocity * 0.7 ) then
			
			self.HealthVal = self.HealthVal * 0.3
		
		else
			
			local explo = EffectData()
			explo:SetOrigin(self:GetPos())
			explo:SetScale(0.50)
			explo:SetNormal(data.HitNormal)
			util.Effect("nn_explosion", explo)
			
			util.BlastDamage( self, self, data.HitPos, 1024, 80)
			self:EjectPilot()
			self.Entity:Remove()
		
		end
		
		self:SetNetworkedInt("health",self.HealthVal)
		
	end
	
end
function ENT:Use(ply,caller)

	if ( !self.IsFlying && !IsValid( self.Pilot ) ) then 
		
		self:Jet_DefaultUseStuff( ply, caller )
	
	end
	
end

function ENT:Think()

	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 20 + 40 ),0,245 )

	for i = 1,3 do
	
		self.EngineMux[i]:ChangePitch( self.Pitch, 0.01 )
		
	end
	
	//print( self:GetVelocity():Length() )
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 35 then
		
			self:EjectPilot()
			self:Remove()
		
		end
		
	end
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 500 )
		
		// HUD Stuff
		self:UpdateRadar()
		
		// Lock On method
		local trace,tr = {},{}
		tr.start = self:GetPos() + self:GetUp() * 67 + self:GetForward() * 512
		tr.endpos = tr.start + self:GetUp() * 67 + self:GetForward() * 20000
		tr.filter = { self.Pilot, self, self.Weapon }
		tr.mask = MASK_SOLID
		trace = util.TraceEntity( tr, self )
		
		local e = trace.Entity
		
		local logic = ( IsValid( e ) && ( e:IsNPC() || e:IsPlayer() || e:IsVehicle() || type(e) == "CSENT_vehicle" || string.find( e:GetClass(), "prop_vehicle" ) ) )
		
		if ( logic && !IsValid( self.Target ) && e:GetOwner() != self && e:GetOwner() != self.Pilot && e:GetClass() != self:GetClass() ) then
			
			self:SetTarget( e )
			
		end
			
		self:NeuroPlanes_CycleThroughJetKeyBinds()
		
		if ( self.LastLaserUpdate + 0.5 <= CurTime() ) then
			
			self.LastLaserUpdate = CurTime()
			if ( IsValid( self.LaserGuided ) ) then
				
				self:SetNetworkedBool( "DrawTracker",true )
				
			else
				
				self:SetNetworkedBool( "DrawTracker",false )
				
			end
			
		end
		
		// Ejection Situations.
		if ( self:WaterLevel() > 0 ) then
		
			self:EjectPilot()
			
		end

		self:NextThink( CurTime() )
		
	else
	
		self:NextThink( CurTime() + 1 )
		
	end
	
	
	return true
	
end

function ENT:PrimaryAttack()
	
	if ( !IsValid( self.Pilot ) ) then
		
		return
		
	end
	
 	local bullet = {} 
 	bullet.Num 		= 1
 	bullet.Src 		= self.Weapon:GetPos() + self.Weapon:GetForward() * 277
 	bullet.Dir 		= self.Weapon:GetAngles():Forward()		// Dir of bullet 
 	bullet.Spread 	= Vector( .019, .019, .019 )				// Aim Cone 
 	bullet.Tracer	= math.random( 2, 4 )					// Show a tracer on every x bullets  
 	bullet.Force	= 450					 					// Amount of force to give to phys objects 
 	bullet.Damage	= math.random( 40, 45 )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "AirboatGunHeavyTracer" 
 	bullet.Callback    = function ( a, b, c )
							
							local e = EffectData()
							e:SetOrigin(b.HitPos)
							e:SetNormal(b.HitNormal)
							e:SetScale( 6.5 )
							util.Effect("ManhackSparks", e)

							local e = EffectData()
							e:SetOrigin(b.HitPos)
							e:SetNormal(b.HitNormal)
							e:SetScale( 2.5 )
							util.Effect("HelicopterMegaBomb", e)
							
							util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 300, 8 )
							
							return { damage = true, effects = DoDefaultEffect } 
							
						end 
 	
	self.Weapon:FireBullets( bullet )
	
	self.Weapon:EmitSound( "A10fart.mp3", 511, 98 )
	
	local effectdata = EffectData()
	effectdata:SetStart( self.Weapon:GetPos() + self:GetForward() * 130 )
	effectdata:SetOrigin( self.Weapon:GetPos() + self:GetForward() * 130 )
	effectdata:SetEntity( self.Weapon )
	effectdata:SetNormal( self:GetForward() )
	util.Effect( "a10_muzzlesmoke", effectdata )  

	self.LastPrimaryAttack = CurTime()
	
end

function ENT:SecondaryAttack( wep, id )
	
	if ( IsValid( wep ) ) then
	
		self:NeuroPlanes_FireRobot( wep, id )
		
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	if ( self.IsFlying ) then
	
		phys:Wake()
		
		local p = { { Key = IN_FORWARD, Speed = 6 };
					{ Key = IN_BACK, Speed = -1.5 }; }
					
		for k,v in ipairs( p ) do
			
			if ( self.Pilot:KeyDown( v.Key ) ) then
			
				self.Speed = self.Speed + v.Speed
			
			end
			
		end
		
		self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 + self:GetUp() * -self.CrosshairOffset // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		local pilotAng = self.Pilot:GetAimVector():Angle()
		local r,pitch,vel,drag
		local mvel = self:GetVelocity():Length()
		
		self.offs = self:VecAngD( ma.y, ta.y )		

		if( self.offs < -160 || self.offs > 160 ) then
			
			r = 0
			
		else
		
			r = ( self.offs / self.BankingFactor ) * -1
			
		end
		
		if ( IsValid( self.LaserGuided ) ) then
		
			pitch = 2.5
			vel = 35
			
		else
		
			pitch = pilotAng.p
			vel = mvel / 40
		
		end
		
		vel = math.Clamp( vel, 10, 120 )
		
		drag = -400 + mvel / 8
		
		if ( mvel < 500 ) then
			
			vel = 135
			
		end
		
		local pr = {}
		pr.secondstoarrive	= 1
		pr.pos 				= self:GetPos() + self:GetForward() * self.Speed + Vector( 0,0,1 ) * drag
		pr.maxangular		= 150 - vel
		pr.maxangulardamp	= 250 - vel
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.8
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = Angle( pitch, pilotAng.y, pilotAng.r ) + Angle( 0, 0, r )
		
		phys:ComputeShadowControl(pr)
			
		self:WingTrails( ma.r, 25 )
		
	end
	
end