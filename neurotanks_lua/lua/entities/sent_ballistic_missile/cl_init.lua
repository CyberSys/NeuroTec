ENT.Spawnable			= false
ENT.AdminSpawnable		= false

include('shared.lua')
language.Add("#pac3", "PAC-3 BML" )
local matHeatWave		= Material( "sprites/heatwave" )
local matFire			= Material( "effects/fire_cloud1" )
local emitter = ParticleEmitter(Vector(0, 0, 0))

function ENT:Initialize()

	local pos = self:GetPos() + self:GetForward() * -200
	self.Seed = math.Rand( 0, 10000 )
	self.Emittime = 0
	-- print("loaded rocket")
end

function ENT:Think()
	
	local dlight = DynamicLight( self:EntIndex() )
	if ( dlight ) then

		local c = Color( 250+math.random(-5,5), 170+math.random(-5,5), 0, 100 )

		dlight.Pos = self:GetPos()
		dlight.r = c.r
		dlight.g = c.g
		dlight.b = c.b
		dlight.Brightness = 1
		dlight.Decay = 0.1
		dlight.Size = 2048
		dlight.DieTime = CurTime() + 0.15

	end
		
	self:NextThink(CurTime())
	if (self.Emittime < CurTime()) then
		local smoke = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-50)
		smoke:SetVelocity(self:GetForward()*-800)
		smoke:SetDieTime(math.Rand(.9,1.2))
		smoke:SetStartAlpha(math.Rand(200,240))
		smoke:SetEndAlpha(0)
		smoke:SetStartSize(math.random(14,18))
		smoke:SetEndSize(math.random(66,99))
		smoke:SetRoll(math.Rand(180,480))
		smoke:SetRollDelta(math.Rand(-2,2))
		smoke:SetGravity( Vector( 0, math.random(1,90), math.random(51,155) ) )
		smoke:SetAirResistance(60)

		local fire = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-50)
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

		local fire = emitter:Add("effects/smoke_a", self:GetPos() + self:GetForward()*-50)
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

		local fire = emitter:Add("effects/yellowflare", self:GetPos() + self:GetForward()*-50)
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

		-- self.Emittime = CurTime() + .01
	end
end

function ENT:Draw()
	self.Entity:DrawModel()
	self.OnStart = self.OnStart or CurTime()
end
function ENT:OnRemove()
	surface.PlaySound( "weapons/mortar/mortar_explode2.wav" )
end

function ENT:OnRestore()
end
