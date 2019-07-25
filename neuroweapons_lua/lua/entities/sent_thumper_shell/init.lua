AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Sauce = 1500
ENT.Delay = 0
ENT.Speed = 400

PrecacheParticleSystem( "rocket_impact_dirt" )
PrecacheParticleSystem( "apc_muzzleflash" )

function ENT:Initialize()
	
	self.seed = math.random( -10000, 10000 )
	
	self:SetModel( "models/items/AR2_Grenade.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	self.HitStuff = false
	self.TraverseAngle = self:GetAngles()
	self.TDir = math.random(-1,1)
	
	self.PhysObj = self:GetPhysicsObject() 
	if ( self.PhysObj:IsValid() ) then
	
		self.PhysObj:Wake()
		self.PhysObj:EnableGravity( true )
		self.PhysObj:EnableDrag( true )
		self.PhysObj:SetMass( 500 )
		
	end
	
	self.SpawnTime = CurTime()
	
	timer.Simple( 0.01, function() ParticleEffect( "apc_muzzleflash", self:GetPos(), self:GetAngles(), self ) end )

	-- util.SpriteTrail(self, 0, Color(255,255,255,math.random(120,160)), false, 8, math.random(1,2), 1, math.random(1,3), "trails/smoke.vmt");  
	
end

function ENT:PhysicsCollide( data, physobj )
	
	if( self:GetPos():Distance( self.Owner:GetPos() ) < 512 ) then return end
	
	if ( IsValid( data.HitEntity ) && data.HitEntity:GetOwner() == self:GetOwner() ) then // Plox gief support for SetOwner ( table )
		
		return
		
	end
	
	if (data.Speed > 10 && data.DeltaTime > 0.1 ) then 
		
		if( IsValid( data.HitEntity ) && !data.HitWorld ) then
		
			self.HitStuff = true
			
		end
		
		local a,b = data.HitPos + data.HitNormal, data.HitPos - data.HitNormal
		util.Decal("Scorch", a, b )
			
		self:Remove()
		
		
	end
	
end

function ENT:PhysicsUpdate()
	
	if ( !IsValid( self.Owner ) ) then
		self.Owner = self
	end
	
end

function ENT:Think()
	
	if( self:WaterLevel() > 0 ) then

		self:Remove()
		
		return
		
	end


end 

function ENT:OnRemove()
	
	if( self:WaterLevel() > 0 ) then
	
		ParticleEffect( "water_impact_big", self:GetPos(), Angle(0,0,0), nil )
		
	else
		
		if( self.HitStuff ) then
			
			ParticleEffect("HE_impact_wall", self:GetPos()+Vector( 0,0,32 ), -self:GetAngles(), nil )
			
		else
		
			ParticleEffect("HE_impact_dirt", self:GetPos()+Vector( 0,0,32 ), -self:GetAngles(), nil )
			
		end
	
	end
	
	local explo = EffectData()
	explo:SetOrigin(self:GetPos() + VectorRand() * 16 )
	util.Effect("Explosion", explo)
	
	local pe = ents.Create( "env_physexplosion" );
	pe:SetPos( self:GetPos() );
	pe:SetKeyValue( "Magnitude", 500005000 );
	pe:SetKeyValue( "radius", 256 );
	pe:SetKeyValue( "spawnflags", 19 );
	pe:Spawn();
	pe:Activate();
	pe:Fire( "Explode", "", 0 );
	pe:Fire( "Kill", "", 0.5 );

	util.BlastDamage( self, self.Owner, self:GetPos()+Vector( 0,0,16 ), 512, math.random( 650, 950 ) )
	
end
