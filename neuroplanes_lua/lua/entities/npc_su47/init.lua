
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
	
    self:SetModel( "models/hawx/air/su-47 berkut.mdl" )		
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
	local mdl = {}
	self.Missile = {}
	pos[1] = self.Entity:GetPos()+self.Entity:GetRight()*179 +self:GetUp()*90  +self.Entity:GetForward()*-130
	pos[2] = self.Entity:GetPos()+self.Entity:GetRight()*103 +self:GetUp()*90 +self.Entity:GetForward()*-150
	pos[3] = self.Entity:GetPos()+self.Entity:GetRight()*-179 +self:GetUp()*90  +self.Entity:GetForward()*-130
	pos[4] = self.Entity:GetPos()+self.Entity:GetRight()*-103 +self:GetUp()*90 +self.Entity:GetForward()*-150
	pos[5] = self.Entity:GetPos()+self:GetUp()*40
	mdl[1] = "models/military2/missile/missile_patriot.mdl"
	mdl[2] = "models/military2/missile/missile_patriot.mdl"
	mdl[3] = "models/military2/missile/missile_patriot.mdl"
	mdl[4] = "models/military2/missile/missile_patriot.mdl"
	mdl[5] = "models/military2/missile/missile_sm2.mdl" 
	for i=1,5 do
		self.Missile[i] = ents.Create("prop_physics_override")
		self.Missile[i]:SetPos(pos[i])
		self.Missile[i]:SetModel(mdl[i])
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
	self.wep:SetPos(self.Entity:GetPos()+self.Entity:GetRight()*-26 + self.Entity:GetForward()*320 +self.Entity:GetUp()*100)
	self.wep:SetAngles(self.Entity:GetAngles())
	self.wep:Spawn()
	self.wep:SetParent(self.Entity)
	self.wep:SetOwner(self.Entity)
	self.wep:SetPhysicsAttacker(self.Entity)
	self.wep:SetSolid( SOLID_NONE )
	self.CycleTarget = ents.Create("sent_neurotarget")
	self.CycleTarget.Owner = self
	self.CycleTarget:SetPos(self.Entity:GetPos()+Vector(1024,1024,1024))
	self.CycleTarget:Spawn()
	self.PhysObj = self.Entity:GetPhysicsObject()  	
	if (self.PhysObj:IsValid()) then 		
		self.PhysObj:Wake()  
		self.PhysObj:EnableGravity(false) 
	end 
end
local function death(ent)
if (ent == nil || ent == NULL) then return end
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
	CSC.teleportdistance	= 500
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
		self:AttackEnemySpecial(1)
	else
		self:AttackEnemySpecial(2)
	end
end
function ENT:Barrage(pos)
if (self.Target:WaterLevel() > 0) then return end -- just no
	local r = ents.Create("sent_guided_missile")
	r:SetPos(pos+self.Entity:GetForward()*128+self:GetUp()*-128)
	r:SetAngles(self:GetAngles())
	r:Spawn()
	r:SetOwner(self.Entity)
	r:SetPhysicsAttacker(self.Entity)
	r.Target = self.Target
	r.Owner = self
	r:GetPhysicsObject():SetVelocity(self.PhysObj:GetVelocity())
end

function ENT:LaunchBigBoy(pos)
if (self.Target:WaterLevel() > 0) then return end -- just no
	local r = ents.Create("sent_guided_missile_2")
	r:SetPos(pos+self.Entity:GetForward()*128+self:GetUp()*-128)
	r:SetAngles(self:GetAngles())
	r:Spawn()
	r:SetOwner(self.Entity)
	r:SetPhysicsAttacker(self.Entity)
	r.Target = self.Target
	r.Owner = self
	r:GetPhysicsObject():SetVelocity(self.PhysObj:GetVelocity())
end

function ENT:AttackEnemySpecial(frm)
	if(!self.Missile || !self) then return end
	if (frm == 1) then

		self.wep.ShouldAttack = true
		
	elseif (frm == 2) then
			
		self.wep.ShouldAttack = false
		
		if (!self:CheckLOS(self.Target)) then return end
		
		local TSR = self.Entity:GetVar('FireSecondary',0)
			
		if (TSR + 15) > CurTime() then return end
				
		self.Entity:SetVar('FireSecondary',CurTime())
		for i=1,5 do
			if(i < 5) then
				local vx=i*1.2
				timer.Simple(vx,function() self:Barrage(self.Missile[i]:GetPos()) end)
			else
				if(math.random(0,10) > 3) then
					self:LaunchBigBoy(self.Missile[i]:GetPos())
				end
			end
		end
	end
end

