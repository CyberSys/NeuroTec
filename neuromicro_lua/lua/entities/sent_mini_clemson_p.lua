ENT.FolderName 			= "sent_mini_clemson_p"
ENT.Type 				= "vehicle"
ENT.Base 				= "base_anim"
ENT.PrintName			= "USS Clemson (DD-186) LEVEL 1 "
ENT.Author				= "Hoffa / StarChick971 / Killstr3aks"
ENT.Category 			= "NeuroTec - Naval Tier IV";
ENT.Country = "USA"
ENT.Spawnable			= true
ENT.AdminSpawnable 		= true
ENT.MicroSpectactularDeath 	= true
ENT.IsMicroCruiser 		= true 
ENT.CanTurnStationary	= false
ENT.HasNPCAntiAir = false 
ENT.WaterRippleScale = .5
ENT.KeepUpWeight = 1750
ENT.TurnAngleValue = 1
ENT.NoSideForce = true 
ENT.ThrottleIncrementSize = 4 
-- Variables
ENT.CamDist 			= 300
ENT.CamUp 				= 78
ENT.CameraMinZ			= 78 
ENT.WorldScale 			= 0.0915 -- 1/16th of original size
ENT.InitialHealth 		= 10000
--  Weapon data
ENT.BarrelLength 		= 35
ENT.IPPShellVelocity 	= 3050 -- speed of shell. Higher velocity = lower arc.
ENT.MinRange 			= 0 
ENT.MaxRange 			= 44000
ENT.MaxVelocity 		= 800 * 5
ENT.MinVelocity 		= -800 * 5 
ENT.ForwardSpeed 		= ENT.MaxVelocity/3
ENT.ReverseSpeed 		= ENT.MinVelocity/3
ENT.TurnModifierValue 	= .0006	
ENT.TurnIncrement = 0.08
ENT.FullSink 			= 0.71045/4
ENT.HalfSink 			= 0.71045/2
ENT.BuoyancyRatio 		= 8
ENT.DampFactor 			= 6
ENT.Mass				= 50000/7
-- positions
ENT.WaterBreakPosition = Vector( 260,0,-20 )
ENT.PeriscopePosition 	= Vector( 20, -0, 75 )
ENT.ExitPos 			= Vector( 664, -158, 1158 )*.0915
ENT.CockpitviewPosition = Vector( 113, 0, 35 )
ENT.ExhaustPosition 	= {Vector( -9, 0, 65 ),
							Vector( 12, 0, 65 ),
							Vector( 49, 0, 65 ),
							Vector( 68, 0, 65 )}

ENT.ExteriorParts = {
"models/neuronaval/killstr3aks/american/destroyers/clemson_bow.mdl",
"models/neuronaval/killstr3aks/american/destroyers/clemson_midback.mdl",
"models/neuronaval/killstr3aks/american/destroyers/clemson_stern.mdl"
}
-- Speed & Sounds
ENT.EngineSoundPath 	= "Misc/water_movement.wav"--"vehicles/diesel_loop2.wav" 
ENT.Model 				= "models/neuronaval/killstr3aks/american/destroyers/clemson_midfront.mdl"
ENT.DeckModel = ""
-- ENT.PropellerPosition = Vector(-220, 0, 0 )
ENT.PropellerSplashSize = 15 
ENT.PropellerPos = {Vector( -198, -12, -11 ), Vector( -198, 12, -11 )}
ENT.PropellerModel = "models/neuronaval/killstr3aks/american/destroyers/clemson_propeller.mdl"
-- Weapon Data
ENT.NumberOfWeaponGroups = 3
ENT.WeaponGroupIcons = { "vgui/ui/ui_he.png", "vgui/ui/ui_torp.png", "vgui/ui/ui_depthcharge.png" }
-- 2D Boat Texture
ENT.HUDData = { Background = Material("vgui/ui/ships/clemson.png" ), 
				W = 232, 
				H = 516, 
				X = 100, 
				Y = 400,
				Rotation = 0}

