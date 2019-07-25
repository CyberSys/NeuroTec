
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName = "Mig-29 Fulcrum"
ENT.Model = "models/hawx/air/mig-29 fulcrum.mdl"
//Speed Limits
ENT.MaxVelocity = 3500
ENT.MinVelocity = 0

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 4 for larger stuff.
ENT.BankingFactor = 2.11

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
ENT.FlareCount = 8
ENT.MaxFlares = 8

// Equipment
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.MachineGunOffset = Vector( 20, 60, 45 )
ENT.CrosshairOffset = 45

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.05

// Co-pilot variables
ENT.SpawnPassengerSeat = false


function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_mig29fulcrum" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	if( ply:IsAdmin() && type( ent.AdminArmament ) == "table" ) then
		
		ent:AddAdminEquipment()
		
	end
	
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
	 
	self.Armament = {
					/*Python 5 - Right Wing */
					{ 
						PrintName = "Python-5"		,		 					// print name, used by the interface
						Mdl = "models/hawx/weapons/python-5.mdl",  				// model, used when creating the object
						Pos = Vector( -134, -151, 57), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 45), 								// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						--isFirst	= true,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"
					}; 
					/*Python 5 - Left Wing */
					{ 
						PrintName = "Python-5"		,		 					// print name, used by the interface
						Mdl = "models/hawx/weapons/python-5.mdl",  				// model, used when creating the object
						Pos = Vector( -134, 151, 57), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 45), 								// Ang, object angle
						Type = "Homing", 										// Type, used when creating the object
						Cooldown = 10, 											// Cooldown between weapons
						isFirst	= false,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_a2a_rocket"
					}; 
					/* CBU-100 Clusterbomb - Right Wing */
					{ 
						PrintName = "CBU-100 Clusterbomb", 
						Mdl = "models/hawx/weapons/cbu-100 clusterbomb.mdl",	 
						Pos = Vector( -112, -124, 54 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Bomb",
						Cooldown = 15,
						--isFirst	= true,
						Class = "sent_mk82"
					}; 
					/* CBU-100 Clusterbomb - Right Wing */
					{ 
						PrintName = "CBU-100 Clusterbomb", 
						Mdl = "models/hawx/weapons/cbu-100 clusterbomb.mdl",	 
						Pos = Vector( -112, 124, 54 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Bomb",
						Cooldown = 15,
						isFirst	= false,
						Class = "sent_mk82"
					}; 
					{ 
						PrintName = "LAU-131a Rocket Pod", 
						Mdl = "models/hawx/weapons/lau-131 a.mdl",	 
						Pos = Vector( -85, -93, 51 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Pod",
						Cooldown = 10,
						--isFirst	= true,
						Class = "sent_a2s_dumb"
	
					};
					{ 
						PrintName = "LAU-131a Rocket Pod", 
						Mdl = "models/hawx/weapons/lau-131 a.mdl",	 
						Pos = Vector( -85, 93, 51 ), 
						Ang = Angle( 0, 0, 45), 
						Type = "Pod",
						Cooldown = 10,
						isFirst	= false,
						Class = "sent_a2s_dumb"
	
					};
				}
	
	self.AdminArmament = {
	
						{ // test
						PrintName = "LAU-131a Rocket Pod", 
						Mdl = "models/hawx/weapons/lau-131 a.mdl",	 
						Pos = Vector( 0, 0, 0 ), 
						Ang = Angle( 0, 0, 0 ), 
						Type = "Pod",
						Cooldown = 10,
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
		self.RocketVisuals[i]:SetPos( self:LocalToWorld( v.Pos ) )
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
	self.TrailPos[1] = Vector( -205, 220, 69 )
	self.TrailPos[2] = Vector( -205, -220, 69 )
	
	
	// Sound
	local esound = { "ambient/atmosphere/station_ambience_stereo_loop1.wav", "physics/cardboard/cardboard_box_scrape_smooth_loop1.wav", "ambient/levels/canals/dam_water_loop2.wav" }
	self.EngineMux = {}
	
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

	local o = self.MachineGunOffset
	self.Weapon = ents.Create("prop_physics_override")
	self.Weapon:SetModel( self.MachineGunModel )
	self.Weapon:SetPos( self:LocalToWorld( o ) )
	self.Weapon:SetAngles( self:GetAngles() )
	self.Weapon:SetSolid( SOLID_NONE )
	//self.Weapon:SetNoDraw( true )
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
	self:SetSkin( math.random( 0, 5 ) )
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
	
	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt( "health", self.HealthVal )
	
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then

		self.Burning = true
		
		for i=1,7 do
			
			local f = ents.Create("env_Fire_trail")
			f:SetPos( self:GetPos() + Vector( math.random(-24,24), math.random(-24,24), math.random(-24,24) ) )
			f:SetParent( self )
			f:Spawn()
		
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
	
		self:DeathFX()
	
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

	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 20 + 40 ),0,245 )

	for i = 1,3 do
	
		self.EngineMux[i]:ChangePitch( self.Pitch, 0.01 )
		
	end
	

	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + Vector( math.random(-50,50), math.random(-50,50), 0 ) )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if ( self.DeathTimer > 100 ) then
		
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
	
	self:Jet_FireHEIBullet()

	self.LastPrimaryAttack = CurTime()
	
end

function ENT:SecondaryAttack( wep, id )
	
	if ( IsValid( wep ) ) then
	
		self:NeuroPlanes_FireRobot( wep, id )
		
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )

	local a = self:GetAngles()
	local stallang = ( ( a.p < -20 || a.r > 20 || a.r < -20 ) && self:GetVelocity():Length() < 600 )
	
	if ( self.IsFlying && !stallang ) then
	
		phys:Wake()
		
		local p = { { Key = IN_FORWARD, Speed = 5 };
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
		local r,pitch,vel
		self.offs = self:VecAngD( ma.y, ta.y )		

		if( self.offs < -160 || self.offs > 160 ) then r = 0 else r = ( self.offs / self.BankingFactor ) * -1 end
		
		if ( IsValid( self.LaserGuided ) ) then
		
			pitch = 2.5
			vel = 35
			
		else
		
			pitch = pilotAng.p
			vel = self:GetVelocity():Length() / 40
		
		end
		
		vel = math.Clamp( vel, 10, 120 )
		
		// Increase speed going down, decrease it going up
		if( ma.p < -10 || ma.p > 10 && !self.AfterBurner ) then self.Speed = self.Speed + ma.p/5 end
		
		local pr = {}
		pr.secondstoarrive	= 1
		pr.pos 				= self:GetPos() + self:GetForward() * self.Speed + Vector( 0,0, -800 + ( self:GetVelocity():Length() / 3.5 ) )
		pr.maxangular		= 164 - vel
		pr.maxangulardamp	= 265 - vel
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.95
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = Angle( pitch, pilotAng.y, pilotAng.r ) + Angle( 0, 0, r )
		
		phys:ComputeShadowControl( pr )
			
		self:WingTrails( ma.r, 15 )
		
	end
	
end
