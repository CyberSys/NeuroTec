
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')


function ENT:Initialize()

	self:SetModel("models/items/AR2_Grenade.mdl")
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	
	self.MinDamage = 50
	self.MaxDamage = 150
	
    local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then 
	
		phys:Wake()
		-- phys:SetMass( 1 )
		-- phys:SetVelocity( self:GetForward() * self.ShellVelocity  )
		
	end
	util.SpriteTrail(self, 0, Color(244,246,166,25), false, math.random(2,5), math.random(1,2), 2, math.random(1,3), "trails/smoke.vmt");  
	
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
	self:GetPhysicsObject():AddAngleVelocity( Vector( 1000, 0, 0 ) ) //spinning shell :D

end

function ENT:PhysicsCollide( data, physobj )
	timer.Simple(0,function()
	
	if ( IsValid( data.HitEntity ) && data.HitEntity.Owner == self.Owner ) then // Plox gief support for SetOwner ( table )
		
		return
		
	end
	
	if( !IsValid( self.Owner ) ) then self.Owner = self end
	if( !IsValid( self.Creditor ) ) then self.Creditor = self end
	
	
	if (data.Speed > 50 && data.DeltaTime > 0.1 ) then 
	
		self:Explode( data )
		
	end
	end)
end

function ENT:Explode( data)

	if( !IsValid( self.Owner ) ) then
		
		self.Owner = self
		
	end
	
	ParticleEffect( "30cal_impact", self:GetPos(), self:GetAngles()*-1, nil )

	util.BlastDamage( self, self.Owner, self:GetPos(), 72, math.random( self.MinDamage, self.MaxDamage ) )

	self:Remove()
	
end
