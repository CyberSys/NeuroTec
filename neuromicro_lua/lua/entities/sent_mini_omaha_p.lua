ENT.FolderName 			= "sent_mini_omaha_p"
ENT.Type 				= "vehicle"
ENT.Base 				= "base_anim"
ENT.PrintName			= "Omaha LEVEL 1"
ENT.Author				= "Hoffa / Killstr3aks"
ENT.Category 			= "NeuroTec - Naval Tier V";
ENT.Country = "USA"
ENT.Spawnable			= true
ENT.AdminSpawnable 		= true
ENT.MicroSpectactularDeath 	= true
ENT.IsMicroCruiser 		= true 
ENT.CanTurnStationary	= false
ENT.HasNPCAntiAir = false 
ENT.WaterRippleScale = 1.3
ENT.KeepUpWeight = 2000
ENT.TurnAngleValue = 0.2
ENT.NoSideForce = true 
ENT.HornPitch = 75 

ENT.ThrottleIncrementSize = 3 
-- Variables
ENT.CamDist 			= 400
ENT.CamUp 				= 78
ENT.CameraMinZ			= 78 
ENT.WorldScale 			= 0.0915 -- 1/16th of original size
ENT.InitialHealth 		= 24000
--  Weapon data
ENT.BarrelLength 		= 35
ENT.IPPShellVelocity 	= 3050 -- speed of shell. Higher velocity = lower arc.
ENT.MinRange 			= 0 
ENT.MaxRange 			= 44000
ENT.MaxVelocity 		= 470 * 7
ENT.MinVelocity 		= -470 * 7
ENT.ForwardSpeed 		= ENT.MaxVelocity/3
ENT.ReverseSpeed 		= ENT.MinVelocity/3
ENT.TurnModifierValue 	= 0.0008	
ENT.TurnIncrement = 0.03
ENT.FullSink 			= 0.71045/4
ENT.HalfSink 			= 0.71045/2
ENT.BuoyancyRatio 		= 1.5
ENT.DampFactor 			= 4
ENT.Mass				= 50000/7
-- positions
ENT.WaterBreakPosition = Vector( 260,0,-20 )
ENT.PeriscopePosition 	= Vector( 20, -0, 75 )
ENT.ExitPos 			= Vector( 664, -158, 1158 )*.0915
ENT.CockpitviewPosition = Vector( 160, 0, 60 )
ENT.ExhaustPosition 	= {Vector( 120, 0, 100 ),Vector( 70, 0, 100 ),Vector( -70, 0, 100 ),Vector( -20, 0, 100 )}

