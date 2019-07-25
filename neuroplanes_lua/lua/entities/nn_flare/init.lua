AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Model = "models/items/AR2_Grenade.mdl"

function ENT:Initialize()
	self:SetModel( self.Model )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	self:SetModel(self.Model)
	self.PhysObj = self:GetPhysicsObject()
	
	if (self.PhysObj:IsValid()) then
		self.PhysObj:Wake()
		self.PhysObj:EnableDrag(true)
		self.PhysObj:EnableGravity(true)
		self.PhysObj:SetMass(15)
	end
	
	-- util.SpriteTrail(self, 0, Color(255,255,255,40), false, 22, math.random(45,58), 2, 1 / 32 * 0.5, "trails/smoke.vmt");  
	-- self.FlareSound = CreateSound(self, "weapons/flaregun/burn.wav")
	
end

function ENT:PhysicsCollide( data, physobj )
	
	if ( data.Speed > 350 && data.DeltaTime > 0.2 ) then 
		
		for i =1, 8 do
		
			local e = EffectData()
			e:SetOrigin( data.HitPos )
			e:SetNormal( data.HitNormal + Vector( math.random(-12,12), math.random(-12,12), 4 ) )
			e:SetScale( math.random(14,19) )
			util.Effect("ManhackSparks", e)

		end

	end

end

function ENT:OnRemove()
	
	-- self.FlareSound:Stop()
	
end

function ENT:Think()
	
	if ( IsValid( self.Owner ) ) then
	
		for k,v in pairs( ents.FindInSphere( self:GetPos(), 7000 ) ) do
			
			if( v != self.Owner && ( v:IsNPC() || v.HealthVal || v:GetVelocity():Length() > 500 ) ) then
				
				if( v.Target == self.Owner || (IsValid( self.Owner.Pilot ) && v.Target == self.Owner.Pilot ) ) then
				
					v.Target = self
				
				end
				
			end
			
		end
		
	end
	
	-- self.FlareSound:PlayEx( 50, 100 )
	
	self:NextThink(CurTime())
	
end
