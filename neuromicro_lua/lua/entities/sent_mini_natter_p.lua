ENT.Type = "vehicle"
ENT.Base = "base_anim"
ENT.PrintName	= "Bachem Ba 349" --  

ENT.Author	= "Hoffa / Hoffa"
ENT.Category 		= "NeuroTec Micro";
ENT.Spawnable	= true
ENT.AdminSpawnable = false
ENT.VehicleType = VEHICLE_PLANE

ENT.InitialHealth = 200
-- Big ass kick-back 
-- ENT.FatRecoil = true
-- ENT.RecoilForce = -500000 --- Units/s force
-- ENT.RecoilAngle = 10.05 -- Degrees up on pitch axis
-- ENT.RecoilDuraiton = 0.045 -- Seconds
 
ENT.Model 			= "models/hoffa/neuroplanes/german/natter/natter_body.mdl"
ENT.TailModel 		= "models/hoffa/neuroplanes/german/natter/natter_tail.mdl"
ENT.WingModels 		= { "models/hoffa/neuroplanes/german/natter/natter_wing_l.mdl", 
						"models/hoffa/neuroplanes/german/natter/natter_wing_r.mdl" }
ENT.PropellerModels 	=  {"models/props_junk/PopCan01a.mdl","models/props_junk/PopCan01a.mdl"} 
ENT.PropellerAttachedToWings = true 

ENT.PropellerPos = { Vector( 0, 17, -2 )   }
ENT.HideProp = true
-- ENT.NoPropeller = true
ENT.ControlSurfaces  = {
	Elevator = { 
			Mdl = "models/hoffa/neuroplanes/german/natter/natter_elevator.mdl", 
			Pos = Vector(-52.5,0,5.5 ),
			Ang = Angle( 0,0,0 )
			};
	Rudder = {	
				{	
						Mdl = "models/hoffa/neuroplanes/german/natter/natter_rudder1.mdl",
						Pos = Vector(-52,0,12.350),
						Ang = Angle( 0,0,0 )
						};
						{
						Mdl = "models/hoffa/neuroplanes/german/natter/natter_rudder2.mdl",
						Pos = Vector(-50,0,-14),
						Ang = Angle( 0,0,0 )
						}
				};
				
	Ailerons = {
			{
			Mdl = "models/starchick971/neuroplanes/american/fa-22 raptor_aileron_l.mdl",
			Pos = Vector(-9,15,-5),
			Ang = Angle( 0,-0,0 )
			};
			{
			Mdl = "models/starchick971/neuroplanes/american/fa-22 raptor_aileron_r.mdl",
			Pos = Vector(-9,-15,-5),
			Ang = Angle( 0,0,-0)
			};
		};
				-- models/starchick971/neuroplanes/american/fa-22 raptor_aileron_l.mdl
			-- };
} 
ENT.HideProp = true
ENT.Armament = {

					{ 
						PrintName = "Rockets",
						Mdl = "models/items/AR2_Grenade.mdl" ,
						Pos = Vector( 35, 0, -5), 							-- Pos, Hard point location on the plane fuselage.
						Ang = Angle( 0, -1, 0), 								-- Ang, object angle
						Type = "Pod",						-- Type, used when creating the object
						-- BurstSize = 10,
						Cooldown = 20, 										-- Cooldown between weapons
						isFirst	= true,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						Class = "sent_mini_rocket",
						Color = Color( 0,0,0, 0 ),
						BurstSize = 8
				
						-- LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					};	
	
				
				}
ENT.TailPos			= Vector( 0, 0, 0)
ENT.WingPositions 	= { Vector( 0,0,0 ), 
						Vector( 0,0,0 ) }
						
						
-- ENT.VisualModels  = {
	-- Cannon = { 
			-- Mdl = "models/props_canal/mattpipe.mdl", 
			-- Pos = Vector(43.5,0,0),
			-- Ang = Angle(0,90,90),
			-- Col = Color(60,60,60,255),
			-- Mat = "models/props_c17/FurnitureMetal001a"
	-- };
-- } 						

