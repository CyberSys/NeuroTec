ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "E.C.H.O FEDERATION"
ENT.Author	= "Hoffa / Aftokinito"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminOnly = true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE
ENT.IsShitPlane = true 

ENT.InitialHealth = 1500
ENT.Armament = {



					{ 
						PrintName = "GBU-12 Paveway II",
						Mdl = "models/starchick971/hawx/weapons/gbu-12 paveway-ii.mdl" ,
						Pos = Vector( -2, -34.75, -6), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 0.5, 										-- Cooldown between weapons
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
						Cooldown = 1, 										-- Cooldown between weapons
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
						Cooldown = 1, 										-- Cooldown between weapons
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
						Cooldown = 1, 										-- Cooldown between weapons
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
						Cooldown = 2, 										-- Cooldown between weapons
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
						Cooldown = 2, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_agm",
						-- -- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 				
					
				};
				
ENT.Model 			= "models/aftokinito/neuroplanes/russian/pe-8_body.mdl"
ENT.TailModel 		= "models/aftokinito/neuroplanes/russian/pe-8_tail.mdl"
ENT.WingModels 		= { "models/aftokinito/neuroplanes/russian/pe-8_wing_l.mdl", 
						"models/aftokinito/neuroplanes/russian/pe-8_wing_r.mdl" }
ENT.PropellerModels 	= { 
"models/aftokinito/neuroplanes/russian/pe-8_prop.mdl",
"models/aftokinito/neuroplanes/russian/pe-8_prop.mdl",
"models/aftokinito/neuroplanes/russian/pe-8_prop.mdl",
"models/aftokinito/neuroplanes/russian/pe-8_prop.mdl"}

ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= {
						Vector( 60, 33.1, 1 ),
						Vector( 46, 75.2, 5 ),
						Vector( 60, -33.1, 1 ),
						Vector( 46, -75.2, 5 )					
					}
ENT.PropellerFireOffset = 32
ENT.PropellerAttachedToWings = true


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
ENT.MouseBankForce = 100 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 


-- Weapons
ENT.PhysicalAmmo = true
ENT.MeanFuckingCannon = true
ENT.MeanCannonSonicSound = "micro/gau8_humm2.wav"
ENT.MeanCannonSonicSoundEnd = { "micro/gau8_humm4.wav", "micro/gau8_humm5.wav", "micro/gau8_humm6.wav" }

-- ENT.NoSecondaryWeapons = true
-- ENT.BurstSize = 3
-- ENT.RoundsPerSecond = 1
-- ENT.BurstDuration = 0.08

ENT.TracerScale1 = 4
ENT.TracerScale2 = 4
ENT.ImpactScale = 2
ENT.TracerGlowProxy = 1

ENT.NoLockon = false
ENT.PrimaryCooldown = 0.075
-- ENT.MuzzleOffset = 85
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
ENT.PrimaryMaxShots = 50
-- End of weapons

-- Visuals
ENT.CameraDistance = 400
ENT.CameraUp = 0
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 5, 0, 12 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }

ENT.PropellerModel 	= "models/props_junk/PopCan01a.mdl"
-- ENT.HideProp = true
-- ENT.NoPropeller = true
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( -12,20,-0 ), Vector( -12, -20, -0 )}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"wt/engines/engine_b25_2300rpm.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/engine_b25_2300rpm.wav"}
	
if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 512
		local ent = ents.Create( class )
		ent:SetPos( SpawnPos )
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()
		timer.Simple( 0, function() if( IsValid( ply ) && IsValid( ent ) ) then ent:Use( ply,ply,0,0 ) end end )
		if( ply:IsAdmin() && type( ent.AdminArmament ) == "table" ) then
			ent:AddAdminEquipment()
		end
		return ent
	end
	function ENT:Initialize() self:CivAir_DefaultInit() end
	function ENT:UpdateTransmitState()	return TRANSMIT_ALWAYS end
	function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
	function ENT:OnRemove() self:CivAir_OnRemove() end
	function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
	function ENT:Use(ply,caller, a, b ) self:CivAir_DefaultUse( ply,caller, a , b ) end
	function ENT:Think() self:JetAir_Think() end
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )		if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) 
		
		if( IsValid( self.Pilot ) && !self.Destroyed ) then
		
			self:GetPhysicsObject():AddAngleVelocity( Vector( 25, 0, 0 ) ) 
		
		end
		
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end
