
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.explodeDel = NULL
ENT.explodeTime = 10

function ENT:Initialize()
	
	self.Ticker = 0
	
	self:SetModel("models/items/AR2_Grenade.mdl")
	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
	if(phys:IsValid()) then 
	phys:Wake()
	phys:SetMass( 1 )
	phys:SetVelocity( self:GetForward() * self.ShellVelocity  )
	end
	
end

function ENT:Think()
	
	self.Ticker = self.Ticker + 1
	
	if( self.Ticker > 1 ) then
	
		ParticleEffect( "neuro_gascan_explo", self:GetPos(), Angle(0,0,0), nil )
			
		self:EmitSound( "explosion3.wav", 511, 100 )
		
		for i = 1,15 do
		
			local p = self:GetPos() + Vector( math.random( -16,16 ), math.random( -16,16 ), math.random( -16,16 ) )
			-- p.z = p.z + math.sin( CurTime() ) * 16
			-- p.y = p.y + math.cos( CurTime() ) * 16
			
			local r = ents.Create("sent_tank_clustershrapnell")
			r:SetPos( p ) 
			r:SetAngles( self:GetAngles() + Angle( math.Rand( -15.5, 15.5 ),math.Rand( -15.5, 14.5 ),math.Rand( -14.5, 14.5 ) ) )
			r:SetOwner( self:GetOwner() )
			r:Spawn()
			r.Owner = self.Owner
			r:SetPhysicsAttacker( self.Owner )
			r.Creditor = self.Creditor
			-- r:SetVelocity( self:GetForward() * 4500 )
			r:GetPhysicsObject():ApplyForceCenter( r:GetForward() * 10000 )
			
		end
		
		self:Remove()
		
		return
		
	end
end

