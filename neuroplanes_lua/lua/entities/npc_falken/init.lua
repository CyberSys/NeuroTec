
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

ENT.HealthVal = 1200
ENT.FireMode = 0
ENT.Target = nil
ENT.MaxGDistance = math.random(1000,1500)
ENT.Weapon = "sent_gau12equalizer"
ENT.HitPercentPrimary = 0
ENT.HitPercentSecondary = 0
ENT.DeathTimer = 0
ENT.Destroyed = false
ENT.Burning = false
ENT.IsOverWater = false
ENT.RollVal = 0
ENT.RollVal2 = 0
ENT.YawVal = 0
ENT.LagCompensate = 450
ENT.HitTabPrimary = {
{4000,3501,10};
{3500,3001,20};
{3000,2501,30};
{2500,2001,55};
{2000,1001,70};
{1000,0,100};
}
ENT.HitTabSecondary = {
{4000,3501,100};
{3500,3001,100};
{3000,2501,69};
{2500,2001,54};
{2000,1001,69};
{1000,0,0};
}

function ENT:Initialize()
	
    self:SetModel( "models/hawx/planes/adf-01 falken.mdl" )		
    self.Entity:PhysicsInit( SOLID_VPHYSICS )  	
    self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
    self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetHullType( HULL_LARGE )	
    self.Entity:SetHealth(self.HealthVal)	
	self:SetNetworkedInt("health",self.HealthVal)
	self:SetNetworkedInt( "MaxHealth",self.HealthVal)
	self.Entity:SetVar('FireSecondary',CurTime())
	self.Entity:SetVar('FireFlares',CurTime())
	local pos = {}
	self.Missile = {}
	pos[1] = self.Entity:GetPos()+self.Entity:GetRight()*139 +self.Entity:GetUp()*-30 +self.Entity:GetForward()*-40
	pos[2] = self.Entity:GetPos()+self.Entity:GetRight()*83 +self.Entity:GetUp()*-30 +self.Entity:GetForward()*-40
	pos[3] = self.Entity:GetPos()+self.Entity:GetRight()*-139 +self.Entity:GetUp()*-30 +self.Entity:GetForward()*-40
	pos[4] = self.Entity:GetPos()+self.Entity:GetRight()*-83 +self.Entity:GetUp()*-30 +self.Entity:GetForward()*-40
	for i=1,4 do
		self.Missile[i] = ents.Create("prop_physics_override")
		self.Missile[i]:SetPos(pos[i])
		self.Missile[i]:SetModel("models/props_phx/amraam.mdl")
		self.Missile[i]:SetAngles(self.Entity:GetAngles())
		self.Missile[i]:SetParent(self.Entity)
		self.Missile[i]:SetSolid(SOLID_NONE)
		self.Missile[i]:Spawn()
	end
	self.EngineMux = {}
	local esound = {}
	esound[1] = "physics/metal/canister_scrape_smooth_loop1.wav"
	esound[2] = "physics/cardboard/cardboard_box_scrape_smooth_loop1.wav"
	esound[3] = "ambient/levels/canals/dam_water_loop2.wav"
	for i=1,3 do
		self.EngineMux[i] = CreateSound(self.Entity,esound[i])
	end

	self.Pitch = 80
	self.EngineMux[1]:PlayEx(500,self.Pitch)
	self.EngineMux[2]:PlayEx(500,self.Pitch)
	self.EngineMux[3]:PlayEx(500,self.Pitch)
	
	self.wep = ents.Create(self.Weapon)
	self.wep:SetPos(self.Entity:GetPos()+self.Entity:GetRight()*-46 + self.Entity:GetForward()*128 +self.Entity:GetUp()*13)
	self.wep:SetAngles(self.Entity:GetAngles())
	self.wep:Spawn()
	self.wep:SetParent(self.Entity)
	self.wep:SetOwner(self.Entity)
	self.wep:SetPhysicsAttacker(self.Entity)
	self.wep:SetSolid( SOLID_NONE )
	self.CycleTarget = ents.Create("info_target")
	self.CycleTarget:SetPos(self.Entity:GetPos()+Vector(1024,1024,1024))
	self.CycleTarget:Activate()
	self.CycleTarget:Spawn()
	self.PhysObj = self.Entity:GetPhysicsObject()  	
	if (self.PhysObj:IsValid()) then 		
		self.PhysObj:Wake()  
		self.PhysObj:EnableGravity(false) 
	end 
