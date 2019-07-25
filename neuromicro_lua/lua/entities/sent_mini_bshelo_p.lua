ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Bulletstorm Banshee"
ENT.Author	= "Hoffa / Hoffa"
ENT.Category 		= "NeuroTec Micro Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_HELICOPTER
ENT.IsHelicopter = true 
ENT.HelicopterMaxLift = 135 
ENT.HelicopterPitchForce = 3
ENT.HelicopterYawForce = 18
ENT.HelicopterRollForce = 3
ENT.HelicopterCorrectionalVector = Vector( -0,0,-0 )
ENT.HelicopterTailLiftValue = 1
ENT.OverrideWeldStrenght = 35000
ENT.ForceWeldTailToWings = true 
ENT.LampOffset = 4 
local SCALE = 1.0

ENT.ServiceCeiling = 13500
ENT.NeverExceedSpeed = 390

ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 45, 5.85, 7 ),
			Ang = Angle(),
			Scale = 0.015
		};
		Compass = {
			Pos = Vector( 45, 1.5, 6 ),
			Ang = Angle(),
			Scale = 0.01
		};
		VSpeed = {
			Pos = Vector( 45, -1.5,6 ),
			Ang = Angle(),
			Scale = 0.0075
		};
		Clock = {
			Pos = Vector( 45, -2.2, 3.5 ),
			Ang = Angle(),
			Scale = 0.005
		};		
		Airspeed = {
			Pos = Vector( 45, -3.5, 6 ),
			Ang = Angle(),
			Scale = 0.008
		};
		Altimeter = {
			Pos = Vector( 45, -5.5, 6.5),
			Ang = Angle(),
			Scale = 0.01
		};
		Throttle = {
			Pos = Vector( 45, 7.1, 6.5 ),
			Ang = Angle(),
			Scale = 0.0125
		};
		EngineTemp = {
			Pos = Vector( 39, 11, 1.5 ),
			Ang = Angle(0,0,0),
			Scale = .0075
		};
		FuelCounter = {
			Pos = Vector( 40, 9, 3.5),
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

ENT.MainRotorModel = "models/hoffa/neuroplanes/china/z10w/rotor.mdl"
ENT.MainRotorPos = Vector(9.85,0,12) * SCALE
ENT.MainRotorAngle = Angle()
ENT.TailRotorModel = "models/hoffa/neuroplanes/misc/heli/tailrotor.mdl" 
ENT.TailRotorPos = Vector( -33.5, 0, 3 ) * SCALE
ENT.TailRotorAngle = Angle()
ENT.TailRotorAddPush = 500
ENT.HelicopterLiftAmount = .25
ENT.MaxVelocity = 380 * 1.8 
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = .61					-- momentum damping
ENT.AngDamping = 3					-- angular momentum damping
ENT.CurVelocity = 0
ENT.InitialHealth = 350

ENT.Model 			= "models/hoffa/neuroplanes/misc/heli/body.mdl"
ENT.TailModel 		= "models/hoffa/neuroplanes/misc/heli/tail.mdl"
ENT.WingModels 		= { "models/hoffa/neuroplanes/misc/heli/wing_l.mdl", 
						"models/hoffa/neuroplanes/misc/heli/wing_r.mdl" }

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
ENT.MachineGunModel ="models/hoffa/neuroplanes/misc/heli/barrel.mdl"
ENT.PrimaryShootSound = Sound(  "wt/guns/type97_gun.wav"  )
ENT.ContigiousFiringLoop = true

-- ENT.MinigunSound = "wt/guns/type97_gun.wav"
ENT.MinigunPos = {  Vector( 36, 0, -5.5 )  * SCALE }
ENT.PrimaryMaxShots = 30
ENT.ShowMinigun = true 
ENT.AimGun = true 
ENT.GunHasBones = true 

-- End of weapons

-- Visuals
ENT.CameraDistance = 130
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.JetExhaust = true 
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = .5
ENT.ExhaustDieTime = .1
ENT.CockpitPosition = Vector( 30, 2, -3.5 ) * SCALE
ENT.PassengerPos = Vector( 30, 2,  -3.5 ) * SCALE
ENT.TrailPos = { Vector( -14, 214, 35 ) * SCALE, Vector( -14, -214, 35 ) * SCALE }
ENT.FireTrailPos = { Vector( 2, -22, 32 ) * SCALE, Vector( 76, 17, 2 ) * SCALE }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( -7.85, -4, -8.5 ),
Vector( -7.58, 3.8, -8.5 ),
Vector( -2.5, 0, 8 ),
Vector( -37.5, 0, -2.75 )

}

-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"npc/attack_helicopter/aheli_rotor_loop1.wav",
	"vehicles/fast_windloop1.wav"}
-- ENT.EngineStartupSound = "helicopter/Mil Mi-28_engine.wav"
-- ENT.NoSecondaryWeapons = true 
ENT._2ndCD = 0.15 -- Override Mouse2 cooldown
ENT.TracerScale1  = 0.1
ENT.TracerScale2 = 0.1
ENT.TracerGlowProxy = 1 
ENT._2ndRecoilAngle = 1.05 
ENT._2ndRecoilDuration = 10 
ENT._2ndRecoilForce = -500000

ENT.Armament = {
					{ 
						PrintName = "Air-to-Air",
						Mdl ="models/weapons/w_missile_closed.mdl" ,
						Pos =  Vector(10, 10, -11.5 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 5, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 
					
					{ 
						PrintName = "Air-to-Air",
						Mdl ="models/weapons/w_missile_closed.mdl" ,
						Pos =  Vector(10, -10, -11.5 ) * SCALE , 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Homing",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 5, 										-- Cooldown between weapons
						isFirst	= false,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						-- Color = Color( 0,0,0,0 ),
						LaunchSound = "lockon/missileshoot.mp3"
					}; 
				
				
				}
				
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
	function ENT:Think() self:JetAir_Think()
		-- self.TailRotor:GetPhysicsObject():AddAngleVelocity( Vector( 0, 5555, 0 ) )
		
	end
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
