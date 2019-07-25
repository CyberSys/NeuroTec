ENT.FolderName 			= "sent_mini_st_louis_p"
ENT.Type 				= "vehicle"
ENT.Base 				= "base_anim"
ENT.PrintName			= "USS St. Louis LEVEL 3"
ENT.Author				= "Hoffa / Killstr3aks"
ENT.Category 			= "NeuroTec - Naval Tier I";
ENT.Country = "USA"
ENT.Spawnable			= true
ENT.AdminSpawnable 		= true
ENT.MicroSpectactularDeath 	= true
ENT.IsMicroCruiser 		= true 
ENT.CanTurnStationary	= false
ENT.HasNPCAntiAir = false 
ENT.WaterRippleScale = 1.2
ENT.KeepUpWeight = 2000
ENT.TurnAngleValue = 0.4
ENT.NoSideForce = true 

ENT.ThrottleIncrementSize = 2 
-- Variables
ENT.CamDist 			= 300
ENT.CamUp 				= 85
ENT.CameraMinZ			= 85 
ENT.WorldScale 			= 0.0915 -- 1/16th of original size
ENT.InitialHealth 		= 28000
--  Weapon data
ENT.BarrelLength 		= 35
ENT.IPPShellVelocity 	= 3050 -- speed of shell. Higher velocity = lower arc.
ENT.MinRange 			= 0 
ENT.MaxRange 			= 44000
ENT.MaxVelocity 		= 320 * 7
ENT.MinVelocity 		= -320 * 7
ENT.ForwardSpeed 		= ENT.MaxVelocity/3
ENT.ReverseSpeed 		= ENT.MinVelocity/3
ENT.TurnModifierValue 	= 0.01	
ENT.TurnIncrement = 0.004
ENT.FullSink 			= 0.71045/4
ENT.HalfSink 			= 0.71045/2
ENT.BuoyancyRatio 		= 1.4
ENT.DampFactor 			= 5
ENT.Mass				= 50000/7
-- positions
ENT.WaterBreakPosition = Vector( 320,0,-20 )
ENT.PeriscopePosition 	= Vector( 20, -0, 75 )
ENT.ExitPos 			= Vector( 664, -158, 1158 )*.0915
ENT.CockpitviewPosition = Vector( 275, 0, 27 )
ENT.ExhaustPosition 	= {Vector( 55, 0, 120 ),Vector( 0, 0, 120 ), Vector( 100, 0, 120 ),Vector( -55, 0, 120 )}