ENT.WeaponSystems = {
	{
		_2Dpos = { x = 0,y = -170, size = 64, icon = Material( "vgui/ui/ships/clemson_maingun.png" ), iconSize = 45 },
		Name = "102mm/50 Mk12",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 156, -0, 21 ),
		Turret = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_mainturret.mdl",
		TPos = Vector( 156, -0, 21 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_maingun.mdl",
		BaPos = Vector( 156, -0, 26 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 6, -- testing
		Damage = 500,
		Radius = 40,
		PenetrationDepth = 6, -- units
		MaxYaw = 140,
		TowerTurnSpeed = 1.3,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 15,y = -30, size = 64, icon = Material( "vgui/ui/ships/clemson_maingun.png" ), iconSize = 45 },
		Name = "102mm/50 Mk12",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 34.5, -15.5, 30 ),
		Turret = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_mainturret.mdl",
		TPos = Vector( 34.5, -15.5, 30 ),
		TAng = Angle( 0, -90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_maingun.mdl",
		BaPos = Vector(34.5, -15.5, 35 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 6, -- testing
		Damage = 500,
		Radius = 40,
		PenetrationDepth = 6, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 1.3,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = -15,y = -30, size = 64, icon = Material( "vgui/ui/ships/clemson_maingun.png" ), iconSize = 45 },
		Name = "102mm/50 Mk12",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 34.5, 15.5, 30 ),
		Turret = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_mainturret.mdl",
		TPos = Vector( 34.5, 15.5, 30 ),
		TAng = Angle( 0, 90, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_maingun.mdl",
		BaPos = Vector(34.5, 15.5, 35 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 6, -- testing
		Damage = 500,
		Radius = 40,
		PenetrationDepth = 6, -- units
		MaxYaw = 70,
		TowerTurnSpeed = 1.3,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = 0,y = 160, size = 64, icon = Material( "vgui/ui/ships/clemson_maingun.png" ), iconSize = 45 },
		Name = "102mm/50 Mk12",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -163, -0, 21 ),
		Turret = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_mainturret.mdl",
		TPos = Vector( -163, -0, 21 ),
		TAng = Angle( 0, 180, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_maingun.mdl",
		BaPos = Vector( -163, -0, 28 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 6, -- testing
		Damage = 500,
		Radius = 40,
		PenetrationDepth = 6, -- units
		MaxYaw = 140,
		TowerTurnSpeed = 1.3,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "navalgun_muzzleflash_3",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{	
			_2Dpos = { x = -15,y = 110, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "Torpedo Launcher",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( -23, 16, 11 ),
			Turret = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_torpturret.mdl",
			TPos = Vector( -23, 16, 15 ),
			TAng = Angle( 0, 90, 0 ),
			Barrel = "models/props_junk/garbage_metalcan002a.mdl",
			BaPos = Vector( -24, 15, 10 ),
			BarrelLength = 45,
			DontAnimateBarrel = true, 
			AmmoType = "sent_mini_torpedo",
			AmmoModel = "",
			Cooldown = 45, -- testing
			ShellVelocity = 45, -- units/s  
			Damage = 7500,
			Radius = 50,
			PenetrationDepth = 20, -- units
			MaxYaw = 45,
			TowerTurnSpeed = 1,
			-- ShootSound = "Misc/hitmarker_sound.wav",
			Muzzle = "",
			NumShots = 3,
			WeaponGroup = 2,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			_2Dpos = { x = -15,y = 30, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "Torpedo Launcher",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( -99, 14, 11 ),
			Turret = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_torpturret.mdl",
			TPos = Vector( -99, 14, 13 ),
			TAng = Angle( 0, 90, 0 ),
			Barrel = "models/props_junk/garbage_metalcan002a.mdl",
			BaPos = Vector( -99, 14, 10 ),
			BarrelLength = 45,
			DontAnimateBarrel = true, 
			AmmoType = "sent_mini_torpedo",
			AmmoModel = "",
			Cooldown = 60, -- testing
			ShellVelocity = 45, -- units/s  
			Damage = 11200,
			Radius = 50,
			PenetrationDepth = 20, -- units
			MaxYaw = 45,
			TowerTurnSpeed = 1,
			-- ShootSound = "Misc/hitmarker_sound.wav",
			Muzzle = "",
			NumShots = 3,
			WeaponGroup = 2,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			_2Dpos = { x = 15,y = 120, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "Torpedo Launcher",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( -126, -14, 11 ),
			Turret = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_torpturret.mdl",
			TPos = Vector( -126, -14, 13 ),
			TAng = Angle( 0, -90, 0 ),
			Barrel = "models/props_junk/garbage_metalcan002a.mdl",
			BaPos = Vector( -126, -14, 10 ),
			BarrelLength = 45,
			DontAnimateBarrel = true, 
			AmmoType = "sent_mini_torpedo",
			AmmoModel = "",
			Cooldown = 60, -- testing
			ShellVelocity = 45, -- units/s  
			Damage = 11200,
			Radius = 50,
			PenetrationDepth = 20, -- units
			MaxYaw = 45,
			TowerTurnSpeed = 1,
			-- ShootSound = "Misc/hitmarker_sound.wav",
			Muzzle = "",
			NumShots = 3,
			WeaponGroup = 2,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			_2Dpos = { x = 15,y = 50, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "Torpedo Launcher",
			Base = "models/props_junk/garbage_metalcan002a.mdl",
			BPos = Vector( -44, -16, 11 ),
			Turret = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_torpturret.mdl",
			TPos = Vector( -44, -16, 15 ),
			TAng = Angle( 0, -90, 0 ),
			Barrel = "models/props_junk/garbage_metalcan002a.mdl",
			BaPos = Vector( -44, -16, 10 ),
			BarrelLength = 45,
			DontAnimateBarrel = true, 
			AmmoType = "sent_mini_torpedo",
			AmmoModel = "",
			Cooldown = 60, -- testing
			ShellVelocity = 45, -- units/s  
			Damage = 11200,
			Radius = 50,
			PenetrationDepth = 20, -- units
			MaxYaw = 45,
			TowerTurnSpeed = 1,
			-- ShootSound = "Misc/hitmarker_sound.wav",
			Muzzle = "",
			NumShots = 3,
			WeaponGroup = 2,
			GroupedShotDelay = 1,
			-- BarrelPorts =  { Vector( 19, -8, 5 ), Vector( 19, -3.25, 5 ),Vector( 19, 3.25, 5 ), Vector( 19, 8, 5 )} 
			},
			{	
			_2Dpos = { x = 0,y = 150, size = 64, icon = Material( "vgui/ui/ships/clemson_torpturret.png" ), iconSize = 40 },
			Name = "Depth Charge",
			Base = "models/neuronaval/killstr3aks/american/destroyers/mini_depth_charge.mdl",
			BPos = Vector( -213, 10, 11 ),
			Turret = "models/neuronaval/killstr3aks/american/destroyers/mini_depth_charge.mdl",
			TPos = Vector( -213, 10, 11 ),
			TAng = Angle( 0, 180, 0 ),
			Barrel = "models/neuronaval/killstr3aks/american/destroyers/mini_depth_charge.mdl",
			BaPos = Vector( -213, 10, 15 ),
			BarrelLength = 0,
			DontAnimateBarrel = true, 
			AmmoType = "sent_micro_depthcharge",
			AmmoModel = "",
			Cooldown = 1, -- testing
			ShellVelocity = 60, -- units/s  
			Damage = 11200,
			Radius = 180,
			PenetrationDepth = 20, -- units
			MaxYaw = 180,
			TowerTurnSpeed = 0,
			-- ShootSound = "Misc/hitmarker_sound.wav",
			Muzzle = "",
			NumShots = 12,
			WeaponGroup = 3,
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

