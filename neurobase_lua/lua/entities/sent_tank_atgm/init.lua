
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.EntAngs = NULL
ENT.MissileSound = NULL
ENT.ExplosionDel = CurTime() + 1
ENT.ExplodeOnce = 0
ENT.ActivateDel = CurTime()

ENT.MissileTime = CurTime() + 1	

ENT.DestPos = NULL
ENT.angchange	= 5
ENT.killed = false
ENT.Trail = NULL

function ENT:Initialize()

	-- self:SetModel("models/weapons/w_missile_closed.mdl")
	self:SetModel("models/bf2/weapons/Eryx/eryx_rocket.mdl")
	-- self:SetColor(255, 255, 255, 255)
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then 
	
		phys:Wake() 
		phys:EnableGravity( true ) 
		phys:SetVelocity( self:GetForward()*1000 )
		phys:SetMass( 50 )
	end
	
	 self.EntAngs = self:GetAngles()
	 
	-- self.smoketrail = ents.Create("env_rockettrail")
	-- self.smoketrail:SetPos(self:GetPos() + self:GetForward() * -83)
	-- self.smoketrail:SetParent(self)
	-- self.smoketrail:SetLocalAngles( Vector(0,0,0))
	-- self.smoketrail:Spawn()
		
	-- self.Trail = util.SpriteTrail(self, 0, Color(200,200,200,255), false, 4, 0, 3, 1/(15+1)*0.5, "trails/smoke.vmt")
	
	self.MissileSound = CreateSound(self,"weapons/rpg/rocket1.wav")
	self.MissileSound:Play()
	self:SetCollisionGroup( 1 )	
	
	-- self.MissileTime = CurTime() + 1
	
	self.DestPos = self.FollowPos
	self.ActivateDel = self.ActivateDel	
	
end

-------------------------------------------PHYS COLLIDE
function ENT:PhysicsCollide( data, phys ) 
	ent = data.HitEntity

	if self.ActivateDel < CurTime() && self.killed == false then
		self:Explode()
	elseif self.killed == false then
		self.killed = true 
		self:Fire("kill", "", 10)
		self.Trail:Remove()
		self.MissileSound:Stop()
		self:EmitSound("weapons/rpg/shotdown.wav",75,math.random(80,120))			
	end
end

-------------------------------------------PHYS UPDATE
function ENT:PhysicsUpdate( physics )

	if self.killed == false then

		if self.ActivateDel < CurTime() && self.DestPos != nil && self.DestPos && self.DestPos != NULL then
			
			if( self:GetPos():Distance( self.DestPos ) < 1000 ) then return end
		
			phys = self:GetPhysicsObject()
			local veloc = phys:GetVelocity()	
			phys:SetVelocity(veloc)
			phys:ApplyForceCenter(self:GetForward() * 2950 )
			
			local AimVec = (self.DestPos - self:GetPos() ):Angle()
			local Dist = math.min(self:GetPos():Distance(self.DestPos), 5000)
			local Dist = Dist / 50000
			local Mod = (1 - Dist) * self.angchange

			self.EntAngs.p = math.ApproachAngle( self.EntAngs.p, AimVec.p, 0.75 + Mod )
			self.EntAngs.r = math.ApproachAngle( self.EntAngs.r, AimVec.r, 0.75 + Mod )
			self.EntAngs.y = math.ApproachAngle( self.EntAngs.y, AimVec.y, 0.75 + Mod )
			self:SetAngles( self.EntAngs )

			local dist = self.DestPos:Distance(self:GetPos())
			if dist < 20 then
				self:Explode()
			end
		
		end
	end
end
-------------------------------------------THINK
function ENT:Think()

	if( self:WaterLevel() > 0 ) then

		ParticleEffect( "water_impact_big", self:GetPos(), Angle(0,0,0), nil )
		
		self:Remove()
		
		return
		
	end
	
	if self.ExplosionDel < CurTime() then
		self:SetCollisionGroup( 3 )
	end
	
	local fx = EffectData()
	fx:SetStart( self:GetPos() )
	fx:SetOrigin( self:GetPos() + 10*Vector( math.random(-10,10),math.random(-10,10), 1 ) )
	fx:SetNormal( self:GetUp() )
	fx:SetMagnitude( 1 )
	fx:SetScale( 10 )
	fx:SetRadius( 10 )
	util.Effect( "ThumperDust", fx )

	phys = self:GetPhysicsObject()
	phys:Wake()
	
end


-------------------------------------------REMOVE
function ENT:OnRemove()

end

function ENT:OnRemove()
	
	if( self.MissileSound ) then
	
		self.MissileSound:Stop()
		
	end
	
end

function ENT:Explode()

	if self.ExplodeOnce == 0 then
		
		self.ExplodeOnce = 1
		local expl = ents.Create("env_explosion")
		expl:SetKeyValue("spawnflags",128)
		expl:SetPos(self:GetPos())
		expl:Spawn()
		expl:Fire("explode","",0)
		
		local FireExp = ents.Create("env_physexplosion")
		FireExp:SetPos(self:GetPos())
		FireExp:SetParent(self)
		FireExp:SetKeyValue("magnitude", 1000)
		FireExp:SetKeyValue("radius", 512)
		FireExp:SetKeyValue("spawnflags", "1")
		FireExp:Spawn()
		FireExp:Fire("Explode", "", 0)
		FireExp:Fire("kill", "", 5)
		
		if( hitstuff ) then
		
			ParticleEffect("rocket_impact_wall", self:GetPos(), self:GetAngles(), nil )
			
		else
		
			ParticleEffect("rocket_impact_dirt", self:GetPos(), self:GetAngles(), nil )
			
		end
		
		self:PlayWorldSound( "ambient/explosions/explode_"..math.random(1,4)..".wav"  )
		
		if( !IsValid( self.Creditor ) || !IsValid( self.Owner ) ) then self:Remove() return end 
		
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos() + self:GetForward()*30, 512, math.random(1000,3000) )
		
		self:Remove()
		
	end
	
end
