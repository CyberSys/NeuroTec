AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.HealthVal = 2000
ENT.Target = NULL
ENT.MaxGDistance = 0
ENT.HitPercentPrimary = 0
ENT.HitPercentSecondary = 0
ENT.DeathTimer = 0
ENT.Destroyed = false
ENT.Burning = false

ENT.LagCompensate = 450
ENT.Weapon = "sent_chopper_gun"
ENT.Velocity = 700
ENT.VelocityMod = 25
ENT.VelocityMult = 150
ENT.MinVelocity = 420
ENT.MaxVelocity = 1400

// No touchy please.
ENT.MaxYawSpeed = 3
ENT.YawSpeed = 0
ENT.YawAcceleration = 0.0578
ENT.YawMax = 1.5
ENT.RollSpeed = 0
ENT.RollAcceleration = 0.04532
ENT.MaxRollSpeed = 19
ENT.MaxPitchSpeed = 5.5
ENT.PitchSpeed = 0
ENT.PitchAcceleration = 0.25123

ENT.Mod = 1

ENT.RotorWashing = false
ENT.RotorWash = nil

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
					{"models/apgb/helicopter_brokenpiece_01.mdl"};
					{"models/apgb/helicopter_brokenpiece_02.mdl"};
					{"models/apgb/helicopter_brokenpiece_03.mdl"};
					{"models/apgb/helicopter_brokenpiece_04_cockpit.mdl"};
					{"models/apgb/helicopter_brokenpiece_05_tailfan.mdl"};
					{"models/apgb/helicopter_brokenpiece_06_body.mdl"};
					}



function ENT:Precache()

	for k,v in pairs(CrashDebris) do

		util.PrecacheModel(tostring(v))
		
	end

end

function ENT:IsOverWater()

	local trace,tr = {},{}
	trace.start = self:GetPos()
	trace.endpos = trace.start + self:GetUp() * -10000
	trace.mask = MASK_SOLID
	trace.filter = { self, self.wep  }
	tr = util.TraceEntity( trace, self )

	return ( tr.Hit && tr.MatType == 78 )
	
end

function ENT:Initialize()
	
    self:SetModel( "models/usmcapachelicopter.mdl" )		
    self:PhysicsInit( SOLID_VPHYSICS )  	
    self:SetMoveType( MOVETYPE_VPHYSICS )
    self:SetSolid( SOLID_VPHYSICS )
	self:SetHullType( HULL_LARGE )	
    self:SetHealth(self.HealthVal)	
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.HealthVal)
	
	//Timers
	self:SetVar('FireSecondary',CurTime())
	self:SetVar('FireFlares',CurTime())
	self:SetVar('FireBombs',CurTime())
	
	self.randseed = math.random( 10, 80 )
	
	self.RollValue = 0
	
	self.MaxGDistance = math.random( 800, 2048 )
	self.wep = ents.Create( self.Weapon )
	self.wep:SetPos( self:GetPos() + self:GetForward() * 132 + self:GetUp() * -100 )
	self.wep:SetAngles( self:GetAngles() )
	self.wep:Spawn()
	self.wep:SetParent( self )
	self.wep:SetOwner( self )
	self.wep.Owner = self // I don't trust SetOwner()
	self.wep:SetPhysicsAttacker( self )
	self.wep:SetSolid( SOLID_NONE )
	
	self.LoopSound = CreateSound(self,Sound("npc/attack_helicopter/aheli_rotor_loop1.wav"))
	self.LoopSound:PlayEx(511,110)
	self.LoopSound:SetSoundLevel(511)
	self.CycleTarget = ents.Create("sent_neurotarget")
	self.CycleTarget.Owner = self
	self.CycleTarget:SetPos(self:GetPos()+Vector(1024,1024,1024))
	self.CycleTarget:Activate()
	self.CycleTarget:Spawn()
	self.PhysObj = self:GetPhysicsObject()  	
	
	if ( self.PhysObj:IsValid() ) then 		
	
		self.PhysObj:Wake()  
		self.PhysObj:EnableGravity( false ) 
		
	end 
	
end

local function death(ent)

	if ( !IsValid( ent ) ) then
	
		return
	
	end
	
	local explo = EffectData()
	explo:SetOrigin( ent:GetPos() )
	util.Effect( "Explosion", explo )
	
