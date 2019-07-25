// Hunter killer NPC
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
// From Jaanus
// this is completely new to me, pretty useful though :D
AccessorFunc( ENT, "m_iRRightParam", "RotorRightParam", 0, FORCE_NUMBER )
AccessorFunc( ENT, "m_iRLeftParam", "RotorLeftParam", 0, FORCE_NUMBER )
AccessorFunc( ENT, "m_iCameraYaw", "CameraYaw", 0, FORCE_NUMBER )
// End of Jaanus


ENT.HealthVal = 1200
ENT.Target = nil
ENT.MaxGDistance = 0
ENT.HitPercentPrimary = 0
ENT.HitPercentSecondary = 0
ENT.DeathTimer = 0
ENT.Destroyed = false
ENT.Burning = false
ENT.Kaboom = false
ENT.IsOverWater = false
ENT.LagCompensate = 225
ENT.Weapon = "sent_hk_gun"
ENT.MaxRockets = 0 // MaxRockets = MaxPodRockets * 2
ENT.MaxPodRockets = 2
ENT.Velocity = 888
ENT.VelocityMod = 150
ENT.VelocityMult = 18
ENT.MinVelocity = 300
ENT.MaxVelocity = 3000
ENT.RollVal = 0
ENT.RollVal2 = 0
ENT.YawVal = 0
// No touchy please.
ENT.MaxYawSpeed = 3
ENT.YawSpeed = 0
ENT.YawAcceleration = 0.0888
ENT.YawMax = 2.5
ENT.RollSpeed = 0
ENT.RollAcceleration = 0.05632
ENT.MaxRollSpeed = 19
ENT.MaxPitchSpeed = 15
ENT.PitchSpeed = 0
ENT.PitchAcceleration = 0.15123



ENT.Mod = 1

ENT.RotorWashing = false
ENT.RotorWash = nil

ENT.HoverSoundFile = "ambient/atmosphere/station_ambience_stereo_loop1.wav"
ENT.RebootingSoundFile = "hk/reboot.wav"
ENT.DeathSoundFile = "hk/Hk_Desactivate.wav"
ENT.HoverSoundPlaying = false

ENT.HitTabPrimary = {
{7500,4001,0};
{4000,3501,10};
{3500,3001,20};
{3000,2501,30};
{2500,2001,55};
{2000,1001,70};
{1000,0,100};
}
ENT.HitTabSecondary = {
{7500,4001,100};
{4000,3501,100};
{3500,3001,100};
{3000,2501,69};
{2500,2001,54};
{2000,1001,70};
{1000,0,0};
}

local CrashDebris = {
{"models/gibs/helicopter_brokenpiece_01.mdl"};
{"models/gibs/helicopter_brokenpiece_02.mdl"};
{"models/gibs/helicopter_brokenpiece_03.mdl"};
{"models/gibs/helicopter_brokenpiece_01.mdl"};
{"models/gibs/helicopter_brokenpiece_02.mdl"};
{"models/gibs/helicopter_brokenpiece_03.mdl"};
{"models/gibs/shield_scanner_gib1.mdl"};
{"models/gibs/shield_scanner_gib4.mdl"};
{"models/gibs/shield_scanner_gib5.mdl"};
{"models/gibs/shield_scanner_gib6.mdl"};
{"models/gibs/manhack_gib01.mdl"};
{"models/gibs/manhack_gib02.mdl"};
{"models/gibs/manhack_gib03.mdl"};
{"models/gibs/manhack_gib04.mdl"};
{"models/combine_apc_destroyed_gib03.mdl"};
{"models/combine_apc_destroyed_gib03.mdl"};
{"models/container_chunk02.mdl"};
{"models/container_chunk03.mdl"};
{"models/container_chunk04.mdl"};
{"models/combine_apc_destroyed_gib03.mdl"};
{"models/combine_apc_destroyed_gib03.mdl"};
{"models/container_chunk02.mdl"};
{"models/container_chunk03.mdl"};
{"models/container_chunk04.mdl"};
{"models/inaki/props_vehicles/terminator_aerialhk_cannon.mdl"};
{"models/inaki/props_vehicles/terminator_aerialhk_turret.mdl"};
{"models/inaki/props_vehicles/terminator_aerialhk_lightl.mdl"};
{"models/inaki/props_vehicles/terminator_aerialhk_turret.mdl"};
{"models/inaki/props_vehicles/terminator_aerialhk_lightl.mdl"};
}