ENT.ExteriorParts = {
"models/neuronaval/killstr3aks/american/cruisers/omaha_bow.mdl",
"models/neuronaval/killstr3aks/american/cruisers/omaha_midback.mdl",
"models/neuronaval/killstr3aks/american/cruisers/omaha_stern.mdl"
}
-- Speed & Sounds
ENT.EngineSoundPath 	= "Misc/water_movement.wav"--"vehicles/diesel_loop2.wav" 
ENT.Model 				= "models/neuronaval/killstr3aks/american/cruisers/omaha_midfront.mdl"
ENT.DeckModel = ""
-- ENT.PropellerPosition = Vector(-220, 0, 0 )
ENT.PropellerSplashSize = 15 
ENT.PropellerPos = {Vector( -289, -34, -15 ), Vector(  -289, 34, -15 ), Vector(  -360, -22, -15 ), Vector( -360, 22, -15 )}
ENT.PropellerModel = "models/neuronaval/killstr3aks/american/destroyers/clemson_propeller.mdl"
-- Weapon Data
ENT.NumberOfWeaponGroups = 3
ENT.WeaponGroupIcons = { "vgui/ui/ui_he.png", "vgui/ui/ui_torp.png", "vgui/ui/ui_flak.png"}
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
		BPos =Vector( 237.6, 26.4, 48.3 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_mainturret.mdl",
		TPos = Vector( 237.6, 26.4, 48.3 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_maingun.mdl",
		BaPos = Vector( 237.6, 26.4, 48.3 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 10, -- testing
		Damage = 2500,
		Radius = 20,
		PenetrationDepth = 10, -- units
		MaxYaw = 60,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = -160, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 237.6, -26.4, 48.3 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_mainturret.mdl",
		TPos = Vector( 237.6, -26.4, 48.3 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_maingun.mdl",
		BaPos = Vector( 237.6, -26.4, 48.3 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 10, -- testing
		Damage = 2500,
		Radius = 20,
		PenetrationDepth = 10, -- units
		MaxYaw = 60,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = -160, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 238, 20, 63 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_mainturret.mdl",
		TPos = Vector( 238, 20, 63 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_maingun.mdl",
		BaPos = Vector( 238, 20, 63 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 10, -- testing
		Damage = 2500,
		Radius = 20,
		PenetrationDepth = 10, -- units
		MaxYaw = 60,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 170, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 238, -20, 63 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_mainturret.mdl",
		TPos = Vector( 238, -20, 63 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_maingun.mdl",
		BaPos = Vector( 238, -20, 63 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 10, -- testing
		Damage = 2500,
		Radius = 20,
		PenetrationDepth = 10, -- units
		MaxYaw = 60,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 170, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -220.5, 33, 20.5 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_mainturret.mdl",
		TPos = Vector( -220.5, 33, 20.5 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_maingun.mdl",
		BaPos = Vector( -220.5, 33, 20.5 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 10, -- testing
		Damage = 2500,
		Radius = 20,
		PenetrationDepth = 10, -- units
		MaxYaw = 60,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 170, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -220.5, -33, 20.5 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_mainturret.mdl",
		TPos = Vector( -220.5, -33, 20.5 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_maingun.mdl",
		BaPos = Vector( -220.5, -33, 20.5 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 10, -- testing
		Damage = 2500,
		Radius = 20,
		PenetrationDepth = 10, -- units
		MaxYaw = 60,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 170, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -220.5, -26.5, 35.3 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_mainturret.mdl",
		TPos = Vector( -220.5, -26.5, 35.3 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_maingun.mdl",
		BaPos = Vector( -220.5, -26.5, 35.3 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 10, -- testing
		Damage = 2500,
		Radius = 20,
		PenetrationDepth = 10, -- units
		MaxYaw = 60,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 170, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "152mm/50 Mk8",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -220.5, 26.5, 35.3 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_mainturret.mdl",
		TPos = Vector( -220.5, 26.5, 35.3 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_maingun.mdl",
		BaPos = Vector( -220.5, 26.5, 35.3 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 10, -- testing
		Damage = 2500,
		Radius = 20,
		PenetrationDepth = 10, -- units
		MaxYaw = 60,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{	
	--_2Dpos = { x = 15,y = 120, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "Torpedo launcher",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos = Vector( -160, -26, 13 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/omaha_torpturret.mdl",
	TPos = Vector( -117, -36, 17 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/props_junk/garbage_metalcan002a.mdl",
	BaPos = Vector( -196, -26, 13 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_torpedo",
	AmmoModel = "",
	Cooldown = 60, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 11200,
	Radius = 200,
	PenetrationDepth = 20, -- units
	MaxYaw = 45,
	TowerTurnSpeed = .6,
	-- ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
	-- Muzzle = "microplane_MG_muzzleflash",
	NumShots = 2,
	WeaponGroup = 2,
	GroupedShotDelay = 1,
	-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = 15,y = 120, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "Torpedo launcher",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos = Vector( -160, 26, 13 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/omaha_torpturret.mdl",
	TPos = Vector( -117, 36, 17 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/props_junk/garbage_metalcan002a.mdl",
	BaPos = Vector( -196, 26, 13 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_torpedo",
	AmmoModel = "",
	Cooldown = 60, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 11200,
	Radius = 200,
	PenetrationDepth = 20, -- units
	MaxYaw = 45,
	TowerTurnSpeed = .6,
	-- ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
	-- Muzzle = "microplane_MG_muzzleflash",
	NumShots = 2,
	WeaponGroup = 2,
	GroupedShotDelay = 1,
	-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = 15,y = 120, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "Torpedo launcher",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos = Vector( -174, -32, 29 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/omaha_torpturret.mdl",
	TPos = Vector( -174, -32, 29 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/props_junk/garbage_metalcan002a.mdl",
	BaPos = Vector( -174, -32, 29 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_torpedo",
	AmmoModel = "",
	Cooldown = 60, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 11200,
	Radius = 200,
	PenetrationDepth = 20, -- units
	MaxYaw = 45,
	TowerTurnSpeed = .6,
	-- ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
	-- Muzzle = "microplane_MG_muzzleflash",
	NumShots = 2,
	WeaponGroup = 2,
	GroupedShotDelay = 1,
	-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = 15,y = 120, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "Torpedo launcher",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos = Vector( -174, 32, 29 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/omaha_torpturret.mdl",
	TPos = Vector( -174, 32, 29 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/props_junk/garbage_metalcan002a.mdl",
	BaPos = Vector( -174, 32, 29 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_torpedo",
	AmmoModel = "",
	Cooldown = 60, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 11200,
	Radius = 200,
	PenetrationDepth = 20, -- units
	MaxYaw = 45,
	TowerTurnSpeed = .6,
	-- ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
	-- Muzzle = "microplane_MG_muzzleflash",
	NumShots = 2,
	WeaponGroup = 2,
	GroupedShotDelay = 1,
	-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -50, -32, 30 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector(-50, -32, 30 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( -50, -32, 35 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	UseHitScan = true,
	Cooldown = .1, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 20,
	Radius = 50,
	PenetrationDepth = 1, -- units
	MaxYaw = 45,
	TowerTurnSpeed = 1,
	ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
	Muzzle = "microplane_MG_muzzleflash",
	NumShots = 1,
	WeaponGroup = 3,
	DisableIPP = true,
	GroupedShotDelay = 1,
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -50, 32, 30 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector(-50, 32, 30 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( -50, 32, 35 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	UseHitScan = true,
	Cooldown = .1, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 20,
	Radius = 50,
	PenetrationDepth = 1, -- units
	MaxYaw = 45,
	TowerTurnSpeed = 1,
	ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
	Muzzle = "microplane_MG_muzzleflash",
	NumShots = 1,
	WeaponGroup = 3,
	DisableIPP = true,
	GroupedShotDelay = 1,
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 0, -32, 31 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector(0, -32, 31 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( 0, -32, 36 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	UseHitScan = true,
	Cooldown = .1, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 20,
	Radius = 50,
	PenetrationDepth = 1, -- units
	MaxYaw = 45,
	TowerTurnSpeed = 1,
	ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
	Muzzle = "microplane_MG_muzzleflash",
	NumShots = 1,
	WeaponGroup = 3,
	DisableIPP = true,
	GroupedShotDelay = 1,
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 0, 32, 31 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector(0, 32, 31 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( 0, 32, 36 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	UseHitScan = true,
	Cooldown = .1, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 20,
	Radius = 50,
	PenetrationDepth = 1, -- units
	MaxYaw = 45,
	TowerTurnSpeed = 1,
	ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
	Muzzle = "microplane_MG_muzzleflash",
	NumShots = 1,
	WeaponGroup = 3,
	DisableIPP = true,
	GroupedShotDelay = 1,
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 50, -32, 32 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector( 50, -32, 32 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( 50, -32, 37 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	UseHitScan = true,
	Cooldown = .1, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 20,
	Radius = 50,
	PenetrationDepth = 1, -- units
	MaxYaw = 45,
	TowerTurnSpeed = 1,
	ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
	Muzzle = "microplane_MG_muzzleflash",
	NumShots = 1,
	WeaponGroup = 3,
	DisableIPP = true,
	GroupedShotDelay = 1,
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{	
	--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 50, 32, 32 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
	TPos =  Vector( 50, 32, 32 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
	BaPos =  Vector( 50, 32, 37 ),
	BarrelLength = 45,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	UseHitScan = true,
	Cooldown = .1, -- testing
	ShellVelocity = 45, -- units/s  
	Damage = 20,
	Radius = 50,
	PenetrationDepth = 1, -- units
	MaxYaw = 45,
	TowerTurnSpeed = 1,
	ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
	Muzzle = "microplane_MG_muzzleflash",
	NumShots = 1,
	WeaponGroup = 3,
	DisableIPP = true,
	GroupedShotDelay = 1,
	BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -210, -23, 44 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_aaturret.mdl",
	TPos =  Vector(-210, -23, 44 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_aagun.mdl",
	BaPos =  Vector( -210, -19, 45 ),
	BarrelLength = 10,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	Cooldown = 1,
	Damage = 100,
	Radius = 256,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 2,
	ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
	Muzzle = "mg_muzzleflash",
	NumShots = 1,
	DisableIPP = true,
	WeaponGroup = 3 
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( -210, 23, 44 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_aaturret.mdl",
	TPos =  Vector(-210, 23, 44 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_aagun.mdl",
	BaPos =  Vector( -210, 19, 45 ),
	BarrelLength = 10,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	Cooldown = 1,
	Damage = 100,
	Radius = 256,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 2,
	ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
	Muzzle = "mg_muzzleflash",
	NumShots = 1,
	DisableIPP = true,
	WeaponGroup = 3 
	}, 
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 180, -26, 50 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_aaturret.mdl",
	TPos =  Vector(180, -26, 50 ),
	TAng = Angle( 0, -90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_aagun.mdl",
	BaPos =  Vector( 180, -22, 51 ),
	BarrelLength = 10,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	Cooldown = 1,
	Damage = 100,
	Radius = 256,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 2,
	ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
	Muzzle = "mg_muzzleflash",
	NumShots = 1,
	DisableIPP = true,
	WeaponGroup = 3 
	},
	{
	-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
	Name = "Bofors 40mm",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos =  Vector( 180, 26, 50 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_aaturret.mdl",
	TPos =  Vector(180, 26, 50 ),
	TAng = Angle( 0, 90, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/phoenix_aagun.mdl",
	BaPos =  Vector( 180, 22, 51 ),
	BarrelLength = 10,
	AmmoType = "sent_mini_flak",
	AmmoModel = "",
	Cooldown = 1,
	Damage = 100,
	Radius = 256,
	PenetrationDepth = 1, -- units
	MaxYaw = 70,
	TowerTurnSpeed = 2,
	ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
	Muzzle = "mg_muzzleflash",
	NumShots = 1,
	DisableIPP = true,
	WeaponGroup = 3 
	}, 
	{	
	--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
	Name = "28mm/75 Mk2",
	Base = "models/props_junk/garbage_metalcan002a.mdl",
	BPos = Vector( -323, 0, 18 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/omaha_mainturret.mdl",
	TPos = Vector( -323, 0, 18 ),
	TAng = Angle( 0, 180, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/omaha_maingun.mdl",
	BaPos = Vector( -323, 0, 18 ),
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
	BPos = Vector( 293, 0, 43 ),
	Turret = "models/neuronaval/Killstr3aKs/american/cruisers/omaha_mainturret.mdl",
	TPos = Vector( 293, 0, 43 ),
	TAng = Angle( 0, 0, 0 ),
	Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/omaha_maingun.mdl",
	BaPos = Vector( 294, 0, 43 ),
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

