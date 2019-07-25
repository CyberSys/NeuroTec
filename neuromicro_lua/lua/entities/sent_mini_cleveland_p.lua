ENT.FolderName 			= "sent_mini_cleveland_p"
ENT.Type 				= "vehicle"
ENT.Base 				= "base_anim"
ENT.PrintName			= "Cleveland LEVEL 2"
ENT.Author				= "Hoffa / Killstr3aks"
ENT.Category 			= "NeuroTec - Naval Tier VI";
ENT.Country = "USA"
ENT.Spawnable			= true
ENT.AdminSpawnable 		= true
ENT.MicroSpectactularDeath 	= true
ENT.IsMicroCruiser 		= true 
ENT.CanTurnStationary	= false
ENT.HasNPCAntiAir = false 
ENT.WaterRippleScale = 1.3
ENT.KeepUpWeight = 3000
ENT.TurnAngleValue = 0.25
ENT.NoSideForce = true 
ENT.HornPitch = 75 

ENT.ThrottleIncrementSize = 3 
-- Variables
ENT.CamDist 			= 480
ENT.CamUp 				= 140
ENT.CameraMinZ			= 140 
ENT.WorldScale 			= 0.0915 -- 1/16th of original size
ENT.InitialHealth 		= 45800
--  Weapon data
ENT.BarrelLength 		= 35
ENT.IPPShellVelocity 	= 3050 -- speed of shell. Higher velocity = lower arc.
ENT.MinRange 			= 0 
ENT.MaxRange 			= 44000
ENT.MaxVelocity 		= 450 * 7
ENT.MinVelocity 		= -450 * 7
ENT.ForwardSpeed 		= ENT.MaxVelocity/3
ENT.ReverseSpeed 		= ENT.MinVelocity/3
ENT.TurnModifierValue 	= 0.0006	
ENT.TurnIncrement = 0.04
ENT.FullSink 			= 0.71045/4
ENT.HalfSink 			= 0.71045/2
ENT.BuoyancyRatio 		= 1
ENT.DampFactor 			= 4
ENT.Mass				= 50000/7
-- positions
ENT.WaterBreakPosition = Vector( 260,0,-20 )
ENT.PeriscopePosition 	= Vector( 20, -0, 75 )
ENT.ExitPos 			= Vector( 664, -158, 1158 )*.0915
ENT.CockpitviewPosition = Vector( 160, 0, 60 )
ENT.ExhaustPosition 	= {Vector( 40, 0, 100 ), Vector( -30, 0, 100 )}