function ENT:Precache( )
	
	util.PrecacheSound( self.HoverSoundFile )
	util.PrecacheSound( self.DeathSoundFile )
	util.PrecacheSound( self.RebootingSoundFile )
	for k,v in pairs(CrashDebris) do
	
		util.PrecacheModel(tostring(v))
	
	end
	
end

function ENT:Initialize()

	local rnd = math.random(0, 15000)
	self.Rand = (CurTime() - 1000) + rnd
    self:SetModel( "models/inaki/props_vehicles/terminator_aerialhk_nw.mdl" )		
    self:PhysicsInit( SOLID_VPHYSICS )  	
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
	self:SetHullType( HULL_LARGE )	
    self:SetHealth(self.HealthVal)	
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.HealthVal)
	
	//Timers
	self:SetVar('FireSecondary',CurTime())
	self:SetVar('FireBombs',CurTime())

	self.MaxGDistance = math.random(666,1000) // Height it can reach on spawn
	
	self:SetRotorRightParam( 0 )
	self:SetRotorLeftParam( 0 )
	self:SetCameraYaw( 0 )
	
	CanReboot = true
	
	// Turret
	if ( !self.wep1 ) then
	
		self.wep = ents.Create( self.Weapon )
		self.wep:SetPos( self:GetPos() + self:GetForward() * 101 + self:GetUp() * -102 + self:GetRight() * -23 )
		self.wep:SetAngles( self:GetAngles() )
		self.wep:Spawn()
		self.wep:SetParent( self )
		self.wep:SetOwner( self )
		self.wep.Damage = math.random(5,10)
		self.wep.Owner = self // I don't trust SetOwner()
		self.wep:SetPhysicsAttacker( self )
		self.wep:SetSolid( SOLID_NONE )
	
	end
	
	// Turret2
	if ( !self.wep2 ) then
	
		self.wep2 = ents.Create( self.Weapon )
		self.wep2:SetPos( self:GetPos() + self:GetForward() * 101 + self:GetUp() * -102 + self:GetRight() * 23 )
		self.wep2:SetAngles( self:GetAngles() )
		self.wep2:Spawn()
		self.wep2:SetParent( self )
		self.wep2:SetOwner( self )
		self.wep.Damage = math.random(5,10)
		self.wep2.Owner = self // I don't trust SetOwner()
		self.wep2:SetPhysicsAttacker( self )
		self.wep2:SetSolid( SOLID_NONE )
	
	end
	
	// Turret
	if ( !self.wep3 ) then
	
		self.wep3 = ents.Create( "sent_hk_cannon" )
		self.wep3:SetPos( self:GetPos() + self:GetForward() * -133 + self:GetUp() * -50 )
		self.wep3:SetAngles( self:GetAngles() )
		self.wep3:Spawn()
		self.wep3.Damage = math.random(20,30)
		self.wep3:SetParent( self )
		self.wep3:SetOwner( self )
		self.wep3.Owner = self // I don't trust SetOwner()
		self.wep3:SetPhysicsAttacker( self )
		self.wep3:SetSolid( SOLID_NONE )
	
	end
	

