AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')


ENT.PrintName = "Combine Helicopter"
ENT.Model = "models/combine_helicopter.mdl"
//Speed Limits
ENT.MaxVelocity = 1000
ENT.MinVelocity = -1000

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle
ENT.BankingFactor = 2.9

ENT.InitialHealth = 3500
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
ENT.CrosshairOffset = 0
ENT.NumRockets = nil
ENT.SecondaryCooldown = 5.0
ENT.SecondaryFireMode = true // Initial secondary firemode: true = dumbfire, false = homing
ENT.GotChopperGunner = false
ENT.isHovering = false
ENT.AutomaticFrameAdvance = true
ENT.MaxSpin = 1200

local CrashDebris = { 
					"models/gibs/helicopter_brokenpiece_01.mdl",
					"models/gibs/helicopter_brokenpiece_02.mdl",
					"models/gibs/helicopter_brokenpiece_03.mdl",
					"models/gibs/helicopter_brokenpiece_04_cockpit.mdl",
					"models/gibs/helicopter_brokenpiece_05_tailfan.mdl",
					"models/gibs/helicopter_brokenpiece_06_body.mdl"
					}
					
for k,v in pairs(CrashDebris) do
	util.PrecacheModel(tostring(v))
end

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 120
	local ent = ents.Create( "sent_combine_helicopter_p" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

function ENT:Initialize()
	
	self.HealthVal = self.InitialHealth
	
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "HudOffset", self.CrosshairOffset )
	self:SetNetworkedInt( "MaxHealth",self.InitialHealth)
	self:SetNetworkedInt( "MaxSpeed",self.MaxVelocity)

	self.LastPrimaryAttack = 0
	self.LastSecondaryAttack = 0
	self.LastFireModeChange = 0
	self.LastRadarScan = 0
	self.LastFlare = 0
	self.ChopperGunAttack = 0
	self.LastChopperGunToggle = 0
	self.LastSecondaryKeyDown = CurTime()
	
	self.Sounds = {}
	self.Sounds.SpinUp = CreateSound( self,"NPC_attackHelicopter.ChargeGun" )
	self.Sounds.SpinDown = CreateSound( self, "NPC_attackHelicopter.ChargeDownGun" )
	self.Sounds.FireSound = CreateSound( self, "npc/attack_helicopter/aheli_weapon_Fire_loop3.wav" )
	self.Sounds.OutOfAmmo = CreateSound( self, "weapons/airboat/airboat_gun_lastshot2.wav" )
			
	self.HoverVal = 100
	self.MoveRight = 0
	self.RudderAng = 0
	self.MinigunSpin = 0
	self.MinigunOverheated = false
	self.MinigunLastSound = 0
	self.MinigunLastLoop = 0
	self.LastDamageAlert = 0
	
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
						PrintName = "Helicopter Bomb"		,		 			// print name, used by the interface
						Mdl = "models/combine_helicopter/helicopter_bomb01.mdl",  		// model, used when creating the object
						Pos = Vector( -50, 0, -31), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "MegaBombSmall", 										// Type, used when creating the object
						Cooldown = 5, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_helibomb"								// the object that will be created.
					};
					{ 
						PrintName = "Mega Bomb"		,		 					// print name, used by the interface
						Mdl = "models/combine_helicopter/helicopter_bomb01.mdl",  		// model, used when creating the object
						Pos = Vector( -50, 0, -31), 							// Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 									// Ang, object angle
						Type = "MegaBomb", 										// Type, used when creating the object
						Cooldown = 20, 											// Cooldown between weapons
						isFirst	= nil,											// If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_helibomb"								// the object that will be created.
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
	
	self.LoopSounds = {}
	self.LoopSounds[1] = CreateSound( self, Sound("npc/attack_helicopter/aheli_rotor_loop1.wav") )
	//self.LoopSounds[2] = CreateSound( self, Sound("npc/attack_helicopter/aheli_wash_loop3.wav") )
	
	for i=1,#self.LoopSounds do
		
		self.LoopSounds[i]:PlayEx( 511,110 )
		self.LoopSounds[i]:SetSoundLevel( 511 )
	
	end

	self:SetUseType( SIMPLE_USE )
	self.IsFlying = false
	self.Pilot = nil
	
	self.ChopperGun = ents.Create("prop_physics_override")
	self.ChopperGun:SetModel( "models/airboatgun.mdl" )
	self.ChopperGun:SetPos( self:GetPos() + self:GetForward() * 140 + self:GetUp() * -94  )
	self.ChopperGun:SetAngles( self:GetAngles() + Angle( 25, 0, 0 ) )
	self.ChopperGun:SetSolid( SOLID_NONE )
	self.ChopperGun:SetParent( self )
	self.ChopperGun:Spawn()	
	self.ChopperGunProp = self.ChopperGun

	// Misc
	self:SetModel( self.Model )	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	
	self.Rotorwash = ents.Create("env_rotorwash_emitter")
	self.Rotorwash:SetPos( self:GetPos() )
	self.Rotorwash:SetParent( self )
	self.Rotorwash:SetKeyValue("altitude","",1024)
	self.Rotorwash:Spawn()
	
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:SetMass(2000)
		self.PhysObj:EnableGravity( true )
		
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
	if ( dmginfo:GetDamage() > 300 && self.LastDamageAlert + 2 <= CurTime() ) then
		
		self.LastDamageAlert = CurTime()
		self:EmitSound("npc/attack_helicopter/aheli_damaged_alarm1.wav", 211, 100 )
		self:SecondaryAttack( self.RocketVisuals[1], 1 )
		
	end
	
	if ( self.HealthVal < self.InitialHealth * 0.25 && !self.Burning ) then

		self.Burning = true
	
		local bones = { "Damage0","Damage1","Damage2","Damage3","Damage4" }
		
		for k,v in pairs( bones ) do
			
			local BoneIndx = self:LookupBone( tostring(v) )
			if( !BoneIndx ) then
				
				BoneIndx = 1
			
			end
			
			local bonepos, boneang = self:GetBonePosition( BoneIndx )
			
			local f = ents.Create("env_Fire_trail")
			f:SetPos( bonepos )
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

	for i=1,#self.LoopSounds do
		
		self.LoopSounds[i]:Stop()
		
	end
	
	if( self.HealthVal < 50 ) then
		
		for i=1, #CrashDebris do
			
			local prop = ents.Create("prop_physics")
			prop:SetPos( self:GetPos() )
			prop:SetAngles( self:GetAngles() )
			prop:SetModel( CrashDebris[i] )
			prop:SetSolid( SOLID_NONE )
			prop:Spawn()
			prop:Ignite(10,10)
			prop:Fire("kill",10)
			
			//prop:GetPhysicsObject():ApplyForceCenter( Vector( math.random(-1,1), math.random(-1,1), math.random(-1,1) ) * math.random( -2000, 2000 ) )
		
		end
		
		self:ExplosionImproved()
		
	end
	
	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilotSpecial()
	
	end
	
end

function ENT:PhysicsCollide( data, physobj )

	if( data.Speed > self.MaxVelocity * 0.25 && self.LastDamageAlert + 2 <= CurTime() ) then
		
		self.LastDamageAlert = CurTime()
		self:EmitSound("npc/attack_helicopter/aheli_damaged_alarm1.wav", 211, 100 )
		
	end
	
	if ( data.Speed > self.MaxVelocity * 0.4 && data.DeltaTime > 0.2 ) then 
		
		if ( self:GetVelocity():Length() < self.MaxVelocity * 0.6 ) then
			
			self.HealthVal = self.HealthVal * 0.3
			
		else
			
			local explo = EffectData()
			explo:SetOrigin(self:GetPos())
			explo:SetScale(0.90)
			explo:SetNormal(data.HitNormal)
			util.Effect("nn_explosion", explo)
			
			util.BlastDamage( self, self, data.HitPos, 3024, 200 )
			self:EjectPilotSpecial()
			self:Remove()
			
			return
			
		end
		
		self:SetNetworkedInt("health",self.HealthVal)
		
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
	self:SetNetworkedBool("ChopperGunner",false)
	self.GotChopperGunner = false
	self.Pilot:SetNetworkedBool( "isGunner", false )
	
	self.Pilot:SetPos( self:GetPos() + self:GetRight() * -150 )
	self.Pilot:SetAngles( Angle( 0, self:GetAngles().y,0 ) )
	self.Owner = NULL
	self.Pilot:SetScriptedVehicle( NULL )
	self.Pilot:SetNetworkedEntity("ChopperGunnerEnt", NULL )
	
	self.Speed = 0
	self.IsFlying = false
	self:SetLocalVelocity(Vector(0,0,0))
	self.Pilot = NULL
	
end

function ENT:Use(ply,caller)

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
		
		//ply:SetNetworkedBool( "isGunner", false )
		ply:SetNetworkedEntity("ChopperGunnerEnt", self.ChopperGun )
		
		self.Entered = CurTime()
	
	end
	
end


function ENT:Think()

	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 100 + 100 ),0,205 )
	
	for i=1,#self.LoopSounds do
		
		self.LoopSounds[i]:ChangePitch( self.Pitch, 0.01 )
	
	end
	
	
	
	local seq = self:LookupSequence( "idle" )
	self:ResetSequence( seq )
	
	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 35 then
		
			self:EjectPilotSpecial()
			self:Remove()
		
		end
		
	end
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
		
		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 72 )
		
		// HUD Stuff
		self:UpdateRadar()
		
		// Lock On method
		local pos1 = self:GetPos() + self:GetUp() * self.CrosshairOffset + self:GetForward() * 512
		local pos2 = pos1 + self:GetForward() * 5000 + self:GetUp() * self.CrosshairOffset
		
		if ( self.GotChopperGunner ) then
			
			pos1 = self.ChopperGun:GetPos() + self.ChopperGun:GetForward() * 240
			pos2 = pos1 + self.ChopperGun:GetForward() * 7000
			
		end
		
		local trace,tr = {},{}
		tr.start = pos1
		tr.endpos = pos2
		tr.filter = { self.Pilot, self, self.Weapon, self.ChopperGun }
		tr.mask = MASK_SOLID
		trace = util.TraceEntity( tr, self )
		
		local e = trace.Entity
		
		local logic = ( IsValid( e ) && ( e:IsNPC() || e:IsPlayer() || e:IsVehicle() || type(e) == "CSENT_vehicle" || string.find( e:GetClass(), "prop_vehicle" ) ) )
		
		if ( logic && !IsValid( self.Target ) && e:GetOwner() != self && e:GetOwner() != self.Pilot && e:GetClass() != self:GetClass() ) then
			
			//self:SetTarget( e )
			
		end
		
		// Clear Target 
		if ( self.Pilot:KeyDown( IN_SPEED ) && IsValid( self.Target ) ) then
			
			//self:ClearTarget()
			//self.Pilot:PrintMessage( HUD_PRINTCENTER, "Target Released" )
			
		end
		
		// Attack
		if ( self.Pilot:KeyDown( IN_ATTACK  ) && !self.MinigunOverheated ) then
			
			self.MinigunSpin = math.Approach( self.MinigunSpin, self.MaxSpin, 1.0 )
			
			if( self.MinigunSpin < 100 ) then
				
				self.Sounds.SpinUp:PlayEx( 1.0, 100 )
				self.Sounds.SpinDown:Stop()
				
				self.MinigunLastSound = CurTime()
				
			end
			
			if( self.MinigunSpin == self.MaxSpin ) then
				
				self.MinigunOverheated = true
				self.Sounds.SpinDown:PlayEx( 1.0, 100 )
				self.Sounds.FireSound:FadeOut( 1.55 )
				self.Sounds.OutOfAmmo:PlayEx( 1.0, 100 )
				
			end
	
			if( self.MinigunSpin >= 100 ) then
				
				self.Sounds.SpinUp:FadeOut( 1.5 )
				self.MinigunLastLoop = CurTime()
				self.Sounds.FireSound:PlayEx( 1.0, 100 )

				if ( self.ChopperGunAttack + 0.07 <= CurTime() ) then
					
					self:FuselageAttack()
				
				end
			
			end
			
		else
			
			self.MinigunSpin = math.Approach( self.MinigunSpin, 0, 1.25 )
			self.Sounds.FireSound:FadeOut( 0.25 )
			self.Sounds.OutOfAmmo:FadeOut( 0.15 )
			
			if( self.MinigunSpin < 100 ) then
				
				self.MinigunOverheated = false
				self.Sounds.SpinDown:Stop()
				
			end
			
		end
				
		if ( !self.GotChopperGunner ) then
			
			// Ugly
			local eyeAng = self.Pilot:EyeAngles()
			local myAng = self:GetAngles()
			
			if ( eyeAng.y > myAng.y + 50 ) then
			
				eyeAng.y = myAng.y + 50
				
			elseif( eyeAng.y < myAng.y -50 ) then
			
				eyeAng.y = myAng.y -50
				
			end

			eyeAng.r = myAng.r
			
			self.ChopperGun:SetAngles( LerpAngle( 0.123, self.ChopperGun:GetAngles(), eyeAng ) )
		
		end

		if ( self.LastSecondaryKeyDown + 0.5 <= CurTime() && self.Pilot:KeyDown( IN_ATTACK2 ) ) then
			
			self.LastSecondaryKeyDown = CurTime()
			
			local id = self.EquipmentNames[ self.FireMode ].Identity
			local wep = self.RocketVisuals[ id ]
			
			if ( wep.LastAttack + wep.Cooldown <= CurTime() ) then
			
				self:SecondaryAttack( wep, id )
				
			else
			
	
				local cd = math.ceil( ( wep.LastAttack + wep.Cooldown ) - CurTime() ) 
				
				if ( cd == 1 ) then 
				
					self.Pilot:PrintMessage( HUD_PRINTTALK, self.PrintName..": "..wep.PrintName.." ready in "..tostring( cd ).. " second." )
				
				else
				
					self.Pilot:PrintMessage( HUD_PRINTTALK, self.PrintName..": "..wep.PrintName.." ready in "..tostring( cd ).. " seconds." )	
				
				end
				
			end
	
		end

		// Firemode 
		if ( self.Pilot:KeyDown( IN_RELOAD ) && self.LastFireModeChange + 0.5 <= CurTime() ) then
			
			self:CycleThroughWeaponsList()
			
		end
		
		// Flares
		if ( self.Pilot:KeyDown( IN_SCORE ) && !self.isHovering && self.FlareCount > 0 && self.LastFlare + self.FlareCooldown <= CurTime() && self.LastFireModeChange + 0.2 <= CurTime() ) then
			
			self.LastFireModeChange = CurTime()
			self.FlareCount = self.FlareCount - 1
			self:SetNetworkedInt( "FlareCount", self.FlareCount )
			self:SpawnFlare()
			
			if ( self.FlareCount == 0  ) then
			
				self.LastFlare = CurTime() 
				self.FlareCount = self.MaxFlares
				
			end
			
		end
	
		if ( self.Pilot:KeyDown( IN_USE ) && self.Entered + 1.0 <= CurTime() ) then

			self:EjectPilotSpecial()
			
		end	
		
		// Ejection Situations.
		if ( self:WaterLevel() > 0 ) then
		
			self:EjectPilotSpecial()
			
		end

	end
	
	self:NextThink( CurTime() )
		
	return true
	
