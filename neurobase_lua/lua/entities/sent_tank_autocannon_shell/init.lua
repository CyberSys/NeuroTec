
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')


function ENT:Initialize()

	self:SetModel("models/items/AR2_Grenade.mdl")
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	self.MinDamage = 250
	self.MaxDamage = 680
	
    local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then 
	
		phys:Wake()
		-- phys:SetMass( 5000 )
	-- phys:SetVelocity( self:GetForward() * self.ShellVelocity  )
		
	end
	
	-- self:Ignite( 100, 100 )

end


function ENT:PhysicsUpdate()
	
	if( self.Destroyed ) then
		 
		 return
		 
	end
	
	local tr,trace = {},{}
	tr.start = self:GetPos()
	tr.endpos = self:GetForward() * 128
	tr.filter = { self, self.Owner }
	tr.mask = MASK_SOLID
	
	trace = util.TraceLine( tr )
	
	if( trace.Hit && IsValid( trace.Entity ) ) then
		
		local fakedata = { HitPos = self:GetPos(), HitNormal = self:GetForward() }
		self:Explode( fakedata )
		self.Destroyed = true
		
		return
		
	end

end

function ENT:Think()

	self:NextThink( CurTime() + 0.1 )
	-- self:GetPhysicsObject():AddAngleVelocity( Vector( 1000, 0, 0 ) ) //spinning shell :D
	-- print( ( self:GetPos() - self.Owner:GetPos()) :Length() )
	-- print( self:GetVelocity():Length() )
end

function ENT:PhysicsCollide( data, physobj )
	
	if ( IsValid( data.HitEntity ) && data.HitEntity.Owner == self.Owner ) then // Plox gief support for SetOwner ( table )
		
		return
		
	end
	
	if( !IsValid( self.Owner ) ) then self.Owner = self end
	if( !IsValid( self.Creditor ) ) then self.Creditor = self end
	
	
	if (data.Speed > 50 && data.DeltaTime > 0.1 ) then 
	
		self:Explode( data )
		
	end
	
end

function ENT:Explode( data)

	if( !IsValid( self.Owner ) ) then
		
		self.Owner = self
		
	end
	
	local e = EffectData()
	e:SetOrigin(data.HitPos)
	e:SetNormal(data.HitNormal)
	e:SetScale(2)
	util.Effect("Explosion", e)
	util.Effect("Launch2", e)
	
	-- local e = EffectData()
	-- e:SetOrigin(data.HitPos)
	-- e:SetNormal(data.HitNormal)
	-- e:SetScale(10)
	-- util.Effect("Sparks", e)
	
	util.BlastDamage( self.Creditor, self.Owner, self:GetPos(), 128, math.random( self.MinDamage, self.MaxDamage ) )

	self:Remove()
	
end
