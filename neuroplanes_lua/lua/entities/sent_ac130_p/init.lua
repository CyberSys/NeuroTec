AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.PrintName	= "AC-130 \"Spectre\""
ENT.Model = "models/military2/air/air_130.mdl"
--Speed Limits
ENT.MaxVelocity = 1500
ENT.MinVelocity = 0

-- How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 4 for larger stuff.
ENT.BankingFactor = 6.4

ENT.InitialHealth = 25000
ENT.HealthVal = nil

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

-- Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 0.5
ENT.MaxFlares = 1

-- Equipment
ENT.CrosshairOffset = 0

local filter = {
					"sent_ac130_105mm_shell",
					"sent_ac130_40mm_shell",
					"sent_ac130_20mm_shell",
					"sent_ac130_howitzer",
					"sent_ac130_vulcan",
					"sent_ac130_gau12a",
					"env_rockettrail",
					"weapon_rpg",
					"prop_vehicle_prisoner_pod"
				}
				
function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( "sent_ac130_p" )
	ent:SetPos( SpawnPos )
	-- ent:SetAngles( ply:GetAngles() )
	ent:Spawn()
	ent:Activate()
	
	if( ply:IsAdmin() ) then
	
		ent:SetColor( Color( 109,109,109,255 ) )
		
	end
	
	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	
	self:SetNetworkedInt( "health",self.HealthVal)
	self:SetNetworkedInt( "HudOffset", self.CrosshairOffset )
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self:SetNetworkedInt( "MaxSpeed",self.MaxVelocity)
	self.seed = math.random( 0, 1000 )
	self.LastPrimaryAttack = CurTime()
	self.LastSecondaryAttack = CurTime()
	self.LastFireModeChange = CurTime()
	self.LastRadarScan = CurTime()
	self.LastFlare = CurTime()
	self.LastLaserUpdate = CurTime()
	self.LastDoor = CurTime()
	self.LastUse = 0
	self.LastGuardianCall = 0
	self.AutoPilot = false
	self.LastAutoPilotToggle = CurTime()
	
	self.Guardians = {}
	
	self.DoorAng = 100
	self.DoorOpen = true
	self.DoorToggle = true
	
	local cname = {}
	cname[1] 	= "M102 Howitzer 105mm"
	cname[2] 	= "Bofors 40mm"
	cname[3] 	= "GAU-2/A 7.62mm"

	local cpos  = {}
	cpos[1] 	= Vector( -242, 100, 40) -- 1× 105 mm M102 howitzer, Left
	cpos[2] 	= Vector( -135, 110, 61) -- Vulcan 20mm rear, Left
	cpos[3] 	= Vector( 186, 80, 70 ) --  Gatling gun front, Left

	-- Weapon Angle
	local cang  = {}
	cang[1] 	= Angle(5,90,0)
	cang[2] 	= Angle(5,90,0)
	cang[3] 	= Angle(5,90,0)

	-- Cooldown in seconds
	local cd  	= {}
	cd[1] 		= 3.5
	cd[2] 		= 0.5
	cd[3] 		= 0.08
	
	local autofire = {}
	autofire[1] = false
	autofire[2] = false
	autofire[3] = true
	
	local cmdl = {}
	cmdl[1] = "models/ac-130/howitzer.mdl"
	cmdl[2] = "models/ac-130/bofors.mdl"
	cmdl[3] = "models/ac-130/Gatling.mdl"
	
	self.Cannons = {}
	
	for i=1, #cname do
		
		self.Cannons[i] = ents.Create( "prop_physics_override" )
		self.Cannons[i]:SetPos( self:GetPos() + cpos[ i ] )
		self.Cannons[i]:SetAngles( self:GetAngles() + cang[ i ] )
		self.Cannons[i]:SetSolid( SOLID_NONE )
		self.Cannons[i]:SetModel( cmdl[i] )
		self.Cannons[i]:Spawn()
		self.Cannons[i]:SetParent( self )
		self.Cannons[i]:SetOwner( self )
		self.Cannons[i]:SetPhysicsAttacker( self )
		self.Cannons[i].Cooldown = cd[ i ]
		self.Cannons[i].PrintName = cname[ i ]
		self.Cannons[i].AutoFire = autofire[i]
		self.Cannons[i].LastAttack = CurTime()
		--self.Cannons[i].CallBack = function() end
		--self.Cannons[i]:GetPhysicsObject():SetMass( 5 )
		
		if( i == 1 ) then
		
			self.Cannons[i]:SetMaterial("models/props_pipes/GutterMetal01a")
			self.Cannons[i]:SetColor( Color( 0, 94, 8, 255 ) )
		
		end
		
	end

	local gunnerseats = {}
	local gunnerangles = {}

	gunnerseats[1] = Vector( -245, 97, 35 )
	gunnerseats[2] = Vector( -135, 79, 42 )
	gunnerseats[3] = Vector( 183, 72, 45 )

	gunnerangles[1] = Angle( 45, 90, 0 )
	gunnerangles[2] = Angle( 45, 90, 0 )
	gunnerangles[3] = Angle( 45, 90, 0 )
	
	local vFov = {}
	vFov[1] = 55
	vFov[2] = 65
	vFov[3] = 70
	
	self.GunnerSeats = {}
	
	for i=1,#gunnerseats do
		
		self.GunnerSeats[i] = ents.Create( "prop_vehicle_prisoner_pod" )
		self.GunnerSeats[i]:SetPos( self:LocalToWorld( gunnerseats[i] ) )
		self.GunnerSeats[i]:SetModel( "models/vehicles/prisoner_pod_inner.mdl" )
		self.GunnerSeats[i]:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		self.GunnerSeats[i]:SetKeyValue( "LimitView", "60" )
		self.GunnerSeats[i]:SetAngles( self:GetAngles() + gunnerangles[i] )
		self.GunnerSeats[i]:SetParent( self )
		self.GunnerSeats[i].MountedWeapon = self.Cannons[i]
		self.GunnerSeats[i]:Spawn() 
		self.GunnerSeats[i]:SetNoDraw( true )
		self.GunnerSeats[i].IsAC130GunnerSeat = true
		self.GunnerSeats[i].FOV = vFov[i]
		
	end
	
	self.prop = {}
	local pos = {}
	pos[1] = self:GetPos() + self:GetRight() * 400 + self:GetForward() * 100 + self:GetUp() * 150
	pos[2] = self:GetPos() + self:GetRight() * 190 + self:GetForward() * 100 + self:GetUp() * 150
	pos[3] = self:GetPos() + self:GetRight() * -190 + self:GetForward() * 100 + self:GetUp() * 150
	pos[4] = self:GetPos() + self:GetRight() * -400 + self:GetForward() * 100 + self:GetUp() * 150
	
	for i = 1, #pos do
		
		self.prop[i] = ents.Create("sent_ac130_rotor")
		self.prop[i]:SetAngles( self:GetAngles() )
		self.prop[i]:SetPos(pos[i])
		self.prop[i]:SetSolid( SOLID_NONE )
		self.prop[i]:SetParent( self )
		self.prop[i]:Spawn()
		
	end
	 
	self.Trails = {}
	self.TrailPos = {}
	self.TrailPos[1] = Vector( -50, -797, 183 )
	self.TrailPos[2] = Vector( -50, 797, 183 )
	
	-- Sound
	local esound = { "npc/manhack/mh_engine_loop1.wav", "npc/manhack/mh_engine_loop2.wav" }
	self.EngineMux = {}
	
	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	self.Pitch = 0
	self.EngineMux[1]:PlayEx( 500 , self.Pitch )
	self.EngineMux[2]:PlayEx( 500 , self.Pitch )

	self:SetUseType( SIMPLE_USE )
	self.IsFlying = false
	self.Pilot = NULL
	
	for i=1,8 do
		
		local seat = ents.Create("prop_vehicle_prisoner_pod")
		seat:SetPos( self:LocalToWorld( Vector( 200 - ( i * 40 ), -60, 54 ) ) )
		seat:SetModel( "models/nova/chair_plastic01.mdl" )
		seat:SetKeyValue( "vehiclescript", "scripts/vehicles/prisoner_pod.txt" )
		seat:SetKeyValue( "LimitView", "60" )
		seat:SetAngles( self:GetAngles() )
		seat:SetParent( self )
		seat:Spawn()
		seat:Fire("unlock","",0)
	
	end
	
	self.DoorOrigin = self:GetForward() * -271 + self:GetRight() * 55 + self:GetUp() * 54  
	self.DoorPos = self:GetForward() * -366 + self:GetUp() * 53   

	self.DoorAxis = ents.Create("prop_physics_override")
	self.DoorAxis:SetModel( "models/props_c17/signpole001.mdl" )
	self.DoorAxis:SetPos( self:GetPos() + self.DoorOrigin )
	self.DoorAxis:SetAngles( self:GetAngles() )
	self.DoorAxis:SetParent( self )
	self.DoorAxis:Spawn()

	self.Door = ents.Create("prop_physics_override")
	self.Door:SetModel( "models/props_phx/construct/plastic/plastic_panel2x4.mdl" )
	self.Door:SetPos( self:GetPos() + self.DoorPos  )
	self.Door:SetAngles( self:GetAngles() )
	self.Door:SetParent( self.DoorAxis )
	self.Door:SetMaterial( "phoenix_storms/metalSet_1-2" )
	self.Door:Spawn()

	self.FakeDoor = ents.Create("prop_physics_override")
	self.FakeDoor:SetModel( "models/props_phx/construct/plastic/plastic_panel2x4.mdl" )
	self.FakeDoor:SetPos( self.Door:GetPos()   )
	self.FakeDoor:SetNoDraw( true )
	self.FakeDoor:SetAngles( self.Door:GetAngles() )
	self.FakeDoor:Spawn()
	self.FakeDoorObj = self.FakeDoor:GetPhysicsObject()
	
	if ( self.FakeDoorObj:IsValid() ) then	
	
		self.FakeDoorObj:Wake()
		self.FakeDoorObj:SetMass( 50 )		
		self.FakeDoorObj:EnableGravity( false )
		self.FakeDoorObj:EnableCollisions( true )
		
	end

	-- Misc
	self:SetModel( self.Model )	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 90000 )
		
	end

	self.FakeDoor:SetSolid( SOLID_NONE )
	self.FakeDoorWeld = constraint.Weld( self.FakeDoor, self, 0,0,0,true )
	
	self.LastAttacked = CurTime()
	
	self:StartMotionController()