end


function ENT:FuselageAttack()

	if ( !self.Pilot || !IsValid( self.Pilot ) ) then
		
		return
		
	end
	
	local bullet = {} 
		bullet.Num 		= math.random( 1, 4 )
		bullet.Src 		= self.ChopperGun:GetPos() + self.ChopperGun:GetForward() * 45
		bullet.Dir 		= self.ChopperGun:GetAngles():Forward()	
		bullet.Spread 	= Vector( .05 + (math.random(0,400)/10000), .05 + (math.random(0,400)/10000), .05 + (math.random(0,400)/10000) )
		bullet.Tracer	= 2
		bullet.Force	= 0
		bullet.Damage	= math.random( 16, 32 )
		bullet.AmmoType = "Ar2" 
		bullet.TracerName 	= "HelicopterTracer" 
		bullet.Callback    = function ( a, b, c ) /**/ end
	
	self.ChopperGun:FireBullets( bullet )
	
	local e = EffectData()
	e:SetStart( self.ChopperGun:GetPos()+self:GetForward() * 62 )
	e:SetOrigin( self.ChopperGun:GetPos()+self:GetForward() * 62 )
	e:SetEntity( self.ChopperGun )
	e:SetAttachment( 1 )
	util.Effect( "ChopperMuzzleFlash", e )
	
	--self.ChopperGun:EmitSound( "ah64fire.wav", 510, 145 )
	--self.ChopperGun:EmitSound( "weapons/smg1/npc_smg1_Fire1.wav", 510, 45 )

	self.ChopperGunAttack = CurTime()
	
