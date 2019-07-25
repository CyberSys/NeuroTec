ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Harbin Z-9"
ENT.Author	= "Hoffa / Hoffa"
ENT.Category 		= "NeuroTec Micro Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_HELICOPTER
ENT.IsHelicopter = true 
ENT.HelicopterMaxLift = 125 
ENT.HelicopterPitchForce = 3
ENT.HelicopterYawForce = 5
ENT.HelicopterRollForce = 7
ENT.HelicopterCorrectionalVector = Vector( -0,0,-0 )
ENT.HelicopterTailLiftValue = 0.91
ENT.OverrideWeldStrenght = 35000
ENT.ForceWeldTailToWings = true 
local SCALE = 0.75 
 
ENT.ServiceCeiling = 11500
ENT.NeverExceedSpeed = 360
ENT.CockpitPosition = Vector( 23, 5, -6.5 ) * SCALE
ENT.PassengerPos = Vector( 10, 0,  2 ) * SCALE
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 22, 4.2, -7.15),
			Ang = Angle(),
			Scale = 0.0025
		};
		Compass = {
			Pos = Vector( 22, 4.85, -7.05 ),
			Ang = Angle(),
			Scale = 0.0025
		};
		VSpeed = {
			Pos = Vector( 22, 4.25, -8.1 ),
			Ang = Angle(),
			Scale = 0.00275
		};
		Clock = {
			Pos = Vector( 22, 3.4, -7.15),
			Ang = Angle(),
			Scale = 0.002
		};		
		Airspeed = {
			Pos = Vector( 22, 2.65, -7),
			Ang = Angle(),
			Scale = 0.0025
		};
		Altimeter = {
			Pos = Vector( 22, 2.0, -7),
			Ang = Angle(),
			Scale = 0.0025
		};
		Throttle = {
			Pos = Vector( 22, 5.25, -7.45 ),
			Ang = Angle(),
			Scale = 0.005
		};
		EngineTemp = {
			Pos = Vector( 22, 3.5, -8.4 ),
			Ang = Angle(0,0,0),
			Scale = .0025
		};
		FuelCounter = {
			Pos = Vector( 22, 3.5, -7.7 ),
			Ang = Angle(0,0,0),
			Scale = .0025
		};
	}

ENT.MainRotorModel = "models/hoffa/neuroplanes/american/z9/rotor.mdl"
ENT.MainRotorPos = Vector(0,0,10) * SCALE
ENT.MainRotorAngle = Angle()
ENT.TailRotorModel = "models/hoffa/neuroplanes/american/z9/tailrotor.mdl" 
ENT.TailRotorPos = Vector( -76, -1.5, -9.5 ) * SCALE
ENT.TailRotorAngle = Angle()

ENT.MaxVelocity = 380 * 1.8 
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = .61					-- momentum damping
ENT.AngDamping = 3					-- angular momentum damping
ENT.CurVelocity = 0
ENT.InitialHealth = 350

ENT.Model 			= "models/hoffa/neuroplanes/american/z9/body.mdl"
ENT.TailModel 		= "models/hoffa/neuroplanes/american/z9/tail.mdl"
ENT.WingModels 		= { "models/hoffa/neuroplanes/american/z9/wing_l.mdl", 
						"models/hoffa/neuroplanes/american/z9/wing_r.mdl" }

-- ENT.PontoonPos = { Vector(-8,-15,-8),Vector(-8,15,-8) }
-- ENT.PontoonAngles = { Angle( 5,0,0),Angle( 5,0,0) }
-- ENT.PontoonModels = {"models/neuronaval/killstr3aks/mini_torpedo_planes.mdl", "models/neuronaval/killstr3aks/mini_torpedo_planes.mdl" }
-- ENT.PontoonBuoyancy = 5010.0 
-- ENT.PontoonMass = 50

ENT.TailPos			= Vector(  ) * SCALE
ENT.WingPositions 	= {  Vector(  ) * SCALE, 
						Vector(  ) * SCALE }

ENT.PhysicalAmmo = true
-- ENT.NoSecondaryWeapons = true
ENT.BurstSize = 6
ENT.RoundsPerSecond = 2
ENT.BurstDuration = 0.08

