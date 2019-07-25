// Helicopter Drone NPC
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
// From Jaanus
// this is completely new to me, pretty useful though :D
AccessorFunc( ENT, "m_iRRightParam", "RotorRightParam", 0, FORCE_NUMBER )
AccessorFunc( ENT, "m_iRLeftParam", "RotorLeftParam", 0, FORCE_NUMBER )
AccessorFunc( ENT, "m_iCameraYaw", "CameraYaw", 0, FORCE_NUMBER )
// End of Jaanus
RenderTargetCamera = nil
RenderTargetCameraProp = nil

local CrashDebris = {
{"models/gibs/airboat_broken_engine.mdl"};
{"models/gibs/manhack_gib01.mdl"};
{"models/gibs/scanner_gib01.mdl"};
{"models/gibs/shield_scanner_gib2.mdl"};
{"models/gibs/manhack_gib02.mdl"};
{"models/gibs/manhack_gib03.mdl"};
{"models/gibs/helicopter_brokenpiece_02.mdl"};
{"models/gibs/scanner_gib04.mdl"};
}




function ENT:Precache( )
	
	util.PrecacheSound( self.HoverSoundFile )

	for k,v in pairs(CrashDebris) do
	
		util.PrecacheModel(tostring(v))
	
	end
	
end

function ENT:Initialize()

	local rnd = math.random(0, 15000)
	self.Rand = (CurTime() - 1000) + rnd
    self:SetModel( "models/jaanus/heli_drone.mdl" )		
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
	
	self.MaxGDistance = math.random(300,600)
	
	self:SetRotorRightParam( 0 )
	self:SetRotorLeftParam( 0 )
	self:SetCameraYaw( 0 )
	
	
	
	self.HoverSound = CreateSound( self, self.HoverSoundFile )

	self.PhysObj = self.Entity:GetPhysicsObject()  	

	if ( self.PhysObj:IsValid() ) then 		
	
		self.PhysObj:Wake()  
		self.PhysObj:EnableGravity(false) 
	
	end 

	RenderTargetCamera = ents.Create( "point_camera" )
	RenderTargetCamera:SetKeyValue( "GlobalOverride", 1 )
	RenderTargetCamera:SetPos(self:GetPos())
	RenderTargetCamera:SetAngles(self:GetAngles()+ Angle(90,0,0))
	RenderTargetCamera:Spawn()
	RenderTargetCamera:Activate()
	RenderTargetCamera:Fire( "SetOn", "", 0.0 )
	RenderTargetCamera:SetParent(self)
	RenderTargetCameraProp = self
	self.DroneCam = RenderTargetCamera
	
	self:CreateDot()
end

local function death(ent)

	if (ent == nil) then
		
		return 
	
	end
	
	local explo = EffectData()
	explo:SetOrigin(ent:GetPos())
	util.Effect("Explosion", explo)
	
end

function ENT:OnTakeDamage(dmginfo)

	if (self.Destroyed == true) then
		
		return 
	
	end
	
	self.Entity:TakePhysicsDamage(dmginfo)
	
	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	
	if ( self.HealthVal < 200 && self.Burning == false ) then
		
		self.Burning = true
		
		local wFire1 = ents.Create("env_Fire_trail")
		wFire1:SetPos(self.PhysObj:GetPos()+self.Entity:GetRight()*20)
		wFire1:SetParent(self.Entity)
		wFire1:Spawn()
		
		local wFire2 = ents.Create("env_Fire_trail")
		wFire2:SetPos(self.PhysObj:GetPos()+self.Entity:GetRight()*-20)
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
	
	
end

function ENT:Use(ply,caller)
	self:SetOwner(ply)
	self:DeathFXSpecial()
end
//Jaanus <3

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
// End of Jaanus <3



function ENT:IsOverWater()

	local trace,tr = {},{}
	trace.start = self:GetPos()
	trace.endpos = trace.start + self:GetUp() * -4048
	trace.mask = MASK_SOLID
	trace.filter = { self }
	tr = util.TraceEntity( trace, self )
	
	if ( tr.Hit && tr.MatType == 78 ) then // Hit water
	
		return true
		
	end
	
	return false
	
end


function ENT:CalculateHitchance(ent)
	
	
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
	
	
end


function ENT:PhysicsSimulate( pobj, delta)

	pobj:Wake()
	
	local CSC = {}
	CSC.secondstoarrive	= 0.1
	CSC.pos					= self.PhysObj:GetPos() + self.Entity:GetForward() * (self.LagCompensate + 100 )
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

