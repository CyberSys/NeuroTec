ENT.FolderName 			= "sent_mini_huitfeldt"
ENT.Type 				= "vehicle"
ENT.Base 				= "base_anim"
ENT.PrintName			= "HDMS Niels Juel (F363) LEVEL 2"
ENT.Author				= "Hoffa / StarChick971 / Killstr3aks / Smithy285"
ENT.Category 			= "NeuroTec - Modern Navy Tier I";
ENT.Spawnable			= true
ENT.AdminSpawnable 		= true
ENT.MicroSpectactularDeath 	= true
ENT.IsMicroCruiser 		= true 
ENT.CanTurnStationary	= true
ENT.HasNPCAntiAir = true 
ENT.TurnForceValue = 15000
ENT.TurnAngleValue = 2.5
ENT.KeepUpWeight = 3500 
ENT.Country = "Denmark"

ENT.PropellerPos = Vector( -244, 0, -27 )
-- Variables
ENT.CamDist 			= 330
ENT.CamUp 				= 78
ENT.CameraMinZ			= 78 
ENT.WorldScale 			= 0.0915 -- 1/16th of original size
ENT.InitialHealth 		= 17500
--  Weapon data
ENT.BarrelLength 		= 35
ENT.IPPShellVelocity 	= 4050 -- speed of shell. Higher velocity = lower arc.
ENT.MinRange 			= 0 
ENT.MaxRange 			= 44000
ENT.MaxVelocity 		= 1500
ENT.MinVelocity 		= -750
ENT.ForwardSpeed 		= ENT.MaxVelocity/4
ENT.ReverseSpeed 		= ENT.MinVelocity/2
ENT.TurnModifierValue 	=0.15	
ENT.FullSink 			= 0.71045/4
ENT.HalfSink 			= 0.71045/2
ENT.BuoyancyRatio 		= 4.971045
ENT.DampFactor 			= 1.0
-- ENT.Mass				= 50000
-- positions
ENT.WaterBreakPosition = Vector( 285.28, 0.4, -20.72 )
ENT.PeriscopePosition 	= Vector( 20, -0, 75 )
ENT.ExitPos 			= Vector( 664, -158, 1158 )*.0915
ENT.CockpitviewPosition = Vector( 20, 0, 75 )
-- ENT.ExhaustPosition 	= Vector( -1045, 0, 1280 )
-- Speed & Sounds
ENT.EngineSoundPath 	= "Misc/water_movement.wav"--"vehicles/diesel_loop2.wav" 
ENT.Model 				= "models/neuronaval/starchick971/Ships/iver huitfeldt.mdl"
ENT.DeckModel = "models/NavalWar/iver huitfeldt_mortar.mdl"
ENT.PropellerPosition = Vector( -244.6, -1.63, -26.41 )
ENT.PropellerSplashSize = 15 

ENT.NumberOfWeaponGroups = 1 
ENT.WeaponGroupIcons = {  }
-- Weapon Data
ENT.NumberOfWeaponGroups = 3  
ENT.WeaponGroupIcons = { "vgui/ui/ui_he.png", "vgui/ui/ui_he.png", "vgui/ui/ui_missile1.png" }
-- 2D Boat Texture
ENT.HUDData = { Background = Material("vgui/ui/ships/huitfeldt_hull.png" ), 
				W = 400, 
				H = 400, 
				X = 100, 
				Y = 450,
				Rotation = 0}
