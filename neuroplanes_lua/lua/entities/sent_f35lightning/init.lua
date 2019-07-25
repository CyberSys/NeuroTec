
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "F-35 Lightning II"
ENT.Model = "models/hawx/planes/parts/f-35 lightning ii/f-35_body.mdl"
//Speed Limits
ENT.MaxVelocity = 3350
ENT.MinVelocity = 0


// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 5 for larger stuff.
ENT.BankingFactor = 1.9

ENT.InitialHealth = 3000
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
ENT.MaxFlares = 8

// Equipment
ENT.MachineGunModel = "models/h500_gatling.mdl"
ENT.MachineGunOffset = Vector( 140, 44, 15 )

ENT.CrosshairOffset = 15

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.125


function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_f35lightning" )
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
						PrintName = "GBU-12 Paveway II", 
						Mdl = "models/hawx/weapons/gbu-12 paveway-ii.mdl",	 
						Pos = Vector( 0, 0, -40 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Bomb",
						Cooldown = 10,
						isFirst	= nil,
						Class = "sent_mk82"
					}; 
					{ 
						PrintName = "AIM-120 AMRAAM", 
						Mdl = "models/hawx/weapons/aim-120 amraam.mdl",	 
						Pos = Vector( -76, 45, -40 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Homing",
						Cooldown = 15,
						isFirst	= nil,
						Class = "sent_a2a_rocket"
					};

					{ 
						PrintName = "AGM-84 Harpoon", 
						Mdl = "models/hawx/weapons/agm-84 harpoon.mdl",	 
						Pos = Vector( -76, -45, -40 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Homing",
						Cooldown = 15,
						isFirst	= nil,
						Class = "sent_a2a_rocket"
					}; 
					{ 
						PrintName = "AIM-07 Sparrow", 
						Mdl = "models/hawx/weapons/aim-07 sparrow.mdl",	 
						Pos = Vector( -76, 45, -40 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Homing",
						Cooldown = 15,
						isFirst	= nil,
						Class = "sent_a2a_rocket"
					}; 
					/* JDAM - Left Wing */
					{ 
						PrintName = "JDAM Bomb", 
						Mdl = "models/hawx/weapons/gbu-32 jdam.mdl",	 
						Pos = Vector( 0, 0, -40 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Bomb",
						Cooldown = 15,
						isFirst	= nil,
						Class = "sent_jdam_medium"
					}; 
					{ 
						PrintName = "Exocet AM-39"		,		 				// print name, used by the interface
						Mdl = "models/hawx/weapons/exocet am39.mdl",  			// model, used when creating the object
						Pos = Vector( -58, -113, -7 ), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Laser", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2l_rocket",								// the object that will be created.
						Damage = 700,
						Radius = 1024
					}; 
					{ 
						PrintName = "Exocet AM-39"		,		 				// print name, used by the interface
						Mdl = "models/hawx/weapons/exocet am39.mdl",  			// model, used when creating the object
						Pos = Vector( -58, 113, -7 ), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "Laser", 										// Type, used when creating the object
						Cooldown = 15, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2l_rocket",								// the object that will be created.
						Damage = 700,
						Radius = 1024
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
		
		if ( v.Type != "Flarepod" ) then
			
			self.RocketVisuals[i]:SetNoDraw( true )
		end
		
		// Hackfix for internal weapons.
		if ( v.Pos.y != -45 && v.Pos.y != 45 && v.Pos.y != 0 ) then
			
			self.RocketVisuals[i]:SetColor( Color( 255,255,255,255 ) )
		
		end
		
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
	self.TrailPos[1] = Vector( -125, -198, 11 )
	self.TrailPos[2] = Vector( -125, 198, 11 )

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
	self.Weapon:SetNoDraw( true )
	self.Weapon:Spawn()
	
	self.Engine = ents.Create("prop_physics_override")
	self.Engine:SetPos( self:GetPos() + self:GetForward() * -175 + self:GetUp() * 0 )
	self.Engine:SetParent( self )
	self.Engine:SetModel( "models/props_wasteland/laundry_washer003.mdl" )
	self.Engine:SetNoDraw( true )
	self.Engine:SetAngles( self:GetAngles() )
	self.Engine:Spawn()
	
	-- hackfix because I'm too lazy to figure out why the angles are borked.
	local nozzle = ents.Create("sent_f35_nozzle")
	nozzle:SetPos( self.Engine:GetPos() )
	nozzle:SetAngles( self:GetAngles() + Angle( 0, 180, 0 ) )
	nozzle:SetParent( self.Engine )
	nozzle:SetModel( "models/hawx/planes/parts/f-35 lightning ii/f-35_engine.mdl" )
	nozzle:Spawn()
	
	self.Rotorwash = ents.Create("env_rotorwash_emitter")
	self.Rotorwash:SetPos( self:GetPos() )
	self.Rotorwash:SetParent( self )
	self.Rotorwash:SetKeyValue("altitude","",1024)
	self.Rotorwash:Spawn()
	
	// Misc
	self:SetModel( self.Model )	
	self:SetSkin( math.random( 0, 1 ) )
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

		local f = ents.Create("env_Fire_trail")
		f:SetPos( self:GetPos() + self:GetForward() * -173 + self:GetRight() * 0 + self:GetUp() * 3 )
		f:SetParent( self )
		f:Spawn()

		
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

	if ( data.Speed > self.MaxVelocity * 0.3 && data.DeltaTime > 0.5 ) then 
		
		if ( self:GetVelocity():Length() < self.MaxVelocity * 0.5 ) then
			
			self.HealthVal = self.HealthVal * 0.3
		
		else
			
			self:DeathFX()
		
			return
		
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
		
		if self.DeathTimer > 400 then
		
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
 	bullet.Src 		= self.Weapon:GetPos() + self.Weapon:GetForward() * 220
 	bullet.Dir 		= self.Weapon:GetAngles():Forward()			// Dir of bullet 
 	bullet.Spread 	= Vector( .021, .022, .019 )				// Aim Cone 
 	bullet.Tracer	= 1											// Show a tracer on every x bullets  
 	bullet.Force	= 450					 					// Amount of force to give to phys objects 
 	bullet.Damage	= 0
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "AirboatGunHeavyTracer" 
 	bullet.Callback    = function ( a, b, c )
							
							local e = EffectData()
							e:SetOrigin(b.HitPos)
							e:SetNormal(b.HitNormal)
							e:SetScale( 4.5 )
							util.Effect("ManhackSparks", e)

							local e = EffectData()
							e:SetOrigin(b.HitPos)
							e:SetNormal(b.HitNormal)
							e:SetScale( 1.5 )
							util.Effect("HelicopterMegaBomb", e)
							
							util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 450, 22 )
							
							return { damage = true, effects = DoDefaultEffect } 
							
						end 
 	
	self.Weapon:FireBullets( bullet )
	
	self.Weapon:EmitSound( "A10fart.mp3", 511, 98 )
	
	local effectdata = EffectData()
	effectdata:SetStart( self.Weapon:GetPos() + self:GetForward() * 140 )
	effectdata:SetOrigin( self.Weapon:GetPos() + self:GetForward() * 140 )
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
	
	if ( self.IsFlying && !self.Destroyed && !self.Burning ) then
		
		local p = { { Key = IN_FORWARD, Speed = 5.5 };
					{ Key = IN_BACK, Speed = -3.55 }; }
					
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
		local r
		local maxang
		local up = 0
		local pilotAng = self.Pilot:GetAimVector():Angle()
				
		local _vel = ( self:GetVelocity():Length() / 180 ) + 1.58
		local vOffset = self.Engine:GetPos() + self:GetUp() * -3.0 + self:GetForward() * -_vel
		local vNormal = ( vOffset - self.Engine:GetPos() ):GetNormalized()
		local vAng = vNormal:Angle()
		vAng.r = ma.r * -1
		//vAng.p = vAng.p * -1
		//vAng.y = ma.y
		
		self.Engine:SetAngles( vAng ) // Engine animation :v
		
		self.offs = self:VecAngD( ma.y, ta.y )	
		
		
		if ( self:GetVelocity():Length() < 1500 ) then
			
			self.isHovering = true
			maxang = 10
			self.BankingFactor = 12
			
			if ( self.Pilot:KeyDown( IN_JUMP ) ) then
				
				self.HoverVal = self.HoverVal + 0.55
				self.Speed = self.Speed + 1.95
				
			elseif ( self.Pilot:KeyDown( IN_DUCK ) ) then
				
				self.HoverVal = self.HoverVal - 0.55
				self.Speed = self.Speed / 1.005
				
			end
			
			self.HoverVal = math.Clamp( self.HoverVal, -150, 150 )
			up = self.HoverVal
			
			pilotAng.p = -12 + math.sin(CurTime()) * 2
			
		else
		
			self.isHovering = false
			maxang = 65
			self.BankingFactor = 1.95
			self.HoverVal = 15
			
		end
		
		if( self.offs < -160 || self.offs > 160 ) then
			
			r = 0
			
		else
		
			r = ( self.offs / self.BankingFactor ) * -1
			
		end
		
		if ( self:OnGround() ) then
		
			pilotAng.y = self:GetAngles().y
			
		end
		
		if ( IsValid( self.LaserGuided ) ) then
			
			pilotAng.p = 0
			
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
					
		self:WingTrails( ma.r, 25 )
		
	end
	
end
