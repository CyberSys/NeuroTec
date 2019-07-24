AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.AutoDetonateTimer = 0

function ENT:Initialize()

	self:SetModel( "models/items/AR2_Grenade.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_BSP )
	self.MaxTime = math.random(2,4)
	self.PhysObj = self:GetPhysicsObject()
	
	if (self.PhysObj:IsValid()) then
	
		self.PhysObj:Wake()
		self.PhysObj:EnableGravity( false )
		self.PhysObj:SetMass( 1 )
		self.PhysObj:SetVelocity( self:GetForward() * self.ShellVelocity  )
		
	end

	util.SpriteTrail(self, 0, Color(255,255,255,80), false, math.random(2,5), math.random(1,2), 2, math.random(1,3), "trails/smoke.vmt");  
	
end
function ENT:PhysicsUpdate()
		
	if( self:WaterLevel() > 1 ) then
		
		self:NeuroPlanes_SurfaceExplosion()
		
		self:Remove()
		
		return
		
	end

end
function ENT:PhysicsCollide( data, physobj )
	
	
	if ( data.Speed > 150 && data.DeltaTime > 0.2 ) then 
		
		if( !IsValid( self.Owner ) ) then self.Owner = self end
		if( !IsValid( self.Creditor ) ) then self.Creditor = self end
		
		util.BlastDamage( self.Creditor, self.Owner, data.HitPos, 512, math.random( self.MinDamage,self.MaxDamage ))
		
		local fx = EffectData()
		fx:SetOrigin(data.HitPos)
		util.Effect("Flaksmoke",fx)

		self:EmitSound( "ambient/fire/gascan_ignite1.wav",211,100 )

		self:Remove()
		
	end
	
end

function ENT:Think()
	
	if( !IsValid( self.Owner ) ) then
		
		self.Owner = self
	
	end
	if( !IsValid( self.Creditor ) ) then
		
		self.Creditor = self
		
	end
	
	self:GetPhysicsObject():ApplyForceCenter( self:GetForward() * 50000 )
	
	local tr, trace = {},{}
	tr.start = self:GetPos()
	tr.endpos = tr.start + self:GetForward() * 250
	tr.filter = self
	tr.mask = MASK_SOLID
	trace = util.TraceLine( tr )
	
	if( trace.HitSky ) then
	
		self:Remove()
		
		return
		
	end
	
	
	self.AutoDetonateTimer = self.AutoDetonateTimer + 1
	
	//print( self.AutoDetonateTimer )
	
	if( self.AutoDetonateTimer >= self.MaxTime ) then
		
		-- for i=1,5 do
		
			local p = Vector( math.random( -256,256), math.random( -256,256), math.random( -256,256) ) 
			util.BlastDamage( self, self.Owner, self:GetPos() + p, 512, math.random( 55,115 ))
			
			local impact = EffectData()
			impact:SetOrigin( self:GetPos() + Vector( 0,0,2))
			impact:SetStart( self:GetPos()  + Vector( 0,0,2))
			impact:SetScale( 4 )
			impact:SetNormal( self.HitNormal or self:GetForward()*-1 )
			util.Effect("micro_flak", impact )
			
			self:EmitSound( "ambient/fire/gascan_ignite1.wav",211,100 )

		-- end
		
		self:Remove()
		
		return
		
	end
	
	
	if( self:WaterLevel() > 0 ) then
	
		self:Remove()
	
	end
	
	if ( !IsValid( self.Owner ) ) then
		
		self.Owner = self
		
	end
	
	if( self:GetPos():Distance( self.Owner:GetPos() ) > 2500 ) then
		
		for k,v in pairs( ents.FindInSphere(self:GetPos(), 1000 ) ) do
		
			if ( ( v:IsNPC() || v.HealthVal ) && v != self.Owner && v:GetParent() != self.Owner && self.AutoDetonateTimer > ( self.MaxTime * 0.5 ) ) then
				
				-- for i=1,5 do
				
					local p = Vector( math.random( -256,256), math.random( -256,256), math.random( -256,256) ) 
					util.BlastDamage( self, self.Owner, self:GetPos() + p, self.Radius or 128, self.MaxDamage or math.random( 25,40 ))

					local impact = EffectData()
					impact:SetOrigin( self:GetPos() + Vector( 0,0,2))
					impact:SetStart( self:GetPos()  + Vector( 0,0,2))
					impact:SetScale( 4 )
					impact:SetNormal( self.HitNormal or self:GetForward()*-1 )
					util.Effect("micro_flak", impact )
					
					self:EmitSound( "ambient/fire/gascan_ignite1.wav",211,100 )

				-- end
			
				self:Remove()
			
			end
		
		end
		
	end
	
end
