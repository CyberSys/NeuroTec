ENT.FolderName 			= "sent_mini_pensacola_p"
ENT.Type 				= "vehicle"
ENT.Base 				= "base_anim"
ENT.PrintName			= "Pensacola LEVEL 1"
ENT.Author				= "Hoffa / Killstr3aks"
ENT.Category 			= "NeuroTec - Naval Tier VI";
ENT.Country = "USA"
ENT.Spawnable			= true
ENT.AdminSpawnable 		= true
ENT.MicroSpectactularDeath 	= true
ENT.IsMicroCruiser 		= true 
ENT.CanTurnStationary	= false
ENT.HasNPCAntiAir = false 
ENT.WaterRippleScale = 1.6
ENT.KeepUpWeight = 3000
ENT.TurnAngleValue = 0.3
ENT.NoSideForce = true 
ENT.HornPitch = 75 

ENT.ThrottleIncrementSize = 3 
-- Variables
ENT.CamDist 			= 480
ENT.CamUp 				= 140
ENT.CameraMinZ			= 140 
ENT.WorldScale 			= 0.0915 -- 1/16th of original size
ENT.InitialHealth 		= 34300
--  Weapon data
ENT.BarrelLength 		= 35
ENT.IPPShellVelocity 	= 3050 -- speed of shell. Higher velocity = lower arc.
ENT.MinRange 			= 0 
ENT.MaxRange 			= 44000
ENT.MaxVelocity 		= 450 * 7
ENT.MinVelocity 		= -450 * 7
ENT.ForwardSpeed 		= ENT.MaxVelocity/3
ENT.ReverseSpeed 		= ENT.MinVelocity/3
ENT.TurnModifierValue 	= 0.002	
ENT.TurnIncrement = 0.03
ENT.FullSink 			= 0.71045/4
ENT.HalfSink 			= 0.71045/2
ENT.BuoyancyRatio 		= 1.3
ENT.DampFactor 			= 4
ENT.Mass				= 50000/7
-- positions
ENT.WaterBreakPosition = Vector( 400,0,-20 )
ENT.PeriscopePosition 	= Vector( 20, -0, 75 )
ENT.ExitPos 			= Vector( 664, -158, 1158 )*.0915
ENT.CockpitviewPosition = Vector( 180, 0, 60 )
ENT.ExhaustPosition 	= {Vector( 70, 0, 100 ), Vector( -65, 0, 90 )}

ENT.ExteriorParts = {
"models/neuronaval/killstr3aks/american/cruisers/pensacola_bow.mdl",
"models/neuronaval/killstr3aks/american/cruisers/pensacola_midback.mdl",
"models/neuronaval/killstr3aks/american/cruisers/pensacola_stern.mdl"
}
-- Speed & Sounds
ENT.EngineSoundPath 	= "Misc/water_movement.wav"--"vehicles/diesel_loop2.wav" 
ENT.Model 				= "models/neuronaval/killstr3aks/american/cruisers/pensacola_midfront.mdl"
ENT.DeckModel = ""
-- ENT.PropellerPosition = Vector(-220, 0, 0 )
ENT.PropellerSplashSize = 15
ENT.PropellerPos = {Vector(  -323, -33, -21 ), Vector(  -323, 33, -21 ), Vector(  -386, -15, -22 ), Vector( -386, 15, -22 )}
ENT.PropellerModel = "models/neuronaval/killstr3aks/american/destroyers/clemson_propeller.mdl"
-- Weapon Data
ENT.NumberOfWeaponGroups = 2
ENT.WeaponGroupIcons = { "vgui/ui/ui_he.png", "vgui/ui/ui_flak.png"}
-- 2D Boat Texture
ENT.HUDData = { Background = Material("vgui/ui/ships/chester.png" ), 
				W = 512, 
				H = 512, 
				X = 100, 
				Y = 400,
				Rotation = 180}