//Ligths 

	if ( !self.flashlightL ) then

		self.flashlightL = ents.Create( "sent_hk_lightl" )
		self.flashlightL:SetPos( self:GetPos() + self:GetForward() * 52.715 + self:GetUp() * -65.55 + self:GetRight() * -24.8  )
		self.flashlightL:SetAngles( self:GetAngles() )
		self.flashlightL:Spawn()
		self.flashlightL:SetParent( self )
		self.flashlightL:SetOwner( self )
		self.flashlightL.Owner = self // I don't trust SetOwner()
		self.flashlightL:SetPhysicsAttacker( self )
		self.flashlightL:SetSolid( SOLID_NONE )
	end

	if ( !self.flashlightR ) then

		self.flashlightR = ents.Create( "sent_hk_lightr" )
		self.flashlightR:SetPos( self:GetPos() + self:GetForward() * 52.715 + self:GetUp() * -65.55 + self:GetRight() * 24.8  )
		self.flashlightR:SetAngles( self:GetAngles() )
		self.flashlightR:Spawn()
		self.flashlightR:SetParent( self )
		self.flashlightR:SetOwner( self )
		self.flashlightR.Owner = self // I don't trust SetOwner()
		self.flashlightR:SetPhysicsAttacker( self )
		self.flashlightR:SetSolid( SOLID_NONE )
	end
		
	// Reference waypoint
	// Reference waypoint
	self.CycleTarget = ents.Create("sent_neurotarget")
	self.CycleTarget.Owner = self
	self.CycleTarget:SetPos(self:GetPos()+Vector(1024,1024,1024))
	self.CycleTarget:Activate()
	self.CycleTarget:Spawn()
	self.PhysObj = self.Entity:GetPhysicsObject() 

	if ( self.PhysObj:IsValid() ) then 		
	
		self.PhysObj:Wake()  
		self.PhysObj:EnableGravity(false) 
		self.HoverSound = CreateSound( self, self.HoverSoundFile )
	
	end 
	
end


local function death(ent)
	if ( ent == nil ) then
		return 
	end
	
	local explo = EffectData()
	if IsValid(explo) then
		explo:SetOrigin(ent:GetPos())
		util.Effect("Explosion", explo)
	end
end

function ENT:OnTakeDamage(dmginfo)

if (self.Destroyed == true) then	
		return 
	end
		   
   self.PhysObj = self.Entity:GetPhysicsObject()  
	
	self.Entity:TakePhysicsDamage(dmginfo)
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
		
	if ( self.HealthVal < 200 && self.Burning == false ) then
		
		self.Burning = true
		
	    local wFire1 = ents.Create("env_Fire_trail")
		wFire1:SetPos(self.PhysObj:GetPos()+self.Entity:GetRight()*135+self:GetForward()*-24)
		wFire1:SetParent(self.Entity)
		wFire1:Spawn()
		
		local wFire2 = ents.Create("env_Fire_trail")
		wFire2:SetPos(self.PhysObj:GetPos()+self.Entity:GetRight()*-135+self:GetForward()*-24)
		wFire2:SetParent(self.Entity)
		wFire2:Spawn()
		
	end
	
	if ( self.HealthVal < 5 ) then
	
		self.Destroyed = true
		
		self.Entity:Ignite( 60, 100 )
		
		for i = 1, 10 do
		
			local vx = i / 2
			
			timer.Simple( vx, function() death( self.Entity ) end )
		
		end
	
	end	
	
if ( self.Target == self.CycleTarget ) then
	
		self.Target = dmginfo:GetInflictor()
	end
end	
  
	
function ENT:RebootSystem()

if ( self.HealthVal < 350 and CanReboot and self.PhysObj:IsValid() ) then
	
	self.Destroyed = true
	Rebooting = true
	CanReboot = false
    self.HoverSound:Stop()
	self.PhysObj:EnableGravity(true) 
    self:SetBodygroup( 0, 1 );	
	self.Target:EmitSound( self.DeathSoundFile, 200, 150 ) 
	timer.Simple(15,Reactivate,self)


local effect = EffectData()
 effect:SetOrigin( self:GetPos() + self.Entity:GetRight()* 50 + self:GetForward()* -24 )
 effect:SetNormal( self:GetPos() )
 effect:SetMagnitude( 5 )
 effect:SetScale( 2 )
 effect:SetRadius(8.1 )
		
util.Effect( "sparks", effect, true, true )
end
end


function ENT:UpdateAnimation()
	
	local rotor_right = self:GetPoseParameter( "rotor_right" )
	local rotor_left = self:GetPoseParameter( "rotor_left" )
	local camera = self:GetPoseParameter( "camera" )
	local target_right = self:GetRotorRightParam() or 0
	local target_left = self:GetRotorLeftParam() or 0
	local target_camera = self:GetCameraYaw() or 0
	
	self:SetPoseParameter( "rotor_right", rotor_right + (target_right-rotor_right) * 0.1 )
	self:SetPoseParameter( "rotor_left", rotor_left + (target_left-rotor_left) * 0.1 )
	self:SetPoseParameter( "camera", camera + (target_camera-camera) * 0.1 )
	
