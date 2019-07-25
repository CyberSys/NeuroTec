AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Model = "models/neuroplanes/c-47 skytrain.mdl"
--Speed Limits
ENT.MaxVelocity = 1050
ENT.MinVelocity = 0

-- How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 4 for larger stuff.
ENT.BankingFactor = 4.8

ENT.InitialHealth = 8500
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
ENT.FlareCooldown = 15
ENT.FlareCount = 8
ENT.MaxFlares = 8

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
					"weapon_rpg"
				}
				
function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 150
	local ent = ents.Create( "sent_aC-47_Skytrain_p" )
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
	
	self.seed = math.random( 0, 1000 )
	self.PrimaryCooldown = 99999999999
	self.LastPrimaryAttack = CurTime()
	self.LastSecondaryAttack = CurTime()
	self.LastFireModeChange = CurTime()
	self.LastRadarScan = CurTime()
	self.LastFlare = CurTime()
	self.LastLaserUpdate = CurTime()

	self.LastUse = 0

	
	self.Armament = {
						{ 
							PrintName = "Napalm #1", 
							Mdl = "models/military2/bomb/bomb_mk82s.mdl",	 
							Pos = Vector( -5, 0, -74 ), 
							Ang = Angle( 45, 0, -10 ), 
							Type = "Bomb",
							Cooldown = 10,
							isFirst	= nil,
							Class = "sent_napalm_bomb",
						}; 
						{ 
							PrintName = "Napalm #2", 
							Mdl = "models/military2/bomb/bomb_mk82s.mdl",	 
							Pos = Vector( -5, 0, -74 ), 
							Ang = Angle( 45, 0, 0 ), 
							Type = "Bomb",
							Cooldown = 10,
							isFirst	= nil,
							Class = "sent_napalm_bomb",
						}; 
						{ 
							PrintName = "Napalm #3", 
							Mdl = "models/military2/bomb/bomb_mk82s.mdl",	  
							Pos = Vector( -5, 0, -74 ), 
							Ang = Angle( 45, 0, 10 ), 
							Type = "Bomb",
							Cooldown = 10,
							isFirst	= nil,
							Class = "sent_napalm_bomb",
						}; 
						{ 
							PrintName = "Napalm #4", 
							Mdl = "models/military2/bomb/bomb_mk82s.mdl",	  
							Pos = Vector( -5, 0, -74 ), 
							Ang = Angle( 45, 0, 20 ), 
							Type = "Bomb",
							Cooldown = 10,
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
	
	local cname = {}
	cname[1] 	= "Bofors 40mm"
	cname[2] 	= "Bofors 40mm"

	local cpos  = {}
	cpos[1] 	= Vector( -161, 30, -40) -- 1× 105 mm M102 howitzer, Left
	cpos[2] 	= Vector( -264, 40, -40) -- Vulcan 20mm rear, Left
	
	-- Weapon Angle
	local cang  = {}
	cang[1] 	= Angle(5,90,0)
	cang[2] 	= Angle(5,90,0)

	-- Cooldown in seconds
	local cd  	= {}
	cd[1] 		= 0.5
	cd[2] 		= 0.5

	local autofire = {}
	autofire[1] = false
	autofire[2] = false

	local cmdl = {}
	cmdl[1] = "models/ac-130/bofors.mdl"
	cmdl[2] = "models/ac-130/bofors.mdl"
	
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
		
	end

	local gunnerseats = {}
	local gunnerangles = {}

	gunnerseats[1] = Vector( -161, 49, -50 )
	gunnerseats[2] = Vector( -264, 44, -40 )

	gunnerangles[1] = Angle( 15, 90, 0 )
	gunnerangles[2] = Angle( 15, 90, 0 )

	local vFov = {}
	vFov[1] = 55
	vFov[2] = 65

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
	pos[1] = self:GetPos() + self:GetRight() * 111 + self:GetForward() * 171 + self:GetUp() * -52
	pos[2] = self:GetPos() + self:GetRight() * -111 + self:GetForward() * 171 + self:GetUp() * -52	
	
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
	self.TrailPos[1] = Vector( -61, -571, -18 )
	self.TrailPos[2] = Vector( -61, 571, -18 )
	
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

	self:StartMotionController()

end


function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed ) then
		
		return

	end

	//print( "Taking damage from ", dmginfo:GetInflictor():GetClass() )

	for i=1,#self.GunnerSeats do
		
		local s = self.GunnerSeats[i]:GetDriver()
		
		if ( IsValid( s ) ) then
			
			s:SetHealth( self.HealthVal )
			
		end
		
	end
	
	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt("health",self.HealthVal)
	
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then
	
		self.Burning = true
		self:EmitSound( "lockon/launchWarning.mp3", 511, 100 )
		
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
	
	if( ply == self.Pilot ) then
		
		self:EjectPilot()
		
		return
	
	end
	
	if ( !self.IsFlying && !IsValid( self.Pilot ) ) then 
	
		self:Jet_DefaultUseStuff( ply, caller )
	
	else 

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
	
end


function ENT:Think()

	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 60 + 100 ),0,180 )

	for i = 1,#self.EngineMux do
	
		self.EngineMux[i]:ChangePitch( self.Pitch, 0.01 )
		
	end
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 200 then
		
			self:EjectPilot()
			self:Remove()
			self:StopSound( "lockon/launchWarning.mp3" )
		
		end
		
	end
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 500 )
		
		self:UpdateRadar()
		self:NeuroPlanes_CycleThroughJetKeyBinds()
		
		if( !IsValid( self.Pilot ) ) then return end
		
		if ( self.Pilot:KeyDown( IN_JUMP ) && self.LastFlare + self.FlareCooldown <= CurTime() ) then
			
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
	
		
		if ( self.Pilot:KeyDown( IN_USE ) && self.LastUse + 0.25 <= CurTime() ) then
			
			local p  = self.Pilot
			self.LastUse = CurTime()
			self:EjectPilot()
			p:SetPos( self:LocalToWorld( Vector( 150, 0, 150 ) ) )
			
		end	

		---- Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
			self:EjectPilot()
			
		end

	end

	-- Gunners
	for i=1,#self.GunnerSeats do
	
		if ( !IsValid( self.Cannons[i] ) ) then print( "invalid entity: Cannon#"..i ) return end
		
		local g = self.GunnerSeats[i]:GetDriver()
		
		if ( IsValid( g ) ) then
			
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
					-- print( "i+1 not valid")
					
				end
				
				if( !IsValid( a:GetDriver() ) ) then
					-- print("no driver found")
					
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
	

	self:NextThink( CurTime() )
	
	return true
	
