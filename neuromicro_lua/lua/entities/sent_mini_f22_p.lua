ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "F-22 Raptor"
ENT.Author	= "Hoffa / StarChick971"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 300
ENT.ControlSurfaces  = {
	Elevator = {
				{	
					Mdl = "models/starchick971/neuroplanes/american/fa-22 raptor_nozzle_l.mdl", 
					Pos = Vector( -45, 5, 1 ),
					Ang = Angle( 0,0,0 )
				};
				{	
					Mdl = "models/starchick971/neuroplanes/american/fa-22 raptor_nozzle_r.mdl", 
					Pos = Vector( -45, -5, 1 ),
					Ang = Angle( 0,0,0 )
				};

			},
	Rudder = {	
				{	
					Mdl = "models/starchick971/neuroplanes/american/fa-22 raptor_rudder_l.mdl",
					Pos = Vector(-42,15.5,12.45),
					Ang = Angle( -24,0,-27 )
				};
			
				{	
					Mdl = "models/starchick971/neuroplanes/american/fa-22 raptor_rudder_r.mdl",
					Pos = Vector(-42,-15.5,12.45),
					Ang = Angle( -24,0,27 )
				};
			}; 
			
	Ailerons = {
			{
			Mdl = "models/starchick971/neuroplanes/american/fa-22 raptor_elevon_l.mdl",
			Pos = Vector(-50,15,1),
			Ang = Angle( 0,-0,0 )
			};
			{
			Mdl = "models/starchick971/neuroplanes/american/fa-22 raptor_elevon_r.mdl",
			Pos = Vector(-50,-15,1),
			Ang = Angle( 0,0,-0)
			};
		};
	Flaps = {
			{
			Mdl = "models/starchick971/neuroplanes/american/fa-22 raptor_flaperon_l.mdl",
			Pos = Vector(-33,15.5,0),
			Ang = Angle( 0,-17,0 )
			};
			{
			Mdl = "models/starchick971/neuroplanes/american/fa-22 raptor_flaperon_r.mdl",
			Pos = Vector(-33,-15.5,0),
			Ang = Angle( 0,17,0)
			};
	
		};
}
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 85, 18.35, 0.25 ),
			Ang = Angle(),
			Scale = 0.03
		};
		Compass = {
			Pos = Vector( 85, 7.5, -4.75 ),
			Ang = Angle(),
			Scale = 0.02
		};		
		FuelCounter = {
			Pos = Vector( 85, 7.5, 0.25 ),
			Ang = Angle(),
			Scale = 0.02
		};
		VSpeed = {
			Pos = Vector( 85, 2, -5.25 ),
			Ang = Angle(),
			Scale = 0.018
		};
		Clock = {
			Pos = Vector( 85, -5, 4 ),
			Ang = Angle(),
			Scale = 0.015
		};
		Altimeter = {
			Pos = Vector( 85, 8, -15.5 ),
			Ang = Angle(0,0,-40),
			Scale = 0.021
		};
		Airspeed = {
			Pos = Vector( 85, 2.0, -.5),
			Ang = Angle(),
			Scale = 0.018
		};
		Throttle = {
			Pos = Vector( 85, 5, -10 ),
			Ang = Angle(0,0,-40),
			Scale = 0.04
		};	
		EngineTemp = {
			Pos = Vector( 85, 13, 4 ),
			Ang = Angle(0,0,-0),
			Scale = 0.015
		};
	}
ENT.CockpitModel = "models/hawx/planes/cockpits/fa-22 raptor_cockpit.mdl"

ENT.Model 			= "models/starchick971/neuroplanes/american/fa-22 raptor_body.mdl"
ENT.TailModel 		= "models/starchick971/neuroplanes/american/fa-22 raptor_fins.mdl"
ENT.WingModels 		= { "models/starchick971/neuroplanes/american/fa-22 raptor_wing_l.mdl", 
						"models/starchick971/neuroplanes/american/fa-22 raptor_wing_r.mdl" }
ENT.PropellerModels 	= { "models/props_phx2/garbage_metalcan001a.mdl","models/props_phx2/garbage_metalcan001a.mdl" }

ENT.TailPos			= Vector( -0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,-0,0 ) }
						
ENT.PropellerAttachedToWings = false 
ENT.PropellerPos 	= { Vector( -40, -5, 1 ), Vector( -40, 5, 1 )  }
ENT.PropellerFireOffset = 32

--- Physics                                                                          
ENT.MinClimb = 15 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -5 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 50	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 17 				--unused atm
ENT.ThrottleIncrementSize = 15000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 35000 	-- how fast we drop speed
ENT.RudderMultiplier = 45 			-- how much we turn 
ENT.PitchValue = 55					-- how fast we rise / dive
ENT.AutoRollYawFactor = 170			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 555		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 123			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 2240 -- dayum			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5.935					-- momentum damping
ENT.AngDamping = 5.84					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 11					-- Propeller Phys Obj Mass
ENT.BankForce = 520					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
ENT.BankForceDivider = 1.5
ENT.PitchForceDivider = .33
ENT.YawForceDivider = 0.11
ENT.OverrideWeldStrenght = 0
ENT.CanSteerAtLowVelocity = true
ENT.SuperFlaps = true 
ENT.ThrustVectoring = true 

