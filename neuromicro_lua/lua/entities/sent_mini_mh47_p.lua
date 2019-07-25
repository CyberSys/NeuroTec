ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "MH-47E"
ENT.Author	= "Hoffa / Hoffa"
ENT.Category 		= "NeuroTec Micro Helicopters";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_HELICOPTER
ENT.IsHelicopter = true 
ENT.HelicopterMaxLift = 150
ENT.HelicopterPitchForce = 1
ENT.HelicopterYawForce = 2
ENT.HelicopterRollForce = 7
ENT.HelicopterCorrectionalVector = Vector()
ENT.HelicopterTailLiftValue = 0.88
ENT.OverrideWeldStrenght = 35000
ENT.HelicopterLiftAmount = 0.15

ENT.ForceWeldTailToWings = true 

local SCALE = 1.0 

ENT.MainRotorModel = "models/hoffa/neuroplanes/american/chinoook/mh47_rotor.mdl"
ENT.MainRotorPos = Vector( 45,0, 16 ) * SCALE
ENT.MainRotorAngle = Angle()
ENT.TailRotorModel = "models/hoffa/neuroplanes/american/chinoook/mh47_rotor.mdl" 
ENT.TailRotorPos = Vector( -75,0, 31 ) * SCALE
ENT.TailRotorAngle = Angle(0,0,0)
ENT.CoaxialRotor = true 
ENT.CoaxialAttachedToTail = true 
-- Sky Lift
ENT.HasCrane = true 
ENT.CranePos = Vector( 0,105,0)
ENT.CraneModel = "models/hoffa/neuroplanes/american/chinoook/mh47_crane.mdl"
ENT.CraneRepelSpeed = 32 -- 
ENT.CraneMaterial = "cables/rope"
ENT.CraneAttachmentPos = Vector( 0,0,-23 )
ENT.CraneOffset = Vector( 0,0, 14 )
--[[ Default Values for Sky Cranes 
ENT.CraneRepelSpeed = 16 -- Winch Velocity
ENT.CraneBone = 0  -- Bone to attach the Winch to 
ENT.CrateOffset = Vector(0,0,0) -- Local to Magnet / Claw 
ENT.CraneAttachmentPos = Vector( 0,0,0 ) -- Local to Helicopter Body
ENT.CraneRope = "cable/rope"
ENT.CranePos = Vector( 0,0,0 ) -- Pos where the magnet spawns relative to helicopter
ENT.CraneModel =  "models/props_junk/meathook001a.mdl"

]]-- 
ENT.NoGuns = true 

ENT.ServiceCeiling = 15500
ENT.NeverExceedSpeed = 300
ENT.CraneRepelKey = KEY_2
ENT.CraneRetractKey = KEY_1
ENT.MaxVelocity = 300 * 1.8 
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = .35					-- momentum damping
ENT.AngDamping = 3.1					-- angular momentum damping
ENT.CurVelocity = 0
ENT.InitialHealth = 800

ENT.Model 			= "models/hoffa/neuroplanes/american/chinoook/mh47_body.mdl"
ENT.TailModel 		= "models/hoffa/neuroplanes/american/chinoook/mh47_tail.mdl"
ENT.WingModels 		= { "models/hoffa/neuroplanes/american/chinoook/mh47_wing_l.mdl", 
						"models/hoffa/neuroplanes/american/chinoook/mh47_wing_r.mdl" }

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

ENT.NoLockon = true
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
-- ENT.MinigunPos = {  Vector( 41, 0, -17 )  * SCALE }
-- ENT.TurretModel = { "models/hoffa/neuroplanes/american/ah1/ah1_turret.mdl" }
-- ENT.TurretPos = { Vector( 50, 0, -9) * SCALE }
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
ENT.ExhaustDieTime = .2
ENT.CockpitPosition = Vector( 25.75, 0, -25.5 ) * SCALE
ENT.TrailPos = { Vector( -14, 214, 35 ) * SCALE, Vector( -14, -214, 35 ) * SCALE }
ENT.FireTrailPos = { Vector( 2, -22, 32 ) * SCALE, Vector( 76, 17, 2 ) * SCALE }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( -74, -11.8, 6.6 ),
Vector( -74, 11.8, 6.6 )
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

-- ENT.ArmamentDamageSystem = true 

ENT.ArmamentAttachedToWings = true 
ENT.Armament = {	

					{ 
						PrintName = "Pretty Mean Cannon",
						Mdl = "models/hoffa/neuroplanes/russian/kamov/ka50_pods.mdl" ,
						Pos = Vector( 11, -16, -13), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 							-- Ang, object angle
						Type = "Effect",										-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 0.1, 										-- Cooldown between weapons
						isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Color = Color( 0,0,0,0 ),
						Class = "sent_mini_shell",
						LaunchSound = "wt/guns/m4_singleshot.wav"
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
	function ENT:PrimaryAttack()   end
	function ENT:SecondaryAttack( wep, id )	  end
	function ENT:PhysicsSimulate( phys, deltatime )

		self:MicroHeloPhys()
		
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end