end

local function death(ent)
if (ent == nil) then return end
		local explo = EffectData()
		explo:SetOrigin(ent:GetPos())
		util.Effect("Explosion", explo)
end

function ENT:OnTakeDamage(dmginfo)
if (self.Destroyed == true) then return end
self.Entity:TakePhysicsDamage(dmginfo)

	self.HealthVal = self.HealthVal - dmginfo:GetDamage()
	if (self.HealthVal < 200 && self.Burning == false) then
	self.Burning = true
	end
		if self.HealthVal < 5 then
		self.Destroyed = true
		self.PhysObj:EnableGravity(true)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:SetMass(2000)
		self.Entity:Ignite(60,100)
		for i=1,10 do
		local vx=i/4
		timer.Simple(vx,function() death(self.Entity) end)
		end
	end
	if (self.Target == self.CycleTarget) then
		self.Target = dmginfo:GetInflictor()
	end
end
function ENT:PhysicsSimulate( pobj, delta)
	pobj:Wake()
	local CSC = {}
	CSC.secondstoarrive	= 0.5
	CSC.pos					= self.Entity:GetPos()+self.Entity:GetForward()*self.LagCompensate+100
	CSC.angle				= (self.Target:GetPos() - self.Entity:GetPos()):Angle()
	CSC.maxangular			= 50000
	CSC.maxangulardamp		= 80000
	CSC.maxspeed			= 1000000
	CSC.maxspeeddamp		= 10000
	SC.dampfactor			= 0.99
	CSC.teleportdistance	= 6000
	CSC.deltatime			= delta
	pobj:ComputeShadowControl(pr)
end
function ENT:PhysicsCollide( data, physobj )
if (data.HitEntity:GetClass() == "prop_combine_ball") then
	local fx =EffectData()
	fx:SetOrigin(data.HitPos)
	fx:SetEntity(data.HitEntity)
	fx:SetStart(data.HitPos)
	fx:SetScale(4)
	util.Effect("CballExplode",fx)
	data.HitEntity:Remove()
	return false
	end
end
function ENT:CalculateHitchance(ent)
local dist = (Vector(self.Entity:GetPos().x,self.Entity:GetPos().y,0) - Vector(ent:GetPos().x,ent:GetPos().y,0)):Length()
	for k,v in pairs(self.HitTabPrimary) do
		if v[1] > dist && v[2] < dist then
			self.HitPercentPrimary = v[3]
		end
	end
	for _,p in pairs(self.HitTabSecondary) do
		if p[1] > dist && p[2] < dist then
			self.HitPercentSecondary = p[3]
		end
	end
	if self.HitPercentPrimary > self.HitPercentSecondary then
		self:AttackEnemy(1)
	else
		self:AttackEnemy(2)
	end
end

