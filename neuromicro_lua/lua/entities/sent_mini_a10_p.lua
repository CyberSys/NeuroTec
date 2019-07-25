ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "A-10 Microbolt II"
ENT.Author	= "Hoffa / StarChick971"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 600

ENT.ServiceCeiling = 36000 -- Used by Altimeter 
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 38, 2.65, 5 ),
			Ang = Angle(),
			Scale = .01
		};
		Compass = {
			Pos = Vector( 38, -.65, 3.7 ),
			Ang = Angle(),
			Scale = .005
		};
		VSpeed = {
			Pos = Vector( 38, 3.25, 4.75 ),
			Ang = Angle(),
			Scale = .005
		};
		
		Clock = {
			Pos = Vector( 38, 3.75, 3.95 ),
			Ang = Angle(),
			Scale = .003
		};
		
		Airspeed = {
			Pos = Vector( 38, 3.25, 3.5 ),
			Ang = Angle(),
			Scale = .005
		};
		
		Altimeter = {
			Pos = Vector( 39, -.75, 4.7 ),
			Ang = Angle(),
			Scale = .005
		};	
		FuelCounter = {
			Pos = Vector( 39, -0.75, 1.85 ),
			Ang = Angle(),
			Scale = .005
		};			
		EngineTemp = {
			Pos = Vector( 39, -2, 1.85 ),
			Ang = Angle(),
			Scale = .005
		};	
		
		Throttle = {
			Pos = Vector( 39, 4.82, 3.25 ),
			Ang = Angle(),
			Scale = .0075
		};
		
		
	}
ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/starchick971/neuroplanes/american/a-10 thunderbolt ii_elevator.mdl", 
			Pos = Vector(-10.5,0,-0.5 ),
			Ang = Angle( 0,0,0 )
			};
	Rudder = {	
				{	
					Mdl = "models/starchick971/neuroplanes/american/a-10 thunderbolt ii_rudder_l.mdl",
					Pos = Vector(-9.5,20.5,7.5),
					Ang = Angle( 0,0,0 )
				};
			
				{	
					Mdl = "models/starchick971/neuroplanes/american/a-10 thunderbolt ii_rudder_r.mdl",
					Pos = Vector(-9.5,-20.5,7.5),
					Ang = Angle( 0,0,0 )
				};
			}; 
			
	Ailerons = {
			{
			Mdl = "models/starchick971/neuroplanes/american/a-10 thunderbolt ii_aileron_l.mdl",
			Pos = Vector(-10,47,0),
			Ang = Angle( 0,-0,0 )
			};
			{
			Mdl = "models/starchick971/neuroplanes/american/a-10 thunderbolt ii_aileron_r.mdl",
			Pos = Vector(-10,-47,0),
			Ang = Angle( 0,0,-0)
			};
		};
	Flaps = {
			{
			Mdl = "models/starchick971/neuroplanes/american/a-10 thunderbolt ii_flap_l1.mdl",
			Pos = Vector(-11,14,-2),
			Ang = Angle( 0,0,0 )
			};
			{
			Mdl = "models/starchick971/neuroplanes/american/a-10 thunderbolt ii_flap_r1.mdl",
			Pos = Vector(-11,-14,-2),
			Ang = Angle( 0,0,0)
			};
			{
			Mdl = "models/starchick971/neuroplanes/american/a-10 thunderbolt ii_flap_l2.mdl",
			Pos = Vector(-11,27.7,-1.5),
			Ang = Angle( 0,0,5.8 ) -- the outwards flaps on the A-10 have a 5.8 degree angle apparently.
			};
			{
			Mdl = "models/starchick971/neuroplanes/american/a-10 thunderbolt ii_flap_r2.mdl",
			Pos = Vector(-11,-27.7,-1.5),
			Ang = Angle( 0,0,-5.8 )
			};

			
			
		};
}

ENT.CockpitModel = "models/hawx/planes/cockpits/a-10 thunderbolt ii_cockpit.mdl"

