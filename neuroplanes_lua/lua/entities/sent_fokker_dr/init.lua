
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.Model = "models/inaki/props_vehicles/fokker_dr1.mdl"
//Speed Limits
ENT.MaxVelocity = 1.8 * 700
ENT.MinVelocity = 0

// How much the plane will rotate around the Z axis when turning. Lower Value = More Angle. Recomended = 2.5 for super sonic jets, 3.5 to 4 for larger stuff.
ENT.BankingFactor = 3.5

ENT.InitialHealth = 5000
ENT.HealthVal = nil
ENT.MuzzleOffset = 60

ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0

ENT.BulletDelay1 = CurTime()
ENT.BulletDelay2 = CurTime()

// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.LastRadarScan = nil
ENT.LastFlare = nil
ENT.FlareCooldown = 15
ENT.FlareCount = 0
ENT.MaxFlares = 0

// Equipment
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.MachineGunOffset = Vector( 0, 0, 0 )
ENT.CrosshairOffset = 26

ENT.NumRockets = nil
ENT.PrimaryCooldown = 0.1

local CrashDebris = {
{"models/gibs/helicopter_brokenpiece_01.mdl"};
{"models/gibs/helicopter_brokenpiece_02.mdl"};
{"models/gibs/helicopter_brokenpiece_03.mdl"};
{"models/gibs/helicopter_brokenpiece_01.mdl"};
{"models/gibs/helicopter_brokenpiece_02.mdl"};
{"models/gibs/helicopter_brokenpiece_03.mdl"};
{"models/gibs/shield_scanner_gib1.mdl"};
{"models/gibs/shield_scanner_gib4.mdl"};
{"models/gibs/shield_scanner_gib5.mdl"};
{"models/gibs/shield_scanner_gib6.mdl"};
{"models/gibs/manhack_gib01.mdl"};
{"models/gibs/manhack_gib02.mdl"};
{"models/gibs/manhack_gib03.mdl"};
{"models/gibs/manhack_gib04.mdl"};
{"models/combine_apc_destroyed_gib03.mdl"};
{"models/combine_apc_destroyed_gib03.mdl"};
{"models/container_chunk02.mdl"};
{"models/container_chunk03.mdl"};
{"models/container_chunk04.mdl"};
{"models/combine_apc_destroyed_gib03.mdl"};
{"models/combine_apc_destroyed_gib03.mdl"};
{"models/container_chunk02.mdl"};
{"models/container_chunk03.mdl"};
{"models/container_chunk04.mdl"};
}

function ENT:Precache( )
	
	util.PrecacheSound( self.HoverSoundFile )
	util.PrecacheSound( self.DeathSoundFile )
	util.PrecacheSound( self.RebootingSoundFile )
	for k,v in pairs(CrashDebris) do
	
		util.PrecacheModel(tostring(v))
	
	end
	
end

function ENT:SpawnFunction( ply, tr)

	local SpawnPos = tr.HitPos + tr.HitNormal * 100
	local ent = ents.Create( "sent_Fokker_dr" )
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
							PrintName = "Bomb", 
							Mdl = "models/props_phx/ww2bomb.mdl",	 
							Pos = Vector( -45, 0, -18 ), 
							Ang = Angle( 0, 0, 0), 
							Type = "Bomb",
							Cooldown = 15,
							isFirst	= nil,
							Class = "sent_jdam_medium"
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
	
	self.NumRockets = #self.EquipmentNames or 0

	// Sound
	local esound = {}
	self.EngineMux = {}
	
	esound[1] = "vehicles/airboat/fan_blade_Fullthrottle_loop1.wav"
	esound[2] = "vehicles/fast_windloop1.wav"
	esound[3] = "vehicles/airboat/fan_motor_Fullthrottle_loop1.wav"
	
	
	for i=1, #esound do
	
		self.EngineMux[i] = CreateSound( self, esound[i] )
		
	end
	
	self.Pitch = 60
	self.WindPitch = 90
	self.EngineMux[1]:PlayEx( 500 , self.Pitch )
	self.EngineMux[2]:PlayEx( 500 , self.WindPitch )
	
	self:SetUseType( SIMPLE_USE )
	self.IsFlying = false
	self.Pilot = nil
		
	// Misc
	self:SetModel( self.Model )	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:EnableGravity(true)
		self.PhysObj:SetMass(5000000)
		
	end
	local wheelpos = {}
	wheelpos[1] = Vector( 8, -56, -75 )
	wheelpos[2] = Vector( 8, 56, -75 )
	
	self.Wheels = {}
	self.WheelWelds = {}
	
	for i = 1, 2 do
		
		self.Wheels[i] = ents.Create("prop_physics")
		self.Wheels[i]:SetPos( self:LocalToWorld( wheelpos[i] ) )
		self.Wheels[i]:SetModel( "models/inaki/props_vehicles/fokker_dr1_wheel.mdl" )
		self.Wheels[i]:SetAngles( self:GetAngles() )
		self.Wheels[i]:Spawn()
    	self.Wheels[i]:SetParent( self )
		
		self.WheelWelds[i] = constraint.Axis( self, self.Wheels[i], 0, 0, Vector(0,1,0) , wheelpos[i], 0, 0, 1, 0 )
	
	end
		
	self.WheelPhys = {}
	for i = 1, 2 do
	
		self.WheelPhys[i] = self.Wheels[i]:GetPhysicsObject()
		self.WheelPhys[i]:Wake()
		self.WheelPhys[i]:SetMass( 50000 )
		self.WheelPhys[i]:EnableGravity( false )
		self.WheelPhys[i]:EnableCollisions( true )

	end

	
	
