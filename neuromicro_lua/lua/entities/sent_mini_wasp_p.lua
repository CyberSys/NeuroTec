-- ENT.FolderName 			= "sent_mini_yamato_p"
ENT.Type 				= "vehicle"
ENT.Base 				= "base_anim"
ENT.PrintName			= "U.S.S Wasp MAX LEVEL"
ENT.Author				= "Hoffa"
ENT.Category 			= "NeuroTec - Naval Tier X";
ENT.Spawnable			= true
ENT.AdminSpawnable 		= false
ENT.MicroSpectactularDeath 	= true
ENT.IsMicroCruiser 		= true 
ENT.CanTurnStationary	= true
ENT.HasNPCAntiAir = true 

ENT.Country = "Japan"

-- Variables
ENT.WaterRippleScale = 2.1
ENT.CamDist 			= 600
ENT.CamUp 				= 300
ENT.CameraMinZ			= 300
ENT.WorldScale 			= 0.0915 -- 1/16th of original size
ENT.InitialHealth 		= 97000
--  Weapon data
ENT.BarrelLength 		= 75
ENT.IPPShellVelocity 	= 4050 -- speed of shell. Higher velocity = lower arc.
ENT.MinRange 			= 0 
ENT.MaxRange 			= 54000
ENT.MaxVelocity 		= 2000
ENT.MinVelocity 		= -1000
ENT.ForwardSpeed 		= ENT.MaxVelocity/5
ENT.ReverseSpeed 		= ENT.MinVelocity/5
ENT.TurnModifierValue 	= 10.5	
ENT.FullSink 			= 0.71045/4
ENT.HalfSink 			= 0.71045/2
ENT.BuoyancyRatio 		= 0.250
ENT.DampFactor 			= 1.0
ENT.TurnAngleValue = 9
ENT.PitchForce = .000011
ENT.PitchSineValue = 11.5 
-- ENT.Mass				= 50000
-- positions
ENT.PeriscopePosition 	= Vector( -18, -0, 155 )
ENT.ExitPos 			= Vector( -45, 45, 245 )
ENT.CockpitviewPosition = Vector( 1536, 0, 943 ) *.0915
ENT.ExhaustPosition 	= Vector( -1045, 0, 1280 )*.0915
-- Speed & Sounds
ENT.EngineSoundPath 	= "Misc/water_movement.wav"--"vehicles/diesel_loop2.wav" 
ENT.Model 				= "models/hoffa/neuroplanes/american/wasp/body.mdl"
ENT.DeckModel = "models/hoffa/neuroplanes/american/wasp/deck.mdl"
ENT.DeckMass = 50 
ENT.PropellerPos = Vector(-550, 0, 0 )
ENT.PropellerSplashSize = 15 

ENT.HornPitch = 60 

ENT.WeaponSystems = {
	{
		_2Dpos = { x = 0,y =  0, size = 64, icon = Material( "vgui/ui/ships/clemson_maingun.png" ), iconSize = 62 },
		Name = "Mark 9 100mm",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( 750, -150, 250),
		Turret = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_mainturret.mdl",
		TPos = Vector(750, -0, 245 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_maingun.mdl",
		BaPos = Vector( 750, -0, 250 ),
		BarrelLength = 5,
		AmmoType = "sent_mini_naval_shell",
		AmmoModel = "",
		Cooldown = 2, -- testing
		Damage = 15000,
		Radius = 40,
		PenetrationDepth = 6, -- units
		MaxYaw = 180,
		TowerTurnSpeed = 1.3,
		ShootSound = "cannons/5-inch_shot_"..math.random(1,3)..".wav",
		Muzzle = "MG_muzzleflash",
		NumShots = 1,
		WeaponGroup = 1
	},	-- BarrelPorts =  { Vector( 355, -124, 4 )*.0915, Vector( 355, -1, 3 )*.0915,Vector( 355, 128, 2 )*.0915 } -- use this if you want to use a single model with more than 1 barrel.
	{
		_2Dpos = { x = -5,y = -240, size = 64, icon = Material( "vgui/ui/ships/clemson_maingun.png" ), iconSize = 4 },
		Name = "Torpedo Tubes",
		Base = "models/props_junk/garbage_metalcan002a.mdl",
		BPos =Vector( -699, 150, 250 ),
		Turret = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_mainturret.mdl",
		TPos = Vector( -699, -0, 245 ),
		Barrel = "models/neuronaval/Killstr3aKs/american/Destroyers/clemson_maingun.mdl",
		BaPos = Vector( -699, -0, 250 ),
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
	
	-- end 
	
end 
