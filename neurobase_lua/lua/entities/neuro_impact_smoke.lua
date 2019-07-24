AddCSLuaFile()
ENT.Type = "anim"
ENT.Author			= ""
ENT.Contact			= ""
ENT.PrintName		= ""
ENT.Purpose			= ""
ENT.Instructions			= ""
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Model = "models/props_junk/popcan01a.mdl"
function ENT:Initialize()

	self:SetModel( self.Model)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	
	-- if( CLIENT ) then 
		
		-- self:CreateParticleEffect("microplane_explosion", 0 )
	
	-- end 
	
end
function ENT:Think()
end

if( CLIENT ) then 

	local matHeatWave		= Material( "sprites/heatwave" )
	local matFire			= Material( "effects/fire_cloud1" )
	local emitter = ParticleEmitter(Vector(0, 0, 0))

	function ENT:Initialize()

		local pos = self:GetPos()
		self.Emitter = ParticleEmitter( pos, false )
		-- self:SetPredictable( true )
	end

	function ENT:Draw()
		
		-- self:DrawModel()
		local smoke = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-7)
		smoke:SetVelocity(self:GetForward() * 1)
		smoke:SetDieTime(math.Rand(.9,1.2))
		smoke:SetStartAlpha(math.Rand(200,240))
		smoke:SetEndAlpha(0)
		smoke:SetStartSize(math.random(0,1))
		smoke:SetEndSize(math.random(4,5))
		smoke:SetRoll(math.Rand(180,480))
		smoke:SetRollDelta(math.Rand(-2,2))
		smoke:SetGravity( Vector( 0, 0, 15 ) )
		smoke:SetColor(50, 50, 50)
		smoke:SetAirResistance(60)
		
	end

end 

function ENT:OnRemove()
end
function ENT:PhysicsUpdate()
end
function ENT:PhysicsCollide(data,phys)
end