ENT.BombdoorModels = { "models/starchick971/neuroplanes/american/fa-22 raptor_missilebaydoor_l.mdl",
						"models/starchick971/neuroplanes/american/fa-22 raptor_missilebaydoor_r.mdl",
						"models/starchick971/neuroplanes/american/fa-22 raptor_bombbaydoor_l.mdl",
						"models/starchick971/neuroplanes/american/fa-22 raptor_bombbaydoor_r.mdl"
						}
ENT.BombdoorPositions = {Vector(10.5,12.5,-1.1),
						 Vector(10.5,-12.5,-1.1),
						 Vector(8,7,-6),
						 Vector(8,-7,-6)
						}
ENT.BombdoorAngles = { Angle( 0,90,0 ),
						Angle( 0,90,0 ),
						Angle( 0,90,0 ),
						Angle( 0,90,0 )}


ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics

-- Mouse Aim Variables.
ENT.MousePichForceMult = 1.9 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 1.0 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 70 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 30 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1.0 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 


-- Weapons
ENT.PhysicalAmmo = true
-- ENT.MeanFuckingCannon = true
-- ENT.MeanCannonSonicSound = "micro/gau8_humm2.wav"
-- ENT.MeanCannonSonicSoundEnd = { "micro/gau8_humm4.wav", "micro/gau8_humm5.wav", "micro/gau8_humm6.wav" }

-- ENT.NoSecondaryWeapons = true
-- ENT.BurstSize = 3
-- ENT.RoundsPerSecond = 1
-- ENT.BurstDuration = 0.08

ENT.TracerScale1 = 0.05
ENT.TracerScale2 = 0.05
ENT.ImpactScale = 1
ENT.TracerGlowProxy = .5

ENT.NoLockon = false
ENT.PrimaryCooldown = 0.11
ENT.MuzzleOffset = 85
ENT.Muzzle = "microplane_MG_muzzleflash"
ENT.PCFMuzzle = true -- use .pcf muzzleflash
ENT.MinDamage = 250
ENT.MaxDamage = 350
ENT.Radius = 16
ENT.AmmoType = "sent_mini_shell" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = "wt/guns/cannon_t_160_loop.wav" 
ENT.PrimaryStopSound = "micro/gau8_end_test.wav"
ENT.ContigiousFiringLoop = true
ENT.MegaMuzzle = true 


-- ENT.MinigunSound = "wt/guns/m2_loop.wav"
ENT.MinigunPos = {  Vector( 0, 6, -1 ) }
ENT.PrimaryMaxShots = 10

-- End of weapons

-- Visuals
ENT.CameraDistance = 250
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 45.9, 0, 9.0 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 2 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.JetExhaust = true
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = .5
ENT.ExhaustDieTime = 1

ENT.ExhaustPos = { 
Vector( -45,5,1 ), Vector( -45, -5,1 )
}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"physics/metal/canister_scrape_smooth_loop1.wav",
	"physics/cardboard/cardboard_box_scrape_smooth_loop1.wav",
	"lockon/A10AroundEngine.mp3"
	}
ENT.VTOL = true 

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
ENT.MoveExhaustWithElevator = true 

ENT.ArmamentDamageSystem = true 
ENT.Armament = {



					{ 
						PrintName = "GBU-12 Paveway II",
						Mdl = "models/starchick971/hawx/weapons/gbu-12 paveway-ii.mdl" ,
						Pos = Vector( 10, -5.75, -1), 							-- Pos, Hard point location on the plane fuselage.
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
						Pos = Vector( 10, 5.75, -1), 							-- Pos, Hard point location on the plane fuselage.
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
						Pos = Vector( 10, -5.75, -1), 							-- Pos, Hard point location on the plane fuselage.
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
						Pos = Vector( 10, 5.75, -1), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 2.5, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					};  	
					
					{  
						PrintName = "Air-to-Ground Missile",
						Mdl = "models/starchick971/hawx/weapons/agm-65 maverick.mdl" ,
						Pos = Vector( 10, -5.9, -1.7), 							-- Pos, Hard point location on the plane fuselage.
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
						Pos = Vector( 10, 5.9, -1.7), 							-- Pos, Hard point location on the plane fuselage.
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
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 12
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
			
				local skin = math.random(0,1)
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
		self:JetAir_Think()
		self:NextThink( CurTime()-1)
		self:SonicBoomTicker()
		-- if( IsValid( self.Pilot ) ) then
			
			-- self.Pilot:PrintMessage(HUD_PRINTCENTER, "ObjectCount: "..#ents.GetAll() )
		
		-- end 
		
	end
	
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) 
	
		if( phys:GetVelocity():Length() < 800 ) then 
			
			self.ThrottleDecreaseSize = 3500 
			
		else
			
			self.ThrottleDecreaseSize = 35000
		
		end 
		self:GetPhysicsObject():AddAngleVelocity( Vector( 5, 18.5, 0.0 )  * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
	
	end

end
	util.PrecacheModel( ENT.CockpitModel )
if( CLIENT ) then 
	

	function ENT:Initialize() 
		
		-- print("WTF?")
		self:CivAir_CInit() 
		self.Cockpit = ents.CreateClientProp( self.CockpitModel )
		self.Cockpit:SetPos( self:GetPos() + self:GetUp() * 5 )
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