end

function ENT:PlayWorldSound(snd)

	for k, v in pairs( player.GetAll() ) do
		
		local tr,trace = {}, {}
		tr.start = self:GetPos() + self:GetUp() * -512
		tr.endpos = v:GetPos()
		tr.mask = MASK_SOLID
		tr.filter = self
		trace = util.TraceLine( tr )
	
		if ( trace.HitNonWorld ) then
		
			local norm = ( self:GetPos() - v:GetPos() ):Normalize()
			local d = self:GetPos():Distance( v:GetPos() )
			
			if ( DEBUG ) then
			
				debugoverlay.Cross( v:GetPos() + norm * ( d / 10 ), 32, 0.1, Color( 255,255,255,255 ), false )
			
			end
			
			if( d > 4500 ) then
				
				WorldSound( snd, v:GetPos() + norm * ( d / 10 ), 211, 100   ) -- Crappy Sauce Engine can't handle a couple of hundred meters of sound. Hackfix for doppler effect.
			
			else
			
				self:EmitSound( snd, 211, 100 )
			
			end
			
		end
		
	
	end

end

function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed ) then
		
		return

	end

	//print( "Taking damage from ", dmginfo:GetInflictor():GetClass() )
	
	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt("health",self.HealthVal)
	
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then
	
		self.Burning = true
		self:EmitSound( "lockon/launchWarning.mp3", 511, 100 )
		
	end
	
	if ( self.HealthVal < 0 ) then
		
		self.HealthVal = 0
		
		self.Destroyed = true
		self.PhysObj:EnableGravity(true)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:SetMass(2000)
		self:Ignite(60,100)
		
	end
	
	for i=1,#self.GunnerSeats do
		
		local s = self.GunnerSeats[i]:GetDriver()
		
		if ( IsValid( s ) ) then
			
			s:SetHealth( self.HealthVal )
			
		end
		
	end
		
	for i=1,2 do
		
		if( IsValid( self.Guardians[i] ) ) then
	
			if( self.Guardians[i].Target == self ) then
				
				//print( "AC130 is the target" )
				
				if( dmginfo:GetInflictor().HealthVal || dmginfo:GetInflictor():IsPlayer() || dmginfo:GetInflictor():IsNPC() ) then
						
					//print("Passed first logic" )
					
					self.LastAttacker = dmginfo:GetInflictor()
					
				elseif( IsValid( dmginfo:GetInflictor().Owner ) ) then
					
					//print( "Second logic" )
					self.LastAttacker = dmginfo:GetInflictor().Owner
					
				end
			
			//print( self.LastAttacker, self.Guardians[i].Target )
			end
				
			self.Guardians[i].Target = self.LastAttacker 
	
		end
		
		self.LastAttacked = CurTime()
		
	
	end
	//print( self.LastAttacker )

	