ENT.ExteriorParts = {
"models/neuronaval/killstr3aks/american/cruisers/cleveland_bow.mdl",
"models/neuronaval/killstr3aks/american/cruisers/cleveland_midback.mdl",
"models/neuronaval/killstr3aks/american/cruisers/cleveland_stern.mdl"
}
-- Speed & Sounds
ENT.EngineSoundPath 	= "Misc/water_movement.wav"--"vehicles/diesel_loop2.wav" 
ENT.Model 				= "models/neuronaval/killstr3aks/american/cruisers/cleveland_midfront.mdl"
ENT.DeckModel = ""
-- ENT.PropellerPosition = Vector(-220, 0, 0 )
ENT.PropellerSplashSize = 15 
ENT.PropellerPos = {Vector(  -283, -30, -24 ), Vector(  -283, 30, -24 ), Vector(  -365, -15, -26 ), Vector( -365, 15, -26 )}
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
		_2Dpos = { x = 4,y = -160, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 89, 30, 42 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_secondturret.mdl",
		TPos = Vector( 89, 30, 42 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_secondgun.mdl",
		BaPos = Vector( 89, 39, 51 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = 4,
		Damage = 100,
		Radius = 512,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 1,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 2,
		DisableIPP = true,
		WeaponGroup = 2 
	},
	{
		_2Dpos = { x = 4,y = -160, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 89, -30, 42 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_secondturret.mdl",
		TPos = Vector( 89, -30, 42 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_secondgun.mdl",
		BaPos = Vector( 89, -39, 51 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = 4,
		Damage = 100,
		Radius = 512,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 1,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 2,
		DisableIPP = true,
		WeaponGroup = 2 
	},
	{
		_2Dpos = { x = 4,y = -160, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -79, -34, 42 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_secondturret.mdl",
		TPos = Vector( -79, -34, 42 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_secondgun.mdl",
		BaPos = Vector( -79, -43, 51 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = 4,
		Damage = 100,
		Radius = 512,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 1,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 2,
		DisableIPP = true,
		WeaponGroup = 2 
	},
	{
		_2Dpos = { x = 4,y = -160, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -79, 34, 42 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_secondturret.mdl",
		TPos = Vector( -79, 34, 42 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_secondgun.mdl",
		BaPos = Vector( -79, 43, 51 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = 4,
		Damage = 100,
		Radius = 512,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 1,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 2,
		DisableIPP = true,
		WeaponGroup = 2
	},
	{
		_2Dpos = { x = 4,y = -160, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -149, 0, 48 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_secondturret.mdl",
		TPos = Vector( -149,0, 48 ),
		TAng = Angle( 0, 180, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_secondgun.mdl",
		BaPos = Vector( -158, 0, 57 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = 4,
		Damage = 100,
		Radius = 512,
		PenetrationDepth = 1, -- units
		MaxYaw = 120,
		TowerTurnSpeed = 1,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 2,
		DisableIPP = true,
		WeaponGroup = 2
	},
	{
		_2Dpos = { x = 4,y = -160, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 153, 0, 42 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_secondturret.mdl",
		TPos = Vector( 153,0, 42 ),
		TAng = Angle( 0, 0, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_secondgun.mdl",
		BaPos = Vector( 162, 0, 53 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = 4,
		Damage = 100,
		Radius = 512,
		PenetrationDepth = 1, -- units
		MaxYaw = 120,
		TowerTurnSpeed = 1,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 2,
		DisableIPP = true,
		WeaponGroup = 2
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -173, -33, 29 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector(-173, -33, 29 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( -173, -33, 34 ),
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
	GroupedShotDelay = 1,
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -173, 33, 29 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector(-173, 33, 29 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( -173, 33, 34 ),
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
	GroupedShotDelay = 1,
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 175, -30, 28 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector( 175, -30, 28 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( 175, -30, 33 ),
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
	GroupedShotDelay = 1,
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 175, 30, 28 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector( 175, 30, 28 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( 175, 30, 33 ),
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
	GroupedShotDelay = 1,
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -5, -32, 48 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_aaturret2.mdl",
	TPos =  Vector(-5, -32, 48 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_aagun2.mdl",
	BaPos =  Vector( -5, -32, 56 ),
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
	NumShots = 4,
	DisableIPP = true,
	WeaponGroup = 2 
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -5, 32, 48 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_aaturret2.mdl",
	TPos =  Vector(-5, 32, 48 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_aagun2.mdl",
	BaPos =  Vector( -5, 32, 56 ),
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
	NumShots = 4,
	DisableIPP = true,
	WeaponGroup = 2
	}, 
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 44, -30, 49 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_aaturret2.mdl",
	TPos =  Vector(44, -30, 49 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_aagun2.mdl",
	BaPos =  Vector( 44, -30, 57 ),
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
	NumShots = 4,
	DisableIPP = true,
	WeaponGroup = 2 
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 44, 30, 49 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_aaturret2.mdl",
	TPos =  Vector(44, 30, 49 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_aagun2.mdl",
	BaPos =  Vector( 44, 30, 57 ),
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
	NumShots = 4,
	DisableIPP = true,
	WeaponGroup = 2 
	}, 
	{	
	--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos = Vector( -263, 0, 33),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_mainturret.mdl",
	TPos = Vector( -263, 0, 33 ),
	TAng = Angle( 0, 180, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_maingun.mdl",
	BaPos = Vector( -275, 0, 40 ),
	BarrelLength = 45, 
	AmmoType = "sent_mini_naval_shell",
	AmmoModel = "",
	Cooldown = 8, -- testing
	ShellVelocity = 3045, -- units/s  
	Damage = 2000,
	Radius = 50,
	PenetrationDepth = 15, -- units
	MaxYaw = 130,
	TowerTurnSpeed = .3,
	ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
	Muzzle = "navalgun_muzzleflash_3",
	NumShots = 3,
	WeaponGroup = 1,
	GroupedShotDelay = 0,
	--BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos = Vector( -200, 0, 33),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_mainturret.mdl",
	TPos = Vector( -210, 0, 45 ),
	TAng = Angle( 0, 180, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_maingun.mdl",
	BaPos = Vector( -222, 0, 52 ),
	BarrelLength = 45, 
	AmmoType = "sent_mini_naval_shell",
	AmmoModel = "",
	Cooldown = 8, -- testing
	ShellVelocity = 3045, -- units/s  
	Damage = 2000,
	Radius = 50,
	PenetrationDepth = 15, -- units
	MaxYaw = 130,
	TowerTurnSpeed = .3,
	ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
	Muzzle = "navalgun_muzzleflash_3",
	NumShots = 3,
	WeaponGroup = 1,
	GroupedShotDelay = 0,
	--BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos = Vector( 278, 0, 32 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_mainturret.mdl",
	TPos = Vector( 278, 0, 32 ),
	TAng = Angle( 0, 0, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_maingun.mdl",
	BaPos = Vector( 290, 0, 39 ),
	BarrelLength = 45, 
	AmmoType = "sent_mini_naval_shell",
	AmmoModel = "",
	Cooldown = 8, -- testing
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
	BPos = Vector( 220, 0, 44 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_mainturret.mdl",
	TPos = Vector( 220, 0, 44 ),
	TAng = Angle( 0, 0, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/cleveland_maingun.mdl",
	BaPos = Vector( 232, 0, 51 ),
	BarrelLength = 45, 
	AmmoType = "sent_mini_naval_shell",
	AmmoModel = "",
	Cooldown = 8, -- testing
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

