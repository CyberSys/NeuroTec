
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "F-14A Tomcat"
ENT.Model = "models/hawx/planes/parts/f-14a tomcat/f-14a_air_body.mdl"
//Speed Limits
ENT.MaxVelocity = 4000
ENT.MinVelocity = 0

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 4 for larger stuff.
ENT.BankingFactor = 1.7

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
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.MachineGunOffset = Vector( 200, 70, 29 )
ENT.CrosshairOffset = 16

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.05


function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_f-14a_p" )
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
	self.LastFireModeChange = CurTime()
	self.LastRadarScan = CurTime()
	self.LastFlare = CurTime()
	self.LastLaserUpdate = CurTime()
	
	/* List of types:
		Homing
		Laser // Laser Guided
		Bomb
		Dumb
		Pod
		Effect
	*/
	 
	self.Armament = {

					{ 
						PrintName = "AIM-9 Sidewinder"		,		 					
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  				
						Pos = Vector( 28, -130, 89), 							
						Ang = Angle( 0, 0, 0), 				
						Type = "Homing", 							
						Cooldown = 5, 										
						--isFirst	= true,											
						Class = "sent_a2a_rocket"
					}; 

					{ 
						PrintName = "AIM-9 Sidewinder"		,		 			
						Mdl = "models/hawx/weapons/aim-9 sidewinder.mdl",  			
						Pos = Vector( 28, 130, 89), 					
						Ang = Angle( 0, 0, 0), 							
						Type = "Homing", 									
						Cooldown = 5, 											
						isFirst	= false,								
						Class = "sent_a2a_rocket"
					}; 

					{ 
						PrintName = "GBU-32 JDAM", 
						Mdl = "models/hawx/weapons/gbu-32 jdam.mdl",	 
						Pos = Vector( -97, -15, 56 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Bomb",
						Cooldown = 15,
						--isFirst	= true,
						Class = "sent_mk82"
					}; 

					{ 
						PrintName = "GBU-32 JDAM", 
						Mdl = "models/hawx/weapons/gbu-32 jdam.mdl",	 
						Pos = Vector( -97, 15, 56 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Bomb",
						Cooldown = 15,
						isFirst	= false,
						Class = "sent_mk82"
					}; 

					{ 
						PrintName = "AIM-7 Sparrow", 
						Mdl = "models/hawx/weapons/aim-07 sparrow.mdl",	 
						Pos = Vector( 34, -117, 71 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Homing",
						Cooldown = 10,
						--isFirst	= true,
						Class = "sent_a2a_rocket"
					}; 					

					{ 
						PrintName = "AIM-7 Sparrow", 
						Mdl = "models/hawx/weapons/aim-07 sparrow.mdl",	 
						Pos = Vector( 34, 117, 71 ), 
						Ang = Angle( 0, 0, 0), 
						Type = "Homing",
						Cooldown = 10,
						isFirst	= false,
						Class = "sent_a2a_rocket"
					}; 					

					{
						PrintName = "AN AAQ-14 Lantirn",
						Mdl = "models/hawx/weapons/an aaq 14 lantirn.mdl",
						Pos = Vector( 0, 0, 45 ),
						Ang = Angle( 0, 0, 0 ),
						Type = "Flarepod",
						Cooldown = 0,
						isFirst = false,
						Class = ""
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
		
			if ( v.Type != "Effect" ) then
				
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
	self.TrailPos[1] = Vector( -278, -178, 88 )
	self.TrailPos[2] = Vector( -278, 178, 88 )

		

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
	self.Pilot = nil

	
	local o = self.MachineGunOffset
	self.Weapon = ents.Create("prop_physics_override")
	self.Weapon:SetModel( self.MachineGunModel )
	self.Weapon:SetPos( self:GetPos() + self:GetForward() * o.x + self:GetRight() * o.y + self:GetUp() * o.z  )
	self.Weapon:SetAngles( self:GetAngles() )
	self.Weapon:SetSolid( SOLID_NONE )
	self.Weapon:SetNoDraw( true )
	self.Weapon:SetParent( self )
	self.Weapon:Spawn()

		if( self.SpawnPassengerSeat ) then
	
		self.CoPilotSeatVector = Vector( 0, 0, 0 )
		
		self.CoSeat = ents.Create( "prop_vehicle_prisoner_pod" )
		self.CoSeat:SetPos( self:LocalToWorld( self.CoPilotSeatVector ) )
		self.CoSeat:SetModel( "models/nova/jeep_seat.mdl" )
		self.CoSeat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		self.CoSeat.HandleAnimation = function( v, p ) return p:SelectWeightedSequence( ACT_GMOD_SIT_ROLLERCOASTER ) end
		self.CoSeat:SetAngles( self:GetAngles() + Angle( 0, -90, 0 ) )
		self.CoSeat:SetParent( self )
		self.CoSeat:SetNoDraw( true )
		self.CoSeat:Spawn()
		self.CoSeat.IsCoPilotSeat = true
		
	end
	
	// Misc
	self:SetModel( self.Model )	
	self:SetSkin( math.random( 0, 1 ) )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	// Wings
	self.Rwing = ents.Create("prop_physics_override")
	self.Rwing:SetPos( self:GetPos() + self:GetForward() * 55 + self:GetRight() * 111 + self:GetUp() * 101 )
	self.Rwing:SetParent( self )
	self.Rwing:SetModel( "models/hawx/planes/parts/f-14a tomcat/f-14a_Rwing.mdl" )
	self.Rwing:SetAngles( self:GetAngles() )
	self.Rwing:SetSkin( self:GetSkin() )
	self.Rwing:Spawn()

	self.Lwing = ents.Create("prop_physics_override")
	self.Lwing:SetPos( self:GetPos() + self:GetForward() * 55 + self:GetRight() * -111 + self:GetUp() * 101 )
	self.Lwing:SetParent( self )
	self.Lwing:SetModel( "models/hawx/planes/parts/f-14a tomcat/f-14a_Lwing.mdl" )
	self.Lwing:SetAngles( self:GetAngles() )
	self.Lwing:SetSkin( self:GetSkin() )
	self.Lwing:Spawn()

	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass(10000)
		
	end

	
		self.Trails[1] = ents.Create("prop_physics_override")
		self.Trails[1]:SetModel( "models/props_lab/huladoll.mdl" )
		self.Trails[1]:SetPos( self:LocalToWorld( self.TrailPos[1] ) )
		self.Trails[1]:SetAngles( self.Rwing:GetAngles() )
		self.Trails[1]:SetParent( self.Rwing )	
		self.Trails[1]:SetNoDraw( true )
		self.Trails[1]:Spawn()

		self.Trails[2] = ents.Create("prop_physics_override")
		self.Trails[2]:SetModel( "models/props_lab/huladoll.mdl" )
		self.Trails[2]:SetPos( self:LocalToWorld( self.TrailPos[2] ) )
		self.Trails[2]:SetAngles( self.Lwing:GetAngles() )
		self.Trails[2]:SetParent( self.Lwing )	
		self.Trails[2]:SetNoDraw( true )
		self.Trails[2]:Spawn()
		
		local col = Color( 255,255,255,90 )
		util.SpriteTrail( self.Trails[1], 0, col, false, 8, 1, 2, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt")
		util.SpriteTrail( self.Trails[2], 0, col, false, 8, 1, 2, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt")

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
		p[1] = self:GetPos() + self:GetForward() * -202 + self:GetRight() * -57 + self:GetUp() * 84
		p[2] = self:GetPos() + self:GetForward() * -202 + self:GetRight() * 57 + self:GetUp() * 84 
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
		
		else
		
		if( !IsValid( self.CoPilot ) ) then return end
		
		if( !self.SpawnPassengerSeat ) then return end
		
		ply:EnterVehicle( self.CoSeat )
		self.CoPilot = ply
		
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

function ENT:PrimaryAttack()
	
	if ( !IsValid( self.Pilot ) ) then
		
		return
		
	end
	
 	local bullet = {} 
 	bullet.Num 		= 1
 	bullet.Src 		= self.Weapon:GetPos() + self.Weapon:GetForward() * 205
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
							e:SetScale( 4.5 )
							util.Effect("ManhackSparks", e)

							local e = EffectData()
							e:SetOrigin(b.HitPos)
							e:SetNormal(b.HitNormal)
							e:SetScale( 1.5 )
							util.Effect("HelicopterMegaBomb", e)
							
							util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 150, 8 )
							
							return { damage = true, effects = DoDefaultEffect } 
							
						end 
 	
	self.Weapon:FireBullets( bullet )
	
	self.Weapon:EmitSound( "ah64fire.wav", 511, 140 )
	
	local effectdata = EffectData()
	effectdata:SetStart( self.Weapon:GetPos() + self:GetForward() * 50 )
	effectdata:SetOrigin( self.Weapon:GetPos() + self:GetForward() * 50 )
	effectdata:SetEntity( self.Weapon )
	effectdata:SetNormal( self:GetForward() )
	util.Effect( "HunterMuzzleFlash", effectdata )  
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
					{ Key = IN_BACK, Speed = -5 }; }
					
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
		local p,y,r,pitch,vel,drag
		local mvel = self:GetVelocity():Length()

		local AngVar = mvel * 55 / self.MaxVelocity

		if AngVar >= 48 then AngVar = 48 end

		self.Rwing:SetLocalAngles( Angle(0, -AngVar, 0 ) )// Right Wing animation
		self.Lwing:SetLocalAngles( Angle(0, AngVar, 0 ) ) // Left Wing animation
		//Wings' angle variation: 20° (cruiser flight) to 68° (supersonic flight)		
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
