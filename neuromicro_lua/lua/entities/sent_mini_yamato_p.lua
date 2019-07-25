ENT.FolderName 			= "sent_mini_yamato_p"
ENT.Type 				= "vehicle"
ENT.Base 				= "base_anim"
ENT.PrintName			= "Yamato LEVEL 10"
ENT.Author				= "Hoffa / StarChick971 / Killstr3aks"
ENT.Category 			= "NeuroTec - Naval Tier X";
ENT.Spawnable			= true
ENT.AdminSpawnable 		= true
ENT.MicroSpectactularDeath 	= true
ENT.IsMicroCruiser 		= true 
ENT.CanTurnStationary	= true
ENT.HasNPCAntiAir = true 

ENT.Country = "Japan"

-- Variables
ENT.WaterRippleScale = 2.1
ENT.CamDist 			= 500
ENT.CamUp 				= 155
ENT.CameraMinZ			= 155 
ENT.WorldScale 			= 0.0915 -- 1/16th of original size
ENT.InitialHealth 		= 55000 --original 97000
--  Weapon data
ENT.BarrelLength 		= 75
ENT.IPPShellVelocity 	= 4050 -- speed of shell. Higher velocity = lower arc.
ENT.MinRange 			= 0 
ENT.MaxRange 			= 44000
ENT.MaxVelocity 		= 1000
ENT.MinVelocity 		= -1000
ENT.ForwardSpeed 		= ENT.MaxVelocity/3
ENT.ReverseSpeed 		= ENT.MinVelocity/3
ENT.TurnModifierValue 	= 1.5	
ENT.FullSink 			= 0.71045/4
ENT.HalfSink 			= 0.71045/2
ENT.BuoyancyRatio 		= 0.971045
ENT.DampFactor 			= 1.0
ENT.TurnAngleValue = 9
ENT.PitchForce = .000011
ENT.PitchSineValue = 11.5 
-- ENT.Mass				= 50000
-- positions
ENT.PeriscopePosition 	= Vector( -18, -0, 155 )
ENT.ExitPos 			= Vector( 664, -158, 1158 )*.0915
ENT.CockpitviewPosition = Vector( 1536, 0, 943 ) *.0915
ENT.ExhaustPosition 	= Vector( -1045, 0, 1280 )*.0915
-- Speed & Sounds
ENT.EngineSoundPath 	= "Misc/water_movement.wav"--"vehicles/diesel_loop2.wav" 
ENT.Model 				= "models/neuronaval/starchick971/Battleships/yamato_hull.mdl"
ENT.DeckModel = "models/neuronaval/starchick971/Battleships/yamato_deck.mdl"
ENT.PropellerPos = Vector(-450, 0, 0 )
ENT.PropellerSplashSize = 15 

ENT.HornPitch = 60 

ENT.NumberOfWeaponGroups = 1 
-- ENT.WeaponGroupIcons = {  }
-- Weapon Data
ENT.NumberOfWeaponGroups = 3  
ENT.WeaponGroupIcons = { "vgui/ui/ui_he.png", "vgui/ui/ui_flak.png","vgui/ui/ui_he.png" }
-- 2D Boat Texture
ENT.HUDData = { Background = Material("vgui/ui/ships/yamato.png" ), 
				W = 300, 
				H = 150, 
				X = 100, 
				Y = 450,
				Rotation = 90}

