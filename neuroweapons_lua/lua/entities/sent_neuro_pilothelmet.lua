AddCSLuaFile()

ENT.PrintName = "Pilot Helmet"
ENT.Author = "Hoffa"
ENT.Category = "NeuroTec Gear"
ENT.Base = "sent_neuro_gear_base"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.InitialHealth = 150
ENT.Model = "models/killstr3aks/pilot_helmet.mdl"
ENT.ModelScale = 1.0
-- ENT.UsingBones = true 
ENT.AttachmentBone = "forward"
ENT.HitgroupProtected = HITGROUP_HEAD
ENT.DamageScaling = 0.0 -- 0 = no damage taken, 1.0 = full damage, 2.0 = double damage. 
ENT.AttachmentAngle = Angle( 0, 0,0 )
ENT.AttachmentPos = Vector( -.5,0,4  ) 


-- custom hooks
function ENT:OnEquipItem( ply ) 
	

end 

function ENT:OnDestroyed( dmginfo )


end 
