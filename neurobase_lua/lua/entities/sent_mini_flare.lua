AddCSLuaFile()
ENT.Type = "anim"

ENT.Author			= ""
ENT.Contact			= ""
ENT.PrintName		= "Flare"
ENT.Purpose			= ""
ENT.Instructions			= ""
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Model = "models/props_junk/popcan01a.mdl"
ENT.DeployDelay = 25

function ENT:Initialize()

	self:SetModel( self.Model)
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )	
	self:SetSolid( SOLID_VPHYSICS )
	
	-- if( CLIENT ) then 
		
		-- self:CreateParticleEffect("microplane_explosion", 0 )
	
	-- end 
	self:Fire("Kill","",15 )
	
end

function ENT:Think()
	
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 512 ) ) do 
		
		if( IsValid( v ) && IsValid( v.Target ) ) then 
			
			v.Target = self 
			
		end 
		
	end 
	
	self:NextThink( CurTime() + .25 )
	
end
if CLIENT then 
local emitter = ParticleEmitter(Vector(0, 0, 0))
function ENT:Initialize()
	self.lifetime = RealTime()
	self.cooltime = CurTime()
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	
	local color = 255 
	local SCALE = .125
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then

		local c = Color( 250+math.random(-5,5), 130+math.random(-5,5), 0, 255 )

		dlight.Pos = self:GetPos()
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = 2
		dlight.Decay = 0.1
		dlight.Size = 512*SCALE
		dlight.DieTime = CurTime() + 0.15

	end
	

	local dist = 0
	if (self.lifetime > RealTime()) then
		if (self.cooltime < CurTime()) then
		local smoke = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
		smoke:SetVelocity(self:GetForward()*-66)
		smoke:SetDieTime(math.Rand(1.1,2.1))
		smoke:SetStartAlpha(math.Rand(160,200))
		smoke:SetEndAlpha(0)
		smoke:SetStartSize(math.random(14,18)*SCALE)
		smoke:SetEndSize(math.random(96,129)*SCALE)
		smoke:SetRoll(math.Rand(180,480))
		smoke:SetRollDelta(math.Rand(-4,2))
		smoke:SetGravity( Vector( 0, math.random(1,90), math.random(151,355) ) )
		smoke:SetColor( color, color, color )
		smoke:SetAirResistance(60)
		local smoke = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
		smoke:SetVelocity(self:GetForward()*-55)
		smoke:SetDieTime(math.Rand(1.9,4.7))
		smoke:SetStartAlpha(math.Rand(55,155))
		smoke:SetEndAlpha(0)
		smoke:SetStartSize(math.random(14,18)*SCALE)
		smoke:SetEndSize(math.random(196,329)*SCALE)
		smoke:SetRoll(math.Rand(180,480))
		smoke:SetRollDelta(math.Rand(-2,3))
		smoke:SetGravity( Vector( 0, math.random(1,90), math.random(151,355) ) )
		smoke:SetColor( color, color, color )
		smoke:SetAirResistance(60)
		local fire = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
		fire:SetVelocity(self:GetForward()*-10)
		fire:SetDieTime(math.Rand(.05,.1))
		fire:SetStartAlpha(math.Rand(222,255))
		fire:SetEndAlpha(0)
		fire:SetStartSize(math.random(11,14)*SCALE)
		fire:SetEndSize(math.random(20,33)*SCALE)
		fire:SetAirResistance(150)
		fire:SetRoll(math.Rand(180,480))
		fire:SetRollDelta(math.Rand(-3,3))
		fire:SetStartLength(15)
		fire:SetColor(255,100,0)
		fire:SetEndLength(math.Rand(100, 150))

		local fire = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
		fire:SetVelocity(self:GetForward()*-10)
		fire:SetDieTime(math.Rand(.05,.1))
		fire:SetStartAlpha(math.Rand(222,255))
		fire:SetEndAlpha(0)
		fire:SetStartSize(math.random(11,14)*SCALE)
		fire:SetEndSize(math.random(20,33)*SCALE)
		fire:SetAirResistance(150)
		fire:SetRoll(math.Rand(180,480))
		fire:SetRollDelta(math.Rand(-3,3))
		fire:SetColor(255,110,0)

		local fire = emitter:Add("effects/yellowflare", self:GetPos() + self:GetForward()*-dist)
		fire:SetVelocity(self:GetForward()*-10)
		fire:SetDieTime(math.Rand(.03,.05))
		fire:SetStartAlpha(math.Rand(222,255))
		fire:SetEndAlpha(0)
		fire:SetStartSize(math.random(77,88)*SCALE)
		fire:SetEndSize(math.random(99,100)*SCALE)
		fire:SetAirResistance(150)
		fire:SetRoll(math.Rand(180,480))
		fire:SetRollDelta(math.Rand(-3,3))
		fire:SetColor(255,120,0)

		self.cooltime = CurTime() + .02
		end
	else
		self.lifetime = RealTime() + 1
	end
end

end
function ENT:OnRemove()
end
function ENT:PhysicsUpdate()
end
function ENT:PhysicsCollide(data,phys)
end