end

function ENT:OnRemove()
	
	for i=1,2 do
		
		if( IsValid( self.Guardians[i] ) ) then
			
			self.Guardians[i]:DeathFX()
			
		end
	
	end
	
	for i=1,#self.EngineMux do
	
		self.EngineMux[i]:Stop()
		
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilot()
	
	end
	
	if ( IsValid( self.DoorAxis ) ) then
	
		self.DoorAxis:Remove()
	
	end
	if ( IsValid( self.Door ) ) then
	
		self.Door:Remove()
	
	end
	if ( IsValid( self.FakeDoor ) ) then
	
		self.FakeDoor:Remove()
	
	end
	
	for i=1,#self.GunnerSeats do
		
		local s = self.GunnerSeats[i]:GetDriver()
		
		if ( s && IsValid( s ) ) then
			
			s:ExitVehicle()

		end
		
	end
	
end

function ENT:PhysicsCollide( data, physobj )

	if ( data.Speed > self.MaxVelocity * 0.45 && data.DeltaTime > 0.2 ) then 
		
		self.HealthVal = self.HealthVal -math.random(400,510)
		self:SetNetworkedInt("health",self.HealthVal)
		
	end
	
end

function ENT:Use(ply,caller)
	
	if ( self.LastUse + 1.0 > CurTime() ) then
		
		return
		
	end
	
	self.LastUse = CurTime()
	
	if( IsValid( self.LastPilot ) && !IsValid( self.Pilot ) && ply != self.LastPilot ) then
		
		self.LastPilot = NULL
		self.AutoPilot = false
		
	end
	
	if( ply == self.LastPilot ) then
		
		self.Speed = self.MaxVelocity
	
	end
	
	if( ply == self.Pilot ) then
		
		self:EjectPilot()
		
		return
	
	end
	
	if ( !self.IsFlying && !IsValid( self.Pilot ) ) then 

		self:GetPhysicsObject():Wake()
		self:GetPhysicsObject():EnableMotion(true)
		self.IsFlying = true
		self.Pilot = ply
		self.Owner = ply
		
		ply:Spectate( OBS_MODE_CHASE  )
		ply:DrawViewModel( false )
		ply:DrawWorldModel( false )
		ply:StripWeapons()
		ply:SetScriptedVehicle( self )
		
		ply:SetNetworkedBool("InFlight",true)
		ply:SetNetworkedEntity( "Plane", self ) 
		self:SetNetworkedEntity("Pilot", ply )
	
	else 

		self:EnterGunnerSeats( ply )

	end
	
