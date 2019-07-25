ENT.FolderName 			= "sent_mini_nautilus"
ENT.Type 				= "vehicle"
ENT.Base 				= "base_anim"
ENT.PrintName			= "The Nautilus"
ENT.Author				= "Hoffa / Sillirion"
ENT.Category 			= "NeuroTec - Naval Submarines Tier I";
ENT.Spawnable			= true
ENT.AdminSpawnable 		= true
ENT.MicroSpectactularDeath 	= true
ENT.IsMicroCruiser 		= true 
ENT.CanTurnStationary	= true
ENT.HasNPCAntiAir = false 
ENT.WaterRippleScale = .33
ENT.KeepUpWeight = 2222
ENT.TurnAngleValue = .001
-- ENT.TurnIncrement = 10.15 
-- Variables
ENT.CamDist 			= 150
ENT.CamUp 				= 8
ENT.CameraMinZ			= 8 
ENT.WorldScale 			= 0.0915 -- 1/16th of original size
ENT.InitialHealth 		= 20000
--  Weapon data
ENT.BarrelLength 		= 35
ENT.IPPShellVelocity 	= 4050 -- speed of shell. Higher velocity = lower arc.
ENT.MinRange 			= 0 
ENT.MaxRange 			= 44000
ENT.MaxVelocity 		= 1200
ENT.MinVelocity 		= -1200
ENT.ForwardSpeed 		= ENT.MaxVelocity/3
ENT.ReverseSpeed 		= ENT.MinVelocity/3
ENT.TurnModifierValue 	= 45.1 	
ENT.FullSink 			= 0.71045/4
ENT.HalfSink 			= 0.71045/2
ENT.BuoyancyRatio 		= 150

-- Submarine Variables 
ENT.BuoyancyRatioSink = 1
ENT.MaxDivingDepth = 2750 -- Units
ENT.MaxDiveSpeed = 10 -- Units/s 
ENT.DiveSpeed = 0.000513	 
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


							
ENT.OverrideImpactDamage = 0 -- The Nautilus sinks her opponents by piercing their hull

-- Speed & Sounds
ENT.EngineSoundPath 	= "Misc/water_movement.wav"--"vehicles/diesel_loop2.wav" 
ENT.Model 				= "models/sillirion/nautilus/nautilus.mdl"
-- ENT.DeckModel = "models/neuronaval/starchick971/submarines/hms u class submarine_deck.mdl"
ENT.DeckMass = 50
-- ENT.PropellerPosition = Vector(-220, 0, 0 )
ENT.PropellerSplashSize = 15 
ENT.PropellerPos = Vector( -67, 0, 12 )
-- Weapon Data
-- ENT.NumberOfWeaponGroups = 2
-- ENT.WeaponGroupIcons = { "vgui/ui/ui_he.png", "vgui/ui/ui_torp.png"  }
-- 2D Boat Texture

			
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
                ent:GetPhysicsObject():SetMass( 500000 )
		-- ent:SetSubMaterial( 0,  "models/props_pipes/destroyedpipes01a" )
		
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
