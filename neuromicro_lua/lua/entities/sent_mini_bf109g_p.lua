ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "BF-109 G"
ENT.Author	= "Hoffa / Aftokinito"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 350

ENT.Model 			= "models/aftokinito/neuroplanes/german/bf-109g-14_body.mdl"
ENT.TailModel 		= "models/aftokinito/neuroplanes/german/bf-109g-14_tail.mdl"
ENT.WingModels 		= { "models/aftokinito/neuroplanes/german/bf-109g-14_wing_l.mdl", 
						"models/aftokinito/neuroplanes/german/bf-109g-14_wing_r.mdl" }
ENT.PropellerModel 	= "models/aftokinito/neuroplanes/german/bf-109g-14_prop.mdl"
ENT.IsShitPlane = true 

ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= {  Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
ENT.PropellerPos 	= Vector( 0, 0, 0 )
ENT.PropellerFireOffset = 32

--- Physics
ENT.MinClimb = 5 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -15 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 60	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 5 				--unused atm
ENT.ThrottleIncrementSize = 6000 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 2000 	-- how fast we drop speed
ENT.RudderMultiplier = 6 			-- how much we turn 
ENT.PitchValue = 10.5					-- how fast we rise / dive
ENT.AutoRollYawFactor = 10			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = 100		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 30			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 580			-- Top speed in km/h
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 5						-- momentum damping
ENT.AngDamping = 5					-- angular momentum damping
ENT.PropForce = 100					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 10					-- Propeller Phys Obj Mass
ENT.BankForce = 200					-- Aileron / banking force Unit/s
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
ENT.MousePitchTreshold = 1.0 -- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 
ENT.PitchForceDivider = 1.75
ENT.YawForceDivider = 0.4925



-- Weapons -- initial data, this gets overridden by the MinigunData table
ENT.Muzzle = "AirboatMuzzleFlash"
ENT.PhysicalAmmo = false
-- ENT.NoSecondaryWeapons = true
ENT.NoLockon = true
-- ENT.BurstSize = 4
-- ENT.RoundsPerSecond = 1.5
-- ENT.BurstDuration = 0.1

ENT.PrimaryCooldown = 0.01
ENT.MuzzleOffset = 85
ENT.MinDamage = 5
ENT.MaxDamage = 15
ENT.Radius = 72
ENT.AmmoType = "sent_mgun_bullet" 
ENT.MinigunTracer = "tracer"
ENT.MachineGunModel = "models/airboatgun.mdl"
ENT.PrimaryShootSound = Sound( "wt/guns/fw_guns.wav" )
ENT.ContigiousFiringLoop = true
ENT.MinigunSound = "wt/guns/fw_guns.wav"

ENT.MinigunPos = { Vector( -5, -2, 4 ), Vector( 0, 0, 4 ), Vector( -5, 2, 4 )   }

-- Entries here correlate with entries in ENT.MinigunPos. First entry = First machinegun data
ENT.MinigunData = {
					{ 
						MinDmg = ENT.MinDamage, -- obvious
						MaxDmg = ENT.MaxDamage, -- obvious
						Radius = ENT.Radius, -- impact radius of explosive shells
						Tracer = "tracer", -- tracer effect, only works if Physical = false
						ShootSound = Sound( "wt/guns/fw_guns.wav" ), -- Shoot sound to play when we fire this round
						Physical = false, -- Use physical ammo? 
						AmmoType = "sent_mini_shell", -- Unused if Physical = false
						CoolDown = 0.01 -- cooldown for this gun
					};
					{ 
						MinDmg = ENT.MinDamage,
						MaxDmg = ENT.MaxDamage,
						Radius = ENT.Radius,
						Tracer = "tracer",
						ShootSound = Sound( "wt/guns/fw_guns.wav" ),
						Physical = false,
						AmmoType = "sent_mini_shell",
						CoolDown = 0.01
					
					};
					{ 
						MinDmg = ENT.MinDamage,
						MaxDmg = ENT.MaxDamage,
						Radius = ENT.Radius,
						Tracer = "tracer",
						ShootSound = Sound( "wt/guns/fw_guns.wav" ),
						Physical = true,
						AmmoType = "sent_mini_shell",
						CoolDown = .5
					
					};
				}
				
ENT.TracerScale1 = 0.1
ENT.TracerScale2 = 0.1
ENT.ImpactScale = 1.0
ENT.PrimaryMaxShots = 30
-- End of weapons

-- Visuals
ENT.CameraDistance = 100
ENT.CameraUp = 0
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 5, 0, 12 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = { 
Vector( 25,6,-2 ), Vector( 25, -6, -2 ),
Vector( 27,6,-2 ), Vector( 27, -6, -2 ),
Vector( 30,6,-2 ), Vector( 30, -6, -2 )}
-- ENT.WheelPos = { Vector( 15, -20, -15 ),Vector( 15, 20, -15 )  }
-- ENT.WheelModels = {"models/cessna/cessna172_nwheel.mdl","models/cessna/cessna172_nwheel.mdl"}
ENT.EngineSounds = {
	"wt/engines/engine_cockpit_open_1750rpm.wav",
	"vehicles/fast_windloop1.wav",
	"wt/engines/engine_cockpit_open_1750rpm.wav"}
ENT.Armament = {

					{ 
						PrintName = "Big Evil Bomb",
						Mdl = "models/killstr3aks/neuroplanes/german/micro_100kg_bomb.mdl" ,
						Pos = Vector( 0, 0, -5), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						Type = "Bomb",						-- Type, used when creating the object
						BurstSize = 1,
						Cooldown = 2, 										-- Cooldown between weapons
						isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_bomb",
						LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					}; 	
				};
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
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	if ( IsValid( wep ) ) then self:NeuroPlanes_FireRobot( wep, id ) end end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) 
	
		if( IsValid( self.Pilot ) && !self.Destroyed ) then
			
			if( self:GetVelocity():Length() > self.MaxVelocity / 2 ) then
				-- Vector( Roll, Pitch, Yaw )
				self:GetPhysicsObject():AddAngleVelocity( Vector( -3.5, 1.095, -1.2 ) ) 
				
			end
		
		end
		
	end

end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() end
	
end