function ENT:Think()
	if (self.Destroyed == true) then 
		local effectdata = EffectData()
		effectdata:SetOrigin( self.Entity:GetPos() + self.Entity:GetRight() * math.random(-62,62) + self.Entity:GetForward() * math.random(-62,62)  )
		util.Effect( "immolate", effectdata )
		self.DeathTimer = self.DeathTimer + 1
		if self.DeathTimer > 70 then
			self:DeathFX()
		end
	end
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

					
	if (self.Entity:VecAngD(self.gAng.y,self.mAng.y) > 1.5) then
		self.RollVal = self.RollVal - 1.5
		if self.RollVal <= -20 then
			self.RollVal = -20
		end
	elseif (self.Entity:VecAngD(self.gAng.y,self.mAng.y) < -1.5) then
		self.RollVal = self.RollVal + 1.5
		if self.RollVal >= 20 then
			self.RollVal = 20
		end
	end
		
	if  self.Entity:GetAngles():Forward():Dot((self.Target:GetPos() - self.Entity:GetPos()):GetNormalized()) > 0.4 && self:GetPos():Distance(self.Target:GetPos()) < 3000 then
		if (self.Entity:VecAngD(self.gAng.p,self.mAng.p) < -1) then
			self.RollVal2 = self.RollVal2 - 2
			if self.RollVal2 <= -35 then
				self.RollVal2 = -35
			end
		elseif (self.Entity:VecAngD(self.gAng.p,self.mAng.p) > 1) then
			self.RollVal2 = self.RollVal2 + 2
			if self.RollVal2 >= 35 then
				self.RollVal2 = 35
			end
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
	if (self.mYaw > 3.5) then
		self.PhysObj:SetAngle(self.mAng2+Angle(0,3.5,0))
		self.PhysObj:SetVelocity(self.mVel)
	elseif (self.mYaw < -3.5) then
		self.PhysObj:SetAngle(self.mAng2+Angle(0,-3.5,0))
		self.PhysObj:SetVelocity(self.mVel)
	elseif (self.mYaw > -3.5 && self.mYaw < 3.5) then
		self.RollVal = math.sin(CurTime())*3
	end 
					
					
	if  self.tarDist > 100 then
		if self.Target:WaterLevel() > 0 then
			self.PhysObj:ApplyForceCenter((self.gNormal * 15200))
			self.PhysObj:ApplyForceCenter((self.Entity:GetForward() * 145200))
			self.PhysObj:ApplyForceCenter(self.Entity:GetUp()*9000)
		else
			self.PhysObj:ApplyForceCenter(( self.gNormal * 29530))
			self.PhysObj:SetVelocity(self.Entity:GetForward()*3400)
		end
	elseif (self.tarDist > 2900 &&  self.Entity:GetForward():Dot((self.Target:GetPos() - self.Entity:GetPos()):GetNormalized()) >= 0.75)then
		self.PhysObj:ApplyForceCenter(( self.gNormal * 159530))
		self.PhysObj:SetVelocity(self.Entity:GetForward()*3900)
	elseif (self.tarDist < 2000) then
		self.PhysObj:ApplyForceCenter(( self.gNormal * 28530))
		self.PhysObj:ApplyForceCenter((self.Entity:GetForward() * 14200))
	end
	if (self.Entity:GetForward():Dot((self.Target:GetPos() - self.Entity:GetPos()):GetNormalized()) >= 0.65) then
		if(self.Target == self.CycleTarget) then return end
		if (!self:CheckLOS(self.Target)) then return end
		self:CalculateHitchance(self.Target)
	end

	if ((Vector(self.Target:GetPos().x,self.Target:GetPos().y,0) - Vector(self.Entity:GetPos().x,self.Entity:GetPos().y,0)):Length() < 2000 && self.Target:WaterLevel() > 1) then
		self.IsOverWater = true
	else
		self.IsOverWater = false
	end
	local ft1={}
	ft1.start=self.Entity:GetPos() + self.Entity:GetForward()*90
	ft1.endpos=self.Entity:GetPos()+self.Entity:GetForward()*712
	ft1.filter=self.Entity
	local tr1=util.TraceLine(ft1)
	local dt1={}
	dt1.start=self.Entity:GetPos()+self.Entity:GetUp()*-100
	dt1.endpos=self.Entity:GetPos()+self.Entity:GetUp()*-700
	dt1.filter=self.Entity
	local tr2=util.TraceLine(dt1)
	if (tr2.Hit) then
		self.PhysObj:ApplyForceCenter(self.Entity:GetUp()*20200)
		self.PhysObj:ApplyForceCenter(self.Entity:GetForward()*5600)
		self.RollVal2 = self.RollVal2 - 0.2
	end
	if (tr1.Hit) then
		self.PhysObj:ApplyForceCenter(self.Entity:GetUp()*14400)
		self.RollVal2 = self.RollVal2 - 0.2
	end

	self:FlareDefence()
end

function ENT:OnRemove()
	for i=1,3 do
		self.EngineMux[i]:Stop()
	end
	self.Entity:Remove()
	self.wep:Remove()
	for i=1,5 do
		self.Missile[i]:Remove()
	end
end