end

// Is this being called on SNPCs?
function ENT:PhysicsCollide( data, physobj )
	
	local velocity = self:GetVelocity()
	local speed = velocity:Length()
	
	if ( speed < 150 ) then
		
		return
		
	end
	
	if ( !data.HitEntity || data.HitEntity == NULL || self:WaterLevel() > 0 ) then

		return

	end
	
	local tr = util.TraceLine({start=data.HitPos+data.HitNormal,endpos=data.HitPos-data.HitNormal,filter=self.Entity})

	if ( data.HitEntity == GetWorldEntity() || data.HitEntity:GetSolid( ) != SOLID_NONE ) then
		
		if(	tr.MatType	==	MAT_METAL		||
			tr.MatType	==	MAT_VENT		||
			tr.MatType	==	MAT_GRATE		||
			tr.MatType	==	MAT_TILE		||
			tr.MatType	==	MAT_GLASS		||
			tr.MatType	==	MAT_CONCRETE	) then
		
		local effectdata = EffectData()
 			effectdata:SetOrigin( data.HitPos )
 			effectdata:SetNormal( data.HitNormal )
 			effectdata:SetMagnitude( 1 )
 			effectdata:SetScale( 0.1 )
 			effectdata:SetRadius( speed * 0.01 )
		
		util.Effect( "sparks", effectdata, true, true )
		
		end
		
	end

end

function ENT:IsOverWater()

	local trace,tr = {},{}
	trace.start = self:GetPos()
	trace.endpos = trace.start + self:GetUp() * -4048
	trace.mask = MASK_SOLID
	trace.filter = { self, self.wep, self.wep2, self.wep3, self.flashlightl, self.flashlightr }
	tr = util.TraceEntity( trace, self )
	
	if ( tr.Hit && tr.MatType == 78 ) then // Hit water
	
		return true
		
	end
	
	return false
	
end


function ENT:CalculateHitchance(ent)
	
if ( self.Target:IsVehicle() && self.Target:GetPos().z < self:GetPos().z )  then
		
		self:AttackEnemySpecial(3)
		
		return 
		
	end
	
	local dist = ( Vector( self.PhysObj:GetPos().x, self.PhysObj:GetPos().y, 0 ) - Vector( ent:GetPos().x, ent:GetPos().y, 0 ) ):Length() //Ignore Z
	
	for k,v in ipairs(self.HitTabPrimary) do
	
		if ( v[1] > dist && v[2] < dist ) then
		
			self.HitPercentPrimary = v[3]
			
		end
		
	end
	
	for _,p in ipairs(self.HitTabSecondary) do
	
		if ( p[1] > dist && p[2] < dist ) then
		
			self.HitPercentSecondary = p[3]
			
		end
		
	end
	
	if self.HitPercentPrimary > self.HitPercentSecondary then
	
		self:AttackEnemySpecial(1)
		
	else
	
		self:AttackEnemySpecial(2)
		
	end
	
end

function ENT:AttackEnemySpecial( FireMode )

	if ( FireMode == 1 ) then	
	
		self.wep.BurstSize = math.random( 4, 6 )
		
		self.wep.Target = self.Target
	
		self.wep.ShouldAttack = true
	
		self.wep2.BurstSize = math.random( 4, 6 )
		
		self.wep2.Target = self.Target
	
		self.wep2.ShouldAttack = true

	elseif ( FireMode == 2 ) then
	
		self.wep.ShouldAttack = true
	
		self.wep2.ShouldAttack = true
	
		local TSR = self:GetVar('FireSecondary',0)
	
		if ( TSR + 25 ) > CurTime() then
			
			return
			
		end
		
		self:SetVar('FirePrimary',CurTime())
		
		/*if ( self:GetPos():Distance( self.Target:GetPos() ) < 1500 ) then
			
			self:LaunchGrenade() // We're equipped for everything.
			
			return
			
		end*/
	