function ENT:Think()
	if (self.Destroyed == true) then 
		local effectdata = EffectData()
		effectdata:SetOrigin( self.Entity:GetPos() + self.Entity:GetRight() * math.random(-62,62) + self.Entity:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.wep.ShouldAttack = false
		self.DeathTimer = self.DeathTimer + 1
			if self.DeathTimer > 70 then
				self:DeathFX()
			end
	return end
	--sm_rcon lua_run for k,v in pairs(ents.FindByClass("npc_harrier")) do ErrorNotifyEveryone(math.Clamp(v.PhysObj:GetVelocity():Length()/5 +30,0,255)) end
	self.Pitch = math.Clamp(math.floor(self.PhysObj:GetVelocity():Length()/3.3 + 50),0,255)
	for i=1,3 do
		self.EngineMux[i]:ChangePitch(self.Pitch,0.01)
	end
	self:ScanForEnemies()
	
	self.LagCompensate = math.floor(self.PhysObj:GetVelocity():Length()/2 +100)
	self.mVel = self.PhysObj:GetVelocity()
	self.gVec = (self.Target:GetPos() - self.Entity:GetPos()) -- + Vector(0,0,280)
	self.gNormal = self.gVec:Normalize()
	self.gAng = (self.Target:GetPos() - self.Entity:GetPos()):Angle() -- + Vector(0,0,280)
	self.mAng =  Angle(0,self:GetPhysicsObject():GetAngles().y,0) -- self:GetAngles()-- 
	self.mYaw = self.Entity:VecAngD(self.gAng.y,self.mAng.y)
	self.mPitch = self.Entity:VecAngD(self.gAng.p,self.mAng.y)
	self.tarDist = self.Entity:GetPos():Distance(self.Target:GetPos())
	self.HeightDifference = (Vector(0,0,self.Target:GetPos().z) - Vector(0,0,self.Entity:GetPos().z )):Length()
	if (self.HeightDifference < self.MaxGDistance) then
		self.PhysObj:ApplyForceCenter(self.Entity:GetUp()*7400)
	end

		
		if (self.Entity:VecAngD(self.gAng.y,self.mAng.y) > 1) then
			self.RollVal = self.RollVal - 0.5
				if self.RollVal <= -20 then
					self.RollVal = -20
				end
			elseif (self.Entity:VecAngD(self.gAng.y,self.mAng.y) < -1) then
				self.RollVal = self.RollVal + 0.5
				if self.RollVal >= 20 then
					self.RollVal = 20
				end
		end

	if  self.Entity:GetAngles():Forward():Dot((self.Target:GetPos() - self.Entity:GetPos()):GetNormalized()) > 0.4 then
		if (self.Entity:VecAngD(self.gAng.p,self.mAng.p) < -1) then
		-- print("Pitching up")
			self.RollVal2 = self.RollVal2 - 2
				if self.RollVal2 <= -35 then
					self.RollVal2 = -35
				end
		elseif (self.Entity:VecAngD(self.gAng.p,self.mAng.p) > 1) then
				self.RollVal2 = self.RollVal2 + 2
				if self.RollVal2 >= 35 then
					self.RollVal2 = 35
				end
				-- print("Pitching down")
		end
	elseif self.Entity:GetAngles():Forward():Dot((self.Target:GetPos() - self.Entity:GetPos()):GetNormalized()) < 0.4 then
			if self.RollVal2 > 0 then
				self.RollVal2 = self.RollVal2 - 1
				if self.RollVal2 < 0 then
					self.RollVal2 = 0
				end
			elseif self.RollVal2 < 0 then
				self.RollVal2 = self.RollVal2 + 1
				if self.RollVal2 > 0 then
					self.RollVal2 = 0
				end
			end
	end
		self.mAng2 = Angle(self.RollVal2,self:GetPhysicsObject():GetAngles().y,self.RollVal)
		if (self.mYaw > 3) then
			self.PhysObj:SetAngle(self.mAng2+Angle(0,3.5,0))
			self.PhysObj:SetVelocity(self.mVel)
		elseif (self.mYaw < -3) then
			self.PhysObj:SetAngle(self.mAng2+Angle(0,-3.5,0))
			self.PhysObj:SetVelocity(self.mVel)
		elseif (self.mYaw > -3 && self.mYaw < 3) then
		
			self.RollVal = math.sin(CurTime())*7
		
		end

		self.PhysObj:ApplyForceCenter(( self.gNormal * 29530))
		self.PhysObj:SetVelocity(self.Entity:GetForward()*3400)

	if (self.Entity:GetForward():Dot((self.Target:GetPos() - self.Entity:GetPos()):GetNormalized()) >= 0.65) then
		if(self.Target == self.CycleTarget) then return end
		if (!self:CheckLOS(self.Target)) then return end
		self:CalculateHitchance(self.Target)
	end
end

   
function ENT:OnRemove()
	for i=1,3 do
		self.EngineMux[i]:Stop()
	end
	self.Entity:Remove()
	self.wep:Remove()
	for i=1,4 do
	self.Missile[i]:Remove()
	end
end