//SILLIRION: ADDED SMOKE EFFECT AT THE ATTACHMENTS PLACED IN THE MODEL "exaust_l" "exaust_r"
	local exaust_attachmentl = self:LookupAttachment("exhaust_l")
	ParticleEffectAttach("smoke_gib_01",PATTAch_POINT_FOLLOW,self,exaust_attachmentl)
	local exaust_attachmentr = self:LookupAttachment("exhaust_r")
	ParticleEffectAttach("smoke_gib_01",PATTAch_POINT_FOLLOW,self,exaust_attachmentr)
//END ADDED SMOKE EFFECT

	local minipos = { Vector( -17, 6, 22 ), Vector( -17, -6, 22 ) }
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
		
	self:StartMotionController()

end


function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed ) then
		
		return

	end
	
	if( IsValid( self.Pilot ) ) then
	
		self.Pilot:ViewPunch( Angle( math.random(-2,2),math.random(-2,2),math.random(-2,2) ) )
	
	end
	
	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 20 + 40 ),0,245 )

	for i = 1,2 do
	
		self.EngineMux[i]:ChangePitch( self.Pitch, 0.01 )
		
	end
	
	self:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	self:SetNetworkedInt("health",self.HealthVal)
	
	//local seq = self:LookupSequence( "range_melee" )
	//self:ResetSequence( seq )
		
	if ( self.HealthVal < self.InitialHealth * 0.15 && !self.Burning ) then
	
		self.Burning = true
		local p = {}
//SILLIRION: HERE IS THE POS OF THE SIDES OF THE ENGINE
		p[1] = self:GetPos() + self:GetForward() * 35 + self:GetRight() * -25 + self:GetUp() * -8.5
		p[2] = self:GetPos() + self:GetForward() * 35 + self:GetRight() * 25 + self:GetUp() * -8.5
		for _i=1,2 do
		
			local f = ents.Create("env_Fire_trail")
			f:SetPos( p[_i] )
			f:SetParent( self )
			f:Spawn()
			
		end
//SILLIRION: ADDED DAMAGE SMOKE EFFECT
	local damage_attachment = self:LookupAttachment("damage_smoke")
	ParticleEffectAttach("smoke_burning_engine",PATTAch_POINT_FOLLOW,self,damage_attachment)
//END ADDED SMOKE EFFECT

		
	end
	
	if ( self.HealthVal < 30 ) then
	
		self:PerformCrash()
		
	end
	
end

function ENT:DeathFXSpecial()

	local explo = EffectData()
	explo:SetOrigin(self.PhysObj:GetPos())
	util.Effect("Explosion", explo)

	for k, v in pairs( CrashDebris ) do
	
		local cdeb = ents.Create( "prop_physics" )
		cdeb:SetModel( tostring( v[1] ) )
		cdeb:SetPos( self.PhysObj:GetPos() + Vector( math.random( -64, 64 ), math.random( -64, 64 ), math.random( 128, 256 ) ) )
		cdeb:SetSolid( 6 )
		cdeb:Spawn()
		cdeb:Fire( "ignite", "", 1 )
		cdeb:Fire( "kill", "", 15 )
		local f1 = EffectData()
		f1:SetOrigin( cdeb:GetPos() )
		f1:SetStart( cdeb:GetPos() )
		util.Effect( "immolate", f1 )
		
	end
	
	implode( self:GetPos(), 1024, 512, -600000000 )
	
	for i = 1, 10 do
	
		local fx=EffectData()
		fx:SetOrigin( self.PhysObj:GetPos() + Vector( math.random( -256, 256 ), math.random( -256, 256 ), math.random( -256, 256 ) ) )
		fx:SetScale( 20 * i )
		util.Effect( "Firecloud", fx )
	
	end
	
	self:EmitSound( "ambient/explosions/explode_"..math.random( 1, 4 )..".wav", 200, 100 )
	util.BlastDamage( self, self,self.PhysObj:GetPos(), 1628, 100 )
	
	self:Remove()

