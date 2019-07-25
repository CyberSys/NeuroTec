ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "AH-64 Apache"
ENT.Author	= "Hoffa / Hoffa"
ENT.Category 		= "NeuroTec Micro Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_HELICOPTER
ENT.IsHelicopter = true 
ENT.HelicopterMaxLift = 135 
ENT.HelicopterPitchForce = 15
ENT.HelicopterYawForce = 17 
ENT.HelicopterRollForce = 15
ENT.HelicopterCorrectionalVector = Vector( .5,0,-0 )
ENT.HelicopterTailLiftValue = 0.919
ENT.OverrideWeldStrenght = 35000
ENT.ForceWeldTailToWings = true 
local SCALE = 0.75 

ENT.ServiceCeiling = 14500
ENT.NeverExceedSpeed = 400

ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 27, 6.25, 1.5 ),
			Ang = Angle(),
			Scale = 0.015
		};
		Compass = {
			Pos = Vector( 27, -1.25+0.25, -1.25 ),
			Ang = Angle(),
			Scale = 0.005
		};
		VSpeed = {
			Pos = Vector( 27,  -1.25+-1.5, -2.2 ),
			Ang = Angle(),
			Scale = 0.0075
		};
		Clock = {
			Pos = Vector( 27,  -1.25+-2.2, -1.25 ),
			Ang = Angle(),
			Scale = 0.005
		};		
		Airspeed = {
			Pos = Vector( 27,  -1.25+.65, -2.2 ),
			Ang = Angle(),
			Scale = 0.008
		};
		Altimeter = {
			Pos = Vector( 27,  -1.25+-1, -1.25),
			Ang = Angle(),
			Scale = 0.005
		};
		Throttle = {
			Pos = Vector( 27, 8, 1 ),
			Ang = Angle(),
			Scale = 0.0125
		};
		EngineTemp = {
			Pos = Vector( 27, -0.75, 1.0 ),
			Ang = Angle(0,0,0),
			Scale = .0075
		};
		FuelCounter = {
			Pos = Vector( 27, -2.5, 1.0 ),
			Ang = Angle(0,0,0),
			Scale = .0075
		};
		-- CockpitLight = {
			-- Pos = Vector( 19, 0, 1 ),
			-- Col = Color( 245,45,45, 255 ),
			-- Mat = Material( "sprites/physg_glow1" ),
			-- Bright = 1,
			-- Size = 32,
		-- };
	
	}

ENT.MainRotorModel = "models/hoffa/neuroplanes/america/apache/rotor.mdl"
ENT.MainRotorPos = Vector(4,0,23) * SCALE
ENT.MainRotorAngle = Angle()
ENT.TailRotorModel = "models/hoffa/neuroplanes/america/apache/tailrotor.mdl" 
ENT.TailRotorPos = Vector( -67, 2, 16.5 ) * SCALE
ENT.TailRotorAngle = Angle()

ENT.MaxVelocity = 400 * 1.8 
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = .61					-- momentum damping
ENT.AngDamping = 3					-- angular momentum damping
ENT.CurVelocity = 0
ENT.InitialHealth = 350

ENT.Model 			= "models/hoffa/neuroplanes/america/apache/body.mdl"
ENT.TailModel 		= "models/hoffa/neuroplanes/america/apache/tail.mdl"
ENT.WingModels 		= { "models/hoffa/neuroplanes/america/apache/wing_l.mdl", 
						"models/hoffa/neuroplanes/america/apache/wing_r.mdl" }

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
ENT.MachineGunModel = "models/hoffa/neuroplanes/america/apache/barrel.mdl"
ENT.PrimaryShootSound = Sound(  "wt/guns/aa12mm_fire_loop.wav"  )
ENT.ContigiousFiringLoop = true

-- ENT.MinigunSound = "wt/guns/type97_gun.wav"
ENT.MinigunPos = {  Vector( 24, 0, -8 )  * SCALE }
ENT.PrimaryMaxShots = 30
ENT.ShowMinigun = true 
ENT.AimGun = true 
ENT.GunHasBones = true 

-- End of weapons

-- Visuals
ENT.CameraDistance = 150
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.JetExhaust = true 
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = .5
ENT.ExhaustDieTime = .1
ENT.CockpitPosition = Vector( 15, 0, 9.5 ) * SCALE
-- ENT.CockpitPosition = Vector( 25, 0, 9.5 ) * SCALE
ENT.PassengerPos = Vector( 15, 0,  9.5 ) * SCALE
ENT.TrailPos = { Vector( -14, 214, 35 ) * SCALE, Vector( -14, -214, 35 ) * SCALE }
ENT.FireTrailPos = { Vector( 2, -22, 32 ) * SCALE, Vector( 76, 17, 2 ) * SCALE }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( -13, 7, 7 ) * SCALE,
Vector( -13, -7, 7 ) * SCALE,
}

-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"npc/attack_helicopter/aheli_rotor_loop1.wav",
	"npc/attack_helicopter/aheli_wash_loop3.wav",
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
						Pos =  Vector(7.5, -14.5, -6 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
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
						Pos =  Vector(7.5, -11, -6 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
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
						Pos =  Vector(7.50, -11, -2 )  * SCALE, 							-- Pos, Hard point location on the plane fuselage.
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
						Pos =  Vector(7.50, -14, -2 )  * SCALE, 							-- Pos, Hard point location on the plane fuselage.
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
						Pos =  Vector(7.5, 14.5, -6 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
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
						Pos =  Vector(7.5, 11, -6 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
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
						Pos =  Vector(7.50, 11, -2 )  * SCALE, 							-- Pos, Hard point location on the plane fuselage.
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
						Pos =  Vector(7.50, 14, -2 )  * SCALE, 							-- Pos, Hard point location on the plane fuselage.
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
