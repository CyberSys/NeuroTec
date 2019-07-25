
include('shared.lua')

function ENT:Initialize()
	
end

local Mat = Material("models/attack_Helicopter/blurred_blade")

function ENT:Draw()
self.Ang = self.Ang or 0
self.Ang = self.Ang + 12
while self.Ang > 360 do
self.Ang = self.Ang - 360
end
render.SetMaterial( Mat )
local dir = self:GetUp()
local pos = self:GetPos()+dir*100
local pos2 = self:GetPos()+dir*50
    render.DrawQuadEasy( pos,dir, 636, 636, Color( 255,255,255,255 ), self.Ang ) 
    render.DrawQuadEasy( pos,dir*-1, 636, 636, Color( 255,255,255,255 ), 360 - self.Ang )     
pos = pos+dir*10
pos2 = pos2+dir*10
render.DrawQuadEasy( pos2,dir, 636, 636, Color( 255,255,255,255 ), 360 - self.Ang+10 ) 
    render.DrawQuadEasy( pos2,dir*-1, 636, 636, Color( 255,255,255,255 ), self.Ang+10 ) 
self:DrawModel()
end
function ENT:OnRemove()

end