end

function ENT:OnTakeDamage(dmginfo)

	if ( self.Destroyed == true ) then
			
		return
	
	end
	
	self:TakePhysicsDamage(dmginfo)
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	
	if ( self.HealthVal < 200 && self.Burning == false ) then
		
		self.Burning = true
		
		local wFire1 = ents.Create("env_Fire_trail")
		wFire1:SetPos(self.PhysObj:GetPos()+self:GetRight()*60)
		wFire1:SetParent(self)
		wFire1:Spawn()
		
		local wFire2 = ents.Create("env_Fire_trail")
		wFire2:SetPos(self.PhysObj:GetPos()+self:GetRight()*-60)
		wFire2:SetParent(self)
		wFire2:Spawn()
		
	end
	
	if ( self.HealthVal < 0 ) then
	
		self.LoopSound:Stop()
		self:DeathFX()
		
		return
		
	end
	
	if ( self.Target == self.CycleTarget ) then
	
		self.Target = dmginfo:GetInflictor()
		
	end
	
end

function ENT:PhysicsCollide( data, physobj )
	
	if ( self.Destroyed ) then
		

		return
		
	end
	
	if ( data.HitEntity:GetClass() == "prop_combine_ball" ) then
	
		local fx =EffectData()
		fx:SetOrigin( data.HitPos )
		fx:SetEntity( data.HitEntity )
		fx:SetStart( data.HitPos )
		fx:SetScale( 4 )
		util.Effect( "CballExplode", fx )
		data.HitEntity:Remove()
	
	end
	
end

function ENT:Bomb(pos)

	if( !IsValid(self) ) then
		
		return 
		
	end
	
	local r = ents.Create( "sent_b52bomb" )
	r:SetPos( pos + Vector( math.random( -128, 128 ), math.random( -128, 128 ), 0 ) )
	r:SetAngles( self:GetAngles() + Angle( 0, 90, 0 ) )
	r:Spawn()
	r:SetOwner( self )
	r:SetPhysicsAttacker( self )
	
end

function ENT:CalculateHitchance(ent)
	
	if ( self.Target:WaterLevel() > 0 && self:IsOverWater() ) then
		
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

function ENT:DumbfireRain(pos)
	
	if(!self) then 
		
		return

	end
	
	if(self.Target == NULL) then
		
		return

	end
	
	local amt = amt or 0
	local dist = ( Vector( self.PhysObj:GetPos().x, self.PhysObj:GetPos().y, 0 ) - Vector( self.Target:GetPos().x, self.Target:GetPos().y, 0 ) ):Length()
	
	if( dist < 1200 ) then
		
		return
		
	end
	
	if(amt >= 16) then
	
		amt = 0
	
	end
	
	if(self.YawSpeed > 1.5 || self.YawSpeed < -1.5) then // too high momentum, missiles won't hit.
	
		if(amt > 0 && amt < 16) then
		
			self:SetVar('FireSecondary',CurTime()+amt) //lower the CD when we failed to launch all rockets.
		
		end
		
		return 
	
	end 
	
	amt = amt + 1
	local _p,p
	
	//cheating so we are guaranteed to hit within the vicinity of our target :P
	if(pos == 1) then
	
		_p = self:GetPos() + self:GetRight()*math.random(-60,-50) + self:GetUp()*-30 + self:GetForward()*-25 //left pod
		p = self.Target:GetPos() + self.Target:GetUp()* math.random(72,110) + self:GetRight() * math.random(-150,-20)
	
	else
	
		_p = self:GetPos() + self:GetRight()*math.random(50,60) + self:GetUp()*-30 + self:GetForward()*-25 //right pod
		p = self.Target:GetPos() + self.Target:GetUp()* math.random(72,110) + self:GetRight() * math.random(20,150)
	
	end
	
	if ( DEBUG ) then
	
		print( "AH-64 Launching Hellfire Rockets" )
		
	end
	
	local r = ents.Create("sent_javeline_rocket_drunk")
		r:SetPos( _p )
		r:SetAngles( self:GetAngles() )
		r:Spawn()
		r:SetOwner( self )
		r:SCUDAim( p )
		r.Owner = self
		r:SetPhysicsAttacker( self )

	local fx = EffectData()
	fx:SetOrigin(_p)
	fx:SetScale(0.5)
	util.Effect("Launch2",fx)
	
	self.PhysObj:ApplyForceCenter( self:GetForward() * -9850 )
	self.PhysObj:ApplyForceCenter( self:GetUp() * -5850 )
	