elseif (FireMode == 3 ) then
	
		self.wep.ShouldAttack = false
		
		self.wep2.ShouldAttack = false
		
		 self.wep3.Target = self.Target

		self.wep3.ShouldAttack = true
	
		local TSR = self:GetVar('FireSecondary',0)
	
		if ( TSR + 15 ) > CurTime() then
			
			return
			
		end
		
		self:SetVar('FireSecondary',CurTime())
	
	     end
	 end

function ENT:PhysicsSimulate( pobj, delta)

	pobj:Wake()
	
	local CSC = {}
	CSC.secondstoarrive	= 0.1
	CSC.pos					= self.PhysObj:GetPos() + self.Entity:GetForward() * self.LagCompensate + 100
	CSC.angle				= (self.PhysObj:GetPos() - self.Target:GetPos()):Angle()
	CSC.maxangular			= 50000
	CSC.maxangulardamp		= 9000
	CSC.maxspeed			= 1000000
	CSC.maxspeeddamp		= 1000
	CSC.dampfactor			= 0.5
	CSC.teleportdistance	= 6000
	CSC.deltatime			= delta
	pobj:ComputeShadowControl(pr)
	
end


function ENT:IncreaseVelocity()

	if ( self.Velocity > self.MaxVelocity ) then
	
		self.Velocity = self.MaxVelocity
		
	end
	
	self.Velocity = self.Velocity + self.VelocityMod
	
	self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * ( self.Velocity * self.VelocityMult ) * self.Mod )	
	
end

function ENT:DecreaseVelocity()

	if(self.Velocity < self.MinVelocity) then

		self.Velocity = self.MinVelocity
	
	end
	
	self.Velocity = self.Velocity - self.VelocityMod
	
	self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * ( self.Velocity * self.VelocityMult ) * self.Mod )	
	
end
			

function ENT:Think()

