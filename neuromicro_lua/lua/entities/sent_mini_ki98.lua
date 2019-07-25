ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Mansyu Ki-98"
ENT.Author	= "Hoffa / Aftokinito"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE
ENT.IsShitPlane = true 

ENT.InitialHealth = 350
-- ENT.Armament = {

					-- { 
						-- PrintName = "37mm Cannon",
						-- Mdl = "models/items/AR2_Grenade.mdl" ,
						-- Pos = Vector( 0, 0, -9), 							-- Pos, Hard point location on the plane fuselage.
						-- Ang = Angle( 0, 0, 0), 								-- Ang, object angle
						-- Type = "Fragment",						-- Type, used when creating the object
						-- BurstSize = 10,
						-- Cooldown = 10, 										-- Cooldown between weapons
						-- isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						-- Class = "sent_mini_bomb",
						-- LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					-- }; 	
				-- };
				
ENT.Model 			= "models/aftokinito/neuroplanes/japanese/ki-98_body.mdl"
ENT.TailModel 		= "models/aftokinito/neuroplanes/japanese/ki-98_tail.mdl"
ENT.WingModels 		= { "models/aftokinito/neuroplanes/japanese/ki-98_wing_l.mdl", 
						"models/aftokinito/neuroplanes/japanese/ki-98_wing_r.mdl" }
ENT.PropellerModel = "models/aftokinito/neuroplanes/japanese/ki-98_prop.mdl"


ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= Vector( -29, 0, 2.4 )
ENT.PropellerFireOffset = 0
-- ENT.PropellerAttachedToWings = true


--- Physics
ENT.MinClimb = 5 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -15 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 80	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 3 				--unused atm
ENT.ThrottleIncrementSize = 4000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 2000 	-- how fast we drop speed
ENT.RudderMultiplier = 7 			-- how much we turn 
ENT.PitchValue = 11				-- how fast we rise / dive
ENT.AutoRollYawFactor = 40			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 200		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 300		-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 550			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 6						-- momentum damping
ENT.AngDamping = 8					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 10					-- Propeller Phys Obj Mass
ENT.BankForce = 575					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight

ENT.BankForceDivider = 0.5
ENT.PitchForceDivider = 3.75
ENT.YawForceDivider = 0.1525

-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
ENT.NA_IsCivilian = true
-- ENT.NoAirbrake = true
-- End of physics

-- Mouse Aim Variables.
ENT.MousePichForceMult = 1.2 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 1.0 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 70 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 100 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 


-- Weapons
-- ENT.PhysicalAmmo = true
-- ENT.NoSecondaryWeapons = false
-- ENT.NoLockon = true
-- ENT.PrimaryCooldown = 0.1
-- ENT.LastPrimaryAttack = CurTime() * 999999

ENT.PhysicalAmmo = true
ENT.NoSecondaryWeapons = true
ENT.NoLockon = true
ENT.PrimaryCooldown = 0.33
ENT.MuzzleOffset = 25

ENT.MinDamage = 690
ENT.MaxDamage = 1090
ENT.Radius = 16
ENT.AmmoType = "sent_mini_shell" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound("wt/guns/bk37_singleshot_1.wav" )
ENT.MinigunSound = "wt/guns/bk37_singleshot_1.wav"
ENT.MinigunPos = { Vector( 18, 0, 0 )  }
ENT.TracerScale1 = 0.1
ENT.TracerScale2 = 0.1
ENT.ImpactScale = 1.5
ENT.GlowProxyScale = 0.7
ENT.Muzzle = "AirboatMuzzleFlash"
ENT.FatRecoil = true
ENT.RecoilForce = -400000 --- Units/s force
ENT.RecoilAngle = 7.05 -- Degrees up on pitch axis
ENT.RecoilDuraiton = 0.035 -- Seconds
 
-- End of weapons

-- Visuals
ENT.CameraDistance = 165
ENT.CameraUp = 0
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 21, 0, 11 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 5, 17, 2 ) }
ENT.JetExhaust = false
-- ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = 4
ENT.ExhaustDieTime = 1
-- ENT.PropellerModel 	= "models/props_junk/PopCan01a.mdl"
-- ENT.HideProp = true
-- ENT.NoPropeller = true
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( -12,5,-0 ), Vector( -12, -5, -0 )}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"wt/engines/engine09_1500rpm.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/engine09_1500rpm.wav"}
	
if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 812
		local ent = ents.Create( class )
		ent:SetPos( SpawnPos )
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()
		timer.Simple( 0, function() if( IsValid( ply ) && IsValid( ent ) ) then ent:Use( ply,ply,0,0 ) end end )
		if( ply:IsAdmin() && type( ent.AdminArmament ) == "table" ) then
			ent:AddAdminEquipment()
		end
		return ent
	end
	function ENT:Initialize() self:CivAir_DefaultInit()
	
		constraint.NoCollide( self.Tail, self.Propeller, 0,0 )
		constraint.NoCollide( self.Wings[1], self.Propeller, 0,0 )
		constraint.NoCollide( self.Wings[2], self.Propeller, 0,0 )

	end
	function ENT:UpdateTransmitState()	return TRANSMIT_ALWAYS end
	function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
	function ENT:OnRemove() self:CivAir_OnRemove() end
	function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
	function ENT:Use(ply,caller, a, b ) self:CivAir_DefaultUse( ply,caller, a , b ) end
	function ENT:Think() self:JetAir_Think() end
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )		if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) 
		
		if( IsValid( self.Pilot ) && !self.Destroyed ) then
			
			local mi = 1.0 * self.CurVelocity  / self.MaxVelocity
			-- print( mi )
			
			self:GetPhysicsObject():AddAngleVelocity( Vector( 0, -10.2, 7.8	) * mi ) 
	
		end
		
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end
