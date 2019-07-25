ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Mil Mi-28"
ENT.Author	= "Hoffa / Hoffa"
ENT.Category 		= "NeuroTec Micro Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_HELICOPTER
ENT.IsHelicopter = true 
ENT.HelicopterMaxLift = 125 
ENT.HelicopterPitchForce = 11 
ENT.HelicopterYawForce = 15 
ENT.HelicopterRollForce = 11
ENT.HelicopterCorrectionalVector = Vector( -0.8,0,-0 )
ENT.HelicopterTailLiftValue = 0.915
ENT.OverrideWeldStrenght = 35000
ENT.ForceWeldTailToWings = true 
local SCALE = 0.75 

ENT.ServiceCeiling = 9500
ENT.NeverExceedSpeed = 324

ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 35, 5.3, -1 ),
			Ang = Angle(),
			Scale = 0.01
		};
		Compass = {
			Pos = Vector( 35, -1.5, -1 ),
			Ang = Angle(),
			Scale = 0.01
		};
		VSpeed = {
			Pos = Vector( 35, -1.5, -3.5 ),
			Ang = Angle(),
			Scale = 0.01
		};
		Clock = {
			Pos = Vector( 35, 6, 0.50 ),
			Ang = Angle(),
			Scale = 0.0051
		};		
		Airspeed = {
			Pos = Vector( 35, 5.5, -4.0 ),
			Ang = Angle(),
			Scale = 0.01
		};
		Altimeter = {
			Pos = Vector( 35, 2, -1 ),
			Ang = Angle(),
			Scale = 0.01
		};
		Throttle = {
			Pos = Vector( 35, 6.7, -1 ),
			Ang = Angle(),
			Scale = 0.01
		};		
		EngineTemp = {
			Pos = Vector( 35, 8.25, -1.8 ),
			Ang = Angle(),
			Scale = 0.0075
		};		
		FuelCounter = {
			Pos = Vector( 35, 8.65, -3.7			),
			Ang = Angle(),
			Scale = 0.0075
		};
		GunCamera = {
			Pos = Vector( 15, -8.65, 10 ),
			Ang = Angle(0,0,0),
			Scale = .25
		};
	
	}

ENT.MainRotorModel = "models/hoffa/neuroplanes/russian/mi-28havoc/mi28_rotor.mdl"
ENT.MainRotorPos = Vector(9.6,0,16) * SCALE
ENT.MainRotorAngle = Angle()
ENT.TailRotorModel = "models/hoffa/neuroplanes/russian/mi-28havoc/mi28_tailrotor.mdl" 
ENT.TailRotorPos = Vector( -93, -1.5, 4.5 ) * SCALE
ENT.TailRotorAngle = Angle()

ENT.MaxVelocity = 380 * 1.8 
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = .61					-- momentum damping
ENT.AngDamping = 3					-- angular momentum damping
ENT.CurVelocity = 0
ENT.InitialHealth = 350

ENT.Model 			= "models/hoffa/neuroplanes/russian/mi-28havoc/mi28_body.mdl"
ENT.TailModel 		= "models/hoffa/neuroplanes/russian/mi-28havoc/mi28_tail.mdl"
ENT.WingModels 		= { "models/hoffa/neuroplanes/russian/mi-28havoc/mi28_wing_l.mdl", 
						"models/hoffa/neuroplanes/russian/mi-28havoc/mi28_wing_r.mdl" }

-- ENT.PontoonPos = { Vector(-8,-15,-8),Vector(-8,15,-8) }
-- ENT.PontoonAngles = { Angle( 5,0,0),Angle( 5,0,0) }
-- ENT.PontoonModels = {"models/neuronaval/killstr3aks/mini_torpedo_planes.mdl", "models/neuronaval/killstr3aks/mini_torpedo_planes.mdl" }
-- ENT.PontoonBuoyancy = 5010.0 
-- ENT.PontoonMass = 50

ENT.TailPos			= Vector( 0, 0, -.25 ) * SCALE
ENT.WingPositions 	= {  Vector( 10,25,-10 ) * SCALE, 
						Vector( 10,-25,-10 ) * SCALE }

-- Weapons
ENT.PhysicalAmmo = false
-- ENT.NoSecondaryWeapons = true
ENT.BurstSize = 6
ENT.RoundsPerSecond = 2
ENT.BurstDuration = 0.08

ENT.NoLockon = true
ENT.PrimaryCooldown = 0.01
ENT.MuzzleOffset = 85
-- ENT.Muzzle = "AirboatMuzzleFlash"
ENT.MinDamage = 5
ENT.MaxDamage = 15
ENT.Radius = 5
ENT.AmmoType = "sent_mgun_bullet" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/hoffa/neuroplanes/russian/mi-28havoc/mi28_barrel.mdl"
ENT.PrimaryShootSound = Sound(  "wt/guns/type97_gun.wav"  )
ENT.ContigiousFiringLoop = true

-- ENT.MinigunSound = "wt/guns/type97_gun.wav"
ENT.MinigunPos = {  Vector( 55, 0, -13 )  * SCALE }
ENT.PrimaryMaxShots = 30
ENT.ShowMinigun = true 
ENT.AimGun = true 
ENT.GunHasBones = true 

-- End of weapons

-- Visuals
ENT.CameraDistance = 180
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.JetExhaust = true 
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = .5
ENT.ExhaustDieTime = .1
ENT.CockpitPosition = Vector( 30, 0, 5.5 ) * SCALE
ENT.PassengerPos = Vector( 30, 0,  5.5 ) * SCALE
ENT.TrailPos = { Vector( -14, 214, 35 ) * SCALE, Vector( -14, -214, 35 ) * SCALE }
ENT.FireTrailPos = { Vector( 2, -22, 32 ) * SCALE, Vector( 76, 17, 2 ) * SCALE }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( -16, -16, -8 ) * SCALE,
Vector( -19, -16, -8 ) * SCALE,
Vector( -24, -16, -8 ) * SCALE,
Vector( -16, 16, -8 ) * SCALE,
Vector( -19, 16, -8 ) * SCALE,
Vector( -24, 16, -8 ) * SCALE
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
						PrintName = "Rockets",
						Mdl = "models/hoffa/neuroplanes/russian/mi-28havoc/mi28_pod.mdl" ,
						Pos = Vector( 12, 23, -15 ) * SCALE, 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, -1, 0), 								-- Ang, object angle
						Type = "Pod",						-- Type, used when creating the object
						-- BurstSize = 10,	
						Cooldown = 2, 										-- Cooldown between weapons
						isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0, 0 ),
						BurstSize = 1
				
						-- LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					};	
					{ 
						PrintName = "Air-to-Air",
						Mdl ="models/starchick971/hawx/weapons/agm-131a sram-ii.mdl" ,
						Pos =  Vector(12, -22, -17.5 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
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
						Mdl ="models/starchick971/hawx/weapons/agm-131a sram-ii.mdl" ,
						Pos =  Vector(12, -22, -12 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
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
						Mdl ="models/starchick971/hawx/weapons/agm-131a sram-ii.mdl" ,
						Pos =  Vector(12, -27, -17.5 )  * SCALE, 							-- Pos, Hard point location on the plane fuselage.
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
						Mdl ="models/starchick971/hawx/weapons/agm-131a sram-ii.mdl" ,
						Pos =  Vector(12, -27, -12 )  * SCALE, 							-- Pos, Hard point location on the plane fuselage.
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