ENT.WeaponSystems = {{
		_2Dpos = { x = 0,y = -35, size = 64, icon = Material( "vgui/ui/ships/yamato_maingun.png" ), iconSize = 44 },
		Name = "460mm Main Battery",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 1121, -0, 600 )*.0915,
		Turret = "models/neuronaval/starchick971/Battleships/yamato_mainturret.mdl",
		TPos = Vector( 1121, -0, 600 )*.0915,
		Barrel = "models/neuronaval/starchick971/Battleships/yamato_mainturret_cannon.mdl",
		BaPos = Vector( 1300, -0, 690 )*.0915,
		BarrelLength = 35,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 15, -- testing
		Damage = 4555,
		Radius = 72,
		PenetrationDepth = 10, -- units
		MaxYaw = 120,
		TowerTurnSpeed = .3,
		ShootSound = "Cannons/18-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash",
		NumShots = 3,
		WeaponGroup = 1,
		BarrelPorts =  {Vector( 25,-11, 0 ), Vector( 25,0, 0 ),Vector( 25,11, 0 ) } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 0,y = -15, size = 64, icon = Material( "vgui/ui/ships/yamato_maingun.png" ), iconSize = 33 },
		Name = "260mm Secondary Battery",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 510, -13, 730 )*.0915,
		Turret = "models/neuronaval/starchick971/Battleships/yamato_secondturret.mdl",
		TPos = Vector( 510, -13, 730 )*.0915,
		Barrel = "models/neuronaval/starchick971/Battleships/yamato_secondturret_cannon.mdl",
		BaPos = Vector( 610, -13, 800 )*.0915,
		BarrelLength = 15,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 5, -- testing
		Damage = 1555,
		Radius = 72,
		PenetrationDepth = 10, -- units
		MaxYaw = 150,
		TowerTurnSpeed = .9,
		ShootSound = "Cannons/18-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 3,
		WeaponGroup = 3,
		BarrelPorts =  { Vector( 155, -90, 4 )*.0915, Vector( 155, -1, 3 )*.0915,Vector( 155, 90, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 0,y = 55, size = 64, icon = Material( "vgui/ui/ships/yamato_maingun.png" ), iconSize = 33 },
		Name = "260mm Secondary Battery",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -2150, -13, 730 )*.0915,
		Turret = "models/neuronaval/starchick971/Battleships/yamato_secondturret.mdl",
		TPos = Vector( -2000, -13, 730 )*.0915,
		TAng = Angle( 0, 180, 0 ),
		Barrel = "models/neuronaval/starchick971/Battleships/yamato_secondturret_cannon.mdl",
		BaPos = Vector( -2000, -13, 800 )*.0915,
		BarrelLength = 15,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 5, -- testing
		Damage = 1555,
		Radius = 72,
		PenetrationDepth = 10, -- units
		MaxYaw = 150,
		TowerTurnSpeed = .9,
		ShootSound = "Cannons/18-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 3,
		WeaponGroup = 3,
		BarrelPorts =  { Vector( 155, -90, 4 )*.0915, Vector( 155, -1, 3 )*.0915,Vector( 155, 90, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},

	{
		_2Dpos = { x = 0,y = -65, size = 64, icon = Material( "vgui/ui/ships/yamato_maingun.png" ), iconSize = 44 },
		Name = "460mm Main Battery",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 2121, -0, 469 )*.0915,
		Turret = "models/neuronaval/starchick971/Battleships/yamato_mainturret.mdl",
		TPos = Vector( 2121, -0, 469 )*.0915,
		Barrel = "models/neuronaval/starchick971/Battleships/yamato_mainturret_cannon.mdl",
		BaPos = Vector( 2300, -0, 540 )*.0915,
		BarrelLength = 35,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 15,
		Damage = 4555,
		Radius = 72,
		PenetrationDepth = 10, -- units
		MaxYaw = 145,
		TowerTurnSpeed = .3,
		ShootSound = "Cannons/18-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash",
		NumShots = 3,
		WeaponGroup = 1,
		BarrelPorts =  {Vector( 25,-11, 0 ), Vector( 25,0, 0 ),Vector( 25,11, 0 ) } -- use this if you want to use a single model with more than 1 barrel.
	},{
		_2Dpos = { x = 0, y = 75, size = 64 , icon = Material( "vgui/ui/ships/yamato_maingun.png" ), iconSize = 44 },
		Name = "460mm Main Battery",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -2690, -0, 500 )*.0915,
		Turret = "models/neuronaval/starchick971/Battleships/yamato_mainturret.mdl",
		TPos = Vector( -2690, -0, 500 )*.0915,
		TAng = Angle( 0, 180, 0 ),
		Barrel = "models/neuronaval/starchick971/Battleships/yamato_mainturret_cannon.mdl",
		BaPos = Vector( -2890, -0, 600 )*.0915,
		BarrelLength = 35,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 15,
		Damage = 4555,
		Radius = 72,
		PenetrationDepth = 10, -- units
		MaxYaw = 120,
		TowerTurnSpeed = .3,
		ShootSound = "Cannons/18-inch_shot_"..math.random(1, 3)..".wav",
		Muzzle = "navalgun_muzzleflash",
		NumShots = 3,
		WeaponGroup = 1,
		BarrelPorts =  {Vector( 25,-11, 0 ), Vector( 25,0, 0 ),Vector( 25,11, 0 ) } -- use this if you want to use a single model with more than 1 barrel.
		
},{ 
		_2Dpos = { x = 15, y = 35, size = 64, icon = Material( "vgui/ui/ships/yamato_aa.png" ), iconSize = 44 },
		Name = "88mm Flak",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -108, -44, 34 ),
		Turret = "models/neuronaval/starchick971/Battleships/yamato_sideturret.mdl",
		TPos =  Vector( -108, -44, 48 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/starchick971/Battleships/yamato_sideturret_cannon.mdl",
		BaPos =  Vector( -108, -47, 52 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = 10,
		Damage = 550,
		Radius = 512,
		PenetrationDepth = 2, -- units
		MaxYaw = 90,
		TowerTurnSpeed = 1.85,
		ShootSound = "Cannons/AA_shot_big_"..math.random(1, 4)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = true,
		WeaponGroup = 2 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		Name = "88mm Flak",
		_2Dpos = { x = 18, y = 15, size = 64, icon = Material( "vgui/ui/ships/yamato_aa.png" ), iconSize = 44 },
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -74, -44, 34 ),
		Turret = "models/neuronaval/starchick971/Battleships/yamato_sideturret.mdl",
		TPos =  Vector( -74, -44, 48 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/starchick971/Battleships/yamato_sideturret_cannon.mdl",
		BaPos =  Vector( -74, -47, 52 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = 10,
		Damage = 550,
		Radius = 512,
		PenetrationDepth = 10, -- units
		MaxYaw = 90,
		TowerTurnSpeed = 1.85,
		ShootSound = "Cannons/AA_shot_big_"..math.random(1, 4)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = true,
		WeaponGroup = 2 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  
,{
		_2Dpos = { x = 15, y = -5, size = 64, icon = Material( "vgui/ui/ships/yamato_aa.png" ), iconSize = 44 },
		Name = "88mm Flak",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -35, -44, 34 ),
		Turret = "models/neuronaval/starchick971/Battleships/yamato_sideturret.mdl",
		TPos =  Vector( -35, -44, 48 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/starchick971/Battleships/yamato_sideturret_cannon.mdl",
		BaPos =  Vector( -35, -47, 52 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = 10,
		Damage = 550,
		Radius = 512,
		PenetrationDepth = 10, -- units
		MaxYaw = 90,
		TowerTurnSpeed = 1.85,
		ShootSound = "Cannons/AA_shot_big_"..math.random(1, 4)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = true,
		WeaponGroup = 2 } 
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		_2Dpos = { x = -15, y = 35, size = 64, icon = Material( "vgui/ui/ships/yamato_aa.png" ), iconSize = 44 },
		Name = "88mm Flak",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -108, 44, 34 ),
		Turret = "models/neuronaval/starchick971/Battleships/yamato_sideturret.mdl",
		TPos =  Vector( -108, 44, 48 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/starchick971/Battleships/yamato_sideturret_cannon.mdl",
		BaPos =  Vector( -108, 47, 52 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = 10,
		Damage = 550,
		Radius = 512,
		PenetrationDepth = 10, -- units
		MaxYaw = 90,
		TowerTurnSpeed =1.85,
		ShootSound = "Cannons/AA_shot_big_"..math.random(1, 4)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = true,
		WeaponGroup = 2 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
,{
		_2Dpos = { x = -18, y = 15, size = 64, icon = Material( "vgui/ui/ships/yamato_aa.png" ), iconSize = 44 },
		Name = "88mm Flak",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -74, 44, 34 ),
		Turret = "models/neuronaval/starchick971/Battleships/yamato_sideturret.mdl",
		TPos =  Vector( -74, 44, 48 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/starchick971/Battleships/yamato_sideturret_cannon.mdl",
		BaPos =  Vector( -74, 47, 52 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = 10,
		Damage = 550,
		Radius = 512,
		PenetrationDepth = 10, -- units
		MaxYaw = 90,
		TowerTurnSpeed = 1.85,
		ShootSound = "Cannons/AA_shot_big_"..math.random(1, 4)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = true,
		WeaponGroup = 2 }
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  
,{
		_2Dpos = { x = -15, y = -5, size = 64, icon = Material( "vgui/ui/ships/yamato_aa.png" ), iconSize = 44 },
		Name = "88mm Flak",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =  Vector( -35, 44, 34 ),
		Turret = "models/neuronaval/starchick971/Battleships/yamato_sideturret.mdl",
		TPos =  Vector( -35, 44, 48 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/starchick971/Battleships/yamato_sideturret_cannon.mdl",
		BaPos =  Vector( -35, 47, 52 ),
		BarrelLength = 1,
		AmmoType = "sent_mini_flak",
		AmmoModel = "",
		Cooldown = 10,
		Damage = 550,
		Radius = 512,
		PenetrationDepth = 10, -- units
		MaxYaw = 90,
		TowerTurnSpeed = 1.85,
		ShootSound = "Cannons/AA_shot_big_"..math.random(1, 4)..".wav",
		Muzzle = "mg_muzzleflash",
		NumShots = 2,
		DisableIPP = true,
		WeaponGroup = 2 } 
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915  } }
			
}



-- Vector( -108, -44, 34 )

-- 
-- Vector( -74, -44, 48 )
-- Vector( -74, -44, 52 )

-- Vector( -35, -44, 34 )
-- Vector( -35, -44, 48 )
-- Vector( -35, -47, 52 )

ENT.CannonType = 1
ENT.CannonTypes = { 
					"npc_yamato_aa_small","npc_yamato_aa_small","npc_yamato_aa_small","npc_yamato_aa_small",
					"npc_yamato_aa_small","npc_yamato_aa_small","npc_yamato_aa_small","npc_yamato_aa_small",
					"npc_yamato_aa_small","npc_yamato_aa_small","npc_yamato_aa_small","npc_yamato_aa_small",
					"npc_yamato_aa_small","npc_yamato_aa_small","npc_yamato_aa_small","npc_yamato_aa_small",
					"npc_yamato_aa_small","npc_yamato_aa_small","npc_yamato_aa_small","npc_yamato_aa_small"}
ENT.CannonPos = { 
					Vector(-123,473,420),Vector(-232,605,420), Vector(-354,747,420), Vector(-560,747,420), Vector(-764,747,420),
					Vector(-961,747,420), Vector(-1173,747,420), Vector(-1299,635,437), Vector(-1396,518,437), Vector(-1553,443,500),
					Vector(-123,-473,420),Vector(-232,-605,420), Vector(-354,-747,420), Vector(-560,-747,420), Vector(-764,-747,420),
					Vector(-961,-747,420), Vector(-1173,-747,420), Vector(-1299,-635,437), Vector(-1396,-518,437), Vector(-1553,-443,500)}
ENT.CannonAngles = { Angle( 0, 180,0 ),
					Angle( 0, 180,0 ),	Angle( 0, 180,0 ),	Angle( 0, 180,0 ),
					Angle( 0, 180,0 ),	Angle( 0, 180,0 ),	Angle( 0, 180,0 ),
					Angle( 0, 180,0 ),	Angle( 0, 180,0 ),  Angle( 0, 180,0 ),
					Angle( 0, 180,0 ),	Angle( 0, 180,0 ),	Angle( 0, 180,0 ),
					Angle( 0, 180,0 ),	Angle( 0, 180,0 ),	Angle( 0, 180,0 ),
					Angle( 0, 180,0 ),	Angle( 0, 180,0 ),	Angle( 0, 180,0 ),
					Angle( 0, 180,0 )}

			
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