end

function ENT:EnterGunnerSeats( ply )

	for i=1,#self.GunnerSeats do
		
		local s = self.GunnerSeats[i]:GetDriver()
		if ( !IsValid( s ) ) then
			
			if( IsValid( self.Pilot ) ) then
				
				self.Pilot:PrintMessage( HUD_PRINTCENTER, ply:Name().." joined the party!" )
				
			end
			
			ply:EnterVehicle( self.GunnerSeats[i] )
			ply.OriginalFOV = ply:GetFOV()
			ply:SetFOV( self.GunnerSeats[i].FOV, 0.15 )
			ply:SetNetworkedBool( "NeuroPlanes__DrawAC130Overlay",true )
			ply:SetNetworkedEntity( "NeuroPlanesMountedGun", self.GunnerSeats[i].MountedWeapon )
			ply:SetNetworkedEntity( "NeuroPlanesAC130", self )
			ply:DrawWorldModel( false )
			ply:SetNoDraw( true )
			ply:PrintMessage( HUD_PRINTCENTER, self.Cannons[i].PrintName )
			ply.LastSwap = CurTime()
			ply:SetHealth( self.HealthVal )
			
			break
			
		end
	
	end
		
end

function ENT:Think()

	constraint.RemoveConstraints( self, "Weld" )
	self.FakeDoor:SetPos( self.Door:GetPos() )
	self.FakeDoor:SetAngles( self.Door:GetAngles() )
	self.FakeDoor:SetSolid( SOLID_VPHYSICS )
	self.FakeDoorWeld = constraint.Weld( self.FakeDoor, self, 0,0,0,true )

	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 60 + 100 ),0,180 )

	for i = 1,#self.EngineMux do
	
		self.EngineMux[i]:ChangePitch( self.Pitch, 0.01 )
		
	end
	
	--print( self:GetVelocity():Length() )
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		
		if self.DeathTimer > 435 then
		
			self:StopSound( "lockon/launchWarning.mp3" )
			-- self:EjectPilotSpecial()
			self:DeathFX()
			
			return
			
		end
		
	end
	
	if( IsValid( self.LastPilot ) && self.LastPilot:GetPos():Distance( self:GetPos() ) > 4000 ) then
		
		self.LastPilot = NULL
		
		return
		
	end
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 500 )
		
		-- HUD Stuff
		self:UpdateRadar()
		
		if( self.Pilot:KeyDown( IN_SPEED )			 && 
			self.Speed > self.MaxVelocity * 0.8		 && 
			!IsValid( self.Guardians[1] )		 && 
			!IsValid( self.Guardians[2] )		 && 
			self.LastGuardianCall + 30 <= CurTime()		 ) then
			
			self.LastGuardianCall = CurTime()
			
			self.Pilot:PrintMessage( HUD_PRINTCENTER, "Friendly F-16C Fighting Falcon Inbound to your assistance" )
			self.Pilot:PrintMessage( HUD_PRINTTALK, "(Radio)Friendly F-16C Fighting Falcon Inbound to your assistance." )
			self:EmitSound( "lockon/voices/copyRejoin.mp3", 511, 100 )
			
			local d = -1
			
			for i=1,2 do
				
				if( i>1 ) then d = 1 end
				
				self.Guardians[i] = ents.Create("npc_ac130_guardian_f16")
				self.Guardians[i]:SetPos( self:GetPos() + self:GetForward() * -3000 + self:GetRight()*d*4300 )
				self.Guardians[i]:SetAngles( self:GetAngles() )
				self.Guardians[i]:Spawn()
				self.Guardians[i].Owner = self
				self.Guardians[i].CycleTarget = self
				self.Guardians[i].Target = self
				self.Guardians[i]:SetNetworkedEntity( "Guardian_Object", self.Pilot )
				
				
			end
			
			return 
			
		end
		
		-- Auto-pilot 
		if( IsValid( self.Pilot ) && self.Pilot:KeyDown( IN_WALK ) && self.LastAutoPilotToggle <= CurTime() ) then
			
			self.AutoPilot = true
			self.LastAutoPilotToggle = CurTime() + 1.0
			self.AutoPilotYawDirection = self:GetPhysicsObject():GetAngles().y
			
			self.LastPilot = self.Pilot
			
			self.LastPilot:PrintMessage( HUD_PRINTCENTER, "Auto-Pilot ON" )
			self:EjectPilot()
			local c = 0
			
			for i=1,#self.GunnerSeats do
				
				local d = self.GunnerSeats[i]:GetDriver()
				if( !IsValid( d ) ) then
					
					self:EnterGunnerSeats( self.LastPilot )
					
					return
					
				else
					
					
					c = c + 1
				
				end
				
			end
			
			if( c == #self.GunnerSeats ) then
				
				self.LastPilot:SetPos( self:LocalToWorld( Vector( 60, 0, 53 ) ) )
				
			end
			
		end
		
		-- Flares
		if ( self.Pilot:KeyDown( IN_JUMP ) && self.LastFlare + self.FlareCooldown <= CurTime() ) then
			
			self:ShootFlares()
			
		end
	
		
		if ( self.Pilot:KeyDown( IN_USE ) && self.LastUse + 0.25 <= CurTime() ) then
			
			local p  = self.Pilot
			self.LastUse = CurTime()
			self:EjectPilot()
			p:SetPos( self:LocalToWorld( Vector( 60, 0, 53 ) ) )
			
		end	

		---- Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
			self:EjectPilot()
			
			return
			
		end
	
		if (!IsValid( self.Pilot ) ) then return end
		
		-- Let's drop some vehicles! by StarChick ;D
		if ( self.Pilot:KeyDown( IN_DUCK ) and self.LastDoor + 0.25 <= CurTime() ) then		
			self.FakeDoor:SetSolid( SOLID_NONE )
			self:EmitSound("lockon/TurretRotation.mp3",511,100)
		
//			self.DoorObj:SetMass(100)		
//			self.DoorAxisObj:SetMass(500)		
		
			//Toggle system :D
			if self.DoorToggle == false then
			self.DoorToggle = true 	
			else
				if self.DoorToggle == true then
				self.DoorToggle = false
				end
			end		

		self.LastDoor = CurTime()
		end
	

		
		if ( self.DoorToggle ) then		
			
			self.DoorAng = self.DoorAng + 2.5
	
			if ( self.DoorAng >= 100 ) then
				
				self.DoorAng = 100
				self:StopSound( "lockon/TurretRotation.mp3" )
				self.FakeDoorObj:SetMass(10)		

			end
			
		end
	
		if ( !self.DoorToggle ) then	
		
			self.DoorAng = self.DoorAng - 3

			if ( self.DoorAng < -80 ) then 
			
				self.DoorAng = -80
				self:StopSound( "lockon/TurretRotation.mp3" )
				self.FakeDoorObj:SetMass( 50 )		
	
			end

		end
			

		self.DoorAxis:SetLocalAngles( Angle( 0.2 * self.DoorAng, 0, 0 ) )

	end
	
	if( IsValid( self.LastPilot ) && self.LastPilot:KeyDown( IN_WALK ) && self.LastAutoPilotToggle <= CurTime() ) then
			
			self.AutoPilot = false
			self.LastAutoPilotToggle = CurTime() + 4
			self.LastPilot:ExitVehicle()
			self:Use( self.LastPilot, self.LastPilot, 0, 0 )
			
			self.LastPilot = NULL
			
			
	end
	
	-- Gunners
	for i=1,#self.GunnerSeats do
	
		if ( !IsValid( self.Cannons[i] ) ) then print( "invalid entity: Cannon#"..i ) return end
		
		local g = self.GunnerSeats[i]:GetDriver()
		
		if ( IsValid( g ) ) then
			
			
			if( g:KeyDown( IN_JUMP ) && !IsValid( self.LastPilot ) && !IsValid( self.Pilot ) ) then
				
				g:ExitVehicle()
				self:Use( g, g )
				
				return
				
			end
			
			if( self.Cannons[i].AutoFire && g:KeyDown( IN_ATTACK ) ) then
				
				local a = self.Cannons[i]:GetAngles()
				local ga = g:EyeAngles()
				
				self.Cannons[i]:SetAngles( Angle( ga.p,ga.y,a.r + 5.5 ) )
			
			else
			
				self.Cannons[i]:SetAngles( LerpAngle( 0.1, self.Cannons[i]:GetAngles(), g:EyeAngles() ) )
			
			end
			
			--print( self.Cannons[i].LastAttack, self.Cannons[i].Cooldown )
			
			if ( ( g:KeyDown( IN_ATTACK ) ||  g:KeyDown( IN_ATTACK2 ) ) && self.Cannons[i].LastAttack + self.Cannons[i].Cooldown <= CurTime() ) then
				
				self.Cannons[i].LastAttack = CurTime()
				
				if ( self.Cannons[i].AutoFire == true ) then
						
					self:FireTurret( self.Cannons[i], g )
					
				else
					
					self:FireHowitzer( self.Cannons[i], g )
					
					--self.Cannons[i]:SetAngles( self.Cannons[i]:GetAngles() + Angle( math.Rand(-.5,.5), math.Rand(-.5,.5), math.Rand(-.5,.5) ) )
					
				end
				
			end
			
	
			if( g:KeyDown( IN_RELOAD ) && g.LastSwap + 2.0 <= CurTime() ) then
				
				local a = self.GunnerSeats[i+1]
				if( !IsValid( a ) ) then
				
					a = self.GunnerSeats[1]
					print( "i+1 not valid")
					
				end
				
				if( !IsValid( a:GetDriver() ) ) then
					print("no driver found")
					
					g.LastSwap = CurTime()
					
					local p = g
					
					g:ExitVehicle()
					
					p:EnterVehicle( a )
					
					p.OriginalFOV = p:GetFOV()
					p:SetFOV( a.FOV, 0.15 )
					p:SetNetworkedBool( "NeuroPlanes__DrawAC130Overlay",true )
					p:SetNetworkedEntity( "NeuroPlanesMountedGun", a.MountedWeapon )
					p:SetNetworkedEntity( "NeuroPlanesAC130", self )
					p:DrawWorldModel( false )
					p:SetNoDraw( true )
					p:PrintMessage( HUD_PRINTCENTER, a.MountedWeapon.PrintName )
					
				end
				
			end
		
		end

	end
	
	self:GuardianLogic()

	self:NextThink( CurTime() )
	
	return true
	
end

function ENT:ShootFlares()

	local validTargets = {}
	local i = 0
	
	for k,v in pairs( ents.GetAll() ) do
	
		if ( v:GetPos():Distance( self:GetPos() ) < 7000 && !table.HasValue( filter, v:GetClass() ) && v:GetOwner() != self && v.Flared != true ) then
			
			if( string.find( v:GetClass(), "missile") 		 != nil || 
				string.find( v:GetClass(), "rocket" ) 		 != nil || 
				string.find( v:GetClass(), "homing" )		 != nil || 
				string.find( v:GetClass(), "heatseaking" )	 != nil || 
				string.find( v:GetClass(), "stinger" ) 		 != nil ) then
				
				i = i + 1
				validTargets[i] = v

			end
			
		end
		
	end

	self:SpawnFlareSpecial( 1, validTargets, i )
	self:SpawnFlareSpecial( 2, validTargets, i )
	self:SpawnFlareSpecial( 3, validTargets, i )
	self:EmitSound( "lockon/flare.mp3",511,100 )

	self.LastFlare = CurTime() 
			
end


function ENT:GuardianLogic()

	for i=1,#self.Guardians do
		
		if( IsValid( self.Guardians[i] ) ) then
			
			self.Guardians[i].CycleOffset = self:GetPos() + self:GetRight() * ( -4000 + ( 4000 * i ) )
			
			if( self.Guardians[i].Target == self ) then
				
				if( IsValid( self.LastAttacker ) ) then
					
					self.Guardians[i].Target = self.LastAttacker
					
				end
				
				self.Guardians[i].Speed = self.Speed - 100
			
			end
			
		
			if( IsValid( self.LastAttacker ) ) then	
				
				if( self.LastAttacked + 15 <= CurTime() && IsValid( self.LastAttacker ) ) then
						
					self.LastAttacker = NULL
					self.Guardians[i].Target = self
					
				end
				
				if( IsValid( self.Guardians[i].Target ) && self:GetPos():Distance( self.Guardians[i].Target:GetPos() ) > 15000 ) then	
					
					self.Guardians[i].Target = self
					
				end
			
			elseif( !IsValid( self.LastAttacker ) ) then
				
				if( IsValid( self.Target ) ) then
					
					self.Guardians[i].Target = self.Target
					
				else
				
					self.Guardians[i].Target = self
					
				end
			
			end
			
		end
		
	end
		
end


function ENT:FireHowitzer( obj, plr )
	
	local shellmod = "sent_ac130_105mm_shell"
	local boomsound = "ac-130/ac-130_105mm_Fire.wav"
	local muzzle = "arty_muzzleflash"
	
	if( obj == self.Cannons[2] ) then
		
		shellmod = "sent_ac130_40mm_shell"
		boomsound = "ac-130/ac-130_40mm_Fire.wav"
		muzzle = "tank_muzzleflash"
		
	else
		
		timer.Simple( 0.5, function() if( IsValid( self.Cannons[1] ) ) then self.Cannons[1]:EmitSound( "T-90_reload.wav", 511, 100 ) end end )
	
	end
	
	self:PlayWorldSound( boomsound )
	
	local shell = ents.Create( shellmod )
	shell:SetPos( obj:GetPos() + obj:GetForward() * 185 )
	shell:SetAngles( obj:GetAngles() )
	shell:SetOwner( plr )
	shell:SetPhysicsAttacker( plr )
	shell:Spawn()
	shell:Activate()
	shell:GetPhysicsObject():ApplyForceCenter( shell:GetForward() * 5000 )
	shell:EmitSound( boomsound, 511, 100 )
	
	ParticleEffect( muzzle, shell:GetPos(), shell:GetAngles() + Angle( 0, 0, 0 ), nil )


end

function ENT:FireTurret( _ent, gunner )

	if ( !_ent ) then
		
		return
		
	end
	
	local sm = EffectData()
	sm:SetStart( _ent:GetPos() )
	sm:SetOrigin( _ent:GetPos() )
	sm:SetScale( 10.5 )
	util.Effect( "a10_muzzlesmoke", sm )
	ParticleEffect( "AA_muzzleflash", _ent:GetPos() + _ent:GetForward() * 90,  _ent:GetAngles(), self )
	
 	local bullet = {} 
 	bullet.Num 		= 2
 	bullet.Src 		= _ent:GetPos() + _ent:GetForward() * 200 + _ent:GetRight() * math.random(-1,1) + _ent:GetUp() * math.random(-1,1)-- Source 
 	bullet.Dir 		= _ent:GetAngles():Forward()			-- Dir of bullet 
 	bullet.Spread 	= Vector( .05, .05, .05 )						-- Aim Cone 
 	bullet.Tracer	= math.random( 1, 4 )					-- Show a tracer on every x bullets  
 	bullet.Force	= 5					 					-- Amount of force to give to phys objects 
 	bullet.Damage	= math.random( 45, 65 )
 	bullet.AmmoType = "Ar2" 
 	bullet.TracerName 	= "AirboatGunHeavyTracer" 
 	bullet.Callback    = function ( a, b, c ) self:TurretCallback( a, b, c ) end 
 	
	gunner:FireBullets( bullet ) 
	
	_ent:EmitSound( "A10fart.mp3", 511, math.random( 65, 71 ) )
	
end

function ENT:TurretCallback( a, b, c )

	if ( IsValid( self.Pilot ) ) then
	
		if( math.random( 0,1 ) > 0 ) then
		
			local e = EffectData()
			e:SetOrigin(b.HitPos)
			e:SetNormal(b.HitNormal)
			e:SetScale( 4.5 )
			util.Effect("HelicopterMegaBomb", e)
				
			local e = EffectData()
			e:SetOrigin(b.HitPos)
			e:SetNormal(b.HitNormal)
			e:SetScale( 4.5 )
			util.Effect("Launch2", e)
			
			e = EffectData()
			e:SetOrigin(b.HitPos)
			e:SetNormal(b.HitNormal)
			e:SetScale( 4.5 )
			util.Effect("ManhackSparks", e)
		
		end
	
		util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 100, math.random( 12, 26 ) )
		
	end
	
	return { damage = true, effects = DoDefaultEffect } 	
	
