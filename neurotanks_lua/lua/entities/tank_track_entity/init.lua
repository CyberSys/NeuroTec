
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')

ENT.HealthVal = 3500
ENT.InitialHealth = 3500
ENT.Destroyed = false

function ENT:Initialize()

	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.LeakPos = {}

end

function ENT:Think()
	
	if( self.HealthVal > 0 ) then
	
		self.Destroyed = false
		self:SetColor( Color(  255,255,255,255 ) )
		
	else
		
		-- self:SetMaterial( "" )
		self.Destroyed = true
		self:SetColor( Color (75,75,75,255 ) )
		
	end
	
end

function ENT:OnTakeDamage( dmginfo )
	
	if( self.Destroyed ) then return end

	if( self.HealthVal > 0 ) then
	
		self.HealthVal = self.HealthVal - dmginfo:GetDamage()
		if( self.HealthVal < 0 ) then self.HealthVal = 0 end

	end
	
end

function ENT:Explode()

	-- self:Remove()
	
end

function ENT:PhysicsCollide( data, physobj )
	
end