end

function ENT:HellfireRain( pos )

	if ( !IsValid( self ) ) then
			
		return 
	
	end
	
	if ( self.Target == NULL ) then 
			
		return 
		
	end // argh timer errors.
	
	if( self.Target:WaterLevel() > 1 ) then
		
		return
	
	end // just no
	
	if( self.Target == self.CycleTarget ) then

		return 
	
	end //pointless.
	
	local HellfirePos = {}
	local p = self:GetPos()
	local r = self:GetRight()
	local u = self:GetUp()
	
	// Hellfire positions.
	HellfirePos[1] = p + r * 72 + u * -62
	HellfirePos[2] = p + r * 72 + u * -92
	HellfirePos[3] = p + r * 90 + u * -62
	HellfirePos[4] = p + r * 90 + u * -92
	HellfirePos[5] = p + r * -72 + u * -62
	HellfirePos[6] = p + r * -72 + u * -92
	HellfirePos[7] = p + r * -90 + u * -62
	HellfirePos[8] = p + r * -90 + u * -92
	
	if ( DEBUG ) then
	
		print( "AH-64 Launching Dumbfire Rockets" )
		
	end
	
	local r = ents.Create("sent_guided_missile")
	r:SetPos(HellfirePos[pos])
	r:SetAngles(self:GetAngles())
	r:Spawn()
	r:SetOwner(self)
	r.Target = self.Target
	r.Owner = self
	r:SetPhysicsAttacker(self)
	r:SetVelocity(self:GetPhysicsObject():GetVelocity())
	
	
end

function ENT:AttackEnemySpecial( Mode )

	if ( Mode == 1 ) then
	
		self.wep.ShouldAttack = true
		
	elseif ( Mode == 2 ) then
		
		self.wep.ShouldAttack = false
		
		local TSR = self:GetVar('FireSecondary',0)
		
		if ( TSR + 20 ) > CurTime() then
			
			return 
			
		end
		

		// Missiles
		
		if( self.Target:OnGround() || self.Target:IsVehicle() && self.Target:GetPos().z < self:GetPos().z ) then // Dumbfire rain
			
			for i = 1, 8 do
			
				local vx = i / 5
				timer.Simple(vx,function() self:DumbfireRain( 1 ) end)
			
			end
			
			for j = 1, 8 do
			
				local vx = j / 4.3
				timer.Simple(vx,function() self:DumbfireRain( 2 ) end)
		
			end
		
		self:SetVar('FireSecondary',CurTime())
			
		elseif ( !self.Target:OnGround() ) then // Hellfire, homing
			
			local a = math.random(1,4)
			local b = math.random(5,8)
			
			for i = a, b do 
			
				local v = i/2
				timer.Simple( v, function() self:HellfireRain( i ) end )
				
			end
			
			self:SetVar('FireSecondary',CurTime())
			
		end
		
	end
	
end

function ENT:IncreaseVelocity()

	if(self.Velocity > self.MaxVelocity) then
	
		self.Velocity = self.MaxVelocity
	
	end
	
	self.Velocity = self.Velocity + self.VelocityMod
	self:GetPhysicsObject():ApplyForceCenter(self:GetForward() * (self.Velocity * self.VelocityMult) * self.Mod)
	
end

function ENT:DecreaseVelocity()
	
	if(self.Velocity < self.MinVelocity) then
	
		self.Velocity = self.MinVelocity
		
	end
	
	self.Velocity = self.Velocity - self.VelocityMod
	self:GetPhysicsObject():ApplyForceCenter(self:GetForward() * (self.Velocity * self.VelocityMult) * self.Mod)
	self:GetPhysicsObject():ApplyForceCenter(self:GetUp() * 5500)
	
end

