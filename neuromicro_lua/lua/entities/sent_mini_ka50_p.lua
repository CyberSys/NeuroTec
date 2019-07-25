ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Kamov Ka-50 Hokum"
ENT.Author	= "Hoffa / Hoffa"
ENT.Category 		= "NeuroTec Micro Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_HELICOPTER
ENT.IsHelicopter = true 
ENT.HelicopterMaxLift = 135
ENT.HelicopterPitchForce = 14
ENT.HelicopterYawForce = 11 
ENT.HelicopterRollForce = 14
ENT.HelicopterCorrectionalVector = Vector()
ENT.HelicopterTailLiftValue = 0.9
ENT.OverrideWeldStrenght = 35000
ENT.HelicopterLiftAmount = 0.25


ENT.ForceWeldTailToWings = true 

local SCALE = 1.0 

ENT.MainRotorModel = "models/hoffa/neuroplanes/american/ah1/ah1_rotor.mdl"
ENT.MainRotorPos = Vector( 6,0, 9.25 ) * SCALE
ENT.MainRotorAngle = Angle()
ENT.TailRotorModel = "models/hoffa/neuroplanes/american/ah1/ah1_rotor.mdl" 
ENT.TailRotorPos = Vector( 6,0, 9.25+10 ) * SCALE
ENT.TailRotorAngle = Angle(0,0,0)
ENT.CoaxialRotor = true 
-- ENT.HasCrane = true 
-- ENT.CranePos = Vector( 0,105,0)

ENT.ServiceCeiling = 13500
ENT.NeverExceedSpeed = 350

ENT.MaxVelocity = 350 * 1.8 
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = .55					-- momentum damping
ENT.AngDamping = 3.1					-- angular momentum damping
ENT.CurVelocity = 0
ENT.InitialHealth = 400

ENT.Model 			= "models/hoffa/neuroplanes/russian/kamov/ka50_body.mdl"
ENT.TailModel 		= "models/hoffa/neuroplanes/russian/kamov/ka50_tail.mdl"
ENT.WingModels 		= { "models/hoffa/neuroplanes/russian/kamov/ka50_wing_l.mdl", 
						"models/hoffa/neuroplanes/russian/kamov/ka50_wing_r.mdl" }

-- ENT.PontoonPos = { Vector(-8,-15,-8),Vector(-8,15,-8) }
-- ENT.PontoonAngles = { Angle( 5,0,0),Angle( 5,0,0) }
-- ENT.PontoonModels = {"models/neuronaval/killstr3aks/mini_torpedo_planes.mdl", "models/neuronaval/killstr3aks/mini_torpedo_planes.mdl" }
-- ENT.PontoonBuoyancy = 5010.0 
-- ENT.PontoonMass = 50

ENT.TailPos			= Vector( 0, 0, -0 )
ENT.WingPositions 	= {  Vector( 0,0,-0 ), 
						Vector( 0,-0,-0 ) }

-- Weapons
ENT.PhysicalAmmo = true
-- ENT.NoSecondaryWeapons = true
ENT.BurstSize = 6
ENT.RoundsPerSecond = 2
ENT.BurstDuration = 0.08
ENT.PhysShellSpawnOffset = 72 

-- ENT.NoLockon = true
ENT.PrimaryCooldown = 0.1
ENT.MuzzleOffset = 85
ENT.Muzzle = "microplane_MG_muzzleflash"
ENT.PCFMuzzle = true -- use .pcf muzzleflash
ENT.MinDamage = 40
ENT.MaxDamage = 80
ENT.Radius = 12
ENT.AmmoType = "sent_mini_shell" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = "wt/guns/type97_gun.wav" 
ENT.MachineGunModel = "models/hoffa/neuroplanes/russian/kamov/ka50_barrel.mdl"
ENT.PrimaryShootSound = Sound(  "wt/guns/mg_13mm_dshk_loop.wav"  )
ENT.ContigiousFiringLoop = true

-- ENT.MinigunSound = "wt/guns/type97_gun.wav"
ENT.MinigunPos = {  Vector( 41, 0, -17 )  * SCALE }
-- ENT.TurretModel = { "models/hoffa/neuroplanes/american/ah1/ah1_turret.mdl" }
-- ENT.TurretPos = { Vector( 50, 0, -9) * SCALE }
ENT.PrimaryMaxShots = 30
ENT.ShowMinigun = true 
ENT.AimGun = true 
ENT.GunHasBones = true 
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 27, 2.4, -4.2),
			Ang = Angle(),
			Scale = .005
		};
		Compass = {
			Pos = Vector( 27, -.1, -4.2 ),
			Ang = Angle(),
			Scale = .005
		};
		VSpeed = {
			Pos = Vector( 27, 2.4, -2.9 ),
			Ang = Angle(),
			Scale = .005
		};
		Altimeter = {
			Pos = Vector( 27, -0.1, -2.9 ),
			Ang = Angle(),
			Scale = .005
		};		
		Airspeed = {
			Pos = Vector( 27, 1.15, -2.9 ),
			Ang = Angle(),
			Scale = .005
		};
		Throttle = {
			Pos = Vector( 27, 1.8, -3.55 ),
			Ang = Angle(0,0,0),
			Scale = .01
		};

		
		
	}
