ENT.Spawnable			= false
ENT.AdminSpawnable		= false

include('shared.lua')

local emitter = ParticleEmitter(Vector(0, 0, 0))
function ENT:Initialize()
	self.lifetime = RealTime()
	self.cooltime = CurTime()
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	
	local color = self:GetNetworkedInt("SmokeColor", 50 ) 
	
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then

		local c = Color( 250+math.random(-5,5), 130+math.random(-5,5), 0, 255 )

		dlight.Pos = self:GetPos()
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = 2
		dlight.Decay = 0.1
		dlight.Size = 512
		dlight.DieTime = CurTime() + 0.15

	end
	
	
		local dist = self.ExhaustPosDistance or 25
		if (self.lifetime > RealTime()) then
			if (self.cooltime < CurTime()) then
			local smoke = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
			smoke:SetVelocity(self:GetForward()*-600)
			smoke:SetDieTime(math.Rand(.9,1.1))
			smoke:SetStartAlpha(math.Rand(160,200))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(14,18))
			smoke:SetEndSize(math.random(96,129))
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-2,2))
			smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
			smoke:SetColor( color, color, color )
			smoke:SetAirResistance(60)
			local smoke = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
			smoke:SetVelocity(self:GetForward()*-500)
			smoke:SetDieTime(math.Rand(.9,1.7))
			smoke:SetStartAlpha(math.Rand(55,155))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.random(14,18))
			smoke:SetEndSize(math.random(96,129))
			smoke:SetRoll(math.Rand(180,480))
			smoke:SetRollDelta(math.Rand(-2,2))
			smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
			smoke:SetColor( color, color, color )
			smoke:SetAirResistance(60)
			local fire = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-dist)
			fire:SetVelocity(self:GetForward()*-10)
			fire:SetDieTime(math.Rand(.05,.1))
			fire:SetStartAlpha(math.Rand(222,255))
			fire:SetEndAlpha(0)
			fire:SetStartSize(math.random(11,14))
			fire:SetEndSize(math.random(20,33))
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
			fire:SetStartSize(math.random(11,14))
			fire:SetEndSize(math.random(20,33))
			fire:SetAirResistance(150)
			fire:SetRoll(math.Rand(180,480))
			fire:SetRollDelta(math.Rand(-3,3))
			fire:SetColor(255,110,0)

			local fire = emitter:Add("effects/yellowflare", self:GetPos() + self:GetForward()*-dist)
			fire:SetVelocity(self:GetForward()*-10)
			fire:SetDieTime(math.Rand(.03,.05))
			fire:SetStartAlpha(math.Rand(222,255))
			fire:SetEndAlpha(0)
			fire:SetStartSize(math.random(77,88))
			fire:SetEndSize(math.random(99,100))
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

function ENT:OnRestore()
end