ENT.WeaponSystems = {
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 125, -26, 72 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector( 125, -26, 72 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( 125, -26, 77 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	UseHitScan = true,
	Cooldown = .1, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 20,
	Radius = 50,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 1,
	ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
	Muzzle = "microplane_MG_muzzleflash",
	NumShots = 1,
	WeaponGroup = 2,
	DisableIPP = true,
	 
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 125, 26, 72 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector( 125, 26, 72 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( 125, 26, 77 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	UseHitScan = true,
	Cooldown = .1, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 20,
	Radius = 50,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 1,
	ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
	Muzzle = "microplane_MG_muzzleflash",
	NumShots = 1,
	WeaponGroup = 2,
	DisableIPP = true,
	 
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -385, 13, 19 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector(-385, 13, 19 ),
	TAng = Angle( 0, 180, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( -385, 13, 24 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	UseHitScan = true,
	Cooldown = .1, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 20,
	Radius = 50,
	PenetrationDepth = 1, -- units
	MaxYaw = 180,
	TowerTurnSpeed = 1,
	ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
	Muzzle = "microplane_MG_muzzleflash",
	NumShots = 1,
	WeaponGroup = 2,
	DisableIPP = true,
	 
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -385, -13, 19 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector(-385, -13, 19 ),
	TAng = Angle( 0, 180, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( -385, -13, 24 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	UseHitScan = true,
	Cooldown = .1, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 20,
	Radius = 50,
	PenetrationDepth = 1, -- units
	MaxYaw = 180,
	TowerTurnSpeed = 1,
	ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
	Muzzle = "microplane_MG_muzzleflash",
	NumShots = 1,
	WeaponGroup = 2,
	DisableIPP = true,
	 
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -91, -32, 32 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aaturret.mdl",
	TPos =  Vector(-91, -32, 32 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aagun.mdl",
	BaPos =  Vector( -91, -32, 40 ),
	BarrelLength = 10,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	Cooldown = 2,
	Damage = 70,
	Radius = 256,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 2,
	ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
	Muzzle = "mg_muzzleflash",
	NumShots = 1,
	DisableIPP = true,
	WeaponGroup = 2
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -91, 32, 32 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aaturret.mdl",
	TPos =  Vector(-91, 32, 32 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aagun.mdl",
	BaPos =  Vector( -91, 32, 40 ),
	BarrelLength = 10,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	Cooldown = 2,
	Damage = 70,
	Radius = 256,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 2,
	ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
	Muzzle = "mg_muzzleflash",
	NumShots = 1,
	DisableIPP = true,
	WeaponGroup = 2 
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -127, -33, 32 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aaturret.mdl",
	TPos =  Vector(-127, -33, 32 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aagun.mdl",
	BaPos =  Vector( -127, -33, 40 ),
	BarrelLength = 10,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	Cooldown = 2,
	Damage = 70,
	Radius = 256,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 2,
	ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
	Muzzle = "mg_muzzleflash",
	NumShots = 1,
	DisableIPP = true,
	WeaponGroup = 2 
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -127, 33, 32 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aaturret.mdl",
	TPos =  Vector(-127, 33, 32 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aagun.mdl",
	BaPos =  Vector( -127, 33, 40 ),
	BarrelLength = 10,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	Cooldown = 2,
	Damage = 70,
	Radius = 256,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 2,
	ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
	Muzzle = "mg_muzzleflash",
	NumShots = 1,
	DisableIPP = true,
	WeaponGroup = 2 
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 138, 34, 45 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aaturret.mdl",
	TPos =  Vector(138, 34, 45 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aagun.mdl",
	BaPos =  Vector( 138, 34, 53 ),
	BarrelLength = 10,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	Cooldown = 2,
	Damage = 70,
	Radius = 256,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 2,
	ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
	Muzzle = "mg_muzzleflash",
	NumShots = 1,
	DisableIPP = true,
	WeaponGroup = 2
	}, 
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 138, -34, 45 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aaturret.mdl",
	TPos =  Vector(138, -34, 45 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aagun.mdl",
	BaPos =  Vector( 138, -34, 53 ),
	BarrelLength = 10,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	Cooldown = 2,
	Damage = 70,
	Radius = 256,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 2,
	ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
	Muzzle = "mg_muzzleflash",
	NumShots = 1,
	DisableIPP = true,
	WeaponGroup = 2
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 93, -34, 44 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aaturret.mdl",
	TPos =  Vector(93, -34, 44 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aagun.mdl",
	BaPos =  Vector( 93, -34, 52 ),
	BarrelLength = 10,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	Cooldown = 1.5,
	Damage = 50,
	Radius = 256,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 2,
	ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
	Muzzle = "mg_muzzleflash",
	NumShots = 1,
	DisableIPP = true,
	WeaponGroup = 2 
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 93, 34, 44 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aaturret.mdl",
	TPos =  Vector(93, 34, 44 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_aagun.mdl",
	BaPos =  Vector( 93, 34, 52 ),
	BarrelLength = 10,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	Cooldown = 1.5,
	Damage = 50,
	Radius = 256,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 2,
	ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
	Muzzle = "mg_muzzleflash",
	NumShots = 1,
	DisableIPP = true,
	WeaponGroup = 2 
	},
	{	
	--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos = Vector( -307, 0, 21),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_mainturret.mdl",
	TPos = Vector( -307, 0, 21 ),
	TAng = Angle( 0, 180, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_maingun.mdl",
	BaPos = Vector( -315, 0, 29 ),
	BarrelLength = 45, 
	AmmoType = "sent_mini_naval_shell",
	AmmoModel = "",
	Cooldown = 15, -- testing
	ShellVelocity = 3045, -- units/s  
	Damage = 3000,
	Radius = 50,
	PenetrationDepth = 15, -- units
	MaxYaw = 130,
	TowerTurnSpeed = .3,
	ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
	Muzzle = "navalgun_muzzleflash_3",
	NumShots = 2,
	WeaponGroup = 1,
	GroupedShotDelay = 0,
	--BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos = Vector( -245, 0, 38),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_mainturret.mdl",
	TPos = Vector( -245, 0, 38 ),
	TAng = Angle( 0, 180, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_maingun.mdl",
	BaPos = Vector( -253, 0, 46 ),
	BarrelLength = 45, 
	AmmoType = "sent_mini_naval_shell",
	AmmoModel = "",
	Cooldown = 15, -- testing
	ShellVelocity = 3045, -- units/s  
	Damage = 3000,
	Radius = 50,
	PenetrationDepth = 15, -- units
	MaxYaw = 130,
	TowerTurnSpeed = .3,
	ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
	Muzzle = "navalgun_muzzleflash_3",
	NumShots = 2,
	WeaponGroup = 1,
	GroupedShotDelay = 0,
	--BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos = Vector( 267, 0, 31 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_mainturret.mdl",
	TPos = Vector( 267, 0, 31 ),
	TAng = Angle( 0, 0, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_maingun.mdl",
	BaPos = Vector( 275, 0, 39 ),
	BarrelLength = 45, 
	AmmoType = "sent_mini_naval_shell",
	AmmoModel = "",
	Cooldown = 15, -- testing
	ShellVelocity = 3045, -- units/s  
	Damage = 2500,
	Radius = 50,
	PenetrationDepth = 15, -- units
	MaxYaw = 130,
	TowerTurnSpeed = .3,
	ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
	Muzzle = "navalgun_muzzleflash_3",
	NumShots = 2,
	WeaponGroup = 1,
	GroupedShotDelay = 0,
	--BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos = Vector( 202, 0, 50 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_mainturret.mdl",
	TPos = Vector( 202, 0, 50 ),
	TAng = Angle( 0, 0, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/pensacola_maingun.mdl",
	BaPos = Vector( 210, 0, 58 ),
	BarrelLength = 45, 
	AmmoType = "sent_mini_naval_shell",
	AmmoModel = "",
	Cooldown = 15, -- testing
	ShellVelocity = 3045, -- units/s  
	Damage = 2500,
	Radius = 50,
	PenetrationDepth = 15, -- units
	MaxYaw = 130,
	TowerTurnSpeed = .3,
	ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
	Muzzle = "navalgun_muzzleflash_3",
	NumShots = 2,
	WeaponGroup = 1,
	GroupedShotDelay = 0,
	--BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	}	
}

			
if SERVER then
	AddCSLuaFile(  )
			
	function ENT:SpawnFunction( ply, tr, class )
		local tr,trace = {},{}
		tr.start = ply:GetShootPos()
		tr.endpos = tr.start + ply:GetAimVector() * 12500
		tr.filter = ply
		tr.mask = MASK_WATER + MASK_SOLID
		trace = util.TraceLine( tr )
		local SpawnPos = trace.HitPos + trace.HitNormal * 1
		local ent = ents.Create( class )
		ent:SetPos( SpawnPos )
		ent.Owner = ply 
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()
		return ent
	end
	function ENT:Initialize() self:NeuroNaval_DefaultCruiserInit() end
	function ENT:OnRemove() self:NeuroNaval_DefaultRemove() end
	function ENT:PhysicsCollide( data, physobj )self:NeuroNaval_DefaultCollisionCallback( data, physobj ) end
	function ENT:Use(ply,caller) self:NeuroNaval_DefaultUse( ply, caller )end
	function ENT:PhysicsUpdate() self:NeuroNaval_DefaultPhysicsUpdate() end
	function ENT:OnTakeDamage(dmginfo) self:NeuroNaval_DefaultDamage( dmginfo ) end
	function ENT:Think() self:NeuroNaval_DefaultCruiserThink() end
	function ENT:PhysicsSimulate( phys, deltatime ) self:NeuroNaval_DefaultPhysSimulate( phys, deltatime ) self:CaptainHasGunsThink() end
end 
if CLIENT then

	function ENT:Initialize() self:DefaultNavalClientInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return NeuroNaval_DefaultBoatCView( ply, Origin, Angles, Fov, self ) end
	function ENT:Draw() 
		self:DefaultMicroShitExhaust() 

		end 

end 