-- ENT.PropellerPos 	= Vector( 0, 0, 0 )
-- ENT.PropellerFireOffset = 32
-- ENT.Armament = { -- This thing did not have bombs cause the cannont weighted more than the whole set of bombs the normal A1 could carry

					-- { 
						-- PrintName = "Big Evil Bomb",
						-- Mdl = "models/killstr3aks/neuroplanes/german/micro_100kg_bomb.mdl" , -- YOLO WE NEED BOMBS TOO BRO
						-- Pos = Vector( 0, 0, -5), 							-- Pos, Hard point location on the plane fuselage.
						-- Ang = Angle( 0, 0, 0 ), 								-- Ang, object angle
						-- Type = "Bomb",						-- Type, used when creating the object
						-- BurstSize = 1,
						-- Cooldown = 2, 										-- Cooldown between weapons
						-- isFirst	= nil,										-- If a plane got 2 rockets of the same type, set the first rocket to isFirst = true.
						-- Class = "sent_mini_bomb",
						-- LaunchSound = "vehicles/crane/crane_magnet_release.wav"
					-- }; 	
				-- };
				
--- Physics
ENT.MinClimb = 5 					-- How much we have to pitch down to start gaining speed.
ENT.MaxClimb = -15 					-- Max angle we can go before we start losing speed.
ENT.ClimbPunishmentMultiplier = 60	-- How fast we gain speed. Higher value faster acceleration / deceleration
ENT.BankingFactor = 7 				--unused atm
ENT.ThrottleIncrementSize = 14950 	-- how fast we gain speed 
ENT.ThrottleDecreaseSize = 7500 	-- how fast we drop speed
ENT.RudderMultiplier = 8 			-- how much we turn 
ENT.PitchValue = 6.7					-- how fast we rise / dive
ENT.AutoRollYawFactor = 30			-- How much we turn when the plane is leaning to either side
ENT.DestroyedDownForce = -5000		-- How much force to apply when the plane is going down after being hit / destroyed
ENT.TailLiftMultiplier = -1115		-- Wing Mass / Mult * Velocity -- lift coefficient 
ENT.WingLiftMultiplier = 200			-- tail lift coefficient
ENT.MaxVelocity = 1.9 * 1100			-- Top speed in km/h // Heavy gun :D
ENT.MinVelocity = 0					-- slowest we can go (unused)
ENT.Damping = 4 						-- momentum damping
ENT.AngDamping = 8					-- angular momentum damping
ENT.PropForce = 0					-- How much torque to apply to propeller. Unit/s 
ENT.PropMass = 1					-- Propeller Phys Obj Mass
ENT.BankForce = 490					-- Aileron / banking force Unit/s
ENT.AxledWheels = true              -- Use axis instead of weld?
ENT.WheelMass = 245				-- Wheel weight
-- ENT.AngleCompensation = Vector( 0, 0, -4 )
-- ENT.HasAfterburner = false
-- ENT.HasAirbrakes = false
-- ENT.NA_IsCivilian = false
-- ENT.NoAirbrake = true
-- End of physics

ENT.YawForceDivider = 0.35
ENT.OverrideWeldStrenght = 9999999999999

-- Mouse Aim Variables.
ENT.MousePichForceMult = 1.2 -- MousePichForceMult * PitchForce, override default max pitch force when using hte mouse.
ENT.MouseBankForceMult = 1.0 -- MouseBankForceMult * BankForce, override default max bank speed if the plane feels sluggish when turning
ENT.MousePitchForce = 70 -- How many times to mulitply the angle difference between plane pitch and mouse pitch
ENT.MouseBankForce = 100 -- How many times to multiply the angle difference between plane Yaw and Mouse Yaw.
ENT.MouseBankTreshold = 2.0 -- How many degrees we can allow the mouse to move before we start banking, set this high if you got a front mounted cannon so you can aim freely a bit.
ENT.MousePitchTreshold = 1.0-- use power of two with MouseBankTreshold to create a mousetrap near the front of the plane. 


-- Weapons
-- ENT.PhysicalAmmo = true
-- ENT.NoSecondaryWeapons = true
-- ENT.NoLockon = true