-- ENT.NoLockon = true
ENT.PrimaryCooldown = 0.1
ENT.MuzzleOffset = 26
ENT.Muzzle = "microplane_MG_muzzleflash"
ENT.PCFMuzzle = true -- use .pcf muzzleflash
ENT.MinDamage = 40
ENT.MaxDamage = 80
ENT.Radius = 12
ENT.AmmoType = "sent_mini_shell" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/hoffa/neuroplanes/american/z9/barrel.mdl"
ENT.PrimaryShootSound = "wt/guns/type97_gun.wav" 
-- ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound(  "wt/guns/type97_gun.wav"  )
ENT.ContigiousFiringLoop = true
-- ENT.NoGuns = true 

-- ENT.MinigunSound = "wt/guns/type97_gun.wav"
ENT.MinigunPos = {  Vector( 11, 10, -7.5 ), Vector( 11,-11,-7.5 ) }
ENT.PrimaryMaxShots = 30
ENT.ShowMinigun = true 
ENT.AimGun = true 
ENT.GunHasBones = true 

-- End of weapons
ENT.TailRotorAddPush = 50

-- Visuals
ENT.CameraDistance = 180
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.JetExhaust = true 
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = .5
ENT.ExhaustDieTime = .1

ENT.TrailPos = { Vector( -14, 214, 35 ) * SCALE, Vector( -14, -214, 35 ) * SCALE }
ENT.FireTrailPos = { Vector( 2, -22, 32 ) * SCALE, Vector( 76, 17, 2 ) * SCALE }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( -21, -4.6, 0 ) * SCALE,
Vector( -21, 4.6, 0 ) * SCALE,
}

-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"npc/attack_helicopter/aheli_rotor_loop1.wav",
	"vehicles/fast_windloop1.wav"}
-- ENT.EngineStartupSound = "helicopter/Mil Mi-28_engine.wav"

ENT._2ndCD = 0.15 -- Override Mouse2 cooldown
ENT.TracerScale1  = 0.1
ENT.TracerScale2 = 0.1
ENT.TracerGlowProxy = 1 
ENT._2ndRecoilAngle = 1.05 
ENT._2ndRecoilDuration = 10 
ENT._2ndRecoilForce = -500000

ENT.ArmamentAttachedToWings = false 
ENT.Armament = {
					{ 
						PrintName = "Air-to-Air",
						Mdl ="models/starchick971/hawx/weapons/aim-9 sidewinder.mdl" ,
						Pos =  Vector(0, -17, -15.5-5 ) * .55 , 							-- Pos, Hard point location on the plane fuselage.
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
						Mdl ="models/starchick971/hawx/weapons/aim-9 sidewinder.mdl" ,
						Pos =  Vector(0, -17, -12-5 ) * .55  , 							-- Pos, Hard point location on the plane fuselage.
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
						Mdl ="models/starchick971/hawx/weapons/aim-9 sidewinder.mdl" ,
						Pos =  Vector(0, -21, -15.5-5 )  * .55 , 							-- Pos, Hard point location on the plane fuselage.
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
						Mdl ="models/starchick971/hawx/weapons/aim-9 sidewinder.mdl" ,
						Pos =  Vector(0, -21, -12-5 )  * .55 , 							-- Pos, Hard point location on the plane fuselage.
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
						Mdl ="models/starchick971/hawx/weapons/aim-9 sidewinder.mdl" ,
						Pos =  Vector(0, 17, -15.5-5 ) * .55  , 							-- Pos, Hard point location on the plane fuselage.
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
						Mdl ="models/starchick971/hawx/weapons/aim-9 sidewinder.mdl" ,
						Pos =  Vector(0, 17, -12-5) * .55  , 							-- Pos, Hard point location on the plane fuselage.
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
						Mdl ="models/starchick971/hawx/weapons/aim-9 sidewinder.mdl" ,
						Pos =  Vector(0, 21, -15.5-5 )  * .55 , 							-- Pos, Hard point location on the plane fuselage.
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
						Mdl ="models/starchick971/hawx/weapons/aim-9 sidewinder.mdl" ,
						Pos =  Vector(0, 21, -12-5 ) * .55  , 							-- Pos, Hard point location on the plane fuselage.
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
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 35
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