end

function ENT:FireHowitzer( obj, plr )
	
	local shellmod = "sent_ac130_40mm_shell"
	local boomsound = "ac-130/ac-130_40mm_Fire.wav"

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
	
	local fx = EffectData()
	fx:SetOrigin( obj:GetPos() + obj:GetForward() * 195 )
	fx:SetScale( 5.0 )
	util.Effect( "a10_muzzlesmoke", fx )
	
	local e = EffectData()
	e:SetStart( obj:GetPos()+obj:GetForward() * 195 )
	e:SetEntity( obj )
	e:SetNormal( obj:GetForward() )
	e:SetScale( 4.0 )
	util.Effect( "ac130_muzzle", e )

end

function ENT:FireTurret( _ent, gunner )

	if ( !_ent ) then
		
		return
		
	end
	
	local e = EffectData()
	e:SetStart( _ent:GetPos() + _ent:GetForward() * 90 + self:GetForward() * self.Speed / 10 )
	e:SetEntity( _ent )
	e:SetScale( math.Rand (1.5, 2.0 ) ) 
	e:SetNormal( _ent:GetForward() )
	util.Effect( "ac130_muzzle", e )
	
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
	
	local sm = EffectData()
	sm:SetStart( _ent:GetPos() + _ent:GetForward() * 90 + self:GetForward() * self.Speed / 10 )
	sm:SetScale(4.8)
	util.Effect( "a10_muzzlesmoke", sm )
	
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
	
		util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 100, math.random( 2,4 ) )
		
	end
	
	return { damage = true, effects = DoDefaultEffect } 	
	
end

function ENT:SpawnFlareSpecial(direction, _ents, i)
	
	local dir = {}
	dir[1] = self:GetPos() + self:GetRight() * math.random(12000,20000) + self:GetUp() * 6000
	dir[2] = self:GetPos() + self:GetRight() * math.random(-20000,-12000) + self:GetUp() * 6000
	dir[3] = self:GetPos() + self:GetUp() * -200
	
	local d = dir[direction]
	
	local fx = EffectData()
	fx:SetOrigin( self:GetPos() + self:GetRight() * ( math.sin( CurTime() - self.seed ) * 100 ) + self:GetUp() * math.random( -50, -10 ) )
	fx:SetScale( 3.0 )
	util.Effect( "HelicopterMegaBomb", fx ) 
	
	local fx = EffectData()
	fx:SetOrigin( self:GetPos() + self:GetRight() * ( math.sin( CurTime() - self.seed ) * 100 ) + self:GetUp() * math.random( -50, -10 ) )
	fx:SetScale( 3.0 )
	util.Effect( "AngelWings", fx ) 

	local f = ents.Create( "nn_flare" )
	f:SetPos( self:GetPos() + self:GetUp() * - 100 + self:GetForward() * -256 )
	f:Spawn()
	f:GetPhysicsObject():ApplyForceCenter( d )
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
	
	if ( self.IsFlying ) then
	
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
		
			maxang = 0
			r = 0
			
		else
			
			maxang = 17.2
			
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
		if( self.Pilot:KeyDown( IN_WALK ) && self.Speed > self.MaxVelocity * 0.5 ) then
			
			pr.angle = Angle( -1, phys:GetAngles().y + 7.6, -15 )
		
		end

		phys:ComputeShadowControl(pr)
			
		self:WingTrails( ma.r, 20 )
		
	end
	
end