function ENT:CreateDot()
		
	local pos = self:GetPos()
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos+self:GetUp()*-100000
	tracedata.filter = {self,self.DroneCam}
	local trace = util.TraceLine(tracedata)

	self.RedDot = ents.Create( "env_sprite" )
	self.RedDot:SetParent( self )	
	self.RedDot:SetPos( trace.HitPos  )
	self.RedDot:SetAngles( self:GetAngles() )
	self.RedDot:SetKeyValue( "spawnflags", 1 )
	self.RedDot:SetKeyValue( "renderfx", 0 )
	self.RedDot:SetKeyValue( "scale", 0.48 )
	self.RedDot:SetKeyValue( "rendermode", 9 )
	self.RedDot:SetKeyValue( "HDRColorScale", .75 )
	self.RedDot:SetKeyValue( "GlowProxySize", 2 )
	self.RedDot:SetKeyValue( "model", "sprites/redglow3.vmt" )
	self.RedDot:SetKeyValue( "framerate", "10.0" )
	self.RedDot:SetKeyValue( "rendercolor", " 255 0 0" )
	self.RedDot:SetKeyValue( "renderamt", 255 )
	self.RedDot:Spawn()

end

function ENT:Spot()
	local pos = self:GetPos()
	local tracedata = {}
	tracedata.start = pos
	tracedata.endpos = pos+self:GetUp()*-100000
	tracedata.filter = {self,self.DroneCam}
	local trace = util.TraceLine(tracedata)

	self.RedDot:SetPos( trace.HitPos  )
	if IsValid(self.Owner) then
		self.Owner:SetNetworkedEntity( "Target", self.RedDot )
	end
end

function ENT:RemoteControls()
	local pos = self:GetNetworkedVector("PositionOrder", Vector(0,0,0))
	local ang = self:GetNetworkedVector("TurnOrder", Vector(0,0,0))
	-- print(ang)
	self.PhysObj:AddVelocity( self:GetForward()*100*pos.x + self:GetRight()*80*pos.y + self:GetUp()*40*pos.z )
	-- self.PhysObj:AddAngleVelocity( -1*self.PhysObj:GetAngleVelocity() + Angle(0,0,-ang.z ))	
	self.PhysObj:AddAngleVelocity( -1*self.PhysObj:GetAngleVelocity() + Vector(0,0,-ang.z ))	
/*
--	local ang = self:GetAngles()
--	local pos = self:GetPos()
--	local mul = self.VelocityMult * self.Mod
	local SpeedOrder = 100*GetConVarNumber("drone_X", 0 ) --* self.MaxVelocity/100
	local YawOrder = 	80*GetConVarNumber("drone_Y", 0 ) --* self.MaxYawSpeed
	local AltOrder = 	40*GetConVarNumber("drone_Z", 0 )
	local YawTurn = GetConVarNumber("drone_Yaw", 0 )
	
--	self.PhysObj:AddVelocity( self:GetForward()*SpeedOrder + self:GetRight()*YawOrder + self:GetUp()*AltOrder )
--	self.PhysObj:AddAngleVelocity( -1*self.PhysObj:GetAngleVelocity() + Angle(0,0,YawTurn ))	
*/
end

function ENT:GPSCoordFinder()
	local orderpos = self:GetNetworkedVector("PositionOrder", Vector(0,0,0))
	local GPS = self:GetNetworkedVector("GPS_coords", self:GetPos())
	local ang = self:GetAngles()
	local newang = Angle(0,0,0)
	local maxdistance = 500
//print(GPS)	//Seems to be saved. :/
		local pos = self:GetPos()
--		local distance = GPS:Sub(pos):Length() 
		local move = Vector(0,0,0)
		local dir = orderpos:GetNormalized():Angle()
		local newang = Angle(0,0,0)
--		newang.y = math.AngleDifference(dir.y, ang.y)
	
--	if distance< maxdistance then
		if (pos.x+10<GPS.x) then
		move.x = 1
		elseif pos.x-10>GPS.x then
		move.x = -1
		else
		move.x= 0
		end
		
		if pos.y+10<GPS.y then
		move.y = 1
		elseif pos.y-10>GPS.y then
		move.y = -1
		else
		move.y= 0
		end
		
		if pos.z<GPS.z+maxdistance then
//		move.z = 1
		elseif pos.z>GPS.z+maxdistance+100 then
//		move.z = -1
		else
		move.z= 0
		end

		if newang.y<-2 then
		newang.y = 1
		elseif newang.y>2 then
		newang.y = -1
		end
--	else
--	end	
	
	if (orderpos.x ==0) && (orderpos.y ==0) && (orderpos.z ==0) then
	self.PhysObj:AddVelocity( Vector( 100*move.x,80*move.y,40*move.z ) )
	end

