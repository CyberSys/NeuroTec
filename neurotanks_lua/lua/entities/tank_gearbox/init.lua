
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')


function ENT:Initialize()

	self:SetModel( "models/mechanics/gears2/gear_12t3.mdl" )

	self:SetOwner(self.Owner)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.LeakPos = {}
	
	-- self:SetPos( self:GetPos() + self:GetUp() * 16 )
	
end

function ENT:PhysicsCollide( data, physobj )
		
	local tank = data.HitEntity
	if( IsValid( tank ) && tank.GearBoxBroken ) then
		
		tank.GearBoxHealth = 750
		tank.GearBoxBroken = true
		tank.EngineBroken = true
		tank:SetNetworkedInt( "EngineGearBoxHealth", tank.GearBoxHealth )
		
		self.Owner:EmitSound( "weapons/crowbar/crowbar_impact"..math.random(1,2)..".wav" )
		
		self:Remove()
		
	end

end

function ENT:Think()
	
	if( self.Destroyed ) then return end
	

end
