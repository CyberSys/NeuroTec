
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.explodeDel = NULL
ENT.explodeTime = 10

function ENT:Initialize()

	self:SetModel("models/items/grenadeammo.mdl")
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then 
		
		phys:Wake()
		phys:SetMass( 500 )
		
	
	end
	
	self.Sprite = ents.Create( "env_sprite" )
	self.Sprite:SetParent( self )	
	self.Sprite:SetPos( self:LocalToWorld( Vector( 0, -0, 0 ) ) )
	self.Sprite:SetAngles( self:GetAngles() )
	self.Sprite:SetKeyValue( "spawnflags", 1 )
	self.Sprite:SetKeyValue( "renderfx", 0 )
	self.Sprite:SetKeyValue( "scale", 0.48 )
	self.Sprite:SetKeyValue( "rendermode", 9 )
	self.Sprite:SetKeyValue( "HDRColorScale", .75 )
	self.Sprite:SetKeyValue( "GlowProxySize", 2 )
	self.Sprite:SetKeyValue( "model", "sprites/redglow3.vmt" )
	self.Sprite:SetKeyValue( "framerate", "10.0" )
	self.Sprite:SetKeyValue( "rendercolor", " 255 0 0" )
	self.Sprite:SetKeyValue( "renderamt", 255 )
	self.Sprite:Spawn()
	
end

ENT.IsActive = false

function ENT:Think()

	
	local sp = self:GetPos()
	
	for k,v in pairs( player.GetAll() ) do
		
		local vp = v:GetPos()
		local dist = ( vp - sp ):Length()
		-- print( math.floor( dist ) )
		if(  dist < 3000 ) then
			
			if( dist < 200 ) then
				
				-- print( dist > 100 ) 
				if( !self.IsActive ) then
				
					self:GetPhysicsObject():ApplyForceCenter( Vector( 0,0,200000 ) )
					self.IsActive = true
					timer.Simple( 0.45, function() if( IsValid( self ) ) then self:Explode() end end )
					
				end
				
				if( dist < 100 ) then
					
					ParticleEffect( "HE_impact_wall", self:GetPos(), Angle(0,0,0), self )
					-- print( "boom" )
					self:Explode()
					
				end
				
			else
				-- print("push")
				self:GetPhysicsObject():ApplyForceCenter( ( vp - sp ):GetNormalized() * 50000 )
			
			end
			
		end
	
	end
		
	self:NextThink( CurTime() + 0.1 )

end

function ENT:PhysicsCollide( data, physobj )
	
	if( data.DeltaTime > 0.25  ) then
				
		if (data.Speed > 1000 ) then 
			
			if( !IsValid( self.Owner ) ) then self.Owner = self end
			if( !IsValid( self.Creditor ) ) then self.Creditor = self end
			
			if( data.HitEntity && !data.HitEntity:IsWorld() ) then
				
				ParticleEffect( "HE_impact_wall", self:GetPos(), Angle(0,0,0), nil )
				-- print( "HE hit nonworld")
			else
				
				ParticleEffect( "HE_impact_dirt", self:GetPos(), Angle(0,0,0), nil )
				-- print( "HE hit world") 
				
			end
			
			local a,b = data.HitPos + data.HitNormal, data.HitPos - data.HitNormal
			util.Decal("Scorch", a, b )
			
			self:Explode()
			
		end
	
	end
	
end

function ENT:Explode()

	if( !IsValid( self.Owner ) ) then
		
		self.Owner = self
		
	end
	
	if( !IsValid( self.Creditor ) ) then
		
		self.Creditor = self.Owner
		
	end
	
	
	if( self:WaterLevel() > 0 ) then

		ParticleEffect( "water_impact_big", self:GetPos(), Angle(0,0,0), nil )

	end
	
	self:EmitSound( "ambient/explosions/explode_1.wav", 511, 100 )

	local pe = ents.Create( "env_physexplosion" );
	pe:SetPos( self:GetPos() );
	pe:SetKeyValue( "Magnitude", 250 );
	pe:SetKeyValue( "radius", 256 );
	pe:SetKeyValue( "spawnflags", 19 );
	pe:Spawn();
	pe:Activate();
	pe:Fire( "Explode", "", 0 );
	pe:Fire( "Kill", "", 0.5 );
	local explo = EffectData()
	explo:SetOrigin( self:GetPos() )
	util.Effect("explosion", explo )
	
	if( self.MinDamage && self.MaxDamage ) then
		
		local dmg = math.random( self.MinDamage, self.MaxDamage )
		
		if( dmg > self.MaxDamage * 0.9 && self.Owner:IsPlayer() ) then
			
			self.Owner:PrintMessage( HUD_PRINTCENTER, "CRIT!" )
		
		end
		
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos(), 712, dmg )
	
	else
	
		util.BlastDamage( self.Creditor, self.Owner, self:GetPos(), 712, math.random( 150, 450 ) )

	end
	
	self:Remove()
end
