 ENT.Base = "base_ai"
 ENT.Type = "ai"
   
 ENT.PrintName = "War of the Servers UFO"
 ENT.Author = "Hoffa"
 ENT.Contact = "no"
 ENT.Purpose = ""
 ENT.Instructions = ""
 ENT.Information	= ""  
 ENT.Category		= ""
  
 ENT.AutomaticFrameAdvance = true
   
 ENT.Spawnable = false
 ENT.AdminSpawnable = false

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
  self.AutomaticFrameAdvance = bUsingAnim
end  