include('shared.lua')
local matHeatWave		= Material( "sprites/halo01" )
local matFire			= Material( "effects/fire_cloud1" )

function ENT:Initialize()

	self.Seed = math.Rand( 0, 10000 )
	self.Emitter = ParticleEmitter( self:GetPos(), false )
	self.Yaw = 0
	self.Pos = self:GetPos()
	self.Ticker = 0
	
end


function ENT:Draw()

	self.Entity:DrawModel()
	self.OnStart = self.OnStart or CurTime()
	-- self:EffectDraw_fire()
	
	self.Yaw = self.Yaw + 0.451235
	if( self.Yaw > 359 ) then
		 
		 self.Yaw = 0
		 
	end
	
	self:SetAngles( Angle( 0, self.Yaw, 0 ) )
	-- self:SetPos( self:GetPos() + self:GetUp() * math.sin(CurTime()) * 8 )

	
end

function ENT:OnRemove()

end

function ENT:EffectDraw_fire()
	
	-- self.Ticker = self.Ticker + 1
	
	-- local radius = 35
	-- self.Pos = self:GetPos() + self:GetUp() * 8
	-- self.Pos.x = self.Pos.x + math.sin(self.Ticker) * math.cos(radius)*radius/2
	-- self.Pos.y = self.Pos.y + math.cos(self.Ticker) * math.cos(radius)*radius/2

	-- for i=1,10 do
	
		-- local particle = self.Emitter:Add(  "particle/fire", self.Pos + self:GetUp() * ( 7.2 * i ) )
		
		-- if ( particle ) then
			
			-- particle:SetVelocity( Vector( 0,0,0  ) )
			-- particle:SetDieTime( 1 )
			-- particle:SetStartAlpha( math.Rand( 20, 30 ) )
			-- particle:SetEndAlpha( 0 )
			-- particle:SetStartSize( 5 )
			-- particle:SetEndSize( 0 )
			-- particle:SetRoll( math.Rand(-1,1) )
			-- particle:SetRollDelta( math.Rand(-1, 1) )
			-- particle:SetColor( 255,255,255,255 ) 
			-- particle:SetAirResistance( 100 ) 
			-- particle:SetGravity( Vector( 0,0,0) ) 	

		-- end
		
	-- end
	
end