ENT.Model 			= "models/starchick971/neuroplanes/american/a-10 thunderbolt ii_body.mdl"
ENT.TailModel 		= "models/starchick971/neuroplanes/american/a-10 thunderbolt ii_tail.mdl"
ENT.WingModels 		= { "models/starchick971/neuroplanes/american/a-10 thunderbolt ii_wing_l.mdl", 
						"models/starchick971/neuroplanes/american/a-10 thunderbolt ii_wing_r.mdl" }
ENT.PropellerModels 	= { "models/props_phx2/garbage_metalcan001a.mdl","models/props_phx2/garbage_metalcan001a.mdl" }

ENT.TailPos			= Vector( -43, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,-18 ), 
						Vector( 0,0,-18 ) }
						
ENT.PropellerAttachedToWings = false 
ENT.PropellerPos 	= { Vector( -30, -10, 5 ), Vector( -30, 10, 5 )  }
ENT.PropellerFireOffset = 32

--- Physics                                                                          
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 50	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 17 				--unused atm
ENT.ThrottleIncrementSize = 6000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 4500 	-- how fast we drop speed
ENT.RudderMultiplier = 25 			-- how much we turn 
ENT.PitchValue = 16					-- how fast we rise / dive
ENT.AutoRollYawFactor = 170			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 1000		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 55			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 1000			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5.935					-- momentum damping
ENT.AngDamping = 5.84					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 11					-- Propeller Phys Obj Mass
ENT.BankForce = 620					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
ENT.BankForceDivider = 1.5
ENT.PitchForceDivider = .25
ENT.YawForceDivider = 0.3

-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics

-- Mouse Aim Variables.
ENT.MousePichForceMult = 1.2 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 1.0 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 70 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 30 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1.0 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 


-- Weapons
ENT.PhysicalAmmo = true
ENT.MeanFuckingCannon = true
ENT.MeanCannonSonicSound = "micro/gau8_humm2.wav"
ENT.MeanCannonSonicSoundEnd = { "micro/gau8_humm4.wav", "micro/gau8_humm5.wav", "micro/gau8_humm6.wav" }

-- ENT.NoSecondaryWeapons = true
-- ENT.BurstSize = 3
-- ENT.RoundsPerSecond = 1
-- ENT.BurstDuration = 0.08

ENT.TracerScale1 = 0.05
ENT.TracerScale2 = 0.05
ENT.ImpactScale = 1
ENT.TracerGlowProxy = .5

ENT.NoLockon = false
ENT.PrimaryCooldown = 0.075
ENT.MuzzleOffset = 85
-- ENT.Muzzle = "microplane_MG_muzzleflash"
ENT.PCFMuzzle = false -- use .pcf muzzleflash
ENT.MinDamage = 250
ENT.MaxDamage = 350
ENT.Radius = 16
ENT.AmmoType = "sent_mini_shell" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = "micro/gau8_test.wav" 
ENT.PrimaryStopSound = "micro/gau8_end_test.wav"
ENT.ContigiousFiringLoop = true
ENT.MegaMuzzle = true 


-- ENT.MinigunSound = "wt/guns/m2_loop.wav"
ENT.MinigunPos = {  Vector( 19, 0, -5 ) }
ENT.PrimaryMaxShots = 25

-- End of weapons

-- Visuals
ENT.CameraDistance = 150
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 28.9, 0, 6.7 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 2 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.JetExhaust = true
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = .5
ENT.ExhaustDieTime = 1

ENT.ExhaustPos = { 
Vector( -37,10,5 ), Vector( -37, -10,5 )
}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"physics/metal/canister_scrape_smooth_loop1.wav",
	"physics/cardboard/cardboard_box_scrape_smooth_loop1.wav",
	"lockon/A10AroundEngine.mp3"
	}