end

function ENT:SpawnFlareSpecial(direction, _ents, i)
	
	local dir = {}
	dir[1] = self:GetPos() + self:GetRight() * math.random(12000,20000) + self:GetUp() * 6000
	dir[2] = self:GetPos() + self:GetRight() * math.random(-20000,-12000) + self:GetUp() * 6000
	dir[3] = self:GetPos() + self:GetUp() * -200
	
	local d = dir[direction]
	
	-- local fx = EffectData()
	-- fx:SetOrigin( self:GetPos() + self:GetRight() * ( math.sin( CurTime() - self.seed ) * 100 ) + self:GetUp() * math.random( -50, -10 ) )
	-- fx:SetScale( 3.0 )
	-- util.Effect( "HelicopterMegaBomb", fx ) 
	
	-- local fx = EffectData()
	-- fx:SetOrigin( self:GetPos() + self:GetRight() * ( math.sin( CurTime() - self.seed ) * 100 ) + self:GetUp() * math.random( -50, -10 ) )
	-- fx:SetScale( 3.0 )
	-- util.Effect( "AngelWings", fx ) 

	local f = ents.Create( "nn_flare" )
	f:SetPos( self:GetPos() + self:GetUp() * -1 + self:GetForward() * -400 )
	f:Spawn()
	f:GetPhysicsObject():ApplyForceCenter( d + self:GetForward() * -5000 )
	f:Fire( "kill","", 4.5 )
	f:SetVelocity( self.PhysObj:GetVelocity() )
	
	local num = #_ents
	
	if ( i > 4 ) then
		
		for j = 1, num do
		 
			if ( IsValid( _ents[j] ) ) then
			
				if ( math.random( 1, 5 ) > 4 ) then
				
					_ents[j]:ExplosionImproved()
					_ents[j]:Remove()
					
				else
				
					_ents[j].Target = nil
					_ents[j].Flared = true
					
				end
			
			end
			
		end
	
	end