ENT.ExteriorParts = {
"models/neuronaval/killstr3aks/american/cruisers/st_louis_bow.mdl",
"models/neuronaval/killstr3aks/american/cruisers/st_louis_midback.mdl",
"models/neuronaval/killstr3aks/american/cruisers/st_louis_stern.mdl"
}
-- Speed & Sounds
ENT.EngineSoundPath 	= "Misc/water_movement.wav"--"vehicles/diesel_loop2.wav" 
ENT.Model 				= "models/neuronaval/killstr3aks/american/cruisers/st_louis_midfront.mdl"
ENT.DeckModel = ""
-- ENT.PropellerPosition = Vector(-220, 0, 0 )
ENT.PropellerSplashSize = 15 
ENT.PropellerPos = {Vector( -271, -16, -24 ), Vector( -271, 16, -24 )}
ENT.PropellerModel = "models/neuronaval/killstr3aks/american/destroyers/clemson_propeller.mdl"
-- Weapon Data
ENT.NumberOfWeaponGroups = 1
ENT.WeaponGroupIcons = { "vgui/ui/ui_he.png"}
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
		Name = "127mm/50 Mk5",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 187, -0, 25.5 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_mainturret.mdl",
		TPos = Vector( 187, -0, 25.5 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_maingun.mdl",
		BaPos = Vector( 187, -0, 32 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8, -- testing
		Damage = 1500,
		Radius = 20,
		PenetrationDepth = 13, -- units
		MaxYaw = 140,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = -120, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/50 Mk5",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 71.5, -42, 16.5 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sideturret.mdl",
		TPos = Vector( 71.5, -42, 16.5 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sidegun.mdl",
		BaPos = Vector(71.5, -40, 17 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8, -- testing
		Damage = 1500,
		Radius = 20,
		PenetrationDepth = 13, -- units
		MaxYaw = 50,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 120, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/50 Mk5",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 71.5, 42, 16.5 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sideturret.mdl",
		TPos = Vector( 71.5, 42, 16.5 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sidegun.mdl",
		BaPos = Vector(71.5, 40, 17 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8, -- testing
		Damage = 1500,
		Radius = 20,
		PenetrationDepth = 13, -- units
		MaxYaw = 50,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = -120, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/50 Mk5",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 71.5, -42, 27.5 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sideturret.mdl",
		TPos = Vector( 71.5, -42, 27.5 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sidegun.mdl",
		BaPos = Vector(71.5, -40, 28 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8, -- testing
		Damage = 1500,
		Radius = 20,
		PenetrationDepth = 13, -- units
		MaxYaw = 50,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 120, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/50 Mk5",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 71.5, 42, 27.5 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sideturret.mdl",
		TPos = Vector( 71.5, 42, 27.5 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sidegun.mdl",
		BaPos = Vector(71.5, 40, 28 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8, -- testing
		Damage = 1500,
		Radius = 20,
		PenetrationDepth = 13, -- units
		MaxYaw = 50,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 120, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/50 Mk5",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -80.5, 42, 27.5 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sideturret.mdl",
		TPos = Vector( -80.5, 42, 27.5 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sidegun.mdl",
		BaPos = Vector(-80.5, 42, 28 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8, -- testing
		Damage = 1500,
		Radius = 20,
		PenetrationDepth = 13, -- units
		MaxYaw = 50,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 120, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/50 Mk5",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -80.5, -42, 27.5 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sideturret.mdl",
		TPos = Vector( -80.5, -42, 27.5 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sidegun.mdl",
		BaPos = Vector(-80.5, -42, 28 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8, -- testing
		Damage = 1500,
		Radius = 20,
		PenetrationDepth = 13, -- units
		MaxYaw = 50,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 120, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/50 Mk5",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -80.5, 42, 16.5 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sideturret.mdl",
		TPos = Vector( -80.5, 42, 16.5 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sidegun.mdl",
		BaPos = Vector(-80.5, 42, 17 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8, -- testing
		Damage = 1500,
		Radius = 20,
		PenetrationDepth = 13, -- units
		MaxYaw = 50,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 120, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/50 Mk5",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -80.5, -42, 16.5 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sideturret.mdl",
		TPos = Vector( -80.5, -42, 16.5 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_sidegun.mdl",
		BaPos = Vector(-80.5, -42, 17 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8, -- testing
		Damage = 1500,
		Radius = 20,
		PenetrationDepth = 13, -- units
		MaxYaw = 50,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 170, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/50 Mk5",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -200, -0, 24.5 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_mainturret.mdl",
		TPos = Vector( -200, -0, 24.5 ),
		TAng = Angle( 0, 180, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/st_louis_maingun.mdl",
		BaPos = Vector( -200, -0, 30.5 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8, -- testing
		Damage = 1500,
		Radius = 20,
		PenetrationDepth = 13, -- units
		MaxYaw = 140,
		TowerTurnSpeed = .4,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{	
			--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( 225, -23, 14 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( 225, -23, 14 ),
			TAng = Angle( 0, -55, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector( 225, -23, 20 ),
			BarrelLength = 45,
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 5, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 3, -- units
			MaxYaw = 20,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = -15,y = 30, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( 225, 23, 14 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( 225, 23, 14 ),
			TAng = Angle( 0, 55, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector( 225, 23, 20 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 5, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 3, -- units
			MaxYaw = 20,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 120, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( 190, 24, 13 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( 190, 24, 13 ),
			TAng = Angle( 0, 90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector( 190, 24, 19 ),
			BarrelLength = 45,
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 5, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 3, -- units
			MaxYaw = 20,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( 190, -24, 13 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( 190, -24, 13 ),
			TAng = Angle( 0, -90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector( 190, -24, 19 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 5, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 20,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( 145, 30, 13 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( 145, 30, 13 ),
			TAng = Angle( 0, 90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector( 145, 30, 19 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 6, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 25,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( 145, -30, 13 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( 145, -30, 13 ),
			TAng = Angle( 0, -90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector( 145, -30, 19 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 6, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 25,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos =Vector( 20, 35, 24 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( 20, 35, 24 ),
			TAng = Angle( 0, 90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector(20, 35, 30 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 6, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 25,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos =Vector( 20, -35, 24 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( 20, -35, 24 ),
			TAng = Angle( 0, -90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector(20, -35, 30 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 6, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 25,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos =Vector( -5, 35, 24 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( -5, 35, 24 ),
			TAng = Angle( 0, 90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector(-5, 35, 30 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 6, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 25,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos =Vector( -5, -35, 24 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( -5, -35, 24 ),
			TAng = Angle( 0, -90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector(-5, -35, 30 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 6, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 25,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos =Vector( -30, -35, 24 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( -30, -35, 24 ),
			TAng = Angle( 0, -90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector(-30, -35, 30 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 6, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 25,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos =Vector( -30, 35, 24 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( -30, 35, 24 ),
			TAng = Angle( 0, 90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector(-30, 35, 30 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 6, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 25,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos =Vector( -158, -30, 13 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( -158, -30, 13 ),
			TAng = Angle( 0, -90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector(-158, -30, 19 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 6, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 25,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos =Vector( -158, 30, 13 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( -158, 30, 13 ),
			TAng = Angle( 0, 90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector(-158, 30, 19 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 6, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 25,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos =Vector( -217, -25, 13 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( -217, -25, 13 ),
			TAng = Angle( 0, -90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector(-217, -25, 19 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 6, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 25,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "76.2mm/50 Mk4",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos =Vector( -217, 25, 13 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondturret.mdl",
			TPos = Vector( -217, 25, 13 ),
			TAng = Angle( 0, 90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/chester_secondgun.mdl",
			BaPos = Vector(-217, 25, 19 ),
			BarrelLength = 45, 
			AmmoType = "sent_mini_naval_shell",
			AmmoModel = "",
			Cooldown = 6, -- testing
			ShellVelocity = 3045, -- units/s  
			Damage = 200,
			Radius = 5,
			PenetrationDepth = 1, -- units
			MaxYaw = 25,
			TowerTurnSpeed = .6,
			ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 1,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
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