end

function ENT:ChopperGunCallback( a, b, c )

	if ( IsValid( self.Pilot ) ) then

		util.BlastDamage( self.Pilot, self.Pilot, b.HitPos, 200, math.random( 4, 12 ) )
		
	end
	
	local fx = EffectData()
	fx:SetOrigin( b.HitPos )
	fx:SetStart( b.HitPos )
	fx:SetNormal( b.HitNormal )
	fx:SetScale( 1.0 )
	util.Effect( "AirboatGunImpact", fx )
	
	return { damage = true, effects = DoDefaultEffect } 	
	
end


function ENT:SecondaryAttack( wep, id )
	
	if ( IsValid( wep ) ) then
	
		self:NeuroPlanes_FireRobotSpecial( wep, id )
		
	end
	
end

function ENT:NeuroPlanes_FireRobotSpecial( wep, id )
	
	if ( !wep || !id ) then
		
		return
		
	end
	
	local pos = wep:GetPos()
	
	if ( wep.isFirst == true ) then
		
		pos = self.RocketVisuals[ id + math.random( 0, 1 ) ]:GetPos()
		
	end
	
	if( wep.Type == "MegaBomb" || wep.Type == "MegaBombSmall" ) then
		
		local count = 8
		if( wep.Type == "MegaBombSmall" ) then
			
			count = 3
			
		end
		
			
		
		for i=1,count do 
			
			timer.Simple( 1 + ( i / 3 ), function( ) 
			
				local r = ents.Create( wep.Class )
				r:SetPos( wep:GetPos() + self:GetRight() * math.random( -10, 10 ) )
				r:SetOwner( self )
				r:SetPhysicsAttacker( self.Pilot )
				r.Target = self.Target
				r.Pointer = self.Pilot
				r:SetModel( wep:GetModel() )
				r:Spawn()
				r:Fire( "Kill", "", 40 )
				r:SetAngles( wep:GetAngles() )
				r:GetPhysicsObject():SetVelocity( self:GetVelocity() + VectorRand() )
				r:EmitSound( "npc/attack_helicopter/aheli_mine_drop1.wav", 511, 100 )
				
			end )
		
		end
		
		wep:EmitSound( "npc/attack_helicopter/aheli_megabomb_siren1.wav", 511, 100 )
		wep.LastAttack = CurTime()
			
		return
		
	end
						
	
	local r = ents.Create( wep.Class )
	r:SetPos( pos )
	r:SetOwner( self )
	r:SetPhysicsAttacker( self.Pilot )
	r.Target = self.Target
	r.Pointer = self.Pilot
	r:SetModel( wep:GetModel() )
	r:Spawn()
	r:Fire( "Kill", "", 40 )
	r:SetAngles( wep:GetAngles() )
	
	if ( r:GetPhysicsObject() != nil ) then
		
		r:GetPhysicsObject():SetVelocity( self:GetVelocity() )
		
	end
	
	wep:EmitSound( "npc/attack_helicopter/aheli_mine_drop1.wav", 511, 100 )
	
	wep.LastAttack = CurTime()
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	local a = self:GetAngles()
	local p,r = a.p,a.r
	local stallAng = ( p > 80 || p < -80 || r > 85 || r < -85 )
	
	if ( self.IsFlying && !stallAng ) then
		
		phys:Wake()
		
		local pilotAng = self.Pilot:GetAimVector():Angle()
		local a = self.Pilot:GetPos() + self.Pilot:GetAimVector() * 3000 + self:GetUp() * 256 // This is the point the plane is chasing.
		local ta = ( self:GetPos() - a ):Angle()
		local ma = self:GetAngles()
		self.offs = self:VecAngD( ma.y, ta.y )		
		local r = r or 0
		local maxang = 52

		local vel = self:GetVelocity():Length()
		if ( vel > -600 && vel < 700 ) then
			
			self.isHovering = true
			self.BankingFactor = 8
		
		else
		
			self.isHovering = false
			self.BankingFactor = 2.9
			
		end
	
		if ( self.Pilot:KeyDown( IN_JUMP ) ) then
			
			self.HoverVal = self.HoverVal + 3.2
			
		elseif ( self.Pilot:KeyDown( IN_DUCK ) ) then
			
			self.HoverVal = self.HoverVal - 3.2
		
		end
		
		self.HoverVal = math.Clamp( self.HoverVal, -500, 500 )
		
		local RAng
		if( self.offs < -160 || self.offs > 160 ) then
			
			r = 0
			RAng = math.sin( CurTime() - self:EntIndex() * 10 ) * 8
			
		else
		
			r = ( self.offs / self.BankingFactor ) * -1
			RAng = ( 1 + self.offs / self.BankingFactor ) * -1
			
		end
		
		self.RudderAng = math.Approach( self.RudderAng, RAng, 1.25 )
		self:SetPoseParameter("rudder", self.RudderAng )
		
		if ( self:GetVelocity():Length() < 1000 ) then 
		
			if ( self.Pilot:KeyDown( IN_MOVELEFT ) ) then
				
				self.MoveRight = self.MoveRight - 8.5
				r  = -25
				
			elseif (  self.Pilot:KeyDown( IN_MOVERIGHT ) ) then
				
				self.MoveRight = self.MoveRight + 8.5
				r = 25
				
			else
				
				self.MoveRight = math.Approach( self.MoveRight, 0, 1.25 )
			
			end

			self.MoveRight = math.Clamp( self.MoveRight, -656, 656 )
		
		else
		
			self.MoveRight = math.Approach( self.MoveRight, r * 8.5, 0.65 )
		
		end
		

		
		if ( ma.p > 2 ) then
	
			self.Speed = self.Speed + ma.p / 3.5
		
		elseif ( ma.p < -2 ) then
			
			self.Speed = self.Speed + ma.p / 3.5
		
		elseif ( ma.p > -2 && ma.p < 2 ) then
		
			self.Speed = self.Speed / 1.005
		
		end
		
		if ( self.Pilot:KeyDown( IN_WALK ) ) then
			
			// Pull up the nose if we're going too fast.
			if( math.floor(self:GetVelocity():Length() / 1.8 ) > 500 && !( self.MoveRight > 500 || self.MoveRight < -500 ) ) then 
			
				pilotAng.p = -35
				self.HoverVal = self.HoverVal / 1.05
				
			else
				
				pilotAng.p = 1.0 + ( math.sin( CurTime() - (self:EntIndex() * 10 ) ) / 2 )
			
			end
			
			self.Speed = self.Speed / 1.0055
		
		end
		
		self.Speed = math.Clamp( self.Speed, self.MinVelocity, self.MaxVelocity )
		
		local pr = {}
		local wind = Vector( math.sin( CurTime() - ( self:EntIndex() * 2 ) ) * 6, math.cos( CurTime() - ( self:EntIndex() * 2 ) ) * 5.8, math.sin( CurTime() - ( self:EntIndex() * 3 ) ) * 7 )
		
		if( self.HealthVal < 400 ) then
		
			local t = t or 0
			t = math.Approach( t, 4.5, 0.15 )
			
			wind = Vector( math.sin(CurTime() - ( self:EntIndex()*10) )*38 + math.random(-64,64),math.cos(CurTime() - ( self:EntIndex()*10) )*38 + math.random(-64,64), -0.01 ) 
			pilotAng.y = pilotAng.y + t
			self.HoverVal = self.HoverVal / 2
			
		end
		
		local desiredPos = self:GetPos() + self:GetForward() * self.Speed + self:GetUp() * self.HoverVal + self:GetRight() * self.MoveRight + wind
		pr.secondstoarrive	= 1
		pr.pos 				= desiredPos
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

