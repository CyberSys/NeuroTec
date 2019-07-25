AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Sauce = 750
ENT.Delay = 0
ENT.Speed = 400

PrecacheParticleSystem( "rocket_impact_dirt" )
function ENT:Initialize()
	
	self.seed = math.random( -10000, 10000 )
	
	self:SetModel( "models/weapons/rocket/rocket.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	self.HitStuff = false
	self.TraverseAngle = self:GetAngles()
	self.TDir = math.random(-1,1)
	
	self.PhysObj = self:GetPhysicsObject() 
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:EnableGravity( false )
		
	end
	
	self.SpawnTime = CurTime()
	
	util.PrecacheSound("Missile.Accelerate")
	
	-- util.SpriteTrail(self, 0, Color(255,255,255,math.random(120,160)), false, 8, math.random(1,2), 1, math.random(1,3), "trails/smoke.vmt");  
	
end

function ENT:PhysicsCollide( data, physobj )
	

	if ( IsValid( data.HitEntity ) && data.HitEntity:GetOwner() == self:GetOwner() ) then // Plox gief support for SetOwner ( table )
		
		return
		
	end
	
	if (data.Speed > 1 && data.DeltaTime > 0.1 ) then 
		
		if( IsValid( data.HitEntity ) && !data.HitWorld ) then
		
			self.HitStuff = true
			
		end
		
		local a,b = data.HitPos + data.HitNormal, data.HitPos - data.HitNormal
		util.Decal("Scorch", a, b )
			
		self:Remove()
		
		
	end
	
end

function ENT:PhysicsUpdate()

	self.PhysObj = self:GetPhysicsObject()
	local tr, trace = {},{}
	tr.start = self:GetPos()
	tr.endpos = tr.start + self:GetForward() * 250
	tr.filter = self
	trace = util.TraceLine( tr )
	
	if ( trace.Hit && trace.HitSky ) then
		
		self:Remove()
		
	end
	
	if ( !IsValid( self.Owner ) ) then
		self.Owner = self
	end
	
	if self.Flying == true then
		
		if self.Sauce >= 1 then
			
			self.Speed = self.Speed * 1.055
			self.PhysObj:SetVelocity( self:GetForward() * self.Speed )
			self.Sauce = self.Sauce - 1
			self:GetPhysicsObject():ApplyForceCenter( VectorRand() * 160 )
			-- local a = self.PhysObj:GetAngles() -- self.TraverseAngle --
			-- // Alcohol Induced Rockets aka Drunk Fire
			-- self.PhysObj:SetAngles( Angle( a.p + math.cos( CurTime() - self.seed ) * .021 ,
										  -- a.y + math.sin( CurTime() - self.seed ) * .021 ,
										  -- a.r + self.TDir  ) )
										  
		else
		
			self.PhysObj:EnableGravity(true)
			self.PhysObj:EnableDrag(true)
			self.PhysObj:SetMass(100)
			
		end
		
	end

	
end

function ENT:Think()
	
	if( self:WaterLevel() > 0 ) then
	
		self:Remove()
		
	end
	
	if self.Delay > 0 then
		self.Delay = self.Delay - 1
		self.Flying = false
	else
		self.Flying = true
		self.Delay = 0
	end
	
	self:EmitSound("Missile.Accelerate")
	
end 

function ENT:OnRemove()
	
	if( self.HitStuff ) then
		
		ParticleEffect("rocket_impact_wall", self:GetPos()+Vector( 0,0,32 ), -self:GetAngles(), nil )
		
	else
	
		ParticleEffect("rocket_impact_dirt", self:GetPos()+Vector( 0,0,32 ), -self:GetAngles(), nil )
		
	end
	
	local explo = EffectData()
	explo:SetOrigin(self:GetPos() + VectorRand() * 16 )
	util.Effect("Explosion", explo)
	
	local pe = ents.Create( "env_physexplosion" );
	pe:SetPos( self:GetPos() );
	pe:SetKeyValue( "Magnitude", 150 );
	pe:SetKeyValue( "radius", 128 );
	pe:SetKeyValue( "spawnflags", 19 );
	pe:Spawn();
	pe:Activate();
	pe:Fire( "Explode", "", 0 );
	pe:Fire( "Kill", "", 0.5 );
	
	util.BlastDamage( self, self.Owner, self:GetPos()+Vector( 0,0,16 ), 450, math.random( 600, 1200 ) )
	self:StopSound("Missile.Accelerate")
	
end
