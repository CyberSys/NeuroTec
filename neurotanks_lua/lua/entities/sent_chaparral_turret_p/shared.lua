ENT.FolderName = "sent_bmp3_turret_p"

ENT.Type = "vehicle"
ENT.TankType = TANK_TYPE_AA
ENT.VehicleType = WEAPON_TURRET
ENT.Base = "base_anim"
ENT.PrintName	= "M48 Chaparral"
ENT.Author	= "NeuroTec\nLua: Hoffa"
ENT.Category 		= "NeuroTec Tanks - Artillery";
ENT.Description = "Static Gun"
ENT.Spawnable	= false
ENT.AdminSpawnable = false
ENT.IsArtillery = false
ENT.HasBinoculars = true
ENT.HasTower = true
ENT.HasCockpit = true
ENT.HasMGun = false
ENT.HasCVol = false
ENT.CockpitSeatMoveWithTower = true
ENT.SkinCount = 1
ENT.TrackPos = -6.95
ENT.VehicleCrosshairType = 3
-- ENT.MouseScale3rdPerson = 0.045
-- ENT.MouseScale1stPerson = 0.045

-- Smaller cannon 
--ENT.BarrelMGunPos = Vector( -14, -1, -4 )
--ENT.BarrelMGunModel = "models/airboatgun.mdl"

ENT.CamDist = 350
ENT.CamUp = 20
ENT.CockpitPosition = Vector( 5, 0, 25 )
--ENT.SeatPos = Vector( 75, 30, 23 )
--ENT.SeatPos = Vector( 0, 30, 35 )
ENT.SeatPos = Vector( -10, 0, 13 )
-- ENT.CopilotPos = Vector( 0, -18, 20 )

ENT.SeatAngle = Angle( 0, 0, 0 )
ENT.HideDriver = true
ENT.StartupSound = Sound( "" )
ENT.EngineSounds = {""}
ENT.StartupDelay = 1.0 -- Seconds

ENT.TowerStopSound = "wot/tigeri/stopmove.wav"
ENT.SoundTower = "wot/tigeri/turret.wav"
ENT.ShootSound = Sound("bf4/rockets/missile_launch.wav")
ENT.ReloadSound = Sound("bf2/tanks/m1a2_reload.wav")
ENT.PrimaryAmmo = "sent_tank_apshell" 
ENT.PrimaryDelay = 2.55
ENT.APDelay = 2.5
ENT.PrimaryEffect = "ChopperMuzzleFlash"
ENT.BarrelPorts = { 
Vector( -25,-33.5,-13 ), 
Vector( -25,-33.5,12 ), 
Vector( -25,33.5,-13 ),
Vector( -25,33.5,12 )  
} -- add one vector for each slot/pod on the rocket launcher
-- Tied to ENT.BarrelPorts, need to have same number of models as vectors.
ENT.VisualShells = { 
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl",
"models/killstr3aks/wot/american/aa_missile_body.mdl"
}

ENT.IsAutoLoader = true
-- For something like a SCUD launcher this table would only have one index
ENT.MagazineSize =  #ENT.BarrelPorts
ENT.ForcedMagazineCount = 100
ENT.RoundsPerSecond = 0.75

// Weapons
ENT.MaxDamage = 3500
ENT.MinDamage = 2100
ENT.BlastRadius = 512

-- ENT.HeadLightsToggle = true
-- ENT.HeadLightsLast = CurTime()
-- ENT.HeadLights = {}
-- ENT.HeadLights.Lamps = {}
-- ENT.HeadLights.Pos = { Vector( 9, 0, 59 ), Vector( 52, -31, 45 ), Vector( 52, 31, 45 ) }
-- ENT.HeadLights.Angles = { Angle( 0, 180, 0 ), Angle( 0, 180, 0 ), Angle( 0, 180, 0 ) }
-- ENT.HeadLightProjectionPattern = "mmnmmommommnonmmonqnmmomomnomnom"
-- ENT.HeadLightProjectionTexture = ""
ENT.OverrideImpactPointPrediction = true
ENT.Model =  "models/killstr3aks/wot/american/m48_chaparral_turret.mdl"
ENT.TowerModel = "models/killstr3aks/wot/american/m48_chaparral_turret.mdl"
-- Tower Pos relative to body
ENT.TowerPos  = Vector( -26, 0, 90 )
-- Barrle model
ENT.BarrelModel = "models/killstr3aks/wot/american/m48_chaparral_gun.mdl"
-- Barrel pos relative to body
ENT.BarrelPos = Vector( -28.5, 0, 121 )
ENT.BarrelLength = 90
-- ENT.MaxBarrelYaw = 25 -- Only works if HasTower is set to false

-- ENT.MGunModel = "models/aftokinito/wot/russian/is7_mgun.mdl"
-- ENT.MGunPos = Vector( -30, -1.25, 115 )
-- ENT.CMGunPos = Vector(0,0,20)
-- ENT.CMGunDelay = 0.125
ENT.MGunSound = Sound("wot/global/mgun.wav")

// Speed Limits
ENT.MaxVelocity = 0
ENT.MinVelocity = 0

ENT.InitialHealth = 1500
ENT.HealthVal = nil
ENT.Destroyed = false
ENT.Burning = false
ENT.Speed = 0
ENT.DeathTimer = 0


// Timers
ENT.LastPrimaryAttack = nil
ENT.LastSecondaryAttack = nil
ENT.LastFireModeChange = nil
ENT.CrosshairOffset = 0
ENT.PrimaryCooldown = 200
ENT.BulletDelay = CurTime()
ENT.ShellDelay = CurTime()

