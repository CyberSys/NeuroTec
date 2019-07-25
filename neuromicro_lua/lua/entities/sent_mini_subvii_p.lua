ENT.FolderName 			= "sent_mini_testsub_p"
ENT.Type 				= "vehicle"
ENT.Base 				= "base_anim"
ENT.PrintName			= "U-1062 LEVEL 2"
ENT.Author				= "Hoffa / Sillirion"
ENT.Category 			= "NeuroTec - Naval Submarines Tier I";
ENT.Spawnable			= true
ENT.AdminSpawnable 		= true
ENT.MicroSpectactularDeath 	= true
ENT.IsMicroCruiser 		= true 
ENT.CanTurnStationary	= true
ENT.HasNPCAntiAir = false 
ENT.WaterRippleScale = .33
ENT.KeepUpWeight = 1750
ENT.TurnAngleValue = .001
-- ENT.TurnIncrement = 10.15 
-- Variables
ENT.CamDist 			= 150
ENT.CamUp 				= 8
ENT.CameraMinZ			= 8 
ENT.WorldScale 			= 0.0915 -- 1/16th of original size
ENT.InitialHealth 		= 2500
--  Weapon data
ENT.BarrelLength 		= 35
ENT.IPPShellVelocity 	= 4050 -- speed of shell. Higher velocity = lower arc.
ENT.MinRange 			= 0 
ENT.MaxRange 			= 44000
ENT.MaxVelocity 		= 250
ENT.MinVelocity 		= -250
ENT.ForwardSpeed 		= ENT.MaxVelocity/3
ENT.ReverseSpeed 		= ENT.MinVelocity/3
ENT.TurnModifierValue 	= 45.1 	
ENT.FullSink 			= 0.71045/4
ENT.HalfSink 			= 0.71045/2
ENT.BuoyancyRatio 		= 15

-- Submarine Variables 
ENT.BuoyancyRatioSink = 0
ENT.MaxDivingDepth = 1750 -- Units
ENT.MaxDiveSpeed = 16 -- Units/s 
ENT.DiveSpeed = 0.0013	 
ENT.DampFactor 			= 1.7
ENT.IsMicroSubmarine = true 
ENT.WonkyHull = true   

-- ENT.Mass				= 50000
-- positions
ENT.PitchForce = 0.0001
ENT.TurnForceValue = .01
ENT.WaterMovementForce = 0.1 
ENT.PitchSineValue = 1001
ENT.WaterBreakPosition = Vector( 125,0,-25 )
ENT.PeriscopePosition 	= Vector( 20, -0, 75 )
ENT.ExitPos 			= Vector( 664, -158, 1158 )*.0915
ENT.CockpitviewPosition = Vector( -4.5, .75, 25.4 )
-- ENT.ExhaustPosition 	= {Vector( -15, 0, 70 ),
							-- Vector( 3, 0, 70 ),
							-- Vector( 42, 0, 70 ),
							-- Vector( 60, 0, 70 )}


-- Speed & Sounds
ENT.EngineSoundPath 	= "Misc/water_movement.wav"--"vehicles/diesel_loop2.wav" 
ENT.Model 				= "models/props_uboat/Micro/jed_ixb_hull.mdl"
ENT.DeckModel = "models/props_uboat/Micro/jed_ixb_twr.mdl"
ENT.DeckPosition = Vector(-9,0,4.85)
ENT.DeckMass = 50

ENT.ExtraProps = {
{ Pos = Vector(), Mdl = "" },
{ Pos = Vector(), Mdl = "" },
{ Pos = Vector(), Mdl = "" },
{ Pos = Vector(), Mdl = "" },
{ Pos = Vector(), Mdl = "" }
}
-- ENT.PropellerPosition = Vector(-220, 0, 0 )
ENT.PropellerSplashSize = 15 
ENT.PropellerPos = { Vector( -112.5, -5, -11 ) , Vector( -112.5, 5, -11 )  }
ENT.PropellerModel = "models/neuronaval/killstr3aks/american/destroyers/clemson_propeller.mdl"
ENT.PropellerSplashScale = .3						
-- Weapon Data
ENT.NumberOfWeaponGroups = 2
ENT.WeaponGroupIcons = { "vgui/ui/ui_he.png", "vgui/ui/ui_torp.png"  }
-- 2D Boat Texture
ENT.HUDData = { Background = Material("vgui/ui/ships/testsub-hull.png" ), 
				W = 516, 
				H = 516, 
				X = 100, 
				Y = 400,
				Rotation = 0}

ENT.WeaponSystems = {
	{
		_2Dpos = { x = -5,y =  -25, size = 64, icon = Material( "vgui/ui/ships/clemson_maingun.png" ), iconSize = 62 },
		Name = "Mark 9 100mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 17, -0, 7),
		Turret = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_mainturret.mdl",
		TPos = Vector( 17, -0, 7 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_maingun.mdl",
		BaPos = Vector( 17, -0, 13 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 6, -- testing
		Damage = 500,
		Radius = 40,
		PenetrationDepth = 6, -- units
		MaxYaw = 180,
		TowerTurnSpeed = 1.3,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "MG_muzzleflash",
		NumShots = 1,
		WeaponGroup = 1
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	},{
		_2Dpos = { x = -5,y = -240, size = 64, icon = Material( "vgui/ui/ships/clemson_maingun.png" ), iconSize = 4 },
		Name = "Torpedo Tubes",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 99, -0, 0 ),
		Turret = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_mainturret.mdl",
		TPos = Vector( 99, -0, 0 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_maingun.mdl",
		BaPos = Vector( 99, -0, 0 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_torpedo",
		AmmoModel = "",
		Cooldown = 15, -- testing
		ShellVelocity = 45, 
		Damage = 5000,
		Radius = 72,
		PenetrationDepth = 16, -- units
		MaxYaw = 140,
		TowerTurnSpeed = 0,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "",
		NumShots = 4,
		WeaponGroup = 2
		-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
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

