ENT.Base = "base_ai"
ENT.Type = "ai"
ENT.PrintName = "Terrorist"
ENT.Author = "Sillirion"
ENT.Contact = "Neurotec Team"
ENT.Information		= ""
ENT.Category		= ""

ENT.Spawnable = false
ENT.AdminSpawnable = false


ENT.AutomaticFrameAdvance = true

 function ENT:PhysicsCollide( data, physobj )
end
 
 

function ENT:PhysicsUpdate( physobj )
end
  
function ENT:SetAutomaticFrameAdvance( bUsingAnim )

self.AutomaticFrameAdvance = bUsingAnim

end