self:ScanForEnemiesSpecial()

	if ( self.Destroyed == true ) then 
		
		local effectdata = EffectData()
		effectdata:SetOrigin( self.PhysObj:GetPos() + self.Entity:GetRight() * math.random(-62,62) + self.Entity:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		
		self.DeathTimer = self.DeathTimer + 1
		
		if ( self.YawSpeed == 0 ) then
		
			self.YawSpeed = math.max( self.MaxYawSpeed, self.YawSpeed + self.YawAcceleration )
			
		else
		
			self.YawSpeed = math.max( self.MaxYawSpeed, self.YawSpeed * 1.025 )
			
		end
		
		local prevel = self.PhysObj:GetVelocity()
		self.mAng2 = Angle( 0, self:GetPhysicsObject():GetAngles().y, 0 )
		self.PhysObj:SetAngles( self.mAng2 + Angle( math.sin( CurTime() ) * 7, self.YawSpeed, 0 ) ) 
		self.PhysObj:SetVelocity(prevel)
		self.PhysObj:ApplyForceCenter(self.Entity:GetUp()*4800)
		self.PhysObj:ApplyForceCenter(self.Entity:GetRight()*5000)
		self.PhysObj:ApplyForceCenter(self.Entity:GetForward()*-15000)
		
		if self.DeathTimer > 105 then
		
			self:DeathFXSpecial()
	
		end
		
		return 
		
	end
	
	self:NextThink(CurTime())
		
	// ty jaanus <3
	
	if ( !self.HoverSoundPlaying ) then
		
		self.HoverSound:SetSoundLevel( 95 )
		self.HoverSound:Play()
		self.HoverSound:ChangeVolume( 0.32,0.001 )
		self.HoverSoundPlaying = true
		
	end
	
	self:UpdateAnimation()
	
	// End of ty jaanus <3
	
	local pitch = math.Clamp( math.floor( ( self.PhysObj:GetVelocity():Length() / 100 + 70 ) ) + math.sin( CurTime() ) * 8, 0, 250 )
	self.HoverSound:ChangePitch( pitch,0.01 )
	
	local rotor_right = 0
	local rotor_left = 0
	
	self.LagCompensate = math.floor( self:GetPhysicsObject():GetVelocity():Length() / 2 + 100 )
	self.mVel = self.PhysObj:GetVelocity()
	self.gVec = ( ( self.Target:GetPos() + Vector( 0, 0, 80 ) ) - self.PhysObj:GetPos() )
	self.gNormal = self.gVec:GetNormalized()
	self.gAng = ( self.Target:GetPos() - (self.PhysObj:GetPos() + Vector( 0, 0, 80) ) ):Angle()
	self.tarDist = self.PhysObj:GetPos():Distance( self.Target:GetPos() )
	self.mAng = Angle( 0, self:GetPhysicsObject():GetAngles().y, 0 )
	self.mYaw = self.Entity:VecAngD(self.gAng.y,self.mAng.y)
	self.HeightDifference = (Vector(0,0,self.Target:GetPos().z) - Vector(0,0,self.PhysObj:GetPos().z )):Length()
	
	if ( self.HeightDifference < self.MaxGDistance ) then
	
		self.PhysObj:ApplyForceCenter(self.Entity:GetUp()*2400)
	
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST --
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	// momentum simulation
	
	self.mAng2 = Angle( 0, self:GetPhysicsObject():GetAngles().y, 0 )
	
	if ( self.mYaw > self.YawMax ) then

		rotor_right = ( rotor_right - 180 ) * 0.5
			
		rotor_left = ( rotor_left + 180 ) * 0.5
		
		self.YawSpeed = math.min( self.YawSpeed + self.YawAcceleration, self.MaxYawSpeed )
		
		self.RollSpeed = math.min( self.RollSpeed + self.RollAcceleration, self.MaxRollSpeed )
		
	elseif ( self.mYaw < -self.YawMax ) then
		
		rotor_right = ( rotor_right + 180 ) * 0.5
				
		rotor_left = ( rotor_left - 180 ) * 0.5
	
		self.YawSpeed = math.max( self.YawSpeed - self.YawAcceleration, -self.MaxYawSpeed )
		
		self.RollSpeed = math.max( self.RollSpeed - self.RollAcceleration, -self.MaxRollSpeed )
		
	elseif ( self.mYaw > -self.YawMax && self.mYaw < self.YawMax ) then // Infront
	
		self.YawSpeed = self.YawSpeed / 2.5 //-- Compensate for too high momentum when infront.
		
		self.RollSpeed =  self.RollSpeed / 1.25
		
	end
	
	// Pitching
	
	if ( self.mYaw > -65 && self.mYaw < 65 ) then //-- front cone - pitch down nose, "preparing" for rocket rain.
	
		self.PitchSpeed = math.min( self.PitchSpeed + self.PitchAcceleration, self.MaxPitchSpeed )
		
	else
	
		self.PitchSpeed = math.max( self.PitchSpeed - self.PitchAcceleration, -1 * ( self.MaxPitchSpeed - 4 ) )
		
	end
	
	local maxdist = 1600
	
	if ( self.tarDist > maxdist ) then
	
		self.PitchSpeed = self.PitchSpeed / 1.2 // straighten out a tad when we're travelign forward
		
		self.Mod = 1
		
	elseif ( self.tarDist < maxdist && self.Target:GetVelocity():Length() == 0 ) then
	
		if ( self.Velocity >= self.MaxVelocity - 400 ) then
		
			self.Velocity = self.Velocity / 1.55
			
		end

		self.PitchSpeed = math.max( self.PitchSpeed - ( self.PitchAcceleration * 2 ), -1 * ( self.MaxPitchSpeed - 4 )  )//-- up with the nose if we're hovering
		
		self.Mod = -1 //-- Move backwards if we're too close to a stationary target, giving a hovering effect.
		
	end

	//print("Yaw: "..self.mYaw.." YawSpeed: "..self.YawSpeed.." PitchSpeed: "..self.PitchSpeed.." TDistance: "..self:GetPos():Distance(self.Target:GetPos()))
	
	self.PhysObj:SetAngles( self.mAng2 + Angle( self.PitchSpeed, self.YawSpeed, ( math.sin( CurTime() ) * 8.5 ) * 1.025 ) )
	
	self.PhysObj:SetVelocity(self.mVel)
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST --
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	if self.tarDist > 2000 then
	
		self:IncreaseVelocity()
		
		self.PhysObj:ApplyForceCenter(  self.gNormal * ( 4500 + ( self:GetVelocity():Length() * 10 ) ) )

	else

		self:DecreaseVelocity()
		
		self.PhysObj:ApplyForceCenter(  self.gNormal * ( 4000 + ( self:GetVelocity():Length() * 10 ) ) )
		
	end
	
	if( self.PhysObj:GetVelocity():Length() > 100 ) then
	
		if( self.Mod == 1 ) then
		
			rotor_right = ( rotor_right - 180 ) * 0.5
			
			rotor_left = ( rotor_left - 180 ) * 0.5
			
		else
		
			rotor_right = ( rotor_right + 180 ) * 0.5
			
			rotor_left = ( rotor_left + 180 ) * 0.5
			
		end
		
	else
		
		self:SetRotorRightParam( math.sin(CurTime()*2 + 3.14159)*5+3 )
		self:SetRotorLeftParam( math.sin(CurTime()*2)*5+3 )
		
		/*
		rotor_right = math.sin( CurTime() * 2 + math.pi ) * 20 + 3
		
		rotor_left = math.sin( CurTime() * 2 ) * 20 + 3
		*/
	end
	
	self:SetCameraYaw(  math.sin(CurTime()) * 38 ) // No I'm not obsessed with sine waves.
	
	self:SetRotorRightParam( math.Clamp( rotor_right, -90, 90 ) )
	
	self:SetRotorLeftParam( math.Clamp( rotor_left, -90, 90 ) )
	
	
	local p = self:GetPos()
	local f = self:GetForward()
	local u = self:GetUp()
	local r = self:GetRight()
	
	local tpos = {
				 { start = p, endpos = p + u * -self.MaxGDistance };
				 { start = p, endpos = p + f * ( 500 + ( self:GetVelocity():Length() * 2 ) ) };
				 { start = p, endpos = p + f * -600 };
				 { start = p, endpos = p + r * -600 };
				 { start = p, endpos = p + r * 600 };
				 }
	
	local tr = {}
    local _Filter = { self, self.wep, self.wep2, self.wep3, self.flashlightl, self.flashlightr }
	local i = 0
	
	for k,v in pairs( tpos ) do
	
		i = i + 1
		v.filter = _Filter
		v.mask = {MASK_SOLID , MASK_WATER }
		tr[i] = util.TraceEntity( v, self )
		
	end
	
	// Cheap Collision Detection & Hackfix to avoid crashing into stuff.
	if ( tr[1].Hit ) then
	
		if ( self:GetPos():Distance(tr[1].HitPos) < ( self.MaxGDistance * 0.8 ) && self:GetPhysicsObject():GetVelocity():Length() > 90 ) then
		
			self:GetPhysicsObject():SetVelocity( self:GetPhysicsObject():GetVelocity() / 1.15 )
			
			self:GetPhysicsObject():ApplyForceCenter( self:GetUp() * 5000 )
	
		end
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetUp() * ( 14000 - ( tr[1].Fraction * 14000 + ( self:GetVelocity():Length() * 4 ) ) ) )
		
	end
	
	if ( tr[2].Hit ) then //tr2
	
		self.YawAcceleration = 0.325
		
		self:GetPhysicsObject():SetVelocity( self:GetPhysicsObject():GetVelocity() / 1.25 )
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetUp() * 8000 )
		
		rotor_right = ( rotor_right + 180 ) * 0.5
			
		rotor_left = ( rotor_left + 180 ) * 0.5
		
	else
	
		self.yawAcceleration = 0.0678
	
	end
	
	if ( tr[3].Hit && !tr[2].Hit ) then
	
		self:IncreaseVelocity()
		
	end
	
	if ( tr[4].Hit && !tr[5].Hit ) then
	
		if ( self:GetVelocity():Length() > 85 ) then
		
			self:SetVelocity( self:GetVelocity() / 1.1 )
			
		end
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetRight() * 9000 )
	
	elseif ( tr[5].Hit && !tr[4].Hit ) then
	
		if ( self:GetVelocity():Length() > 85 ) then
		
			self:SetVelocity( self:GetVelocity() / 1.1 )
			
		end	
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetRight() * -9000 )
	
	elseif ( tr[4].Hit && tr[5].Hit ) then
	
		self:SetVelocity( self:GetVelocity() / 1.1 )
	
	end
	
	if ( self.Entity:GetForward():Dot( ( self.Target:GetPos() - self.PhysObj:GetPos() ):GetNormalized() ) >= 0.85 ) then
	
		if ( self.Target == self.CycleTarget ) then 
			
			return
	
		end
		
		if ( self:CheckLOS( self.Target ) ) then
			
			return

		end
		
		self:CalculateHitchance( self.Target )
		
	    end
	end