end

function ENT:PerformCrash()

	self.Destroyed = true
	self.PhysObj:EnableGravity(true)
	self.PhysObj:EnableDrag(true)
	self:Ignite(60,100)
	
	for i = 1,3 do
	
		self.EngineMux[i]:Stop()
		
	end
	
	for i=1,#self.Wheels do
			
		if ( IsValid( self.WheelWelds[i] ) ) then
			
			self.WheelWelds[i]:Remove()
			self.WheelPhys[i]:EnableGravity( true )
			self.Wheels[i]:Fire("kill","",25)
		
		end
	
	end

	for k,v in pairs( self.RocketVisuals ) do
		
		if( v && IsValid( v ) && math.random(1,2) == 1 ) then
			
			v:SetParent(nil)
			v:SetSolid( SOLID_VPHYSICS )	
			v:Fire("kill","",25)
			
			if( self.HealthVal < self.InitialHealth * 0.5 ) then
				
				v:Ignite(25,25)
			
			end
			
			local p = v:GetPhysicsObject()
			if( p ) then
				
				p:Wake()
				p:EnableGravity( true )
				p:EnableDrag( true )
				
			end
		
		end
		
	end

end

function ENT:OnRemove()

	for i=1,2 do
	
		self.EngineMux[i]:Stop()
		
	end
	
	for i = 1, #self.Wheels do
		
		if ( IsValid( self.Wheels[i] ) ) then
			
			self.Wheels[i]:Remove()
		
		end
		
	end

	if ( IsValid( self.Pilot ) ) then
	
		self:EjectPilot()
	
	end

	
end

function ENT:PhysicsCollide( data, physobj )

	if ( data.Speed > self.MaxVelocity * 0.3 && data.DeltaTime > 0.2 ) then 
		
		if ( self:GetVelocity():Length() < self.MaxVelocity * 0.95 ) then

	-- //StarChick: Delete the crash into things, put a sound instead.		
--		self.HealthVal = self.HealthVal * ( 0.50 + 0.12 + math.Rand( 0.1, 0.3 ) )
		self:EmitSound( "lockon/PlaneHit.mp3", 510, math.random( 100, 130 ) )
		
		else
			
			self:DeathFX()
			
			return
		
		end
		
		self:SetNetworkedInt("health",self.HealthVal)
		
		if( self.Destroyed ) then
			
			self:EmitSound("physics/metal/metal_large_debris2.wav",511,100)
			self.Weapon:EmitSound( "ambient/explosions/explode_3.wav", 511, 100 )
			
		else
		
			self:EmitSound("physics/metal/metal_box_break1.wav", 250, 60 )
		
		end
		
	end
	
end


function ENT:Use(ply,caller)

	if ( !self.IsFlying && !IsValid( self.Pilot ) ) then 
		
		self:Jet_DefaultUseStuff( ply, caller )
		
		self.pilotmodel = ents.Create("prop_dynamic")
		self.pilotmodel:SetModel( self.Pilot:GetModel() )
		self.pilotmodel:SetPos( self:LocalToWorld( Vector( -41,0,-4 )  ) )
		self.pilotmodel:SetAngles( self:GetAngles() )
		self.pilotmodel:SetSolid( SOLID_NONE )
		self.pilotmodel:SetParent( self )
		self.pilotmodel:SetKeyValue( "DefaultAnim", "ACT_DRIVE_AIRBOAT" )
		self.pilotmodel:SetKeyValue( "disableshadows", 1 )
		self.pilotmodel:Spawn()
		self.pilotmodel:SetColor( Color( 255,255,255,255 ) )
		//self:UpdatePilotModel()
		
   end
   
end