ENT.Muzzle = "AirboatMuzzleFlash"
ENT.PhysicalAmmo = true
-- ENT.NoSecondaryWeapons = true
ENT.NoLockon = true
ENT.PrimaryCooldown = .1
ENT.MuzzleOffset = 85
ENT.Muzzle = "microplane_MG_muzzleflash"
ENT.PCFMuzzle = true -- use .pcf muzzleflash
ENT.MinDamage = 40
ENT.MaxDamage = 80
ENT.Radius = 12
ENT.AmmoType = "sent_mini_shell" 
-- Visuals
ENT.CameraDistance = 300
ENT.CameraUp = 0
ENT.TinySmoke = true
ENT.CockpitPosition = Vector( 15, 0,10 )
ENT.TrailPos = { Vector( -14, 214, 35 ), Vector( -14, -214, 35 ) }
ENT.FireTrailPos = { Vector( 2, -22, 32 ), Vector( 76, 17, 2 ) }
-- ENT.PilotModelPos = Vector( -5,9,-7)
ENT.ExhaustPos = {
Vector( -45, -11, -7 ), Vector( -45, -11, -1 ),
Vector( -45, 11, -7 ), Vector( -45, 11, -1 ) , Vector( -55, 0, -3 ) 

}
ENT.JetExhaust = true
ENT.ExhaustTexture = "effects/EpicExplosion1"
ENT.ParticleSize = 0.2
ENT.ExhaustDieTime = 2
ENT.EngineStartupSound =  "bf4/misc/scud_fire.wav"

ENT.MinigunPos = { Vector( 15,3,-5),Vector(15,-3,-5) }
ENT.MachineGunModel ="models/airboatgun.mdl"
ENT.PrimaryShootSound = "wt/guns/type97_gun.wav" 
ENT.ContigiousFiringLoop = true
ENT.EngineSounds = { "wt/engines/jet_engine_rpm66.wav", 
"physics/cardboard/cardboard_box_scrape_smooth_loop1.wav", 
"RocketEngine.wav" }
if( SERVER ) then

	AddCSLuaFile(  )
	function ENT:SpawnFunction( ply, tr, class )
		local SpawnPos =  ply:GetPos() + ply:GetUp() * 555
		local ent = ents.Create( class )
		ent:SetPos( SpawnPos )
		ent:SetAngles( ply:GetAngles() )
		ent:Spawn()
		ent:Activate()
		-- constraint.Weld( ent, game.GetWorld(), 0,0,0, true, false )
		
		timer.Simple( 0, function() if( IsValid( ply ) && IsValid( ent ) ) then ent:Use( ply,ply,0,0 ) end end )
		if( ply:IsAdmin() && type( ent.AdminArmament ) == "table" ) then
			ent:AddAdminEquipment()
		end
		return ent
	end
	function ENT:Initialize() 
	
		self:CivAir_DefaultInit() 
	
	
		
	end
	function ENT:UpdateTransmitState()	return TRANSMIT_ALWAYS end
	function ENT:OnTakeDamage(dmginfo) self:CivAir_DefaultDamage(dmginfo) end
	function ENT:OnRemove() self:CivAir_OnRemove() end
	function ENT:PhysicsCollide( data, physobj ) self:Micro_PhysCollide( data, physobj ) end
	function ENT:Use(ply, caller, a, b ) 
		
		if( self.RampLaunched && caller != self.Ramp ) then 
			
			self.Ramp:Use( ply, caller,a,b )
			
		else
		
			self:CivAir_DefaultUse( ply,caller, a , b ) 
		
		end 
		
	end
	function ENT:Think() self:JetAir_Think() end
	function ENT:PrimaryAttack() self:Micro_DefaultPrimaryAttack() end
	function ENT:SecondaryAttack( wep, id )	return end
	function ENT:PhysicsSimulate( phys, deltatime ) self:MicroPhysics( phys, deltatime ) 
		
		if( IsValid( self.Pilot ) && !self.Destroyed && self.CurVelocity ) then
			
			if( self:GetVelocity():Length() > self.MaxVelocity / 4 ) then
			
				self:GetPhysicsObject():AddAngleVelocity( Vector(-0, 16, -1.5 ) * 1.0 * ( self.CurVelocity  / self.MaxVelocity ) ) 
				
			end
		
		end
		
	end
	
end