function ENT:Think()
	
	self:NextThink( CurTime() )
	
	if ( self.Destroyed	) then 
	
		local effectdata = EffectData()
		effectdata:SetOrigin( self.PhysObj:GetPos() + self:GetRight() * math.random(-62,62) + self:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		
		self.DeathTimer = self.DeathTimer + 1
	
		
		if ( self.DeathTimer > 5 ) then
			
			self:DeathFX()
			
		end
		
		return 
		
	end
	
	self:ScanForEnemies()
	
	local types = { "Entity", "Player", "Vehicle", "CSENT_vehicle" };
	
	if( !table.HasValue( types, type( self.Target ) ) ) then
		
		self.Target = self.CycleTarget
		
	end
	
	self.LoopSound:ChangePitch( math.random( 99, 100 ),0.01 ) //is this a good idea?
	
	self.LagCompensate = math.floor(self:GetPhysicsObject():GetVelocity():Length()/2 +100)
	self.mVel = self.PhysObj:GetVelocity()
	self.gVec = (self.Target:GetPos() - self.PhysObj:GetPos() + Vector(0,0,80))
	-- self.gNormal = self.gVec:Normalize()
	self.gNormal = self.gVec:GetNormalized()
	self.gAng = (self.Target:GetPos() - self.PhysObj:GetPos() + Vector(0,0,80)):Angle()
	self.tarDist = self.PhysObj:GetPos():Distance(self.Target:GetPos())
	self.mAng = Angle(0,self:GetPhysicsObject():GetAngles().y,0)
	self.mYaw = self:VecAngD(self.gAng.y,self.mAng.y)
	self.mPitch = self:VecAngD(self.gAng.p,self.mAng.y)
	self.HeightDifference = (Vector(0,0,self.Target:GetPos().z) - Vector(0,0,self.PhysObj:GetPos().z )):Length()
	
	if (self.HeightDifference < self.MaxGDistance) then
	
		self.PhysObj:ApplyForceCenter(self:GetUp() * 28400 )
		
	elseif (self.HeightDifference > self.MaxGDistance) then
	
		self.PhysObj:ApplyForceCenter(self:GetUp() * -28400 )
		
	end
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST --
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	// momentum simulation
	self.mAng2 = Angle( 0, self:GetPhysicsObject():GetAngles().y, 0 )
	
	if ( self.mYaw > self.YawMax ) then
	
		self.YawSpeed = math.min( self.YawSpeed + self.YawAcceleration, self.MaxYawSpeed )
		self.RollSpeed = math.min( self.RollSpeed + self.RollAcceleration, self.MaxRollSpeed )
	
	elseif ( self.mYaw < -self.YawMax ) then
	
		self.YawSpeed = math.max( self.YawSpeed - self.YawAcceleration, -self.MaxYawSpeed )
		self.RollSpeed = math.max( self.RollSpeed - self.RollAcceleration, -self.MaxRollSpeed )
		
	elseif ( self.mYaw > -self.YawMax && self.mYaw < self.YawMax ) then // Infront
	
		self.YawSpeed = self.YawSpeed / 2.5 //-- Compensate for too high momentum when infront.
		self.RollSpeed =  self.RollSpeed / 1.25
		
	end
	
	// Pitching
	if( self.mYaw > -55 && self.mYaw < 55 ) then //-- front cone - pitch down nose, "preparing" for rocket rain.
	
		self.PitchSpeed = math.min( self.PitchSpeed + self.PitchAcceleration, self.MaxPitchSpeed )
		
	else
	
		self.PitchSpeed = math.max( self.PitchSpeed - self.PitchAcceleration * 1.5, -1 * ( self.MaxPitchSpeed + 15 ) )
		
	end
	
	local maxdist = 1700
	
	if( self.tarDist > maxdist ) then
	
		self.PitchSpeed = self.PitchSpeed / 1.2 // straighten out a tad when we're travelign forward
		self.Mod = 1
		
	elseif( self.tarDist < maxdist && self.Target:GetVelocity():Length() == 0 ) then
	
		if ( self.Velocity >= self.MaxVelocity - 1000 ) then
		
			self.Velocity = self.Velocity / 1.25
			
		end

		self.PitchSpeed = math.max( self.PitchSpeed - ( self.PitchAcceleration * 2.0 ), -1 * ( self.MaxPitchSpeed + 15 ) )//-- up with the nose if we're hovering
		self.Mod = -1 //-- Move backwards if we're too close to a stationary target, giving a hovering effect.
		
	end
	
	if ( self.Mod == -1 ) then
	
		self.PitchSpeed = math.max( self.PitchSpeed - ( self.PitchAcceleration * 1.5 ), -1 * ( self.MaxPitchSpeed + 15 ) )//-- up with the nose if we're hovering
		
	end
	
	
	
	if( self.mYaw < -160 || self.mYaw > 160 ) then
			
		self.RollValue = 0
			
	else
		
		self.RollValue = math.Approach( self.RollValue, ( self.mYaw / 3.25 ) * -1, 0.33333 )
			
	end
	
	--print( self.RollValue ) 
	
	if(DEBUG) then
	
		print("Yaw: "..self.mYaw.." YawSpeed: "..self.YawSpeed.." PitchSpeed: "..self.PitchSpeed.." TDistance: "..self:GetPos():Distance(self.Target:GetPos()))
		
	end
	
	self.PhysObj:SetAngles( self.mAng2 + Angle( self.PitchSpeed, self.YawSpeed, self.RollValue  ) ) --( math.sin( CurTime() + ( self:EntIndex() * self.randseed ) ) * 12 ) * 1.025 ) )

	self.PhysObj:SetVelocity(self.mVel)
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST --
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	if self.tarDist > 2000 then
	
		self:IncreaseVelocity()
		self.PhysObj:ApplyForceCenter( ( self.gNormal * 35000 ) )
	
	else
		
		self:DecreaseVelocity()
	
	end
	
	
	-- self.PhysObj:ApplyForceCenter( self.gNormal * 10000 )
	self.PhysObj:ApplyForceCenter( self.gNormal * 10000 )

	if (self:GetRight():Dot((self.Target:GetPos() - self.PhysObj:GetPos()):GetNormalized()) >= 0.45) then
	
		self:GetPhysicsObject():ApplyForceCenter( self:GetRight() * 9001 ) // it's over 9000 !
	
	else
	
		self:GetPhysicsObject():ApplyForceCenter( self:GetRight()  *-9001 )
		
	end
	
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
	local _Filter = { self, self.wep }
	local i = 0
	
	for k,v in pairs( tpos ) do
	
		i = i + 1
		v.filter = _Filter
		-- v.mask = ( MASK_SOLID  MASK_WATER )
		v.mask =   bit.band( MASK_SOLID, MASK_WATER )
		tr[i] = util.TraceEntity( v, self )
		
	end
	
	// Cheap Collision Detection & Hackfix to avoid crashing into stuff.
	if ( tr[1].Hit ) then
	
		if ( self:GetPos():Distance(tr[1].HitPos) < 300 && self:GetPhysicsObject():GetVelocity():Length() > 90 ) then
		
			self:GetPhysicsObject():SetVelocity( self:GetPhysicsObject():GetVelocity() / 1.15 )
			
			self:GetPhysicsObject():ApplyForceCenter( self:GetUp() * 10000 )
	
		end
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetUp() * ( 25000 - ( tr[1].Fraction * 25000 + ( self:GetVelocity():Length() * 4 ) ) ) )
		
	end
	
	if ( tr[2].Hit ) then //tr2
	
		self.YawAcceleration = 0.325
		
		self:GetPhysicsObject():SetVelocity( self:GetPhysicsObject():GetVelocity() / 1.25 )
		
		self:GetPhysicsObject():ApplyForceCenter( self:GetUp() * 18000 )
		
	else
	
		self.YawAcceleration = 0.0578
	
	end
	
	if ( tr[3].Hit && !tr[2].Hit ) then
	
		self:IncreaseVelocity()
		
	end
	
	if ( tr[4].Hit && !tr[5].Hit ) then
	
		if ( self:GetVelocity():Length() > 85 ) then
		
			self:SetVelocity( self:GetVelocity() / 1.08 )
			
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
	
	if ( self:GetForward():Dot( ( self.Target:GetPos() - self.PhysObj:GetPos() ):GetNormalized() ) >= 0.85 ) then
	
		if ( self.Target == self.CycleTarget ) then 
			
			return
	
		end
		
		if ( self:CheckLOS( self.Target ) ) then
			
			return

		end
		
		self:CalculateHitchance( self.Target )
		
	end
	
end


function ENT:OnRemove()

	self:StopSound("npc/attack_helicopter/aheli_rotor_loop1.wav")
	self.LoopSound:Stop()
	
end

