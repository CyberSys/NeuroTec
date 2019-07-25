include( 'shared.lua' )
language.Add ("npc_ohmygodaliensareattacking", "ALIENS D:")
local matLight 				= Material( "sprites/gmdm_pickups/light" )
function ENT:Initialize()

end

function ENT:Draw()
	
	if( self:GetNetworkedBool("DrawLaserBeams", false ) ) then
	
		local pos = {}
		local pos2 = {}
		
		for i = 1, 36 do
			
			pos[i] = self:GetPos() + self:GetUp() * 32
			pos[i].x = pos[i].x + math.sin( CurTime() - ( i * 10 ) ) * 25
			pos[i].y = pos[i].y + math.cos( CurTime() - ( i * 10 ) ) * 25
			
			pos2[i] = trace.HitPos + Vector( 0,0,0 -400 )
			pos2[i].x = pos2[i].x + math.sin( CurTime() - ( i * 10 ) ) * 256
			pos2[i].y = pos2[i].y + math.cos( CurTime() - ( i * 10 ) ) * 256
			
			local tr,trace = {},{}
			tr.start = pos[i]
			tr.endpos = pos2[i]
			tr.filter = { self, self.LolBall }
			tr.mask = MASK_WORLD
			trace = util.TraceLine( tr )
			
			local fx = EffectData()
			fx:SetStart(  pos[i] )
			fx:SetOrigin( trace.HitPos /*pos2[i]*/ )
			util.Effect( "TraceBeam", fx )
			
		end
	
	end
	
	self:DrawModel()

end