ENT.WeaponSystems = {{
		_2Dpos = { x = -5,y = -120, size = 64, icon = Material( "vgui/ui/ships/huitfeldt_gun.png" ), iconSize = 64 },
		Name = "Otobreda 76 mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 117, -0, 20 ),
		Turret = "models/neuronaval/starchick971/Ships/Iver Huitfeldt_turret1.mdl",
		TPos = Vector( 201.62, 1.3, 19.5 ),
		Barrel = "models/neuronaval/starchick971/Ships/iver huitfeldt_cannon1.mdl",
		BaPos = Vector( 204, 1.1, 26.2 ),
		BarrelLength = 35,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 3, -- testing
		Damage = 1550,
		Radius = 20,
		PenetrationDepth = 14, -- units
		MaxYaw = 180,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/kwk40_shot_0"..math.random(1,3)..".wav",
		Muzzle = "MG_muzzleflash",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = -5,y = -100, size = 32, icon = Material( "vgui/ui/ships/hamina_maingun.png" ), iconSize = 32 },
		Name = "Oerlikon Millennium 35 mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 117, -0, 20 ),
		Turret = "models/neuronaval/starchick971/Ships/Iver Huitfeldt_turret2.mdl",
		TPos = Vector( 169.18, 0.7, 28 ),
		Barrel = "models/neuronaval/starchick971/Ships/Iver Huitfeldt_cannon2.mdl",
		BaPos = Vector( 169.18, 0.7, 33 ),
		BarrelLength = 35,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 3, -- testing
		Damage = 650,
		Radius = 10,
		PenetrationDepth = 14, -- units
		MaxYaw = 180,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/kwk40_shot_0"..math.random(1,3)..".wav",
		Muzzle = "MG_muzzleflash",
		NumShots = 1,
		WeaponGroup = 2
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{
		_2Dpos = { x = -5,y = 100, size = 32, icon = Material( "vgui/ui/ships/hamina_maingun.png" ), iconSize = 32 },
		Name = "Oerlikon Millennium 35 mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 117, -0, 20 ),
		Turret = "models/neuronaval/starchick971/Ships/Iver Huitfeldt_turret2.mdl",
		TPos = Vector( -121.44, 1, 36.5 ),
		TAng = Angle( 0, 180, 0 ),
		Barrel = "models/neuronaval/starchick971/Ships/Iver Huitfeldt_cannon2.mdl",
		BaPos = Vector( -121.44, 1, 40 ),
		BaAng = Angle( 0, 180, 0 ),
		BarrelLength = 35,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 3, -- testing
		Damage = 950,
		Radius = 10,
		PenetrationDepth = 14, -- units
		MaxYaw = 180,
		TowerTurnSpeed = 2,
		ShootSound = "Cannons/kwk40_shot_0"..math.random(1,3)..".wav",
		Muzzle = "MG_muzzleflash",
		NumShots = 1,
		WeaponGroup = 2
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},
	{	
			_2Dpos = { x = -7.5, y = 60, size = 64, icon = Material( "vgui/ui/ships/hamina_torp.png" ), iconSize = 44 },
			Name = "Missile Launcher",
			Base = "models/magnet/submine/submine.mdl",
			BPos = Vector( -75, -10, 30 ),
			Turret = "models/neuronaval/starchick971/Ships/iver huitfeldt_mortar.mdl",
			TPos = Vector( -75, -10, 30 ),
			TAng = Angle( 90, 0, 0 ),
			Barrel = "models/weapons/w_missile_launch.mdl",
			BaPos = Vector( -75, -10, 20 ),
			-- BaAngle = Angle( -90, 0, 0 ),
			BarrelLength = 0,
			DontAnimateBarrel = true, 
			DontPitchBarrel = true,
			-- DontAnimateTower = true, 
			AmmoType = "sent_mini_naval_missile",
			AmmoModel = "models/starchick971/hawx/weapons/bgm-109 tomahawk.mdl",
			Cooldown = 30, -- testing
			ShellVelocity = 10, -- units/s  
			Damage = 25500,
			Radius = 256,
			PenetrationDepth = 15, -- units
			MaxYaw = 180,
			TowerTurnSpeed = 100,
			ShootSound = "bf4/misc/scud_fire.wav",
			Muzzle = "microplane_MG_muzzleflash",
			NumShots = 1,
			WeaponGroup = 3,
			GroupedShotDelay = 30,
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

