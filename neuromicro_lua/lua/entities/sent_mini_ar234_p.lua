ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Arado AR-234"
ENT.Author	= "Hoffa / Aftokinito"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.BombSound = "weapons/mortar/mortar_shell_incomming1.wav"

ENT.InitialHealth = 600
ENT.Armament = {

					{ 
						PrintName = "Big Evil Bomb",
						Mdl = "models/killstr3aks/neuroplanes/german/micro_500kg_bomb.mdl" ,
						Pos = Vector( 0, 0, -9), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0), 								-- Ang, object angle
						Type = "Fragment",						-- Type, used when creating the object
						BurstSize = 10,
						Cooldown = 15, 										-- Cooldown between weapons
						isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_bomb",
						Color = Color( 0,0,0,0 ),
						LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					}; 	
				};
				
ENT.Model 			= "models/aftokinito/neuroplanes/german/ar-234b-2_body.mdl"
ENT.TailModel 		= "models/aftokinito/neuroplanes/german/ar-234b-2_tail.mdl"
ENT.WingModels 		= { "models/aftokinito/neuroplanes/german/ar-234b-2_wing_l.mdl", 
						"models/aftokinito/neuroplanes/german/ar-234b-2_wing_r.mdl" }
ENT.PropellerModel 	= "models/aftokinito/neuroplanes/german/bf-109g-14_prop.mdl"

ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= Vector( 0, 0, 0 )
ENT.PropellerFireOffset = 32
ENT.IsShitPlane = true 

--- Physics
ENT.MinClimb = 5 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -15 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 100	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 7 				--unused atm
ENT.ThrottleIncrementSize = 9000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 1500 	-- how fast we drop speed
ENT.RudderMultiplier = 2 			-- how much we turn 
ENT.PitchValue = 6.5					-- how fast we rise / dive
ENT.AutoRollYawFactor = 55			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 55		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 50			-- tail lift coefficient
ENT.MaxVelocity = 1.8 * 600			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5						-- momentum damping
ENT.AngDamping = 5					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 10					-- Propeller Phys Obj Mass
ENT.BankForce = 345					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 2450				-- Wheel weight
-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
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
ENT.PhysicalAmmo = false
ENT.NoSecondaryWeapons = true
ENT.NoLockon = true
ENT.PrimaryCooldown = 10000.01
ENT.LastPrimaryAttack = CurTime() * 999999
ENT.NoMgun = true

ENT.MuzzleOffset = 85
ENT.MinDamage = 15
ENT.MaxDamage = 25
ENT.Radius = 72
ENT.AmmoType = "sent_mgun_bullet" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "IL-2/gun_17_22.mp3" )
ENT.MinigunSound = "IL-2/gun_17_22.mp3"
ENT.MinigunPos = { Vector( -10, 15, -2 ),Vector( -10, -15, -2 ), Vector( -25, -2, 4 ),Vector( -25, 2, 4 )  }

-- End of weapons

-- Visuals
ENT.CameraDistance = 200
ENT.CameraUp = 0
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 5, 0, 12 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
ENT.JetExhaust = true
ENT.ExhaustTexture = "sprites/heatwave"
ENT.ParticleSize = 0.5
ENT.ExhaustDieTime = 1
ENT.PropellerModel 	= "models/props_junk/PopCan01a.mdl"
ENT.HideProp = true
ENT.NoPropeller = true
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( -12,20,-0 ), Vector( -12, -20, -0 )}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = { "wt/engines/jet_engine_rpm33.wav", 
"physics/cardboard/cardboard_box_scrape_smooth_loop1.wav", 
"wt/engines/jet_engine_rpm33.wav" }
	
if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 512
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
	function ENT:Initialize() self:CivAir_DefaultInit() end
	function ENT:UpdateTransmitState()	return TRANSMIT_ALWAYS end
	function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
	function ENT:OnRemove() self:CivAir_OnRemove() end
	function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
	function ENT:Use(ply,caller, a, b ) self:CivAir_DefaultUse( ply,caller, a , b ) end
	function ENT:Think() self:JetAir_Think() end
	function ENT:PrimaryAttack() return end
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end
