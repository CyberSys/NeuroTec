ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "MH-6 \'Killer Egg\'"
ENT.Author	= "Hoffa / Hoffa"
ENT.Category 		= "NeuroTec Micro Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_HELICOPTER
ENT.IsHelicopter = true 
ENT.HelicopterMaxLift = 150
ENT.HelicopterPitchForce = 25
ENT.HelicopterYawForce = 25
ENT.HelicopterRollForce = 25
ENT.HelicopterCorrectionalVector = Vector(1.5,0,-0)
ENT.HelicopterTailLiftValue = .92
ENT.OverrideWeldStrenght = 35000
ENT.HelicopterLiftAmount = 0.35

ENT.ForceWeldTailToWings = true 
ENT.Gauges = {
		AttitudeIndicator = {
			Pos = Vector( 16, 1.3, 1.6 ),
			Ang = Angle(),
			Scale = .005
		};	
		Throttle = {
			Pos = Vector( 16, .0, 1.6 ),
			Ang = Angle(),
			Scale = .005
		};
		
		Compass = {
			Pos = Vector( 16, 1.5, .35 ),
			Ang = Angle(),
			Scale = .005
		};		
		Clock = {
			Pos = Vector( 16, .3, .35 ),
			Ang = Angle(),
			Scale = .005
		};
		
		VSpeed = {
			Pos = Vector( 16, 1.5, -.9 ),
			Ang = Angle(),
			Scale = .005
		};		
		Airspeed = {
			Pos = Vector( 16, 0.3, -.9 ),
			Ang = Angle(),
			Scale = .005
		};
		Altimeter = {
			Pos = Vector( 15.5, 1.8, -1.7 ),
			Ang = Angle( 0, 0,-60 ),
			Scale = .006
		};
		
	}
	
local SCALE = 1.0 

ENT.MainRotorModel = "models/hoffa/neuroplanes/american/mh6/mh6_rotor.mdl"
ENT.MainRotorPos = Vector( 4,0, 9.25 ) * SCALE
ENT.MainRotorAngle = Angle(0,0,0)
ENT.TailRotorModel = "models/hoffa/neuroplanes/american/mh6/mh6_tailrotor.mdl" 
ENT.TailRotorPos = Vector( -31, 3, 1.5 ) * SCALE
ENT.TailRotorAngle = Angle(0,0,0)
-- ENT.CoaxialRotor = true 


ENT.ServiceCeiling = 9500
ENT.NeverExceedSpeed = 300

ENT.MaxVelocity = 300 * 1.8 
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = .7					-- momentum damping
ENT.AngDamping = 3.1					-- angular momentum damping
ENT.CurVelocity = 0
ENT.InitialHealth = 400

ENT.Model 			= "models/hoffa/neuroplanes/american/mh6/mh6_body.mdl"
ENT.TailModel 		= "models/hoffa/neuroplanes/american/mh6/mh6_tail.mdl"
ENT.WingModels 		= { "models/hoffa/neuroplanes/american/mh6/mh6_wing_l.mdl", 
						"models/hoffa/neuroplanes/american/mh6/mh6_wing_r.mdl" }

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
ENT.NoSecondaryWeapons = true
ENT.BurstSize = 12
ENT.RoundsPerSecond = 10
ENT.BurstDuration = 0.1
ENT.PhysShellSpawnOffset = 72 


ENT.NoLockon = true
ENT.PrimaryCooldown = 0.1
ENT.MuzzleOffset = 55
ENT.Muzzle = "microplane_MG_muzzleflash"
ENT.PCFMuzzle = true -- use .pcf muzzleflash
ENT.MinDamage = 25
ENT.MaxDamage = 65
ENT.Radius = 16
ENT.AmmoType = "sent_mini_shell" 
ENT.MinigunTracer = "tracer"
-- ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = "wt/guns/type97_gun.wav" 
ENT.MachineGunModel = "models/hoffa/neuroplanes/russian/mi-28havoc/mi28_barrel.mdl"
ENT.PrimaryShootSound = Sound(  "wt/guns/mg17_loop.wav"  )
ENT.ContigiousFiringLoop = true

-- ENT.MinigunSound = "wt/guns/type97_gun.wav"
ENT.MinigunPos = {  Vector( 11, -7, -5), Vector( 11, 7, -5)  }
-- ENT.TurretModel = { "models/hoffa/neuroplanes/american/ah1/ah1_turret.mdl" }
-- ENT.TurretPos = { Vector( 50, 0, -9) * SCALE }
ENT.PrimaryMaxShots = 15
-- ENT.ShowMinigun = true 
-- ENT.AimGun = true 
ENT.GunHasBones = true 

-- End of weapons

-- Visuals
ENT.CameraDistance = 78
ENT.CameraUp = 3
ENT.TinySmoke = true
ENT.JetExhaust = true 
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = .5
ENT.ExhaustDieTime = .1
ENT.CockpitPosition = Vector( 11, 2,  2.5 ) * SCALE
ENT.PassengerPos = Vector( 11, -2,  2.5 ) * SCALE
ENT.TrailPos = { Vector( -14, 214, 35 ) * SCALE, Vector( -14, -214, 35 ) * SCALE }
ENT.FireTrailPos = { Vector( 2, -22, 32 ) * SCALE, Vector( 76, 17, 2 ) * SCALE }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( -9, 0, -3 )
}

-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
ENT.EngineSounds = {
	"npc/attack_helicopter/aheli_rotor_loop1.wav",
	"vehicles/fast_windloop1.wav"}

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
