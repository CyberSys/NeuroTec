AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:Initialize()

	-- if ( self:GetModel() ) then		
		-- self:SetModel( self:GetModel() )		
	-- else	
		self:SetModel( "models/neuronaval/killstr3aks/american/destroyers/mini_depth_charge.mdl" )	
	-- end
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	 
	self:SetSolid( SOLID_VPHYSICS )
	
	self.PhysObj = self:GetPhysicsObject()
	
	if ( self.PhysObj:IsValid() ) then
	
	-- print("walla")
		self.PhysObj:EnableGravity( true )
		
		self.PhysObj:SetMass( 10 )
		self.PhysObj:SetBuoyancyRatio( 1145.925 )
		self.PhysObj:SetDamping( 24.0, 1.0 )
		self.PhysObj:EnableDrag( true )
		self.PhysObj:Wake()
		
	end
	-- self:SetAngles( self:GetAngles() + AngleRand() * math.Rand(-.85, .85 ) )
	-- self:EmitSound("hitmarker_sound.wav", 511, 100 )
	self.DetonationDelay = math.random( 10, 15 )
	self.DetonationTicker = 0 
	

end
function ENT:SpawnFunction( ply, tr, class )
	local tr,trace = {},{}
	tr.start = ply:GetShootPos()
	tr.endpos = tr.start + ply:GetAimVector() * 12500
	tr.filter = ply
	tr.mask = MASK_WATER + MASK_SOLID
	trace = util.TraceLine( tr )
	local SpawnPos = trace.HitPos + trace.HitNormal * 1
	local ent = ents.Create( class )
	ent:SetPos( SpawnPos )
	ent.Owner = ply 
	ent:SetAngles( ply:GetAngles() )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Think()
	
	if( self:WaterLevel() > 0 && !self.Splashed ) then 
			
		self.Splashed = true 
		
		local effect2 = EffectData()
		effect2:SetOrigin(self:GetPos()  )
		effect2:SetMagnitude( 1 )
		util.Effect("WaterSplash", effect2 )

	
	end 
	
	self.DetonationTicker = self.DetonationTicker + 1 
	if( self.DetonationTicker >= self.DetonationDelay ) then 
		
		self:SubmergedDetonation()
		
	
	end 

end 
function ENT:SubmergedDetonation()
		
		local effect2 = EffectData()
		effect2:SetOrigin(self:GetPos()  )
		util.Effect("WaterSurfaceExplosion", effect2 )

		util.BlastDamage( self, self.Owner or self,self:GetPos(), 100, math.random( 1725, 3250 ) )
		self:EmitSound("Torpedo_Impact.wav",511,100)
		self:PlayWorldSound("Torpedo_Impact.wav")
	
		self:Remove()
		
end 

function ENT:PhysicsCollide( data, physobj )
	
	-- if( !self.Roped ) then return end 
	
	if( data.HitEntity:GetClass() == self:GetClass() ) then return end 
	
	if( data.HitEntity == self.Owner ) then return end 
	
	if ( data.Speed > 1 && data.DeltaTime > 0.2 && self:WaterLevel() > 0 ) then 

		
		self:SubmergedDetonation()
		
	end
	
end

function ENT:PhysicsUpdate()
	
	-- self:GetPhysicsObject():ApplyForceCenter( VectorRand() 	)
	-- for k,v in pairs( ents.FindInSphere( self:GetPos(), 2024 ) ) do
		
		-- if( v.HealthVal || string.find( v:GetClass(), "prop_vehicle") || v:IsVehicle() ) then
		
			
			-- self.PhysObj:ApplyForceCenter( ( self:GetPos() - v:GetPos() ):GetNormalized() * 1000 )
		
		
		-- end
	self:GetPhysicsObject():ApplyForceCenter( Vector( 0,0,250 ) )
	-- end
	
end

function ENT:OnRemove()

	
end