-- End of weapons

-- Visuals
ENT.CameraDistance = 180
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.JetExhaust = true 
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = .5
ENT.ExhaustDieTime = .1
ENT.CockpitPosition = Vector(22.75, 0, -1.75  ) * SCALE
ENT.TrailPos = { Vector( -14, 214, 35 ) * SCALE, Vector( -14, -214, 35 ) * SCALE }
ENT.FireTrailPos = { Vector( 2, -22, 32 ) * SCALE, Vector( 76, 17, 2 ) * SCALE }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( -17, -7.5, -4 ),
Vector( -15, -7.5, -5 ),
Vector( -13, -7.5, -6 ),
Vector( -10, -7.5, -7 ),
Vector( -17, 7.5, -4 ),
Vector( -15, 7.5, -5 ),
Vector( -13, 7.5, -6 ),
Vector( -10, 7.5, -7 )
}

-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"npc/attack_helicopter/aheli_rotor_loop1.wav",
	"vehicles/fast_windloop1.wav",
	"physics/cardboard/cardboard_box_scrape_smooth_loop1.wav"
	}
-- ENT.EngineStartupSound = "helicopter/Mil Mi-28_engine.wav"

ENT._2ndCD = 0.15 -- Override Mouse2 cooldown
ENT.TracerScale1  = 0.1
ENT.TracerScale2 = 0.1
ENT.TracerGlowProxy = .7 
ENT._2ndRecoilAngle = 1.05 
ENT._2ndRecoilDuration = 10 
ENT._2ndRecoilForce = -500000

--ENT.ArmamentDamageSystem = false 

ENT.ArmamentAttachedToWings = false 
ENT.Armament = {	

					{ 
						PrintName = "Pretty Mean Cannon",
						Mdl = "models/hoffa/neuroplanes/russian/kamov/ka50_pods.mdl" ,
						Pos = Vector( 11, -16, -13), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 							-- Ang, object angle
						Type = "Shell",										-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 0.1, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						-- Color = Color( 0,0,0,0 ),
						Class = "sent_mini_shell",
						LaunchSound = "wt/guns/m4_singleshot.wav"
					};
					{ 
						PrintName = "Pretty Mean Cannon",
						Mdl = "models/hoffa/neuroplanes/russian/kamov/ka50_pods.mdl" ,
						Pos = Vector( 11, 16, -13), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 							-- Ang, object angle
						Type = "Shell",										-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 0.1, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						-- Color = Color( 0,0,0,0 ),
						Class = "sent_mini_shell",
						LaunchSound = "wt/guns/m4_singleshot.wav"
					};
					{ 
						PrintName = "Air-to-Air",
						Mdl ="models/hoffa/neuroplanes/russian/kamov/ka50_rockets.mdl" ,
						Pos =  Vector(11, -24, -16.5 )  * SCALE, 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 7, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 
					{ 
						PrintName = "Air-to-Air",
						Mdl ="models/hoffa/neuroplanes/russian/kamov/ka50_rockets.mdl" ,
						Pos =  Vector(11, -24, -15 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 7, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					};
					{ 
						PrintName = "Air-to-Air",
						Mdl ="models/hoffa/neuroplanes/russian/kamov/ka50_rockets.mdl" ,
						Pos =  Vector(11, -20, -16.5 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 7, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 
					{ 
						PrintName = "Air-to-Air",
						Mdl ="models/hoffa/neuroplanes/russian/kamov/ka50_rockets.mdl" ,
						Pos =  Vector(11, -20, -15 )  * SCALE, 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 7, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 
					{ 
						PrintName = "Air-to-Air",
						Mdl ="models/hoffa/neuroplanes/russian/kamov/ka50_rockets.mdl" ,
						Pos =  Vector(11, 24, -16.5 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 7, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 
					{ 
						PrintName = "Air-to-Air",
						Mdl ="models/hoffa/neuroplanes/russian/kamov/ka50_rockets.mdl" ,
						Pos =  Vector(11, 24, -15 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 7, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					};
					{ 
						PrintName = "Air-to-Air",
						Mdl ="models/hoffa/neuroplanes/russian/kamov/ka50_rockets.mdl" ,
						Pos =  Vector(11, 20, -16.5 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 7, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 
					{  
						PrintName = "Air-to-Air",
						Mdl ="models/hoffa/neuroplanes/russian/kamov/ka50_rockets.mdl" ,
						Pos =  Vector(11, 20, -15 )  * SCALE, 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 7, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 

		
				};
if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 25
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
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime )

		self:MicroHeloPhys()
		
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end