function ENT:Think()
//THIS WAS ADDED.
	self.Pitch = math.Clamp( math.floor( self:GetVelocity():Length() / 20 + 40 ),0,245 )

	for i = 1,2 do
	
		self.EngineMux[i]:ChangePitch( self.Pitch, 0.01 )
		
	end

	//SILLIRION: HERE IS THE CODE THAT MOVES THE AILERONS, TURNS ON THE PROPELLER AND THE PROPELLER MOTION BLUR EFFECT.
	--//NOTE: This needs to be in the "THINK" function or in a loop, since it needs to be updated all the time.
	local phys = self:GetPhysicsObject()
	--//always do a isvalid check!!
	if phys:IsValid() then

			local PlaneDrive = phys:GetAngleVelocity()
			self:SetPoseParameter( "move_yaw", PlaneDrive.z * 1.0 ) 

	//Disabled 'cause it makes the rest looks odd
	//			self:SetPoseParameter( "move_pitch", PlaneDrive.x * 1.0 ) 

	//Redundant
	//			local PlaneVelocity = phys:GetVelocity()
	//			self:SetPoseParameter( "move_propeller", PlaneVelocity.x * 0.1 ) 

//Propeller Blur effect. change the value number to fit it best for the airplane velosity
		if phys:GetVelocity():Length() >= 800 then
			self:SetBodygroup( 0, 4 );	
			elseif phys:GetVelocity():Length() >= 400 then
			self:SetBodygroup( 0, 3 );	
			elseif phys:GetVelocity():Length() >= 200 then
			self:SetBodygroup( 0, 2 );	
			elseif phys:GetVelocity():Length() >= 100 then
			self:SetBodygroup( 0, 1 );	
			else
			self:SetBodygroup( 0, 1 );	
		end
end
//END OF WHAT WAS ADDED.

	if ( self.Destroyed ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		
		if self.DeathTimer > 35 then
		
			self:EjectPilot()
			self:Remove()
		
		end

		if self.DeathTimer > 100 then
		
			self:DeathFX()
	
		end
		
	end
	
	if ( self.IsFlying && IsValid( self.Pilot ) ) then
		
		if( self.Pilot:KeyDown( IN_ATTACK ) ) then
		
			//seq = self:LookupSequence( "idle_smg1" )
		
		elseif( self.Pilot:KeyDown( IN_ATTACK2 ) ) then
		
			//seq = self:LookupSequence( "elevatorScramble_PostIdle" ) 
		
		end

		self.Pilot:SetPos( self:GetPos() + self:GetUp() * 500 )
		
		
		self:NeuroPlanes_CycleThroughJetKeyBinds()
		
		if ( self.LastLaserUpdate + 0.5 <= CurTime() ) then
			
			self.LastLaserUpdate = CurTime()
			if ( IsValid( self.LaserGuided ) ) then
				
				self:SetNetworkedBool( "DrawTracker",false)
						
			end
			
		end
		
		// Ejection Situations.
		if ( self:WaterLevel() > 2 ) then
		
			self:EjectPilot()
			
		end

	end
	
//	self:ResetSequence( seq )
	
	self:NextThink( CurTime() )
	
	return true
	
end

function ENT:PrimaryAttack()
	
	if ( !IsValid( self.Pilot ) ) then
		
		return
		
	end
	
	self:Jet_FireMultiBarrel()
	self:EmitSound( "Vickers.wav", 510, math.random( 100, 130 ) )
	
	self.LastPrimaryAttack = CurTime()
	
end


function ENT:SecondaryAttack( wep, id )
	
	if ( IsValid( wep ) ) then
	
		self:NeuroPlanes_FireRobot( wep, id )
		
	end
	
end

function ENT:PhysicsSimulate( phys, deltatime )
	
	if ( self.IsFlying && !self.Destroyed ) then
	
		phys:Wake()
		
		local p = { { Key = IN_FORWARD, Speed = 1.15 };
					{ Key = IN_BACK, Speed = -0.95 }; }
					
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
			
		else
		
			pitch = pilotAng.p
	
		end
	
		
		drag = -150 + mvel / 8
		
		local pr = {}
		pr.secondstoarrive	= 1
		pr.pos 				= self:GetPos() + self:GetForward() * self.Speed + Vector( 0,0,1 ) * drag
		pr.maxangular		= 40
		pr.maxangulardamp	= 40
		pr.maxspeed			= 1000000
		pr.maxspeeddamp		= 10000
		pr.dampfactor		= 0.75
		pr.teleportdistance	= 10000
		pr.deltatime		= deltatime
		pr.angle = Angle( pitch, pilotAng.y, pilotAng.r ) + Angle( 0, 0, r )
		
		phys:ComputeShadowControl(pr)
					
	end
	
end
