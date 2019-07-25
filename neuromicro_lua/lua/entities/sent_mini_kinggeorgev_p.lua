ENT.FolderName 			= "sent_mini_KingGeorgeV_p"
ENT.Type 				= "vehicle"
ENT.Base 				= "base_anim"
ENT.PrintName			= "King George V Battleship"
ENT.Author				= "Hoffa / StarChick971 / Killstr3aks"
ENT.Category 			= "NeuroTec Micro Naval";
ENT.Spawnable			= false
ENT.AdminSpawnable 		= false
ENT.MicroSpectactularDeath 	= true
ENT.IsMicroCruiser 		= true 
ENT.CanTurnStationary	= true
ENT.HasNPCAntiAir = false 

ENT.Country = "United Kingdom"

-- Variables
ENT.KeepUpWeight = 2900
ENT.WaterRippleScale = 2.1
ENT.CamDist 			= 500
ENT.CamUp 				= 155
ENT.CameraMinZ			= 155 
ENT.WorldScale 			= 0.0915 -- 1/16th of original size
ENT.InitialHealth 		= 60000
--  Weapon data
ENT.BarrelLength 		= 75
ENT.IPPShellVelocity 	= 3050 -- speed of shell. Higher velocity = lower arc.
ENT.MinRange 			= 0 
ENT.MaxRange 			= 44000
ENT.MaxVelocity 		= 500
ENT.MinVelocity 		= -500
ENT.ForwardSpeed 		= ENT.MaxVelocity/3
ENT.ReverseSpeed 		= ENT.MinVelocity/3
ENT.TurnModifierValue 	= 1.3	
ENT.FullSink 			= 0.71045/4
ENT.HalfSink 			= 0.71045/2
ENT.BuoyancyRatio 		= 0.74
ENT.DampFactor 			= 1.0
ENT.TurnAngleValue = 5
ENT.PitchForce = .000011
ENT.PitchSineValue = 11.5 
-- ENT.Mass				= 50000
-- positions

ENT.HornPitch = 50 
ENT.WaterBreakPosition = Vector( 550,0,10 )
ENT.PeriscopePosition 	= Vector( -18, -0, 155 )
ENT.ExitPos 			= Vector( 664, -158, 1158 )*.0915
ENT.CockpitviewPosition = Vector( 1500, 0, 1500 )*.0915 
ENT.ExhaustPosition 	= {Vector( -106, 0, 150 ),
							Vector( 10, 0, 150 )}
-- Speed & Sounds
ENT.EngineSoundPath 	= "Misc/water_movement.wav"--"vehicles/diesel_loop2.wav" 
ENT.Model 				= "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_hull.mdl"
ENT.DeckModel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_deck.mdl"
ENT.PropellerPos = { Vector( -424, -38.5, 4 ), 
						Vector( -474, -14, -2 ),  
						Vector( -424, 38.5, 4 ), 
						Vector( -474, 14, -2 ) }
ENT.PropellerSplashSize = 15 
ENT.PropellerModel = "models/neuronaval/killstr3aks/british/battleships/kinggeorgev_propeller.mdl"
ENT.PropellerSplashScale = 3

ENT.NumberOfWeaponGroups = 1 
ENT.WeaponGroupIcons = {  }
-- Weapon Data
ENT.NumberOfWeaponGroups = 3  
ENT.WeaponGroupIcons = { "vgui/ui/ui_he.png", "vgui/ui/ui_he.png", "vgui/ui/ui_flak.png" }
-- 2D Boat Texture
ENT.HUDData = { Background = Material("vgui/ui/ships/george-v-hull.png" ), 
				W = 512, 
				H = 512, 
				X = 100, 
				Y = 450,
				Rotation = 1.5}

