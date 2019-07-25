ENT.FolderName 			= "sent_mini_erie_p"
ENT.Type 				= "vehicle"
ENT.Base 				= "base_anim"
ENT.PrintName			= "Erie LEVEL 0"
ENT.Author				= "Hoffa / StarChick971 / Killstr3aks"
ENT.Category 			= "NeuroTec - Naval Tier I";
ENT.Country = "USA"
ENT.Spawnable			= true
ENT.AdminSpawnable 		= true
ENT.MicroSpectactularDeath 	= true
ENT.IsMicroCruiser 		= true 
ENT.CanTurnStationary	= false
ENT.HasNPCAntiAir = false 
ENT.WaterRippleScale = .8
ENT.KeepUpWeight = 2000
ENT.TurnAngleValue = 0.17
ENT.NoSideForce = true 

ENT.ThrottleIncrementSize = 4 
-- Variables
ENT.CamDist 			= 300
ENT.CamUp 				= 78
ENT.CameraMinZ			= 78 
ENT.WorldScale 			= 0.0915 -- 1/16th of original size
ENT.InitialHealth 		= 9000
--  Weapon data
ENT.BarrelLength 		= 35
ENT.IPPShellVelocity 	= 3050 -- speed of shell. Higher velocity = lower arc.
ENT.MinRange 			= 0 
ENT.MaxRange 			= 44000
ENT.MaxVelocity 		= 600 * 7
ENT.MinVelocity 		= -600 * 7
ENT.ForwardSpeed 		= ENT.MaxVelocity/3
ENT.ReverseSpeed 		= ENT.MinVelocity/3
ENT.TurnModifierValue 	= 0.00025	
ENT.TurnIncrement = 0.15
ENT.FullSink 			= 0.71045/4
ENT.HalfSink 			= 0.71045/2
ENT.BuoyancyRatio 		= 5
ENT.DampFactor 			= 6
ENT.Mass				= 50000/7
-- positions
ENT.WaterBreakPosition = Vector( 260,0,-20 )
ENT.PeriscopePosition 	= Vector( 20, -0, 75 )
ENT.ExitPos 			= Vector( 664, -158, 1158 )*.0915
ENT.CockpitviewPosition = Vector( 113, 0, 35 )
ENT.ExhaustPosition 	= {Vector( 10, 0, 80 )}

ENT.ExteriorParts = {
"models/neuronaval/killstr3aks/american/cruisers/erie_bow.mdl",
"models/neuronaval/killstr3aks/american/cruisers/erie_midback.mdl",
"models/neuronaval/killstr3aks/american/cruisers/erie_stern.mdl"
}
-- Speed & Sounds
ENT.EngineSoundPath 	= "Misc/water_movement.wav"--"vehicles/diesel_loop2.wav" 
ENT.Model 				= "models/neuronaval/killstr3aks/american/cruisers/erie_midfront.mdl"
ENT.DeckModel = ""
-- ENT.PropellerPosition = Vector(-220, 0, 0 )
ENT.PropellerSplashSize = 15 
ENT.PropellerPos = {Vector( -187, -15, -11 ), Vector( -187, 15, -11 )}
ENT.PropellerModel = "models/neuronaval/killstr3aks/american/destroyers/clemson_propeller.mdl"
-- Weapon Data
ENT.NumberOfWeaponGroups = 2
ENT.WeaponGroupIcons = { "vgui/ui/ui_he.png", "vgui/ui/ui_flak.png" }
-- 2D Boat Texture
ENT.HUDData = { Background = Material("vgui/ui/ships/erie_hull.png" ), 
				W = 512, 
				H = 512, 
				X = 100, 
				Y = 400,
				Rotation = 180}

ENT.WeaponSystems = {
	{
		_2Dpos = { x = 4,y = -160, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/51 Mk7",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 164, -0, 24 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_mainturret.mdl",
		TPos = Vector( 164, -0, 24 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_maingun.mdl",
		BaPos = Vector( 164, -0, 30 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 5, -- testing
		Damage = 1000,
		Radius = 20,
		PenetrationDepth = 3, -- units
		MaxYaw = 140,
		TowerTurnSpeed = 1,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = -120, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/51 Mk7",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 121, 0, 33 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_mainturret.mdl",
		TPos = Vector( 121, 0, 33 ),
		TAng = Angle( 0, 0, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_maingun.mdl",
		BaPos = Vector(121, 0, 39 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 5, -- testing
		Damage = 1000,
		Radius = 20,
		PenetrationDepth = 3, -- units
		MaxYaw = 140,
		TowerTurnSpeed = 1,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 120, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/51 Mk7",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -102, 0, 30 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_mainturret.mdl",
		TPos = Vector( -102, 0, 30 ),
		TAng = Angle( 0, 180, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_maingun.mdl",
		BaPos = Vector(-102, 0, 36 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 5, -- testing
		Damage = 1000,
		Radius = 20,
		PenetrationDepth = 6, -- units
		MaxYaw = 140,
		TowerTurnSpeed = 1,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 4,y = 170, size = 64, icon = Material( "vgui/ui/ships/erie_maingun.png" ), iconSize = 64 },
		Name = "127mm/51 Mk7",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -142, -0, 21 ),
		Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_mainturret.mdl",
		TPos = Vector( -142, -0, 21 ),
		TAng = Angle( 0, 180, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_maingun.mdl",
		BaPos = Vector( -142, -0, 27 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 5, -- testing
		Damage = 1000,
		Radius = 20,
		PenetrationDepth = 6, -- units
		MaxYaw = 140,
		TowerTurnSpeed = 1,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{	
			--_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "28mm/75 Mk2",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( 96, 0, 40 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
			TPos = Vector( 96, 0, 40 ),
			TAng = Angle( 0, 0, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
			BaPos = Vector( 97, 0, 45 ),
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
			WeaponGroup = 2,
			DisableIPP = true,
			GroupedShotDelay = 1,
			BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = -15,y = 30, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "28mm/75 Mk2",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( 45, 18, 53 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
			TPos = Vector( 45, 18, 53 ),
			TAng = Angle( 0, 90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
			BaPos = Vector( 45, 19, 58 ),
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
			WeaponGroup = 2,
			DisableIPP = true,
			GroupedShotDelay = 1,
			BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 120, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "28mm/75 Mk2",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( 45, -18, 53 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
			TPos = Vector( 45, -18, 53 ),
			TAng = Angle( 0, -90, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
			BaPos = Vector( 45, -19, 58 ),
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
			WeaponGroup = 2,
			DisableIPP = true,
			GroupedShotDelay = 0,
			BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			--_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "28mm/75 Mk2",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( -74, 0, 42 ),
			Turret = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aaturret.mdl",
			TPos = Vector( -74, 0, 42 ),
			TAng = Angle( 0, 180, 0 ),
			Barrel = "models/neuronaval/Killstr3aKs/american/cruisers/erie_aagun.mdl",
			BaPos = Vector( -75, 0, 47 ),
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
			WeaponGroup = 2,
			DisableIPP = true,
			GroupedShotDelay = 0,
			BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
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

