AddCSLuaFile()

ENT.PrintName = "Medium Body Armor"
ENT.Author = "Hoffa"
ENT.Category = "NeuroTec Gear"
ENT.Base = "sent_neuro_gear_base"

ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.ModelScale = .7

ENT.InitialHealth = 300
ENT.Model = "models/killstr3aks/body_armor.mdl" -- 3d model
ENT.AttachmentBone = "chest"
ENT.HitgroupProtected = bit.band( HITGROUP_CHEST, HITGROUP_STOMACH )
ENT.DamageScaling = 0.0 -- 0 = no damage taken, 1.0 = full damage, 2.0 = double damage. 
ENT.AttachmentAngle = Angle( -0, 5, 0 )
ENT.AttachmentPos = Vector( 2.5, -0, -5 ) 

-- custom hooks
function ENT:OnEquipItem( ply ) 
	

end 

function ENT:OnDestroyed( dmginfo )


end 

