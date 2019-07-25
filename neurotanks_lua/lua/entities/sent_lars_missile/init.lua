AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Speed = 3000
ENT.MaxDamage = 750
ENT.MinDamage = 250
ENT.Radius = 256
ENT.Cluster = 5--//12

function ENT:Initialize()
	
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	self.Ticker = 0
	
	-- 
	
	local fx = EffectData()
	fx:SetOrigin( self:GetPos() )
	fx:SetEntity( self )
	fx:SetStart( self:GetPos() ) 
	fx:SetAngles( self:GetAngles() )
	fx:SetMagnitude( 1.0 )
	fx:SetScale( 1.0 )
	util.Effect( "rockettrail", fx )
	
	
	-- print( particle )
	-- ParticleEffect("rockettrail", self:GetPos(), self:GetAngles(), self.Entity )
	
	-- if( IsValid( particle ) ) then particle:SetParent( self ) end
	

	math.randomseed( self:EntIndex() * 1000 + CurTime() )
	local r = math.random( 0, 1 ) 
	self.rand = ( r > 0  ) and 1 or -1
	
	self.PhysObj = self:GetPhysicsObject()
	self.Sound = CreateSound(self, "Missile.Accelerate")
	
	if ( self.PhysObj:IsValid() ) then
		
		self.PhysObj:EnableGravity(true)
		self.PhysObj:EnableDrag(true)
		self.PhysObj:Wake()
		
	end
	
	util.PrecacheSound("Missile.Accelerate")

	-- self.smoketrail = ents.Create("env_rockettrail")
	-- self.smoketrail:SetPos(self:GetPos() + self:GetForward() * -83)
	-- self.smoketrail:SetParent(self)
	-- self.smoketrail:SetLocalAngles(Vector(0,0,0))
	-- self.smoketrail:Spawn()

	if ( self:GetModel() == "models/error.mdl" ) then
		
		self:SetModel( "models/weapons/w_missile_closed.mdl" )
		
	else
	
		self:SetModel( self:GetModel() )
		
	end
	
	-- ParticleEffect("rockettrail", self:GetPos(), self:GetAngles(), self )
	
	-- util.SpriteTrail(self, 0, Color(255,225,180,math.random(150,170)), false, 24, math.random(1,2), 0.5, math.sin(CurTime()) / math.pi * 0.5, "trails/smoke.vmt");  
	self.OriginShot = self:GetPos()
	timer.Simple(15, function() 
		if (IsValid( self )) then
		self:NeuroPlanes_BlowWelds( self:GetPos(), self.Radius )
		self:ExplosionImproved()
		self:Remove()
		end
	end )

end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime < 0.2 ) or ( self:GetVelocity():Length()>50 ) then
	
		if ( !self.Owner || !IsValid( self.Owner ) ) then
		
			self.Owner = self
			
		end
	
		if( IsValid( data.HitEntity ) && !data.HitWorld ) then
		
			ParticleEffect("rocket_impact_wall", self:GetPos(), self:GetAngles(), nil )
		
		else
		
			ParticleEffect("rocket_impact_dirt", self:GetPos(), self:GetAngles(), nil )
			
		end
		
		self:EmitSound( "ambient/explosions/explode_1.wav", 511, 200 )
		util.BlastDamage( self, self.Owner, self:GetPos(), self.Radius, math.random( self.MinDamage, self.MaxDamage ) )
	
		self:Remove()
		
	end
	
end

function ENT:PhysicsUpdate()
		

	if( self:WaterLevel() > 1 ) then
		
		self:NeuroPlanes_SurfaceExplosion()
		
		self:Remove()
		
		return
		
	end
	
	if( self.Ticker < 90 ) then
		
		self.PhysObj:SetVelocity( self:GetForward() * self.Speed )
	
	
		self.Ticker = self.Ticker + 1
		
		return
		
	end
	

end

function ENT:Think()

	self.Sound:PlayEx( 100, 1 )
		
end 

function ENT:OnRemove()

	-- self.Sound:Stop()	
	local expl = ents.Create("env_explosion")
	expl:SetKeyValue("spawnflags",128)
	expl:SetPos( self:GetPos() )
	expl:Spawn()
	expl:Fire("explode","",0)
	
end