ENT.WeaponSystems = {{
		_2Dpos = { x = 0,y = -107, size = 32, icon = Material( "vgui/ui/ships/george-v-maingun.png" ), iconSize = 100},
		Name = "Mark 7 355mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 2550, -0, 670 )*.0915,
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_mainturret.mdl",
		TPos = Vector( 2550, -0, 670 )*.0915,
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_maingun.mdl",
		BaPos = Vector( 2830, -0, 880 )*.0915,
		BarrelLength = 75,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 15, -- testing
		Damage = 3550,
		Radius = 72,
		PenetrationDepth = 8, -- units
		MaxYaw = 120,
		TowerTurnSpeed = .2,
		ShootSound = "Cannons/18-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash",
		NumShots = 4,
		WeaponGroup = 1,
		BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915,  Vector( 355, -124, 4 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},{
		_2Dpos = { x = 0,y = -65, size = 32, icon = Material( "vgui/ui/ships/george-v-secgun.png" ), iconSize = 88 },
		Name = "Mark 7 355mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 1830, -0, 800 )*.0915,
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_secondturret.mdl",
		TPos = Vector( 1830, -0, 800 )*.0915,
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_secondgun.mdl",
		BaPos = Vector( 1970, -0, 1020 )*.0915,
		BarrelLength = 75,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 15,
		Damage = 3500,
		Radius = 72,
		PenetrationDepth = 8, -- units
		MaxYaw = 130,
		TowerTurnSpeed = .2,
		ShootSound = "Cannons/18-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash",
		NumShots = 2,
		WeaponGroup = 1,
		BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915 }
	},{
		_2Dpos = { x = 0, y = 120, size = 32 , icon = Material( "vgui/ui/ships/george-v-maingun.png" ), iconSize = 100 },
		Name = "Mark 7 355mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -3120, -0, 630 )*.0915,
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_mainturret.mdl",
		TPos = Vector( -3120, -0, 630 )*.0915,
		TAng = Angle( 0, 180, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_maingun.mdl",
		BaPos = Vector( -3400, -0, 840 )*.0915,
		BarrelLength = 75,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 15,
		Damage = 3500,
		Radius = 72,
		PenetrationDepth = 8, -- units
		MaxYaw = 120,
		TowerTurnSpeed = .2,
		ShootSound = "Cannons/18-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash",
		NumShots = 4,
		WeaponGroup = 1,
		BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915,  Vector( 355, -124, 4 )*.0915 } }
		
,{
		_2Dpos = { x = 25, y = -33, size = 32, icon = Material( "vgui/ui/ships/george-v-flak.png" ), iconSize = 66 },
		Name = "Mark 1 DP",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -111, -60, 77 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sideturret.mdl",
		TPos =  Vector( -111, -60, 77 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sidegun.mdl",
		BaPos =  Vector( -111, -62, 87 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8,
		Damage = 500,
		Radius = 32,
		PenetrationDepth = 4, -- units
		MaxYaw = 80,
		TowerTurnSpeed = .8,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = false,
		WeaponGroup = 2 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		_2Dpos = { x = -25, y = -33, size =32, icon = Material( "vgui/ui/ships/george-v-flak.png" ), iconSize = 66 },
		Name = "Mark 1 DP",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -111, 62, 77 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sideturret.mdl",
		TPos =  Vector( -111, 62, 77 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sidegun.mdl",
		BaPos =  Vector( -111, 64, 87 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8,
		Damage = 500,
		Radius = 32,
		PenetrationDepth = 4, -- units
		MaxYaw = 80,
		TowerTurnSpeed = .8,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = false,
		WeaponGroup = 2 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		_2Dpos = { x = 25, y = 33, size = 32, icon = Material( "vgui/ui/ships/george-v-flak.png" ), iconSize = 66 },
		Name = "Mark 1 DP",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -170, -58, 60 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sideturret.mdl",
		TPos =  Vector( -170, -58, 60 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sidegun.mdl",
		BaPos =  Vector( -170, -60, 70 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8,
		Damage = 500,
		Radius = 32,
		PenetrationDepth = 4, -- units
		MaxYaw = 80,
		TowerTurnSpeed = .8,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = false,
		WeaponGroup = 2 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		_2Dpos = { x = -25, y = 33, size = 32, icon = Material( "vgui/ui/ships/george-v-flak.png" ), iconSize = 66 },
		Name = "Mark 1 DP",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -170, 59, 60 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sideturret.mdl",
		TPos =  Vector( -170, 59, 60 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sidegun.mdl",
		BaPos =  Vector( -170, 61, 70 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8,
		Damage = 500,
		Radius = 32,
		PenetrationDepth = 4, -- units
		MaxYaw = 80,
		TowerTurnSpeed = .8,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = false,
		WeaponGroup = 2 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		_2Dpos = { x = -25, y = 66, size = 32, icon = Material( "vgui/ui/ships/george-v-flak.png" ), iconSize = 66 },
		Name = "Mark 1 DP",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( 55, 59, 60 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sideturret.mdl",
		TPos =  Vector( 55, 59, 60 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sidegun.mdl",
		BaPos =  Vector( 55, 61, 70 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8,
		Damage = 500,
		Radius = 32,
		PenetrationDepth = 4, -- units
		MaxYaw = 80,
		TowerTurnSpeed = .8,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = false,
		WeaponGroup = 2 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		_2Dpos = { x = 25, y = 66, size = 32, icon = Material( "vgui/ui/ships/george-v-flak.png" ), iconSize = 66 },
		Name = "Mark 1 DP",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( 55, -59, 60 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sideturret.mdl",
		TPos =  Vector( 55, -58, 60 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sidegun.mdl",
		BaPos =  Vector( 55, -60, 70 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8,
		Damage = 500,
		Radius = 32,
		PenetrationDepth = 4, -- units
		MaxYaw = 80,
		TowerTurnSpeed = .8,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = false,
		WeaponGroup = 2 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		_2Dpos = { x = 25, y = -11, size = 32, icon = Material( "vgui/ui/ships/george-v-flak.png" ), iconSize = 66 },
		Name = "Mark 1 DP",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( 2, -60, 77 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sideturret.mdl",
		TPos =  Vector( 2, -60, 77 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sidegun.mdl",
		BaPos =  Vector( 2, -61, 87 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8,
		Damage = 500,
		Radius = 32,
		PenetrationDepth = 4, -- units
		MaxYaw = 80,
		TowerTurnSpeed = .8,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = false,
		WeaponGroup = 2 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		_2Dpos = { x = -25, y = -11, size = 32, icon = Material( "vgui/ui/ships/george-v-flak.png" ), iconSize = 66 },
		Name = "Mark 1 DP",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( 2, 61, 77 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sideturret.mdl",
		TPos =  Vector( 2, 61, 77 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_sidegun.mdl",
		BaPos =  Vector( 2, 62, 87 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 8,
		Damage = 500,
		Radius = 32,
		PenetrationDepth = 4, -- units
		MaxYaw = 80,
		TowerTurnSpeed = .8,
		ShootSound = "Cannons/5-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = false,
		WeaponGroup = 2 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{ 
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Bofors 40mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( 35, 31, 96 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_flakturret.mdl",
		TPos =  Vector( 35, 31, 96 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_flakgun.mdl",
		BaPos =  Vector( 35, 31, 101 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .7,
		Damage = 200,
		Radius = 512,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }
		-- BarrelPorts =  {V}
,{
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Bofors 40mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( 35, -61, 77 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_flakturret.mdl",
		TPos =  Vector(35, -31, 96 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_flakgun.mdl",
		BaPos =  Vector( 35, -31, 101 ),
		BarrelLength = 10,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .7,
		Damage = 200,
		Radius = 512,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_big_"..math.random(1, 3)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }  
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Oerlikon 20mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( 95, -28, 116 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAturret.mdl",
		TPos =  Vector( 95, -28, 116 ),
		TAng = Angle( 0, 0, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAgun.mdl",
		BaPos =  Vector( 95, -28, 122.5 ),
		BarrelLength = 45,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .1,
		UseHitScan = true,
		Damage = 30,
		Radius = 16,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
		Muzzle = "microplane_MG_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Oerlikon 20mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( 95, 29, 116 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAturret.mdl",
		TPos =  Vector( 95, 29, 116 ),
		TAng = Angle( 0, 0, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAgun.mdl",
		BaPos =  Vector( 95, 29, 122.5 ),
		BarrelLength = 45,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .1,
		UseHitScan = true,
		Damage = 30,
		Radius = 16,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
		Muzzle = "microplane_MG_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Oerlikon 20mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( 70, -23, 134 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAturret.mdl",
		TPos =  Vector( 70, -23, 134 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAgun.mdl",
		BaPos =  Vector( 70, -21, 141 ),
		BarrelLength = 45,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .1,
		UseHitScan = true,
		Damage = 30,
		Radius = 16,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
		Muzzle = "microplane_MG_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Oerlikon 20mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( 70, 24, 134 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAturret.mdl",
		TPos =  Vector( 70, 24, 134 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAgun.mdl",
		BaPos =  Vector( 70, 22, 141 ),
		BarrelLength = 45,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .1,
		UseHitScan = true,
		Damage = 30,
		Radius = 16,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
		Muzzle = "microplane_MG_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Oerlikon 20mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( 2, -26, 109 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAturret.mdl",
		TPos =  Vector( 2, -26, 109 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAgun.mdl",
		BaPos =  Vector( 2, -25, 116 ),
		BarrelLength = 45,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .1,
		UseHitScan = true,
		Damage = 30,
		Radius = 16,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
		Muzzle = "microplane_MG_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Oerlikon 20mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( 2, 26, 109 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAturret.mdl",
		TPos =  Vector( 2, 26, 109 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAgun.mdl",
		BaPos =  Vector( 2, 25, 116 ),
		BarrelLength = 45,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .1,
		UseHitScan = true,
		Damage = 30,
		Radius = 16,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
		Muzzle = "microplane_MG_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Oerlikon 20mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -190, -35, 88 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAturret.mdl",
		TPos =  Vector( -190, -35, 88 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAgun.mdl",
		BaPos =  Vector( -190, -34, 95 ),
		BarrelLength = 45,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .1,
		UseHitScan = true,
		Damage = 30,
		Radius = 16,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
		Muzzle = "microplane_MG_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Oerlikon 20mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -210, -30, 88 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAturret.mdl",
		TPos =  Vector( -210, -30, 88 ),
		TAng = Angle( 0, -180, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAgun.mdl",
		BaPos =  Vector( -209, -30, 95 ),
		BarrelLength = 45,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .1,
		UseHitScan = true,
		Damage = 30,
		Radius = 16,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
		Muzzle = "microplane_MG_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Oerlikon 20mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -190, 35, 88 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAturret.mdl",
		TPos =  Vector( -190, 35, 88 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAgun.mdl",
		BaPos =  Vector( -190, 34, 95 ),
		BarrelLength = 45,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .1,
		UseHitScan = true,
		Damage = 30,
		Radius = 16,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
		Muzzle = "microplane_MG_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Oerlikon 20mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -210, 30, 88 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAturret.mdl",
		TPos =  Vector( -210, 30, 88 ),
		TAng = Angle( 0, -180, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAgun.mdl",
		BaPos =  Vector( -209, 30, 95 ),
		BarrelLength = 45,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .1,
		UseHitScan = true,
		Damage = 30,
		Radius = 16,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
		Muzzle = "microplane_MG_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		-- _2Dpos = { x = 15, y = 35, size = 64, icon = Material( "" ), iconSize = 44 },
		Name = "Oerlikon 20mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -213, 0, 121 ),
		Turret = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAturret.mdl",
		TPos =  Vector( -213, 0, 121 ),
		TAng = Angle( 0, -180, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/british/Battleships/KingGeorgeV_AAgun.mdl",
		BaPos =  Vector( -212, 0, 128 ),
		BarrelLength = 45,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = .1,
		UseHitScan = true,
		Damage = 30,
		Radius = 16,
		PenetrationDepth = 1, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/AA_shot_"..math.random(1, 3)..".wav",
		Muzzle = "microplane_MG_muzzleflash",
		NumShots = 1,
		DisableIPP = true,
		WeaponGroup = 3 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
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
	
	-- end 
	
end 