if( CLIENT ) then 

	function ENT:Initialize() self:CivAir_CInit() 
	
		self.Emitter = ParticleEmitter(Vector(0, 0, 0))
		self.lifetime = RealTime()
		self.cooltime = CurTime()
	end
	function ENT:CalcView( ply, Origin, Angles, Fov ) return DefaultPropPlaneCView( ply, Origin, Angles, Fov ) end
	function ENT:Draw() self:CivAir_Draw() 
		
	
	if( !self:GetNWBool("EngineStarted") ) then return end 
	
	local color = self:GetNetworkedInt("SmokeColor", 50 ) 
	local dist = 60
	local dlight = DynamicLight( self:EntIndex() )
		
	local ppos = self:GetPos() + self:GetUp()*-5 + self:GetForward()*-dist + self:GetVelocity() *FrameTime()
	
	if ( dlight ) then

		local c = Color( 250+math.random(-5,5), 130+math.random(-5,5), 0, 255 )

		dlight.Pos =  self:GetPos() + self:GetUp()*-5 + self:GetForward()*-dist 
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = 2
		dlight.Decay = 0.1
		dlight.Size = 256
		dlight.DieTime = CurTime() + 0.15

	end


		if (self.lifetime > RealTime()) then
			if (self.cooltime < CurTime()) then
			
			local smoke = self.Emitter:Add("effects/smoke_a", ppos  + self:GetForward() * -dist/4)
			smoke:SetVelocity(self:GetForward()*-255)
			smoke:SetDieTime(math.Rand(.9,1.1))
			smoke:SetStartAlpha(math.Rand(160,200))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(14,18)*.5)
			smoke:SetEndSize(math.random(96,129)*.5)
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-2,2))
			smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
			smoke:SetColor( color, color, color )
			smoke:SetAirResistance(60)
			
			local smoke = self.Emitter:Add("effects/smoke_a", ppos + self:GetForward() * -dist/4)
			smoke:SetVelocity(self:GetVelocity()*-1)
			smoke:SetDieTime(math.Rand(.9,1.7))
			smoke:SetStartAlpha(math.Rand(55,155))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(14,18)*.5)
			smoke:SetEndSize(math.random(96,129)*.5)
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-2,2))
			smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
			smoke:SetColor( color, color, color )
			smoke:SetAirResistance(60)
			
			local fire = self.Emitter:Add("effects/smoke_a", ppos )
			fire:SetVelocity(self:GetForward()*-10)
			fire:SetDieTime(math.Rand(.05,.1))
			fire:SetStartAlpha(math.Rand(222,255))
			fire:SetEndAlpha(0)
			fire:SetStartSize(math.random(11,14)*.5)
			fire:SetEndSize(math.random(20,33)*.5)
			fire:SetAirResistance(150)
			fire:SetRoll(math.Rand(180,480))
			fire:SetRollDelta(math.Rand(-3,3))
			fire:SetStartLength(15)
			fire:SetColor(255,100,0)
			fire:SetEndLength(math.Rand(100, 150))

			local fire = self.Emitter:Add("effects/smoke_a", ppos )
			fire:SetVelocity(self:GetForward()*-10)
			fire:SetDieTime(math.Rand(.05,.1))
			fire:SetStartAlpha(math.Rand(222,255))
			fire:SetEndAlpha(0)
			fire:SetStartSize(math.random(11,14)*.5)
			fire:SetEndSize(math.random(20,33)*.5)
			fire:SetAirResistance(150)
			fire:SetRoll(math.Rand(180,480))
			fire:SetRollDelta(math.Rand(-3,3))
			fire:SetColor(255,110,0)

			local fire = self.Emitter:Add("effects/yellowflare", ppos )
			fire:SetVelocity(self:GetForward()*-10)
			fire:SetDieTime(math.Rand(.03,.05))
			fire:SetStartAlpha(math.Rand(222,255))
			fire:SetEndAlpha(0)
			fire:SetStartSize(math.random(77,88)*.5)
			fire:SetEndSize(math.random(99,100)*.5)
			fire:SetAirResistance(150)
			fire:SetRoll(math.Rand(180,480))
			fire:SetRollDelta(math.Rand(-3,3))
			fire:SetColor(255,120,0)

			self.cooltime = CurTime() 
			end
		
	else
		self.lifetime = RealTime() + 1
	end
	
	end
	
end