-- Additional variables for using shells in ammo table
ENT.BombSound = "wt/guns/50mm_shot.wav" -- if LaunchSound isnt working in the armament table, use this as fallback.
ENT._2ndCD = 0.15 -- Override Mouse2 cooldown
ENT._2ndRecoilAngle = 1
ENT.TracerScale1  = 0.12
ENT.TracerScale2 = 0.1
ENT.TracerGlowProxy = 1 
ENT.ArmamentAttachedToWings = true 
ENT.FatRecoil = true
ENT.RecoilForce = -600000 --- Units/s force
ENT.RecoilAngle = 3.05 -- Degrees up on pitch axis
ENT.RecoilDuraiton = 0.059 -- Seconds

ENT.ArmamentDamageSystem = true 
ENT.Armament = {



					{ 
						PrintName = "GBU-12 Paveway II",
						Mdl = "models/starchick971/hawx/weapons/gbu-12 paveway-ii.mdl" ,
						Pos = Vector( -2, -34.75, -6), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 5, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_bomb",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "wt/misc/bomb_drop.wav"
					}; 	
					
					{  
						PrintName = "GBU-12 Paveway II",
						Mdl = "models/starchick971/hawx/weapons/gbu-12 paveway-ii.mdl" ,
						Pos = Vector( -2, 34.75, -6), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 5, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_bomb",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "wt/misc/bomb_drop.wav"
					}; 	
					
					{  
						PrintName = "AGM-84 Harpoon",
						Mdl = "models/starchick971/hawx/weapons/agm-84 harpoon.mdl" ,
						Pos = Vector( -6, -42.75, -3), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 2.5, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 	
					{  
						PrintName = "AGM-84 Harpoon",
						Mdl ="models/starchick971/hawx/weapons/agm-84 harpoon.mdl" ,
						Pos = Vector( -6, 42.75, -3), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 2.5, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 
					
					---disabled napalm
					--{ 
						--PrintName = "Napalm",
						--Mdl = "models/starchick971/hawx/weapons/drop tank.mdl" ,
						--Pos = Vector( -2, -12, -9), 							-- Pos, Hard point location on the plane fuselage.
						--Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						--Type = "Bomb",						-- Type, used when creating the object
						--BurstSize = 1,
						--Cooldown = 9999, 										-- Cooldown between weapons
						--isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						--Class = "sent_mini_napalm",
						-- Color = Color( 0,0,0,0 ),
						--LaunchSound = "wt/misc/bomb_drop.wav"
					--}; 	
					
					--{  
						--PrintName = "Napalm",
						--Mdl = "models/starchick971/hawx/weapons/drop tank.mdl" ,
						--Pos = Vector( -2, 12, -9), 							-- Pos, Hard point location on the plane fuselage.
						--Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						--Type = "Bomb",						-- Type, used when creating the object
						--BurstSize = 1,
						--Cooldown = 1, 										-- Cooldown between weapons
						--isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						--Class = "sent_mini_napalm",
						-- Color = Color( 0,0,0,0 ),
						--LaunchSound = "wt/misc/bomb_drop.wav"
					--}; 	
					
				{  
						PrintName = "Air-to-Ground Missile",
						Mdl = "models/starchick971/hawx/weapons/agm-65 maverick.mdl" ,
						Pos = Vector( -3, -25.9, -6.7), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Singlelock",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 10, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_agm",
					--	-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 	
					{  
						PrintName = "Air-to-Ground Missile",
						Mdl ="models/starchick971/hawx/weapons/agm-65 maverick.mdl" ,
						Pos = Vector( -3, 25.9, -6.7), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Singlelock",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 10, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_agm",
						-- -- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 				
					
				};
if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 512
		local ent = ents.Create( class )
		ent:SetPos( SpawnPos )
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()
		-- constraint.Weld( ent, game.GetWorld(), 0,0,0, true )
		timer.Simple( 0, function() if( IsValid( ply ) && IsValid( ent ) ) then ent:Use( ply,ply,0,0 ) end end )
		if( ply:IsAdmin() && type( ent.AdminArmament ) == "table" ) then
			ent:AddAdminEquipment()
		end

		return ent
	end
	function ENT:Initialize() 
	
		self:CivAir_DefaultInit()
		timer.Simple(0.1, function()
			
			if( IsValid( self ) ) then
			
				local skin = math.random(0,6)
				local parts = self:GetPlaneParts()
				
				for k,v in pairs( parts ) do 
					if( IsValid( v ) ) then
						
						v:SetSkin( skin )
						
					end
					
				end
				self.Rudders[2]:SetSkin( skin )
				for i=1,#self.Flaps do 
					if( IsValid( self.Flaps[i] ) ) then
						self.Flaps[i]:SetSkin( skin )
						
					end
				end
						
				self:SetSkin( skin )
				
			end
			
		end )
	
	end
	function ENT:UpdateTransmitState()	return TRANSMIT_ALWAYS end
	function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
	function ENT:OnRemove() self:CivAir_OnRemove() end
	function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
	function ENT:Use(ply,caller, a, b ) self:CivAir_DefaultUse( ply,caller, a , b ) end
	function ENT:Think()  
	
		-- self:NextThink( CurTime()-1)
		-- if( IsValid( self.Pilot ) ) then
			
			-- self.Pilot:PrintMessage(HUD_PRINTCENTER, "ObjectCount: "..#ents.GetAll() )
		
		-- end 
		
	end
	
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) 
	
		self:JetAir_Think()
		self:GetPhysicsObject():AddAngleVelocity( Vector( 0, -2, -1.0 )  * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
	
	end

end
	util.PrecacheModel( ENT.CockpitModel )
if( CLIENT ) then 
	

	function ENT:Initialize() 
		
		-- print("WTF?")
		self:CivAir_CInit() 
		self.Cockpit = ents.CreateClientProp( self.CockpitModel )
		self.Cockpit:SetPos( self:GetPos() )
		self.Cockpit:SetAngles( self:GetAngles() )
		self.Cockpit:SetMoveType( MOVETYPE_NONE )
		self.Cockpit:SetParent( self )
		self.Cockpit:SetLegacyTransform( false )
		self.Cockpit:SetModelScale( 0.185, 0  )
		
		self.Cockpit:Spawn()
		self.Cockpit:SetRenderMode( RENDERMODE_TRANSALPHA )
		self:SetRenderMode( RENDERMODE_TRANSALPHA )
		self.Cockpit:SetColor( Color( 255,255,255,0 ) )
		self.Cockpit:SetSkin( self:GetSkin() ) 
		
		-- print( self.Cockpit )
		-- self.Cockpit:SetRenderClipPlaneEnabled( true )
		-- self.Cockpit:SetRenderClipPlane( self:GetPos(), 0 )
		
		-- self:DelteOnRemove( self.Cockpit )
		-- timer.Simple(1, function()
			
				
			-- end)
	
	end
	function ENT:Think()
		
		if( LocalPlayer() == self:GetNetworkedEntity("Pilot") ) then 
			
			self.Cockpit:SetSkin( self:GetSkin() ) 
			
			if( GetConVarNumber("jet_cockpitview") == 1 ) then
				
				self.Cockpit:SetColor( Color( 255,255,255,255 ) )
				-- self:SetRenderMode( RENDERMODE_TRANSALPHA )
				self:SetColor( Color( 255,255,255, 0 ) ) 
				self:SetNoDraw( true )
				
			else
				
				self.Cockpit:SetColor( Color( 255,255,255,0 ) )
				-- self:SetRenderMode( RENDERMODE_TRANSALPHA )
				self:SetColor( Color( 255,255,255, 255 ) ) 
				self:SetNoDraw( false )
				
			end
			
		end
		
	end
	
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() 
		-- print(  self:GetNetworkedEntity("Pilot") )
		self:DrawModel()
		self:CivAir_Draw() 
		-- print( self:GetNetworkedEntity("Pilot" ) )


		
	end
	function ENT:OnRemove()
		
		if( IsValid( self.Cockpit ) ) then
		
			self.Cockpit:Remove()
			
		end
	end
end