end
function ENT:IncreaseVelocity()

	if ( self.Velocity > self.MaxVelocity ) then
	
		self.Velocity = self.MaxVelocity
		
	end
	
	if (GetConVarNumber("drone_auto", 0 )==1 ) then
	self.Velocity = self.Velocity + self.VelocityMod
	else
	self.Velocity = 0
	end
	self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * (self.Velocity * self.VelocityMult) * self.Mod )

end

function ENT:DecreaseVelocity()

	if(self.Velocity < self.MinVelocity) then

		self.Velocity = self.MinVelocity
	
	end
	
	if (GetConVarNumber("drone_auto", 0 )==1 ) then
	self.Velocity = self.Velocity - self.VelocityMod
	else
	self.Velocity = 0
	end	
	self:GetPhysicsObject():ApplyForceCenter(self:GetForward() * (  self.Velocity * self.VelocityMult * self.Mod ) )
	
end

function ENT:Think()

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
	
--	if IsValid( self.Owner) then
	--	self.Target = self.Owner
--		else
		self:ScanForEnemies()
--	end
	// ty jaanus <3
	
	if ( !self.HoverSoundPlaying ) then
		
		self.HoverSound:SetSoundLevel( 95 )
		self.HoverSound:Play()
		self.HoverSound:ChangeVolume( 0.32, 0.01 )
		self.HoverSoundPlaying = true
		
	end
	
	self:UpdateAnimation()
	
	// End of ty jaanus <3
	
	local pitch = math.Clamp( math.floor( ( self.PhysObj:GetVelocity():Length() / 100 + 70 ) ) + math.sin( CurTime() ) * 8, 0, 250 )
	self.HoverSound:ChangePitch( pitch, 0.01 )
	
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

	if (GetConVarNumber("drone_auto", 0 )==1 ) then
		if ( self.HeightDifference < self.MaxGDistance ) then
		
			self.PhysObj:ApplyForceCenter(self.Entity:GetUp()*2400)
		
		end	
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
	if (GetConVarNumber("drone_auto", 0 )==1 ) then
		self.PhysObj:SetAngles( self.mAng2 + Angle( self.PitchSpeed, self.YawSpeed, ( math.sin( CurTime() ) * 8.5 ) * 1.025 ) )
	elseif (GetConVarNumber("drone_auto", 0 )==2 ) then
		self:GPSCoordFinder()
	else
		self:RemoteControls()
	end	
	
	
//	self.PhysObj:SetVelocity(self.mVel)
	
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST -- TEST --
	---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	if self.tarDist > 2000 then
	
		self:IncreaseVelocity()
		
	if (GetConVarNumber("drone_auto", 0 )==1 ) then
			self.PhysObj:ApplyForceCenter(  self.gNormal * ( 4500 + ( self:GetVelocity():Length() * 10 ) ) )
		end
	else

		self:DecreaseVelocity()
		
	if (GetConVarNumber("drone_auto", 0 )==1 ) then
			self.PhysObj:ApplyForceCenter(  self.gNormal * ( 4000 + ( self:GetVelocity():Length() * 10 ) ) )
		end	
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
	
		local pos = self:GetPos()
		local pos2 = self.Target:GetPos()
		local tracedata = {}
		tracedata.start = pos
		tracedata.endpos = pos2
		tracedata.filter = {self,self.DroneCam}
		local trace = util.TraceLine(tracedata)

	self:SetCameraYaw(  (trace.Normal).y ) // No I'm not obsessed with sine waves.
	
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
	local _Filter = { self}
	local i = 0
	
	if (GetConVarNumber("drone_auto", 0 )==1 ) then
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
	
	else
	local randP = math.random(-5,5)
	local randY = math.random(-5,5)
	local randR = math.random(-5,5)
	local entang = self:GetAngles()
	self.PhysObj:SetVelocity( LerpVector( 0.1, self.PhysObj:GetVelocity(), Vector( randP, randY, randR ) )) -- + self:GetForward()*4.267 ) //To balance the unknown backward force.
	self:SetAngles( LerpAngle( 0.1, entang, Angle(entang.p,entang.y,0) )) -- + self:GetForward()*4.267 ) //To balance the unknown backward force.
	end
	
	if GetConVarNumber("target_Set",0)==1 then
		self:Spot()
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
		cdeb:Fire( "ignite", "", 0 )
		cdeb:Fire( "kill", "", 15 )
		local f1 = EffectData()
		f1:SetOrigin( cdeb:GetPos() )
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

function ENT:OnRemove()

	if IsValid(self.HoverSound)then
	self.HoverSound:Stop()
	end
	if IsValid(self.DroneCam)then
	self.DroneCam:Remove()
	end
	if IsValid(self.RedDot)then
	self.RedDot:Remove()
	end
end