end

function ENT:PhysicsSimulate( phys, deltatime )
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
	
		phys:Wake()
		
		local keys = {  { Key = IN_FORWARD,  Speed = 3.4 	};
						{ Key = IN_BACK,	 Speed = -1.25  }; } -- slow ass breaking for heavy and slow ass plane.
					
		for k,v in ipairs( keys ) do -- numeric stuff, ipairs is supposedly faster.
			
			if ( self.Pilot:KeyDown( v.Key ) ) then
			
				self.Speed = self.Speed + v.Speed
			
			end
			
		end

	
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 5000 + self:GetUp() * -self.CrosshairOffset -- This is the point the plane is chasing.
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
		
		pitch = pilotAng.p
		drag = -300 + mvel / 6
		local maxang
		
		if( mvel < 50 ) then
		
			maxang = 2
			
		else
			
			maxang = 17
			
		end
		
		-- Increase speed going down, decrease it going up
		if( ma.p < -25 || ma.p > 12 ) then 	
			
			self.Speed = self.Speed + ma.p/6
			
		end
		
		self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
	
		
		local pr = {}
		pr.secondstoarrive	= 1
		pr.pos 				= self:GetPos() + self:GetForward() * self.Speed + Vector( 0,0,1 ) * drag
		pr.maxangular		= maxang
		pr.maxangulardamp	= maxang
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.8
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = Angle( pitch, pilotAng.y, pilotAng.r ) + Angle( 0, 0, r )
		
		--// Cruise control baby
		-- if( self.Pilot:KeyDown( IN_WALK ) && self.Speed > self.MaxVelocity * 0.5 ) then
			
			-- pr.angle = Angle( math.sin(CurTime()*self:EntIndex()), phys:GetAngles().y + 8.6, -15 )
		
		-- end

		phys:ComputeShadowControl(pr)
			
		self:WingTrails( ma.r, 20 )
		
	end
	
	if( self.AutoPilot ) then 
		
		local dir = 1
		-- if( self.AutoPilotYawDirection >= 0 ) then dir = 1 end
		
		local pr = {}
		pr.secondstoarrive	= 1
		pr.pos 				= self:GetPos() + self:GetForward() * ( self.MaxVelocity * 0.65 )
		pr.maxangular		= 17
		pr.maxangulardamp	= 17
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.8
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = Angle( math.sin(CurTime()*self:EntIndex()), phys:GetAngles().y + ( 9.6 * dir ), -15 )
		
		phys:ComputeShadowControl(pr)
			
		self:WingTrails( self:GetAngles().r, 20 )
	
	end
	
end