function ENT:DeathFXSpecial()

	local explo = EffectData()
	explo:SetOrigin(self.PhysObj:GetPos())
	util.Effect("Explosion", explo)

	for k, v in pairs( CrashDebris ) do
	
		local cdeb = ents.Create( "prop_physics" )
		cdeb:SetModel( tostring( v[1] ) )
		cdeb:SetPos( self.PhysObj:GetPos() + Vector( math.random( -64, 64 ), math.random( -64, 64 ), math.random( 128, 256 ) ) )
		cdeb:SetSolid( 6 )
		cdeb:Spawn()
		cdeb:Fire( "ignite", "", 1 )
		cdeb:Fire( "kill", "", 15 )
		local f1 = EffectData()
		f1:SetOrigin( cdeb:GetPos() )
		f1:SetStart( cdeb:GetPos() )
		util.Effect( "immolate", f1 )
		
	end
	
	implode( self:GetPos(), 1024, 512, -600000000 )
	
	for i = 1, 10 do
	
		local fx=EffectData()
		fx:SetOrigin( self.PhysObj:GetPos() + Vector( math.random( -256, 256 ), math.random( -256, 256 ), math.random( -256, 256 ) ) )
		fx:SetScale( 20 * i )
		util.Effect( "Firecloud", fx )
	
	end
	
	self.Entity:EmitSound( "ambient/explosions/explode_"..math.random( 1, 4 )..".wav", 200, 100 )
	util.BlastDamage( self.Entity, self.Entity,self.PhysObj:GetPos(), 1628, 100 )
	
	self.Entity:Remove()

end

function Reactivate(self) //Don't touch this!!!
self.PhysObj = self.Entity:GetPhysicsObject()  	
self:EmitSound( self.RebootingSoundFile, 511, math.random( 95, 115 ) )
Rebooting = false
self.Destroyed = false
self.Kaboom = true
self.HoverSoundPlaying = false
self.Entity:SetHealth(480)
CanReboot = false // to be sure
self.PhysObj:EnableGravity(false)
self:SetBodygroup( 0, 0 );

end

function ENT:ScanForEnemiesSpecial()

	local dist = dist or 25600
	local tempd = tempd or 0
	local t = t or self.CycleTarget

	for k,v in pairs( ents.FindInSphere( self:GetPos(), 25600 ) ) do

		if ( v != self && v:GetClass() != self:GetClass() && v:GetClass() != "npc_missile_homer" ) then
		
			if ( v:IsPlayer() || v:IsNPC() || ( v:IsVehicle() && v:GetVelocity():Length() > 1 ) || string.find( v:GetClass(), "npc_" ) )  then
			
				if( v.Destroyed ) then 
				
					return 
				
				end
				
				tempd = self:GetPos():Distance( v:GetPos() )
				
				if ( tempd < dist ) then
					
					dist = tempd
					t = v
					
				end
				
				self.Target = t
				
			end
			
		end
		
		if ( !IsValid( self.Target ) ) then //better safe than sorry
		
			self.Target = self.CycleTarget
			
		end
		
	end
	
end

function ENT:OnRemove()

	self.HoverSound:Stop()
	
end
			//
			// This is stuff u may want to get to work so it looks even better...
			//
		//	local Movesideway = self:GetVelocity()
		//	self:SetPoseParameter( "move_yaw", Movesideway.x * 90 ) //from -90 to 90

 		//	local rotateturretsbase = self.wep:GetAngles()
		//	self:SetPoseParameter( "turrets_yaw", rotateturretsbase.z * 180 ) // -180 to 180

  		//	local rotatecannonbase = self.wep3:GetAngles()
		//	self:SetPoseParameter( "cannon_yaw", rotatecannonbase.z * 180 ) // -180 to 180 

		//	self:SetPoseParameter( "lights_pitch", rotatecannonbase.y * 45 ) // -45 to 45
 

